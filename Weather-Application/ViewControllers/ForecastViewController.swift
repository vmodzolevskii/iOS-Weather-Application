//
//  ForecastViewController.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import SnapKit

protocol ForecastDataRetrevedDelegate: class {
    func updateForecast()
}

class ForecastViewController: UIViewController, ForecastDataRetrevedDelegate {
    var forecastView: ForecastView?
    var weatherPresenter: WeatherPresenter
    
    init(presenter: WeatherPresenter) {
        self.weatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
        weatherPresenter.forecastDataRetrievedDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateForecast() {
        let array = weatherPresenter.forecast
        print("IN FORECAST VC")
        print(array)
        //forecastView?.cityTitle.text = weatherPresenter.city
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        let forecastView = ForecastView(frame: UIScreen.main.bounds)
        self.forecastView = forecastView
        self.view.addSubview(forecastView)
        
        forecastView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}
