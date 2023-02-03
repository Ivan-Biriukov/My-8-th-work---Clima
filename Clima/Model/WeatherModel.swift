//
//  WeatherModel.swift
//  Clima
//
//  Created by иван Бирюков on 04.02.2023.
//Created this file to reorganize code with MVC Pattern

import Foundation

struct WeatherModel { // created the model for our finel object view (all properties we nned translated from JSON saved here)
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let windSpeed: Double
    
    var conditionName: String { // created Computed property thats match incoming ID value with ranges and gives back name of SF weather picture
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default: return "cloud"
        }
    }
    
    // Создадим еще 1 computed properties которое вернет нам значение температуры в качестве String с округлением до 1 десятичной
    var temperatureString: String{
       return String(format: "%.1f", temperature)
    }
    
    var  windSpeedString: String{
        return String(format: "%.1f", windSpeed)
    }
}
