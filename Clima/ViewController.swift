//
//  ViewController.swift
//  Clima
//
//  Created by иван Бирюков on 01.02.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Our TextField report in our class her status (User Interaction)
        searchTextField.delegate = self
    }

    // Method from our search button
    @IBAction func searcxhPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)  //dismiss keyboard

    }
    
    
    // This method helps us interact with a keyboard button "Go"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    // This method do itself when user done with TextField
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = searchTextField.text   // save user written text with a city name
        searchTextField.text = ""
    }
    
    // This method we need to check do user fill the TextField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Write name of the City"
            return false
        }
    }
    
    
    
    
    
    
}

