//
//  GeoInfoViewCellTableViewCell.swift
//  WeatherApp
//
//  Created by Angel Escribano on 22/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit

class GeoInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var geoInfo: GeoInfoModel?{
        didSet{
            bindGeoInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    private func bindGeoInfo() {
        self.nameLabel.text = geoInfo?.name
        self.countryLabel.text = geoInfo?.countryName
    }
    
}
