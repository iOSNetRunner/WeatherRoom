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
    
    init(forecastData: [String: Any]) {
        date = forecastData["date"] as? Int ?? 0
        weather = forecastData["weather"] as? String ?? ""
        temperature.max = forecastData.keys.first["max"] as? Int ?? 0
    }
}

struct Temperature: Decodable {
    var max: Int
    let min: Int
    
    init(temperatureData: [String: Any]) {
        max = temperatureData["max"] as? Int ?? 0
        min = temperatureData["min"] as? Int ?? 0
    }
}

struct ForecastInfo: Decodable {
    let dataseries: [Forecast]
    
    init(forecastDataSeries: [String : Any]) {
        
    }
}
