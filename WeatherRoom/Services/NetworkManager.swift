//
//  NetworkManager.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 22.06.2023.
//

import Foundation

enum Location {
    case SPB
    case MSK
    case BER
    case NY
    case LA
    case MSR
    case MIL
    case HKW
    case MNT
    case NOR
    
    var coordinates: [String] {
        switch self {
        case .SPB: return ["30.324395", "59.929593"]
        case .MSK: return ["37.618962", "55.755358"]
        case .BER: return ["13.391243", "52.517347"]
        case .NY: return ["-73.994429", "40.714315"]
        case .LA: return ["-118.208229", "33.815092"]
        case .MSR: return ["17.810020", "43.348254"]
        case .MIL: return ["9.190022", "45.464248"]
        case .HKW: return ["80.099866", "6.136289"]
        case .MNT: return ["-73.576550", "45.479278"]
        case .NOR: return ["88.210548", "69.343999"]
        }
    }
}

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
            return URL(string: NetworkManager.shared.getURLfrom(Location.SPB))!
        case .moscowURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.MSK))!
        case .berlinURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.BER))!
        case .losAngelesURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.LA))!
        case .newYorkURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.NY))!
        case .mostarURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.MSR))!
        case .milanURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.MIL))!
        case .hikkaduwaURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.HKW))!
        case .montrealURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.MNT))!
        case .norilskURL:
            return URL(string: NetworkManager.shared.getURLfrom(Location.NOR))!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
//    func fetchForecast(for location: URL) {
//
//        URLSession.shared.dataTask(with: location) { data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let forecastInfo = try decoder.decode(ForecastInfo.self, from: data)
//
//                print(forecastInfo)
//            } catch {
//                print(error)
//            }
//
//        }.resume()
//    }
    
    func getURLfrom(_ location: Location) -> String {
        guard let lon = location.coordinates.first else { return "0"}
        guard let lat = location.coordinates.last else { return "0"}
        
        return "https://www.7timer.info/bin/civillight.php?lon=\(lon)&lat=\(lat)&ac=0&unit=metric&output=json"
        }
}
