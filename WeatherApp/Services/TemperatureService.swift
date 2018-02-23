//
//  TemperatureService.swift
//  WeatherApp
//
//  Created by Angel Escribano on 23/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class TemperatureService: NSObject {
    
    private let baseURL = "http://api.geonames.org/weatherJSON"
    
    func getGeoLocationTemperature(geoInfo: GeoInfoModel, completionHandler: @escaping (([TemperatureModel]?, Error?) -> Void)) {
        
        var parameters: [String: Any] = [:]
        
        if let north = geoInfo.north, let south = geoInfo.south, let east = geoInfo.east, let west = geoInfo.west {
            parameters = ["north":north,
                          "south":south,
                          "east":east,
                          "west":west,
                          "username":"ilgeonamessample"]
        }
        
        let request = Alamofire.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseArray(queue: DispatchQueue.global(), keyPath: "weatherObservations") { (response: DataResponse<[TemperatureModel]>) in
            if response.result.isSuccess {
                if let tempArray = response.result.value {
                    completionHandler(tempArray, nil)
                } else {
                    completionHandler(nil, response.error)
                }
            } else {
                completionHandler(nil, response.error)
            }
        }
        
        print(request.debugDescription)
    }
    
}
