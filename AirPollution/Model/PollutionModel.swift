//
//  PollutionModel.swift
//  AirPollution
//
//  Created by Julian Lehrer on 2/10/19.
//  Copyright © 2019 Julian Lehrer. All rights reserved.
//

import UIKit

class PollutionModel {
    var imageName = ""
    var dominantPollutant = ""
    var aqi = ""
    
    func getImageName(aqi: Int) -> String {
        switch (aqi) {
            case 0...50:
                return "healthy"
            case 51...100:
                return "moderate"
            case 101...150:
                return "moderate-sensitive"
            case 151...200:
                return "unhealthy"
            case 201...300:
                return "very-unhealthy"
            case 301...500:
                return "hazardous"
            default:
                return "unknown"
        }
    }
}
