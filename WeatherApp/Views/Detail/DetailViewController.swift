//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Angel Escribano on 22/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var geoInfo: GeoInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindGeoInfo()
    }

    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func bindGeoInfo() {
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
}
