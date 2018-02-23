//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Angel Escribano on 21/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var locationsTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var geoInfoTableView: UITableView!
    
    var searchController : UISearchController!
    private let geoInfoViewModel = GeoInfoViewModel()
    
    let geoInfoCellIdentifier = "geoInfoCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView(){
        self.navigationController?.navigationBar.isHidden = true
        geoInfoTableView.delegate = self
        geoInfoTableView.dataSource = self
        geoInfoTableView.register(UINib.init(nibName: "GeoInfoTableViewCell", bundle: nil), forCellReuseIdentifier: geoInfoCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        if let searchText = searchTextField.text{
            if !searchText.isEmpty {
                LoadingOverlay.shared.showOverlay(view: self.view)
                geoInfoViewModel.requestGeoInfoFor(location: searchText, completion: { error in
                    LoadingOverlay.shared.hideOverlay()
                    if let requestError = error{
                        print(requestError.localizedDescription)
                    } else {
                        self.geoInfoTableView.reloadData()
                    }
                })
            }
        }
    }
    
}

//MARK:UICollectionView Datasource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return geoInfoViewModel.geoInfoLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GeoInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: geoInfoCellIdentifier, for: indexPath) as! GeoInfoTableViewCell
        
        let geoInfo = geoInfoViewModel.geoInfoLocation[indexPath.row]
        cell.geoInfo = geoInfo
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let geoInfo = geoInfoViewModel.geoInfoLocation[indexPath.row]
        let detailViewController = DetailViewController.init(nibName: "DetailViewController", bundle: nil, geoInfo: geoInfo)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

