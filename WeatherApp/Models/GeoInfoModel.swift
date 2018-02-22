//
//  GeoModel.swift
//  WeatherApp
//
//  Created by Angel Escribano on 21/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import ObjectMapper

struct GeoInfoModel: Mappable {
    
    var name: String?
    var countryName: String?
    var population: Int?
    var lat: String?
    var lng: String?
    var east: Double?
    var south: Double?
    var north: Double?
    var west: Double?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.countryName <- map["countryName"]
        self.population <- map["population"]
        self.lat <- map["lat"]
        self.lng <- map["lng"]
        self.east <- map["east"]
        self.south <- map["south"]
        self.north <- map["north"]
        self.west <- map["west"]
    }
    
}
