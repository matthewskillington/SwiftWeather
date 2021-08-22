//
//  Network.swift
//  SwiftUI-Weather
//
//  Created by Matthew Skillington on 21/08/2021.
//

import Foundation

class Network {
    func getCityWeather(completion: @escaping (Result<CityWeather, Error>) -> Void){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=6056aff17720f1d131c75c6fe6cdd53c&units=metric") else {
            print("Invalid Url!"); return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let countries = try! JSONDecoder().decode(CityWeather.self, from: data!)
                completion(.success(countries))
                print(countries)
            } catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
            
        }.resume()
    }
}

