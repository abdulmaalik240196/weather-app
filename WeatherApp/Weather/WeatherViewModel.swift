//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Abdul maalik on 20/09/24.
//

import UIKit

@Observable class WeatherViewModel: ObservableObject {
    
    var weatherList: [WeatherList] = []
    
    var getDateList : [String] {
        return displayDateWeatherList.keys.map { date in
            return date
        }
    }
    
    var displayDateWeatherList : [String:[WeatherList]] = [:]{
        didSet{
            self.selectedWeatherDate = self.displayDateWeatherList.first?.key
            self.selectedWeatherTime = self.displayDateWeatherList[self.selectedWeatherDate ?? ""]?.first
        }
    }
    var selectedWeatherDate: String?{
        didSet{
            self.selectedWeatherTime = self.displayDateWeatherList[self.selectedWeatherDate ?? ""]?.first
        }
    }
    var selectedWeatherTime: WeatherList?
    
    var cityName: String = ""
    
    func fetchWeatherData() {
        let apiKey = "c49b4b07e0bc3fa699f6e6e382fe0a2d"
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data")
                return
            }
            let weatherResponse = try? JSONDecoder().decode(WeatherResponseModel.self, from: data)
            DispatchQueue.main.async {
                self.weatherList = []
                let weatherListData = weatherResponse?.list ?? []
                for weatherList in weatherListData{
                    var data = weatherList
                    data.displayDate = self.formatDate(timestamp: weatherList.dt ?? 0,isShowTime: false)
                    data.displayDateTime = self.formatDate(timestamp: weatherList.dt ?? 0)
                    
                    
                    self.weatherList.append(data)
                }
                let groupData = Dictionary(grouping: self.weatherList, by: {$0.displayDate ?? "-"})
                
                self.displayDateWeatherList = groupData
            }
        }.resume()
    }
    // Helper function to format date
    func formatDate(timestamp: Int,isShowTime:Bool = true) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let calendar = Calendar.current
        let now = Date.now
        let startOfToday = calendar.startOfDay(for: now)
        let startOfDayOnDate = calendar.startOfDay(for: date)
        let formatter = DateFormatter()
        
        let daysFromToday = calendar.dateComponents([.day], from: startOfToday, to: startOfDayOnDate).day!
        
        if abs(daysFromToday) <= 1 {
            // Yesterday, today or tomorrow
            formatter.dateStyle = .full
            formatter.doesRelativeDateFormatting = true
        }
        else if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
            // Another date this year
            formatter.setLocalizedDateFormatFromTemplate(isShowTime ? "HH:mm a" : "EEEE")
        }
        else {
            // Another date in another year
            formatter.setLocalizedDateFormatFromTemplate(isShowTime ? "HH:mm a" : "EEEE")
        }
        return formatter.string(from: date)
    }
}

