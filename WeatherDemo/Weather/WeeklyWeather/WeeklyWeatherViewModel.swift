
import Combine
import SwiftUI

class WeeklyWeatherViewModel: ObservableObject {
    @Published var dataSource: [DailyWeatherRowViewModel] = []

    let city: String
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    init(
        city: String,
        weatherFetcher: WeatherFetchable,
        scheduler _: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        self.city = city
    }

    func fetchWeather() {
        weatherFetcher
            .weeklyWeatherForecast(forCity: city)
            .map { response in
                response.list.map(DailyWeatherRowViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.dataSource = forecast
                }
            )
            .store(in: &disposables)
    }
}

extension WeeklyWeatherViewModel {
    var currentWeatherView: some View {
        WeeklyWeatherBuilder.makeCurrentWeatherView(
            withCity: city,
            weatherFetcher: weatherFetcher
        )
    }
}
