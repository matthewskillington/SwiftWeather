//
//  CityWeather.swift
//  SwiftUI-Weather
//
//  Created by Matthew Skillington on 22/08/2021.
//

import Foundation

struct CityWeather: Codable, Hashable {
    var name: String
    var id: Int32
    var main: TempData
}

struct TempData: Codable, Hashable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    
    init(){
        self.temp = 0;
        self.feels_like = 0;
        self.temp_min = 0;
        self.temp_max = 0;
        self.pressure = 0;
        self.humidity = 0;
    }
}

