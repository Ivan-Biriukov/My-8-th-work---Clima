//
//  ViewController.swift
//  Clima
//
//  Created by иван Бирюков on 01.02.2023.
//

import UIKit
import CoreLocation // insert an library for getting location

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager() // Created an object whic are working for location searching
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Our TextField report in our class her status (User Interaction)
        searchTextField.delegate = self
        locationManager.delegate = self // Set this View Cotroller as a Delegate for our Trigger so this View will triger that method

        locationManager.requestWhenInUseAuthorization() // So we asc an user allow to get information about his geoDataposition
        
        locationManager.requestLocation() // So we now get information about user location. One time delivery method
        weatherManager.delegate = self // Set this View Cotroller as a Delegate for our Trigger in WheaterManager^ so this View will triger that method
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate{ // Create Extension for our ViewController Class so we cand delite : UITextFieldDeligate ba class at the top
    
    // This method we need to check do user fill the TextField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Write name of the City"
            return false
        }
    }
    
    // This method helps us interact with a keyboard button "Go"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    // This method do itself when user done with TextField
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{  // save user written text with a city name
            weatherManager.fetchWeather(cityName: city)  // its Optional, so when its not nil then we will use it
        }
        searchTextField.text = ""
    }
    
    // Method from our search button
    @IBAction func searcxhPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)  //dismiss keyboard

    }
}

// MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate{ // Create Extension for our ViewController Class so we cand delite :WeatherManagerDelegate ba class at the top/
    
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel){ // Created method thats transfer weahert data from logic up to ViewController. Modify input with APPLE standarts - so we say who will trigger this method (WeatherManager)
        
        DispatchQueue.main.async { // Created standart Apple Method for Change UI in main thread (основной поток)
            self.temperatureLabel.text = weather.temperatureString
            self.windSpeedLabel.text = weather.windSpeedString
            self.weatherConditionImage.image = UIImage(systemName: weather.conditionName) // To change Images we should choose systemName property name
            self.cityNameLabel.text = weather.cityName
            
        }
        
    }
    
    func didFailWIthError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate{ // use this extention for taking a protocol thats needed by LocationManager to be delegated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // realised the method neded for protocol
        if let location = locations.last {  // In reason that Input of locations - array we can safly get information about location
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(longitude: lon, latitude: lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { // realised the method neded for protocol
        print(error)
    }
}

