//
//  WeatherService.swift
//  Clima
//
//  Created by T.K Pius on 14/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherService {
    let wheatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c2ee4200d03e09a79437469f8064455a&units=metric"
    var delegate: WeatherDelegete?
    
    func fetchWeather(cityName: String) -> Void {
        let url = "\(self.wheatherUrl)&q=\(cityName)"
        self.performRequest(with: url)
    }
    
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees) -> Void {
        let url = "\(self.wheatherUrl)&lat=\(latitude)&lon=\(longitude)"
        self.performRequest(with: url)
    }
    
    func performRequest(with urlString: String) -> Void {
        // create a URL
        if let url = URL(string: urlString){
            // create URL session
//            let session = URLSession(configuration: .default)
            
            //give session a task
//            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let responseData = data{
//                    print(String(data: responseData, encoding: .utf8))
                    if let weatherModel = self.parseJson(with: responseData){
                        self.delegate?.didWeatherUpdate(weather: weatherModel)
                    }
                }
            })
            
            // start task
            task.resume()
        }
    }
    
    func parseJson(with responseData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodeResponse = try decoder.decode(WeatherModel.self, from: responseData)
            
            return decodeResponse
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

