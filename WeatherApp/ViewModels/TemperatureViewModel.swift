//
//  TemperatureViewModel.swift
//  WeatherApp
//
//  Created by Angel Escribano on 21/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit

class TemperatureViewModel: NSObject {
    
    private let tempService = TemperatureService()
    var temperatureInfo: [TemperatureModel] = []
    
    func getTemperatureInfo(geoInfo: GeoInfoModel, completion:@escaping((Int?,Error?) -> Void)) {
        tempService.getGeoLocationTemperature(geoInfo: geoInfo) { [weak self] tempArray, error in
            guard let strongSelf = self else {return}
            if let requestError = error {
                completion(0,requestError)
            } else {
                if let temperatureArray = tempArray {
                    strongSelf.temperatureInfo = temperatureArray
                    let avgTemp = strongSelf.calculateTemperatureFromInfo()
                    completion(avgTemp,nil)
                }
            }
        }
    }
    
    func calculateTemperatureFromInfo() -> Int {
        var temperature : Double = 0
        for tempInfo in self.temperatureInfo {
            temperature = temperature + Double(tempInfo.temperature!)!
        }
        
        if self.temperatureInfo.count != 0 {
            temperature = temperature / Double((self.temperatureInfo.count))
        }
        return Int(temperature)
    }

}
