//
//  WeatherManager.swift
//  Clima
//
//  Created by иван Бирюков on 02.02.2023.
// File for structure working with URL API and data logick

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3031c9730cede0714743e59a76763c7e&units=metric"
    
    func fetchWeather(cityName: String){ // method which adapts our URL adress with user input in textField
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString) // Call the method which do the Networking. Input - our URL link.
    }
    
    
    func performRequest(urlString: String){ // created a method which will do Networking
        //1. Create a url (from basic method URL(string:)
        if let url = URL(string: urlString){ // cose our url -optional we will unwrap it and do other step when it exist
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default) // Create an object from basic APPLE class URLSession with one standart input, and set the value to this input = .default
            
            //3. Give a session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:)) // This step is done from just created session, when we call a standart method .dataTask. First input with: we set to pur if let url value. Second input whanna heve an function, so we need to create it. Becose this method restore back an data -> we save it in let.
            
            //4. Start the task
            task.resume() // with this one we will start our task
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void { // created an extra method for #3 input
        if error != nil { // Catching errors if they exist we will stop make a code
            return // just return keywoard means -> exit from this function and do not do it nexts steps.
        }
        
        if let safeData = data{ // unwraping incoming Data? becouse its optional
            let dataString = String(data: safeData, encoding: .utf8) // formated incoming data to string from internets data type .utf8 and saved it
            print(dataString)
        }
    }
}
