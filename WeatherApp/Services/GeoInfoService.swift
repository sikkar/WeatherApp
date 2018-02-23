//
//  GeoInfoService.swift
//  WeatherApp
//
//  Created by Angel Escribano on 22/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class GeoInfoService: NSObject {

    private let baseURL = "http://api.geonames.org/searchJSON"
    
    func getGeoFromPlace(place: String, completionHandler: @escaping(([GeoInfoModel]?, Error?) -> Void)){
        
        let parameters: [String: Any] = ["q":place,
                                         "maxRows":20,
                                         "startRow":0,
                                         "lang":"en",
                                         "isNameRequired":true,
                                         "style":"FULL",
                                         "username":"ilgeonamessample"]
        
        let request = Alamofire.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseArray(queue: DispatchQueue.main, keyPath: "geonames") { (response: DataResponse<[GeoInfoModel]>) in
            if response.result.isSuccess {
                if let geoArray = response.result.value {
                    completionHandler(geoArray, nil)
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
