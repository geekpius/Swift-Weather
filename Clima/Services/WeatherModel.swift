//
//  WeatherModel.swift
//  Clima
//
//  Created by T.K Pius on 14/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    var getName: String{
        return self.name
    }
}


struct Weather: Codable {
    let id: Int
    let description: String
    
    var getConditionIcon: String{
        switch self.id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...521:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}


struct Main: Codable {
    let temp: Double
    
    var getTemperature: String{
        return String(format: "%.1f", self.temp)
    }
}
