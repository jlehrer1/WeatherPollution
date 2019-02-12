//
//  WeatherViewController.swift
//  AirPollution
//
//  Created by Julian Lehrer on 2/10/19.
//  Copyright © 2019 Julian Lehrer. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempOutlet: UILabel!
    var API_KEY_WEATHER = "db642cf7009906f979c7ca0c9ba8aa82"
    var WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let locationManager = CLLocationManager()
    let weatherModel = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherData(url: String, parameters: [String : String]) {
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if (response.result.isSuccess) {
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            } else {
                print("getWeatherRequest failed")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func updateWeatherData(json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            weatherModel.temperature = Int((tempResult - 273.15) * 9/5 + 32)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            
            updateUIWithWeatherData()
        }
    }
    
    //GET LOCACATION AND HANDLE ERROR
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
        }
        
        let lat = String(location.coordinate.latitude)
        let long = String(location.coordinate.longitude)
        
        let params : [String : String] = ["lat" : lat, "lon" : long, "appid" : API_KEY_WEATHER]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    //
    
    //UPDATE UI
    func updateUIWithWeatherData() {
        cityLabel.text = weatherModel.city
        tempOutlet.text = "\(weatherModel.temperature) F"
        imageView.image = UIImage(named: weatherModel.weatherIconName)
    }
}
