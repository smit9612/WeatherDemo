
import SwiftUI

enum WeeklyWeatherBuilder {
    static func makeCurrentWeatherView(
        withCity city: String,
        weatherFetcher: WeatherFetchable
    ) -> some View {
        let viewModel = CurrentWeatherViewModel(
            city: city,
            weatherFetcher: weatherFetcher
        )
        return CurrentWeatherView(viewModel: viewModel)
    }

    static func makeWeeklyWeatherView(
        withCity city: String,
        weatherFetcher: WeatherFetchable
    ) -> some View {
        let viewModel = WeeklyWeatherViewModel(city: city, weatherFetcher: weatherFetcher)
        return WeeklyWeatherView(viewModel: viewModel)
    }
}
