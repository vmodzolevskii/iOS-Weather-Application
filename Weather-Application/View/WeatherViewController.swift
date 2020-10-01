//
//  WeatherViewController.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol WeatherDataRetrievedDelegate: class {
    func updateWeather()
    func presentErrorAlert(errorAlert: UIAlertController)
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate,
                                                            WeatherDataRetrievedDelegate {
    private weak var dailyWeatherView: DailyWeatherView?
    private weak var weatherPresenter: WeatherPresenter?
    
    private let locationManager = CLLocationManager()
    private var weatherAsText: String = ""
    private var isLocationDefined = false
    
    
    // MARK: Init
    init(presenter: WeatherPresenter) {
        self.weatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ConnectivityVerification.isConnectedToInternet {
            guard let presnter = weatherPresenter else { return }
            presnter.weatherDataRetrievedDelegate = self
        } else {
            let alertManager = AlertManager()
            self.present(alertManager.absenceConnectionAlert(), animated: true)
        }

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        guard let weatherView = dailyWeatherView else { return }
        weatherView.shareWeatherAction = { [weak self] in self?.shareWeatherAsText() }
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
            
        
    }

    @objc func appMovedToForeground() {
        isLocationDefined = false
        locationManager.startUpdatingLocation()
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        let weatherView = DailyWeatherView(frame: UIScreen.main.bounds)
        self.dailyWeatherView = weatherView
        self.view.addSubview(weatherView)
        
        weatherView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: WeatherDataRetrievedDelegate
    func updateWeather() {
        var arguments = [String: String]()
        guard let presenter = weatherPresenter else { return }
        arguments[WeatherArguments.city.rawValue] = presenter.city
        arguments[WeatherArguments.country.rawValue] = presenter.country
        arguments[WeatherArguments.temp.rawValue] = presenter.temperature
        arguments[WeatherArguments.state.rawValue] = presenter.state
        
        arguments[WeatherArguments.humidity.rawValue] = presenter.humidity
        arguments[WeatherArguments.clouds.rawValue] = presenter.clouds
        arguments[WeatherArguments.pressure.rawValue] = presenter.pressure
        arguments[WeatherArguments.speed.rawValue] = presenter.speed
        arguments[WeatherArguments.direction.rawValue] = presenter.direction
        
        dailyWeatherView?.updateView(args: arguments)
        // update text representation of current weather
        collectText()
    }
    
    func presentErrorAlert(errorAlert: UIAlertController) {
        self.present(errorAlert, animated: true)
    }
    
    // MARK: Sharing data
    private func shareWeatherAsText(){
        let sharingViewController = UIActivityViewController(activityItems: [weatherAsText], applicationActivities: [])
        self.present(sharingViewController, animated: true)
    }
    
    private func collectText() {
        guard let presenter = weatherPresenter else { return }
        var weather = "city - \(presenter.city), "
        weather += "temperature - \(presenter.temperature), "
        weather += "state - \(presenter.state), "
        weather += "humidity - \(presenter.humidity), "
        weather += "windSpeed - \(presenter.speed)"
        weatherAsText = weather
    }
    
    // MARK: Geolocation
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else {
                debugPrint("can't define current location", error.debugDescription)
                return
            }
            
            let requestCity = city.replacingOccurrences(of: " ", with: "+")
            let requestCountry = country.replacingOccurrences(of: " ", with: "+")
            
            guard let presenter = self.weatherPresenter else { return }
            if self.isLocationDefined == false {
                presenter.completeRequests(with: requestCity, with: requestCountry, originalCity: city, originalCountry: country)
                self.isLocationDefined = true
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    
    
    private func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        let alertManager = AlertManager()
//        self.present(alertManager.exceptionAlert(with: AlertMessages.locationIssueTitle.rawValue,
//                        alertMessage: AlertMessages.locationIssueMessage.rawValue), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
}
        
