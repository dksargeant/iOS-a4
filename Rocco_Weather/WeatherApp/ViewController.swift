//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rocco Alexander on 2021-04-08.
//

import UIKit
import Combine
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var CityPicker: UIPickerView!
    var pickerData:[String] = [String]()
    let weatherFetcher = WeatherFether.getInstance()
    var weatherData : Weather = Weather()
    
//    Labels with colors
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempC: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var uvIndex: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var tempHidLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var windSpeedHiddenLabel: UILabel!
    @IBOutlet weak var uvHiddenLabel: UILabel!
    @IBOutlet weak var humidityHiddenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.CityPicker.delegate = self
        self.CityPicker.dataSource = self
//        Set up the City Picker Elements
        pickerData = ["Toronto", "Los Angeles", "New Delhi", "Tokyo", "Bejing", "Metro Manila","Bangkok","Ibiza","Berlin","Tehran"].sorted()
    }
    
    @IBAction func showWeather(_ sender: Any) {
        let selectedCity = pickerData[CityPicker.selectedRow(inComponent: 0)]
        self.weatherFetcher.fetchDataFromAPI(selectedCity: selectedCity)
        print(weatherData)
        self.weatherData = weatherFetcher.weatherList
        
        cityLabel.text = weatherData.cityName
        cityLabel.isHidden = false
        tempC.text = String(weatherData.temperature)
        tempC.isHidden = false
        feelsLike.text = String(weatherData.feelsLikeTemp)
        feelsLike.isHidden = false
        humidity.text = String(weatherData.humidity)
        humidity.isHidden = false
        uvIndex.text = String(weatherData.UV)
        uvIndex.isHidden = false
        windSpeed.text = String(weatherData.windKMH)
        windSpeed.isHidden = false
        tempHidLabel.isHidden = false
        feelsLikeTempLabel.isHidden = false
        humidityHiddenLabel.isHidden = false
        uvHiddenLabel.isHidden = false
        windSpeed.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    Number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
//    return data from row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}

