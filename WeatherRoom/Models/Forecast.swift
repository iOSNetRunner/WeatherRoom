//
//  Forecast.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 19.06.2023.
//

struct Forecast: Decodable {
    let date: Int
    let weather: String
    let temp2m: Temperature
    let wind10m_max: Int
}

struct Temperature: Decodable {
    let max: Int
    let min: Int
}

struct ForecastInfo: Decodable {
    let dataseries: [Forecast]
}

