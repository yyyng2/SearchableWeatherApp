//
//  APIService.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import Alamofire
import SwiftyJSON

class APIService {
    
    let repository = ForecastRepository()
    
//    func requestWeather(lat: Double, lon: Double, completionHandler: @escaping (DataResponse<City, AFError>) -> ()) {
//
//        let api = WeatherAPI.request(lat: lat, lon: lon, appid: APIKey.openWeather, units: "metric")
//
//        User.userLat = lat
//        User.userLon = lon
//        print(api.path)
//
//        AF.request(api.path, method: .get, parameters: api.parameters, encoding: URLEncoding(arrayEncoding: .noBrackets)).responseDecodable(of: City.self) { response in
//            print(response)
//            completionHandler(response)
//        }
//    }
    
    func requestForecast(lat: Double, lon: Double, completionHandler: @escaping ([ForecastModel], [CurrentWeatherModel]) -> ()) {

        let api = WeatherAPI.reqeustForecast(lat: lat, lon: lon, appid: APIKey.openWeather, units: "metric")

        User.userLat = lat
        User.userLon = lon

        AF.request(api.path, method: .get, parameters: api.parameters, encoding: URLEncoding(arrayEncoding: .noBrackets)).responseData(completionHandler: { response in
            switch response.result {
            case .success(let value):
                self.repository.deleteAll()
                
                var result: [ForecastModel] = []
                
                var currentWeather: [CurrentWeatherModel] = []
            
                
                let json = JSON(value)
                
                if let items = json["list"].array {
                    for item in items {
                        let temp = item["main"]["temp"].doubleValue
                        let temp_min = item["main"]["temp_min"].doubleValue
                        let temp_max = item["main"]["temp_max"].doubleValue
                        var icon = ""
                        if let weather = item["weather"].array {
                            for i in weather {
                                icon = i["icon"].stringValue
                            }
                        }
                  
                        let dtTxt = item["dt_txt"].stringValue
                        
                        let date = dtTxt.replacingOccurrences(of: "+0000", with: "").stringFormatToDate()
                        
                        result.append(ForecastModel(temp: temp, temp_min: temp_min, temp_max: temp_max, icon: icon.dropLast(1).description, dt_txt: date))
            
                        let task = Forecast(temp: temp, icon: icon.dropLast(1).description, date: date, temp_max: temp_max, temp_min: temp_min)
                        self.repository.addRecord(record: task)
                      
                    }
                }
                
                let temp = json["list"][0]["main"]["temp"].doubleValue
                let temp_min = json["list"][0]["main"]["temp_min"].doubleValue
                let temp_max = json["list"][0]["main"]["temp_max"].doubleValue
                let pressure = json["list"][0]["main"]["pressure"].intValue
                let humidity = json["list"][0]["main"]["humidity"].intValue
                
                let main = json["list"][0]["weather"][0]["main"].stringValue
                let description = json["list"][0]["weather"][0]["description"].stringValue
                
                let clouds = json["list"][0]["clouds"]["all"].intValue
                
                let speed = json["list"][0]["wind"]["speed"].doubleValue
                let gust = json["list"][0]["wind"]["gust"].doubleValue
                
                let name = json["city"]["name"].stringValue
                let lat = json["city"]["coord"]["lat"].doubleValue
                let lon = json["city"]["coord"]["lon"].doubleValue
                
                
                currentWeather.append(CurrentWeatherModel(pressure: pressure, humidity: humidity, clouds: clouds, temp: temp, lat: lat, lon: lon, speed: speed, gust: gust, temp_min: temp_min, temp_max: temp_max, city: name, main: main))
                User.pressure = pressure
                User.humidity = humidity
                User.clouds = clouds
                User.temp = temp
                User.lat = lat
                User.lon = lon
                User.speed = speed
                User.gust = gust
                User.tempMin = temp_min
                User.tempMax = temp_max
                User.city = name
                User.main = main
                
                
                User.lastUpdate = result[0].dt_txt
                
                completionHandler(result, currentWeather)

            case .failure(let error):
                print(error)
            }
        })
         
        }
    
    }

