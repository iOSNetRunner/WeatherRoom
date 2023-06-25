//
//  WeekForecastTableViewController.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 25.06.2023.
//

import UIKit
import Alamofire

final class WeekForecastTableViewController: UITableViewController {

    //MARK: - Public properties
    var url: URL!
    var selectedCityTitle: String!
    
    //MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var forecasts: [Forecast] = []
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setTableViewGradient()
        tableView.rowHeight = 80
        title = "\(selectedCityTitle ?? "Week forecast")"
        print(forecasts)
        fetchSelectedForecast()
        print(forecasts)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        forecasts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecasts.count / forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = convertToDate(from: forecasts[indexPath.section].date)
        content.textProperties.font = UIFont.systemFont(ofSize: 20)
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let forecastVC = segue.destination as? ForecastViewController else { return }
        forecastVC.forecast = forecasts[indexPath.section]
        forecastVC.title = selectedCityTitle
    }
    
    //MARK: - Private Methods
    private func convertToDate(from number: Int) -> String {
        var index = 0

        var day = ""
        var month = ""
        var year = ""

        for character in String(number) {
            switch index {
            case 0...3:
                year.append(character)
                index += 1
            case 4...5:
                month.append(character)
                index += 1
            default:
                day.append(character)
            }
        }

        let date = "\(day).\(month).\(year)"
        
        return date
    }
    
    //MARK: - Networking
//    private func fetchSelectedForecast() {
//        networkManager.fetch(from: url) { result in
//            switch result {
//            case .success(let forecastInfo):
//                self.forecasts = forecastInfo.dataseries
//                self.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func fetchSelectedForecast() {
        AF.request(url)
            .validate()
            .responseJSON { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let forecastsInfo = value as? [[String: Any]] else { return }
                    for forecastInfo in forecastsInfo {
//                      let forecast = ForecastInfo(
//                        dataseries: forecastInfo["dataseries"] as? [Forecast] ?? []
//                      )
//                        print(forecast)
                        
                        
                        
                        
//                        let forecast = Forecast(
//                            date: forecastData["date"] as? Int ?? 0,
//                            weather: forecastData["weather"] as? String ?? "",
//                            temperature: forecastData["temperature"] as! Temperature,
//                            windSpeed: forecastData["windSpeed"] as? Int ?? 0)

//                        let temperatureValues = Temperature(
//                            max: forecastData["max"] as? Int ?? 0,
//                            min: forecastData["min"] as? Int ?? 0
//                        )
//
//                        let forecastWithTemperature = Forecast(
//                            date: forecastData["date"] as? Int ?? 0,
//                            weather: forecastData["weather"] as? String ?? "",
//                            temperature: temperatureValues["max", "min"] as! Temperature,
//                            windSpeed: forecastData["windSpeed"] as? Int ?? 0)

                        self?.forecasts.append(contentsOf: forecast.dataseries)
                        
                    }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
                
                
            }
        
        
    }
    
}

