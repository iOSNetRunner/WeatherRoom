//
//  Forecast.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 19.06.2023.
//

struct Forecast {
    let date: Int
    let weather: String
    let temperature: Temperature
    let windSpeed: Int
    
    init(forecastData: [String: Any]) {
        date = forecastData["date"] as? Int ?? 0
        weather = forecastData["weather"] as? String ?? ""
        let temperatureDict = forecastData["temp2m"] as? [String: Any] ?? [:]
        temperature = Temperature(temperatureData: temperatureDict)
        windSpeed = forecastData["wind10m_max"] as? Int ?? 0
        
    }
    
    static func getForecasts(from value: Any) -> [Forecast] {
        guard let value = value as? [String: Any] else { return [] }
        guard let dataseries = value["dataseries"] as? [[String: Any]] else { return [] }
        return dataseries.map { Forecast(forecastData: $0) }
    }
}

struct Temperature {
    var max: Int
    let min: Int
    
    init(temperatureData: [String: Any]) {
        max = temperatureData["max"] as? Int ?? 0
        min = temperatureData["min"] as? Int ?? 0
    }
}
