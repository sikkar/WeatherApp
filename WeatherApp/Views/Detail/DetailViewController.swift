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
    @IBOutlet weak var temperatureContainer: UIView!
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var animateViewLeading: NSLayoutConstraint!
    
    var geoInfo: GeoInfoModel?
    private var temperatureViewModel: TemperatureViewModel = TemperatureViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindGeoInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadingOverlay.shared.showOverlay(view: self.temperatureContainer)
        if let geoInfo = self.geoInfo {
            temperatureViewModel.getTemperatureInfo(geoInfo: geoInfo, completion: { temperature, error in
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlay()
                    if let tempError = error {
                        print(tempError)
                    } else {
                        self.temperatureLabel.text = "\(temperature!)º"
                        self.animateTemperatureView(temp: temperature!)
                    }
                }
            })
        }
    }
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, geoInfo: GeoInfoModel) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.geoInfo = geoInfo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.createGradientView()
    }
    
    private func bindGeoInfo() {
        if let geoInfo = self.geoInfo {
            nameLabel.text = geoInfo.name
            countryLabel.text = geoInfo.countryName
            if (geoInfo.population != 0){
                populationLabel.text = "Population: \n   \(String(describing: geoInfo.population!))"
            }
            if let north = geoInfo.north, let south = geoInfo.south, let east = geoInfo.east, let west = geoInfo.west {
                let span = MKCoordinateSpanMake(fabs(north - south), fabs(east - west));
                let center = CLLocationCoordinate2DMake((north - span.latitudeDelta / 2), east - span.longitudeDelta / 2);
                let region = MKCoordinateRegion.init(center: center, span: span)
                mapView.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(geoInfo.lat!)!, longitude: Double(geoInfo.lng!)!)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    private func createGradientView(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.temperatureView.bounds
        gradientLayer.colors = ColorHelper.getGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.temperatureView.layer.addSublayer(gradientLayer)
    }
    
    private func animateTemperatureView(temp: Int){
        var animationMovement = CGFloat((Double(temperatureView.frame.size.width) * Double(temp)) / 50)
        if animationMovement <= 0 {
            animationMovement = 1
        }
        animateViewLeading.constant += animationMovement
        
        UIView.animate(withDuration: 0.7) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
