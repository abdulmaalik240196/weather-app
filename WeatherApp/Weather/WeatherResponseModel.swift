//
//  WeatherResponseModel.swift
//  Weather
//
//  Created by Abdul maalik on 20/09/24.
//

import Foundation


struct WeatherResponseModel : Codable {
    let cod : String?
    let message : Int?
    let cnt : Int?
    let list : [WeatherList]?
    let city : City?
    
    enum CodingKeys: String, CodingKey {
        
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try? values.decodeIfPresent(String.self, forKey: .cod)
        message = try? values.decodeIfPresent(Int.self, forKey: .message)
        cnt = try? values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try? values.decodeIfPresent([WeatherList].self, forKey: .list)
        city = try? values.decodeIfPresent(City.self, forKey: .city)
    }
    
}


struct WeatherList : Codable,Hashable,Identifiable {
    
    var id: ObjectIdentifier?
    var displayDate : String?
    var displayDateTime : String?
    
    let dt : Int?
    let main : MainWeather?
    let weather : [Weather]?
    let clouds : Clouds?
    let wind : Wind?
    let visibility : Int?
    let pop : Double?
    let rain : Rain?
    let sys : Sys?
    let dt_txt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case rain = "rain"
        case sys = "sys"
        case dt_txt = "dt_txt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try? values.decodeIfPresent(Int.self, forKey: .dt)
        main = try? values.decodeIfPresent(MainWeather.self, forKey: .main)
        weather = try? values.decodeIfPresent([Weather].self, forKey: .weather)
        clouds = try? values.decodeIfPresent(Clouds.self, forKey: .clouds)
        wind = try? values.decodeIfPresent(Wind.self, forKey: .wind)
        visibility = try? values.decodeIfPresent(Int.self, forKey: .visibility)
        pop = try? values.decodeIfPresent(Double.self, forKey: .pop)
        rain = try? values.decodeIfPresent(Rain.self, forKey: .rain)
        sys = try? values.decodeIfPresent(Sys.self, forKey: .sys)
        dt_txt = try? values.decodeIfPresent(String.self, forKey: .dt_txt)
    }
    
}
struct MainWeather : Codable,Hashable,Identifiable {
    
    var id: ObjectIdentifier?
    let temp : Double?
    let feels_like : Double?
    let temp_min : Double?
    let temp_max : Double?
    let pressure : Int?
    let sea_level : Int?
    let grnd_level : Int?
    let humidity : Int?
    let temp_kf : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try? values.decodeIfPresent(Double.self, forKey: .temp)
        feels_like = try? values.decodeIfPresent(Double.self, forKey: .feels_like)
        temp_min = try? values.decodeIfPresent(Double.self, forKey: .temp_min)
        temp_max = try? values.decodeIfPresent(Double.self, forKey: .temp_max)
        pressure = try? values.decodeIfPresent(Int.self, forKey: .pressure)
        sea_level = try? values.decodeIfPresent(Int.self, forKey: .sea_level)
        grnd_level = try? values.decodeIfPresent(Int.self, forKey: .grnd_level)
        humidity = try? values.decodeIfPresent(Int.self, forKey: .humidity)
        temp_kf = try? values.decodeIfPresent(Double.self, forKey: .temp_kf)
    }
    
}

struct City : Codable,Hashable,Identifiable {
    let id : Int?
    let name : String?
    let coord : Coord?
    let country : String?
    let population : Int?
    let timezone : Int?
    let sunrise : Int?
    let sunset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        coord = try? values.decodeIfPresent(Coord.self, forKey: .coord)
        country = try? values.decodeIfPresent(String.self, forKey: .country)
        population = try? values.decodeIfPresent(Int.self, forKey: .population)
        timezone = try? values.decodeIfPresent(Int.self, forKey: .timezone)
        sunrise = try? values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try? values.decodeIfPresent(Int.self, forKey: .sunset)
    }
    
}


struct Clouds : Codable,Hashable,Identifiable {
    
    var id: ObjectIdentifier?
    let all : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case all = "all"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try? values.decodeIfPresent(Int.self, forKey: .all)
    }
    
}
struct Coord : Codable,Hashable,Identifiable {
    
    var id: ObjectIdentifier?
    let lon : Double?
    let lat : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lon = "lon"
        case lat = "lat"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lon = try? values.decodeIfPresent(Double.self, forKey: .lon)
        lat = try? values.decodeIfPresent(Double.self, forKey: .lat)
    }
    
}

struct Sys : Codable,Hashable,Identifiable {
    
    let type : Int?
    let id : Int?
    let country : String?
    let sunrise : Int?
    let sunset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try? values.decodeIfPresent(Int.self, forKey: .type)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        country = try? values.decodeIfPresent(String.self, forKey: .country)
        sunrise = try? values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try? values.decodeIfPresent(Int.self, forKey: .sunset)
    }
    
}
struct Weather : Codable,Hashable,Identifiable {
    
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        main = try? values.decodeIfPresent(String.self, forKey: .main)
        description = try? values.decodeIfPresent(String.self, forKey: .description)
        icon = try? values.decodeIfPresent(String.self, forKey: .icon)
    }
    
}
struct Wind : Codable,Hashable,Identifiable {
    
    var id: ObjectIdentifier?
    let speed : Double?
    let deg : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case deg = "deg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try? values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try? values.decodeIfPresent(Int.self, forKey: .deg)
    }
    
}
struct Rain : Codable,Hashable,Identifiable {
    
    var id: ObjectIdentifier?
    let threeHrs : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case threeHrs = "3h"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        threeHrs = try? values.decodeIfPresent(Double.self, forKey: .threeHrs)
    }
    
}
