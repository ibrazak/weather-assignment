//
//  City.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 07/09/2022.
//

import Foundation

struct CitiesResponse: Codable {
    let city: City?
    let time: Int?
    let main: Main?
}

struct City: Codable {
    let id: Int
    let name: String
    let findname: String
    let country: String
    let coord: CityCoordinate
    let zoom: Int
}

struct CityCoordinate: Codable {
    let lon: Double
    let lat: Double
}

struct Main: Codable {
    let temp: Double
    let pressure: Double?
    let humidity: Int?
    let tempMin: Double
    let tempMax: Double
    let wind: Wind?
    let clouds: Cloud?
    let weather: [Weather]?
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity, wind, clouds, weather
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let varBeg: Int
    let varEnd: Int
    
    enum CodingKeys: String, CodingKey {
        case speed, deg
        case varBeg = "var_beg"
        case varEnd = "var_end"
    }
}

struct Cloud: Codable {
    let all: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

//{"main":{"temp":291.15,"pressure":1017,"humidity":45,"temp_min":291.15,"temp_max":291.15},"wind":{"speed":9.3,"deg":240,"var_beg":200,"var_end":270},"clouds":{"all":75},"weather":[{"id":501,"main":"Rain","description":"proximity moderate rain","icon":"10d"}]}
