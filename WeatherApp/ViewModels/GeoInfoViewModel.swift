//
//  GeoInfoViewModel.swift
//  WeatherApp
//
//  Created by Angel Escribano on 21/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit
import CoreData

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
    
    func saveGeoInfo(geoInfoData: GeoInfoModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GeoInfo")
        let predicate: NSPredicate = NSPredicate.init(format: "name = %@", geoInfoData.name!)
        fetchRequest.predicate = predicate
        do {
            let found = try managedContext.fetch(fetchRequest)
            if (found.count == 0){
                let entity = NSEntityDescription.entity(forEntityName: "GeoInfo", in: managedContext)!
                let geoInfo = NSManagedObject(entity: entity, insertInto: managedContext)
                geoInfo.setValue(geoInfoData.name, forKeyPath: "name")
                geoInfo.setValue(geoInfoData.countryName, forKey: "countryName")
                geoInfo.setValue(geoInfoData.population, forKey: "population")
                geoInfo.setValue(geoInfoData.lat, forKey: "lat")
                geoInfo.setValue(geoInfoData.lng, forKey: "lng")
                geoInfo.setValue(geoInfoData.north, forKey: "north")
                geoInfo.setValue(geoInfoData.east, forKey: "east")
                geoInfo.setValue(geoInfoData.west, forKey: "west")
                geoInfo.setValue(geoInfoData.south, forKey: "south")
                try managedContext.save()
            }
        } catch let error as NSError{
             print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func retrieveGeoInfoHistory(completionHandler: @escaping(() -> Void)){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GeoInfo")
        
        do {
            let geoInfoHistory = try managedContext.fetch(fetchRequest)
            geoInfoLocation.removeAll()
            for object in geoInfoHistory {
                let geo = managedObjToGeoInfo(managedObj: object)
                geoInfoLocation.append(geo)
            }
            geoInfoLocation.reverse()
            completionHandler()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    private func managedObjToGeoInfo(managedObj: NSManagedObject) -> GeoInfoModel{
        var geoInfo: GeoInfoModel = GeoInfoModel()
        geoInfo.name = managedObj.value(forKey: "name") as? String
        geoInfo.countryName = managedObj.value(forKey: "countryName") as? String
        geoInfo.population = managedObj.value(forKey: "population") as? Int
        geoInfo.lat = managedObj.value(forKey: "lat") as? String
        geoInfo.lng = managedObj.value(forKey: "lng") as? String
        geoInfo.north = managedObj.value(forKey: "north") as? Double
        geoInfo.east = managedObj.value(forKey: "east") as? Double
        geoInfo.west = managedObj.value(forKey: "west") as? Double
        geoInfo.south = managedObj.value(forKey: "south") as? Double
        return geoInfo
    }
}
