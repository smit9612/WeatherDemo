
import Combine
import Foundation

protocol WeatherFetchable {
    func weeklyWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError>

    func currentWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}

class WeatherFetcher {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - WeatherFetchable

extension WeatherFetcher: WeatherFetchable {
    func weeklyWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        forecast(with: makeWeeklyForecastComponents(withCity: city))
    }

    func currentWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
        forecast(with: makeCurrentDayForecastComponents(withCity: city))
    }

    private func forecast<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - OpenWeatherMap API

private extension WeatherFetcher {
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "9bcbb3d4f0f94863415fa09665f1e71e"
    }

    func makeWeeklyForecastComponents(
        withCity city: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/forecast"

        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key),
        ]

        return components
    }

    func makeCurrentDayForecastComponents(with lat: String, lon: String, count: String? = "10") -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/find"

        components.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "cnt", value: count),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key),
        ]

        return components
    }

    func makeCurrentDayForecastComponents(
        withCity city: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"

        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key),
        ]

        return components
    }
}
