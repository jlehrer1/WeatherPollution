//
//  WeatherModel.swift
//  AirPollution
//
//  Created by Julian Lehrer on 2/10/19.
//  Copyright © 2019 Julian Lehrer. All rights reserved.
//

import UIKit

class WeatherModel {
    var temperature = 0;
    var condition = 0;
    var city = ""
    var weatherIconName = ""
    
    
    func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {

            case 0...300 :
                return "tstorm1"

            case 301...500 :
                return "light_rain"

            case 501...600 :
                return "shower3"

            case 601...700 :
                return "snow4"

            case 701...771 :
                return "fog"

            case 772...799 :
                return "tstorm3"

            case 800 :
                return "sunny"

            case 801...804 :
                return "cloudy2"

            case 900...903, 905...1000  :
                return "tstorm3"

            case 903 :
                return "snow5"

            case 904 :
                return "sunny"

            default :
                return "dunno"
        }
    }
}
