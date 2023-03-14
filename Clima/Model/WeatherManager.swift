//
//  WeatherManager.swift
//  Clima
//
//  Created by иван Бирюков on 02.02.2023.
// File for structure working with URL API and data logick

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {  // made an protocol to make WeahetManager functional Anonimety so every View (throught self.delegate setting) can make trigger method to update the weather
    func didUpdateWeather(weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWIthError(error: Error) // added method for delegate thats help us dismiss errors from our WeahterManager
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=enterAPIID&units=metric"
    var delegate: WeatherManagerDelegate? // made an Handler which can be trigeret by any Class who got it -> so it will run weahterupdate to ViewController
    
    func fetchWeather(cityName: String){ // method which adapts our URL adress with user input in textField
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString) // Call the method which do the Networking. Input - our URL link.
    }
    
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){ // created a method which will do Networking
        //1. Create a url (from basic method URL(string:)
        if let url = URL(string: urlString){ // cose our url -optional we will unwrap it and do other step when it exist
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default) // Create an object from basic APPLE class URLSession with one standart input, and set the value to this input = .default
            
            //3. Give a session a task
            let task = session.dataTask(with: url) { data, response, error in // This step is done from just created session, when we call a standart method .dataTask. First input with: we set to pur if let url value. Second input whanna heve an function, so we need to create it. Becose this method restore back an data -> we save it in let. Ufter know about Closure we dont need more extra create a func for input we made input like a Closure.
                
                if error != nil { // Catching errors if they exist we will stop make a code
                    self.delegate?.didFailWIthError(error: error!)
                    return // just return keywoard means -> exit from this function and do not do it nexts steps.
                }
                
                if let safeData = data{ // unwraping incoming Data? becouse its optional
                    if let weather = self.parseJSON(safeData) { // Call method thats translate to Struck incoming JSON data from openweathermap. set self. before name om method in Closure - its rule
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather) // set up method to update wheater Data, also sas who will trigger this method (self)
                    }
                }

            }
            
            //4. Start the task
            task.resume() // with this one we will start our task
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? { // Created method thats will translate JSON into struck data type, as input we set data whic we got from session.dataTask, and return an WeahetModel Optional Object
        let decoder = JSONDecoder() // created an objest from JSONDecoder() Apply Class to translate incoming data
        do { // in do block {} we are rapping every method that throw an error (every method with keywoard try)
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData) // Here we are decoding (transleting) our data. 1st parametr - Data Type, second - what data. We should mark this method with keywoard try, becouse he can trhow an error.
            
            let id = decodedData.weather[0].id // saved Id property to match its for weather picture changes
            let temp = decodedData.main.temp // Saved Temp value to transfer it
            let name = decodedData.name // Saved Name of city property to transfer it
            let wind = decodedData.wind.speed // Saved wind speed propertys value
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, windSpeed: wind) // Created an object from Weather model which will save all transleted propertyes from API request
            
//weather.conditionName // call to computed property thats in uotput gives us name of weahter picture to pass it for IBOutlet
            
            return weather // Becouse we got method with output - we need to return
            
            
            
        } catch { // and When he throws an error we can catch that error in block catch
                print(error)
            return nil // becouse we got method with output and even when we got error we need something to return
        }
    }
    
}
