
import Foundation

struct WeeklyForecastResponse: Codable {
    let list: [WeatherItem]
}

struct CurrentWeatherForecastResponse: Decodable {
    let coord: Coord
    let main: MainClass
}

// MARK: - CurrentWeatherForecastCitiesResponse

struct NearbyCitiesForeCastResponse: Codable {
    var message, cod: String?
    var count: Int?
    var list: [WeatherItem]
}

// MARK: - List

struct WeatherItem: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var main: MainClass
    var dt: Date
    var wind: Wind?
    var sys: Sys?
    var rain: Rain?
    var snow: Rain?
    var clouds: Clouds?
    var weather: [Weather]
}

// MARK: - Clouds

struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord

struct Coord: Codable {
    var lat, lon: Double
}

// MARK: - MainClass

struct MainClass: Codable {
    var temperature, feelsLike, minTemperature, maxTemperature: Double
    var pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Rain

struct Rain: Codable {
    var the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys

struct Sys: Codable {
    var country: String?
}

// MARK: - Weather

struct Weather: Codable {
    var id: Int?
    var main: String?
    var weatherDescription: String
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind

struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
