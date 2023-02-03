//
//  WeatherData.swift
//  Clima
//
//  Created by иван Бирюков on 03.02.2023.
// This File was created for saving incoming Data from JSON into struck data type.

import Foundation

struct WeatherData: Decodable { // Created struck to save incoming weather data. By applying :Decodable protocol we are saying that this struckt can now decording its self from external representation.
    let name: String
    let main: Main // so we make its qual way main.temp
    let weather: [Weather] // adopt way weather[0].description
}

struct Main: Decodable { // Create another struct becouse for property temp in our url we got that way: main.temp -> thats meants that main is an object with property temp
    let temp: Double
}

struct Weather: Decodable { // Create another struct becouse for property discription in our url we got that way: weather[0].description -> 
    let description: String
}
