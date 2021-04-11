//
//  Weather.swift
//  WeatherApp
//
//  Created by Rocco Alexander on 2021-04-10.
//
//temperature (Celsius), feels like temperature (Celsius), wind (kph), wind direction, UV index, etc.
import Foundation
struct Weather : Codable {
    var cityName:String // location [{}] -> name
//    var tempC : Float // current [{}] -> temp_c
    var temperature :Float
    var feelsLikeTemp:Float
    var windKMH:Float
    var UV:Float
    var humidity:Int
    
    init(){
        self.cityName = ""
        self.temperature = 0.0
        self.feelsLikeTemp = 0.0
        self.windKMH = 0.0
        self.UV = 0.0
        self.humidity = 0
    }
    enum CodingKeys : String, CodingKey{
        case cityName = "name"
        case tempC = "temp_c"
        case feelsLikeTemp = "feelslike_c"
        case windKMH = "wind_kph"
        case UV = "uv"
        case humidity = "humidity"
        case location = "location"
        case current = "current"
    }
    func encode(to encoder: Encoder) throws {
        // nothing to do
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        let locationContainer = try response.decodeIfPresent(Location.self, forKey: .location)
        self.cityName = locationContainer?.location ?? "unavailable"
        let currentContainer = try response.decodeIfPresent(Current.self, forKey: .current)
        self.temperature = currentContainer?.tempC ?? -999.0
        self.feelsLikeTemp = currentContainer?.feelsLikeTemp ?? -999.0
        self.windKMH = currentContainer?.windKMS ?? -999.0
        self.UV = currentContainer?.uv ?? -999.0
        self.humidity = currentContainer?.humidity ?? -1
    }
}

struct Location : Codable{
    let location : String
    enum CodingKeys:String,CodingKey {
        case location = "name"
    }
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try response.decodeIfPresent(String.self,forKey: .location) ?? "Unavailable"
    }
}

struct Current : Codable {
    let tempC : Float
    let feelsLikeTemp : Float
    let windKMS : Float
    let uv : Float
    let humidity : Int
    enum CodingKeys:String,CodingKey {
        case tempC = "temp_c"
        case feelsLikeTemp = "feelslike_c"
        case windKMS = "wind_kph"
        case uv = "uv"
        case humidity = "humidity"
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.tempC = try response.decodeIfPresent(Float.self, forKey: .tempC) ?? -000.0
        self.feelsLikeTemp = try response.decode(Float.self, forKey: .feelsLikeTemp)
        self.windKMS = try response.decode(Float.self, forKey: .windKMS)
        self.uv = try response.decode(Float.self, forKey: .uv)
        self.humidity = try response.decode(Int.self, forKey: .humidity)
    }
    func encode(to encoder: Encoder) throws {
        //nt
    }
}
