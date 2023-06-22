//
//  CitiesListViewController.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 22.06.2023.
//

import UIKit

enum City: CaseIterable {
    case saintPetersburg
    case moscow
    case berlin
    case losAngeles
    case newYork
    case mostar
    case milan
    case hikkaduwa
    case montreal
    case norilsk
    
    var title: String {
        switch self {
        case .saintPetersburg:
            return "Saint-Petersburg"
        case .moscow:
            return "Moscow"
        case .berlin:
            return "Berlin"
        case .losAngeles:
            return "Los Angeles"
        case .newYork:
            return "New York"
        case .mostar:
            return "Mostar"
        case .milan:
            return "Milan"
        case .hikkaduwa:
            return "Hikkaduwa"
        case .montreal:
            return "Montreal"
        case .norilsk:
            return "Norilsk"
        }
    }
}

final class CitiesListViewController: UITableViewController {
    
    //MARK: - Private Properties
    private let cities = City.allCases
    private let links = Link.allCases
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setTableViewGradient()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count / cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cities[indexPath.section].title
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let forecastVC = segue.destination as? ForecastViewController else { return }
        forecastVC.title = cities[indexPath.section].title
        forecastVC.url = links[indexPath.section].url
    }
}
