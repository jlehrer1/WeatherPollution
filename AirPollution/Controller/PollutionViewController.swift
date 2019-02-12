//
//  ViewController.swift
//  AirPollution
//
//  Created by Julian Lehrer on 2/10/19.
//  Copyright © 2019 Julian Lehrer. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class PollutionViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var domPollutantLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var pollutionImage: UIImageView!
    var POLLUTION_URL = "https://api.breezometer.com/air-quality/v2/current-conditions"
    let API_KEY = "c399395641d74fcf92927872c877aebc"
    let pollutionModel = PollutionModel()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func getPollutionData(url: String, parameters: [String : String]) {
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if (response.result.isSuccess) {
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updatePollutionData(json: weatherJSON)
            } else {
                print(response.error!)
            }
        }
    }
    
    func updatePollutionData(json: JSON) {
        if let aqi = json["data"]["indexes"]["baqi"]["aqi"].int {
            let dominantPollutant = json["data"]["indexes"]["baqi"]["dominant_pollutant"].stringValue
            pollutionModel.dominantPollutant = dominantPollutant
            pollutionModel.imageName = pollutionModel.getImageName(aqi: aqi)
            pollutionModel.aqi = String(aqi)
            
            updateUIWithPollutionData()
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
        
        let params : [String : String] = ["lat" : lat, "lon" : long, "key" : API_KEY]
        getPollutionData(url: POLLUTION_URL, parameters: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    //
    
    //UPDATE UI
    func updateUIWithPollutionData() {
        domPollutantLabel.text = pollutionModel.dominantPollutant
        aqiLabel.text = pollutionModel.aqi
        pollutionImage.image = UIImage(named: pollutionModel.imageName)
    }

}

