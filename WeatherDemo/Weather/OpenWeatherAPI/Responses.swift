
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

struct WeatherItem: Codable {
    let date: Date
    let main: MainClass
    let name: String
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case name
    }
}

struct MainClass: Codable {
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

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
