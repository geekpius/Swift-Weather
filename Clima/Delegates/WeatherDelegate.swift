//
//  WeatherDelegate.swift
//  Clima
//
//  Created by T.K Pius on 14/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDelegete {
    
    func didWeatherUpdate(weather: WeatherModel)
    
    func didFailWithError(error: Error)
}
