
import Foundation
import MapKit
import SwiftUI

struct CurrentWeatherRowViewModel {
    private let item: CurrentWeatherForecastResponse

    var temperature: String {
        String(format: "%.1f", item.main.temperature)
    }

    var maxTemperature: String {
        String(format: "%.1f", item.main.maxTemperature)
    }

    var minTemperature: String {
        String(format: "%.1f", item.main.minTemperature)
    }

    var humidity: String {
        String(format: "%.1f", item.main.humidity)
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: item.coord.lat, longitude: item.coord.lon)
    }

    init(item: CurrentWeatherForecastResponse) {
        self.item = item
    }
}
