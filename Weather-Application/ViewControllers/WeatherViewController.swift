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
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate, WeatherDataRetrievedDelegate {
    private var dailyWeatherView: DailyWeatherView?
    private let weatherPresenter: WeatherPresenter
    
    private let locationManager = CLLocationManager()
    private var weatherAsText: String = ""
    
    // MARK: Init
    init(presenter: WeatherPresenter) {
        self.weatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectText() {
        var weather = "city - \(weatherPresenter.city), "
        weather += "temperature - \(weatherPresenter.temperature), "
        weather += "state - \(weatherPresenter.state), "
        weather += "humidity - \(weatherPresenter.humidity), "
        weather += "windSpeed - \(weatherPresenter.speed)"
        weatherAsText = weather
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if ConnectivityVerification.isConnectedToInternet {
            weatherPresenter.weatherDataRetrievedDelegate = self
        } else {
            let alertManager = AlertManager()
            self.present(alertManager.absenceConnectionAlert(), animated: true)
        }

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        dailyWeatherView!.shareWeatherAction = { [weak self] in self?.shareWeatherAsText() }
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
        var parameters = [String: Any]()
        parameters[DataModel.city.rawValue] = weatherPresenter.city
        parameters[DataModel.country.rawValue] = weatherPresenter.country
        parameters[DataModel.temp.rawValue] = weatherPresenter.temperature
        parameters[DataModel.state.rawValue] = weatherPresenter.state
        
        let params = [weatherPresenter.humidity, weatherPresenter.clouds, weatherPresenter.pressure, weatherPresenter.speed, weatherPresenter.direction]
        parameters[DataModel.details.rawValue] = params
    
        dailyWeatherView?.updateView(parameters: parameters)
        collectText()
    }
    
    // MARK: Sharing data
    private func shareWeatherAsText(){
        let sharingViewController = UIActivityViewController(activityItems: [weatherAsText], applicationActivities: [])
        self.present(sharingViewController, animated: true)
    }
    
    
    // MARK: Geolocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print()
            print(city + ", " + country)
        }
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}
        
