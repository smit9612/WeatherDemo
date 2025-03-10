import SwiftUI

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel

    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            if viewModel.dataSource.isEmpty {
                emptySection
            } else {
                cityHourlyWeatherSection
                forecastSection
            }
        }.onAppear(perform: viewModel.fetchWeather)
            .listStyle(GroupedListStyle())
            .navigationBarTitle(viewModel.city)
    }
}

private extension WeeklyWeatherView {
    var forecastSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
        }
    }

    var cityHourlyWeatherSection: some View {
        Section {
            NavigationLink(destination: viewModel.currentWeatherView) {
                VStack(alignment: .leading) {
                    Text(viewModel.city)
                    Text("Weather today")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}

struct WeeklyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
