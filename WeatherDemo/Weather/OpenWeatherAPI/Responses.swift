
import Foundation

struct WeeklyForecastResponse: Codable {
    let list: [Item]

    struct Item: Codable {
        let date: Date
        let main: MainClass
        let weather: [Weather]

        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }

    struct MainClass: Codable {
        let temp: Double
    }

    struct Weather: Codable {
        let main: MainEnum
        let weatherDescription: String

        enum CodingKeys: String, CodingKey {
            case main
            case weatherDescription = "description"
        }
    }

    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
}

struct CurrentWeatherForecastResponse: Decodable {
    let coord: Coord
    let main: Main

    struct Main: Codable {
        let temperature: Double
        let humidity: Int
        let maxTemperature: Double
        let minTemperature: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }

    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentWeatherForecastCitiesResponse = try? newJSONDecoder().decode(CurrentWeatherForecastCitiesResponse.self, from: jsonData)

import Foundation

// MARK: - CurrentWeatherForecastCitiesResponse

struct CurrentWeatherForecastCitiesResponse: Codable {
    var message, cod: String?
    var count: Int?
    var forecastList: [ForecastList]?
}

// MARK: - List

struct ForecastList: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var main: Main?
    var dt: Int?
    var wind: Wind?
    var sys: Sys?
    var rain, snow: Rain?
    var clouds: Clouds?
    var weather: [Weather]?
}

// MARK: - Clouds

struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord

struct Coord: Codable {
    var lat, lon: Double?
}

// MARK: - Main

struct Main: Codable {
    var temp: Double?
    var pressure, humidity: Int?
    var tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys

struct Sys: Codable {
    var country: String?
}

// MARK: - Weather

struct Weather: Codable {
    var id: Int?
    var main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind

struct Wind: Codable {
    var speed: Double?
    var deg, gust: Int?
}

struct Rain: Codable {
    var oneHour, threeHour: Double?
}

typealias Snow = Rain
