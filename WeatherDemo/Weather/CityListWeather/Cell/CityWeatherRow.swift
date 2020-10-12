
import SwiftUI

struct CityWeatherRowView: View {
    private let viewModel: CityWeatherRowViewModel

    init(viewModel: CityWeatherRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Text("\(viewModel.name)")
                .font(.title)
            Spacer()
            VStack(alignment: .leading) {
                Text("Temp: \(viewModel.temperature)")
                    .font(.body)
                Text("Humidity: \(viewModel.humidity)")
                    .font(.footnote)
            }
            .padding(.leading, 8)
        }
    }
}
