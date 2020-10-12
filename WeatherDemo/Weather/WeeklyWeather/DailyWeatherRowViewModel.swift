

import Foundation
import SwiftUI

struct DailyWeatherRowViewModel: Identifiable {
    private let item: WeatherItem

    var id: String {
        day + temperature + title
    }

    var day: String {
        dayFormatter.string(from: item.dt)
    }

    var month: String {
        monthFormatter.string(from: item.dt)
    }

    var temperature: String {
        String(format: "%.1f", item.main.temperature)
    }

    var title: String {
        guard let title = item.weather.first?.main else { return "" }
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
extension DailyWeatherRowViewModel: Hashable {
    static func == (lhs: DailyWeatherRowViewModel, rhs: DailyWeatherRowViewModel) -> Bool {
        lhs.day == rhs.day
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(day)
    }
}
