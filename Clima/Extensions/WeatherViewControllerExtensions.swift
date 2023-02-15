//
//  WeatherViewControllerExtensions.swift
//  Clima
//
//  Created by T.K Pius on 14/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation



//Mark: - Extending TextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let search = self.searchTextField.text{
            weatherService.fetchWeather(cityName: search)
            return true
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchTextField.text = ""
    }
    
    
}

//Mark: - Extending WeatherDelegate

extension WeatherViewController: WeatherDelegete{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didWeatherUpdate(weather: WeatherModel) {
        DispatchQueue.main.async{
            self.cityLabel.text = weather.getName
            self.temperatureLabel.text = weather.main.getTemperature
            self.conditionImageView.image = UIImage(systemName: weather.weather[0].getConditionIcon)
        }
    }
}

//Mark: - Extending Core Location

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> Void {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            weatherService.fetchWeather(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
