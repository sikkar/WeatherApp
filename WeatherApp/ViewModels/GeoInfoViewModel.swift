//
//  GeoInfoViewModel.swift
//  WeatherApp
//
//  Created by Angel Escribano on 21/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit

class GeoInfoViewModel: NSObject {

    private let geoService = GeoInfoService()
    var geoInfoLocation: [GeoInfoModel] = []
    
    func requestGeoInfoFor(location: String, completion:@escaping((Error?) -> Void)){
        geoService.getGeoFromPlace(place: location) { [weak self] locations, error in
            guard let strongSelf = self else {return}
            if let requestError = error {
                completion(requestError)
            } else {
                if let locations = locations {
                    strongSelf.geoInfoLocation = locations
                    completion(nil)
                }
            }
        }
    }
}
