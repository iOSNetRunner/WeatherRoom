//
//  ForecastViewController.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 22.06.2023.
//

import UIKit
import SpringAnimation

final class ForecastViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var weatherImage: SpringImageView!
    
    @IBOutlet var currentWeatherLabel: UILabel!
    @IBOutlet var dayTemperatureLabel: UILabel!
    @IBOutlet var nightTemperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    
    //MARK: - Public properties
    var url: URL!
    
    //MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchCurrentForecast(for: url)
        setAnimation()
    }
    //MARK: - Networking
    private func fetchCurrentForecast(for location: URL) {
        
        URLSession.shared.dataTask(with: location) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let forecastInfo = try decoder.decode(ForecastInfo.self, from: data)
                
                DispatchQueue.main.async {
                    self.currentWeatherLabel.text = forecastInfo.dataseries.first?.weather
                    self.dayTemperatureLabel.text = "\(String( forecastInfo.dataseries.first?.temperature.max ?? 0)) ℃"
                    self.nightTemperatureLabel.text = "\(String(forecastInfo.dataseries.first?.temperature.min ?? 0)) ℃"
                    self.windSpeedLabel.text = "\(String(forecastInfo.dataseries.first?.windSpeed ?? 0)) m/s"
                    self.activityIndicator.stopAnimating()
                    self.setIconForCurrentWeather()
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    //MARK: - Private Methods
    private func setIconForCurrentWeather() {
        switch currentWeatherLabel.text {
        case "rain", "lightrain", "oshower", "ishower":
            weatherImage.image = UIImage(systemName: "cloud.rain.fill")?.withRenderingMode(.alwaysOriginal)
        case "mcloudy", "cloudy":
            weatherImage.image = UIImage(systemName: "cloud.fill")?.withRenderingMode(.alwaysOriginal)
        case "pcloudy":
            weatherImage.image = UIImage(systemName: "cloud.sun.fill")?.withRenderingMode(.alwaysOriginal)
        case "clear":
            weatherImage.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
        case "lightsnow", "snow":
            weatherImage.image = UIImage(systemName: "cloud.snow.fill")?.withRenderingMode(.alwaysOriginal)
        case "rainsnow":
            weatherImage.image = UIImage(systemName: "cloud.sleet.fill")?.withRenderingMode(.alwaysOriginal)
        case "ts", "pts":
            weatherImage.image = UIImage(systemName: "cloud.bolt.fill")?.withRenderingMode(.alwaysOriginal)
        default: weatherImage.image = UIImage(systemName: "sun.max.trianglebadge.exclamationmark.fill")
        }
    }
    
    private func setAnimation() {
        weatherImage.animation = "zoomIn"
        weatherImage.duration = 1
        weatherImage.animate()
        
        weatherImage.animation = "pop"
        weatherImage.force = 0.2
        weatherImage.duration = 3
        weatherImage.repeatCount = .infinity
        weatherImage.animate()
    }
}
