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
    var mainView: DailyWeatherView?
    let weatherPresenter: WeatherPresenter
    
    let locationManager = CLLocationManager()
    
    init(presenter: WeatherPresenter) {
        self.weatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
        weatherPresenter.weatherDataRetrievedDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWeather() {
        var parameters = [String: Any]()
        parameters[DataModel.city.rawValue] = weatherPresenter.city
        parameters[DataModel.country.rawValue] = weatherPresenter.country
        parameters[DataModel.temp.rawValue] = weatherPresenter.temperature
        parameters[DataModel.state.rawValue] = weatherPresenter.state
        
        let params = [weatherPresenter.humidity, weatherPresenter.clouds, weatherPresenter.pressure, weatherPresenter.speed, weatherPresenter.direction]
        parameters[DataModel.details.rawValue] = params
    
        mainView?.updateView(parameters: parameters)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        
        //mainView.shareWeatherAction = { [weak self] in self?.shareWeatherAsText() }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // verification on internet connection
        if ConnectivityVerification.isConnectedToInternet {

        } else {
            let alertManager = AlertManager()
            self.present(alertManager.absenceConnectionAlert(), animated: true)
        }
        // verification on
        //mainView.shareWeatherAction = self.shareWeatherAsText()
        
        
        
    }
    
    private func shareWeatherAsText(){
        
    }
    
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        let weatherView = DailyWeatherView(frame: UIScreen.main.bounds)
        self.mainView = weatherView
        self.view.addSubview(weatherView)
        
        weatherView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
}
        
