//
//  ContentView.swift
//  Weather
//
//  Created by Abdul maalik on 20/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //    {"dt":1726833600,"main":{"temp":33.95,"feels_like":40.95,"temp_min":29.1,"temp_max":33.95,"pressure":1003,"sea_level":1003,"grnd_level":1002,"humidity":63,"temp_kf":4.85},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":40},"wind":{"speed":3.27,"deg":116,"gust":3.6},"visibility":10000,"pop":0.24,"rain":{"3h":0.46},"sys":{"pod":"d"},"dt_txt":"2024-09-20 12:00:00"}
    @State var viewModel = WeatherViewModel()
    
    
    var body: some View {
        ScrollView{
            TextField("Enter city..", text: $viewModel.cityName, onCommit: {
                viewModel.fetchWeatherData()
            }).onAppear(perform: {
                self.viewModel.cityName = "Bangalore"
                viewModel.fetchWeatherData()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(5)
            .frame(height: 40)
            .background(Color.gray)
            .keyboardType(.webSearch)
            
            
            Text("Weather Forecast")
                .font(.largeTitle)
                .padding(.top)
            
            
            WeatherDateListView()
                .environmentObject(viewModel)

            WeatherTimeListView()
                .environmentObject(viewModel)

            Spacer(minLength: 20)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Temperature: \(self.viewModel.selectedWeatherTime?.main?.temp ?? 0, specifier: "%.1f")°C")
                        Spacer()
                        Text("Feels Like: \(self.viewModel.selectedWeatherTime?.main?.feels_like ?? 0, specifier: "%.1f")°C")
                    }
                    
                    HStack {
                        Text("Min: \(self.viewModel.selectedWeatherTime?.main?.temp_min ?? 0, specifier: "%.1f")°C")
                        Spacer()
                        Text("Max: \(self.viewModel.selectedWeatherTime?.main?.temp_max ?? 0, specifier: "%.1f")°C")
                    }
                    
                    Text("Weather: \(self.viewModel.selectedWeatherTime?.weather?.first?.description?.capitalized ?? "")")
                    
                    HStack {
                        Text("Wind Speed: \(self.viewModel.selectedWeatherTime?.wind?.speed ?? 0, specifier: "%.1f") m/s")
                        Spacer()
                        Text("Wind Gust: \(self.viewModel.selectedWeatherTime?.wind?.deg ?? 0, specifier: "%.1f") m/s")
                    }
                    
                    HStack {
                        Text("Humidity: \(self.viewModel.selectedWeatherTime?.main?.humidity ?? 0)%")
                        Spacer()
                        Text("Pressure: \(self.viewModel.selectedWeatherTime?.main?.pressure ?? 0) hPa")
                    }
                }
                .padding(10)
            }
            .cornerRadius(10)
            .background(Color.blue.opacity(0.5))
            Spacer()
        }
        .padding(20)
    }
}

struct WeatherDateListView: View {
    @EnvironmentObject var viewModel : WeatherViewModel
    
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false, content: {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 100, maximum: 200))], spacing: 15) {
                ForEach(self.viewModel.getDateList, id: \.self) { weather in
                    WeatherDateViewCell(weatherData: weather)
                        .environmentObject(viewModel)
                         .onTapGesture {
                            self.viewModel.selectedWeatherDate = weather
                        }
                    
                    
                    
                }
            }
            
        })
        .frame(height: 50)
    }
}
struct WeatherTimeListView: View {
    
    @EnvironmentObject var viewModel : WeatherViewModel
    
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false, content: {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 100, maximum: 200))], spacing: 15) {
                ForEach(self.viewModel.displayDateWeatherList[self.viewModel.selectedWeatherDate ?? ""] ?? [], id: \.self) { weather in
                    WeatherViewCell(weatherData: weather)
                        .environmentObject(viewModel)
                        .onTapGesture {
                            self.viewModel.selectedWeatherTime = weather
                        }
                    
                    
                    
                }
            }
            
        })
    }
}
    
struct WeatherDateViewCell: View {
     var weatherData: String
    
    @EnvironmentObject var viewModel : WeatherViewModel

    var body: some View {
 
            VStack(spacing: 16) {
                // Display date and time
                Text("\(weatherData)")
                    .font(.headline)
             }
            .padding(10)
            .border((viewModel.selectedWeatherDate == self.weatherData) ? Color.blue.opacity(0.5) : Color.gray.opacity(0.5), width: 1.5)
            .background((viewModel.selectedWeatherDate == self.weatherData) ? Color.blue.opacity(0.5) : Color.gray.opacity(0.5))
            .cornerRadius(10)

            
     }
}
struct WeatherViewCell: View {
     var weatherData: WeatherList?
    
    @EnvironmentObject var viewModel : WeatherViewModel

    var body: some View {
 
            VStack(spacing: 16) {
                // Display date and time
                Text("\(self.weatherData?.displayDateTime ?? "")")
                    .font(.headline)
                Text("\(self.weatherData?.main?.temp ?? 0, specifier: "%.1f")°C")

                
                     Text("Rain:\(weatherData?.rain?.threeHrs ?? 0, specifier: "%.2f") mm")
             }
            .padding(10)
            .border((weatherData?.dt ?? 0 == self.viewModel.selectedWeatherTime?.dt ?? 0) ? Color.blue.opacity(0.5) : Color.gray.opacity(0.5), width: 1.5)
            .background((weatherData?.dt ?? 0 == self.viewModel.selectedWeatherTime?.dt ?? 0) ? Color.blue.opacity(0.5) : Color.gray.opacity(0.5))
            .cornerRadius(10)
     }
}
//SWIFT DATE
//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
