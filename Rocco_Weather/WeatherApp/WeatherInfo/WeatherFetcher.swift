//
//  WeatherFetcher.swift
//  WeatherApp
//
//  Created by Rocco Alexander on 2021-04-10.
//

import Foundation
class WeatherFether : ObservableObject{
    @Published var weatherList = Weather()
    //    Singleton Instance
    private static var shared : WeatherFether?
    
    static func getInstance() -> WeatherFether{
        if shared != nil{
            
            return shared!
        }else{
            return WeatherFether()
        }
    }
    func fetchDataFromAPI(selectedCity:String){
        var urlCityName = selectedCity
        if urlCityName.contains(" "){
            urlCityName = urlCityName.replacingOccurrences(of: " ", with: "%20")
        }
        guard let api = URL(string: "https://api.weatherapi.com/v1/current.json?key=37dcaf9520124e279ad195909211004&q=\(urlCityName)&aqi=no")else{
            return
        }
        print(api)
        URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error{
                print(#function, "Could not fetch data",err)
            }else{
                // recieved data or res
                do{
                    if let jsonData = data{
                        let decoder = JSONDecoder()
                        let decodedList = try decoder.decode(Weather.self, from: jsonData)
                        DispatchQueue.main.async {
                            self.weatherList = decodedList
                        }
                    }else{
                        print(#function,"no json data has been recieved.")
                    }
                }catch let error{
                    print(#function,error)
                }
            }
        }.resume()
    }
}
