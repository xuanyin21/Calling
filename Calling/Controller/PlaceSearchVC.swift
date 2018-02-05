//
//  PlaceSearchVC.swift
//  Calling
//
//  Created by Xuan Yin on 1/25/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import UIKit

class PlaceSearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var places = [Place]()
    
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell {
            let place = places[indexPath.row]
            cell.configureCell(title: place.descriptionTitle, detail: place.descriptionDetail)
            return cell
        }
        return PlaceCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: TO_DETAIL, sender: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    // UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            placesRequest(searchText: searchText)
        } else {
            places.removeAll()
            tableView.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            return
        }
        if searchText != "" {
            placesRequest(searchText: searchText)
        }
    }
    
    func placesRequest(searchText: String) {
        spinner.isHidden = false
        spinner.startAnimating()
        GooglePlacesService.instance.getSearchResults(searchTerm: searchText) { (places, errorMessage) in
            
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            
            if places != nil {
                self.places = places!
                self.tableView.reloadData()
            } else {
                debugPrint(errorMessage)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_DETAIL {
            let detailVC = segue.destination as! PlaceDetailVC
            detailVC.place = places[selectedIndex!]
        }
    }
    
}
