//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Matthew Skillington on 10/08/2021.
//

import SwiftUI
import UIKit


struct ContentView: View {
    
    @State private var isNight = false
    @State var cityWeather: CityWeather = CityWeather(name: "", id: 0, main: TempData())
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack{
                CityTextView(cityName: cityWeather.name)
                
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: Int(cityWeather.main.temp))
                
                HStack( spacing: 12){
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 77)
                    WeatherDayView(dayOfWeek: "THU", imageName: "cloud.sun.fill", temperature: 78)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 80)
                    WeatherDayView(dayOfWeek: "SAT", imageName: "sun.max.fill", temperature: 84)
                    WeatherDayView(dayOfWeek: "SUN", imageName: "sun.max.fill", temperature: 88)
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.bolt.fill", temperature: 79)
                }
                Spacer()
                
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
        .onAppear(){
            getCityWeatherData()
        }
    }
}

extension ContentView {
    func getCityWeatherData() {
        Network().getCityWeather {(result) in
            switch result {
            case .success(let cityWeather):
                DispatchQueue.main.async {
                    self.cityWeather = cityWeather
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
//    var topColor: Color
//    var bottomColor: Color
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

