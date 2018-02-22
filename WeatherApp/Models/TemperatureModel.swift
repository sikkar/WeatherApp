//
//  TemperatureModel.swift
//  WeatherApp
//
//  Created by Angel Escribano on 21/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import ObjectMapper

struct TemperatureModel: Mappable {
    
    var temperature: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.temperature <- map["temperature"]
    }
    
}
