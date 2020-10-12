

import Foundation
import SwiftUI

struct CityWeatherRowViewModel: Identifiable {
    private let item: WeatherItem

    var id: String {
        day + temperature + (item.name ?? title)
    }

    var name: String {
        item.name ?? ""
    }

    var day: String {
        dayFormatter.string(from: item.date)
    }

    var month: String {
        monthFormatter.string(from: item.date)
    }

    var humidity: String {
        String(format: "%d", item.main.humidity)
    }

    var temperature: String {
        String(format: "%.1f", item.main.temperature)
    }

    var title: String {
        guard let title = item.weather.first?.main.rawValue else { return "" }
        return title
    }

    var fullDescription: String {
        guard let description = item.weather.first?.weatherDescription else { return "" }
        return description
    }

    init(item: WeatherItem) {
        self.item = item
    }
}

// Used to hash on just the day in order to produce a single view model for each
// day when there are multiple items per each day.
extension CityWeatherRowViewModel: Hashable {
    static func == (lhs: CityWeatherRowViewModel, rhs: CityWeatherRowViewModel) -> Bool {
        lhs.day == rhs.day
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(day)
    }
}
