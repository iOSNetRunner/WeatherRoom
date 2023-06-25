//
//  NetworkManager.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 22.06.2023.
//

import Foundation

enum Link: CaseIterable {
    case saintPetersburgURL
    case moscowURL
    case berlinURL
    case losAngelesURL
    case newYorkURL
    case mostarURL
    case milanURL
    case hikkaduwaURL
    case montrealURL
    case norilskURL
    
    var url: URL {
        switch self {
        case .saintPetersburgURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=30.324395&lat=59.929593&ac=0&unit=metric&output=json")!
        case .moscowURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=37.618962&lat=55.755358&ac=0&unit=metric&output=json")!
        case .berlinURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=13.391243&lat=52.517347&ac=0&unit=metric&output=json")!
        case .losAngelesURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=-73.994429&lat=40.714315&ac=0&unit=metric&output=json")!
        case .newYorkURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=-118.208229&lat=33.815092&ac=0&unit=metric&output=json")!
        case .mostarURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=17.810020&lat=43.348254&ac=0&unit=metric&output=json")!
        case .milanURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=9.190022&lat=45.464248&ac=0&unit=metric&output=json")!
        case .hikkaduwaURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=80.099866&lat=6.136289&ac=0&unit=metric&output=json")!
        case .montrealURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=-73.576550&lat=45.479278&ac=0&unit=metric&output=json")!
        case .norilskURL:
            return URL(string: "https://www.7timer.info/bin/civillight.php?lon=88.210548&lat=69.343999&ac=0&unit=metric&output=json")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetch(from url: URL, completion: @escaping(Result<ForecastInfo, NetworkError>) -> Void) {

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let forecastInfo = try decoder.decode(ForecastInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(forecastInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
    
    
}
