//
//  Forecast.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 19.06.2023.
//

struct Forecast: Decodable {
    let date: Int
    let weather: String
    let temperature: Temperature
    let windSpeed: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case weather = "weather"
        case temperature = "temp2m"
        case windSpeed = "wind10m_max"
    }
}

struct Temperature: Decodable {
    let max: Int
    let min: Int
}

struct ForecastInfo: Decodable {
    let dataseries: [Forecast]
}
