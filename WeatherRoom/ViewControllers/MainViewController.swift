//
//  MainViewController.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 19.06.2023.
//

import UIKit

enum Link {
    case saintPetersburgURL
    
    var url: URL {
        switch self {
        case .saintPetersburgURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=30.324395&lat=59.929593&ac=0&unit=metric&output=json")!
        }
    }
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchForecast()
    }
}

extension MainViewController {
    private func fetchForecast() {
        
        URLSession.shared.dataTask(with: Link.saintPetersburgURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let forecastInfo = try decoder.decode(ForecastInfo.self, from: data)
                print(forecastInfo)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
