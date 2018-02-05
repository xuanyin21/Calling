//
//  PlaceDetailVC.swift
//  Calling
//
//  Created by Xuan Yin on 1/26/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import UIKit

class PlaceDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    
    var place:Place?
    var phone:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBtn.isEnabled = false
        GooglePlacesService.instance.getPlaceDetail(place: place!) { (updatedPlace, errorMessage) in
            
            if updatedPlace.isUpdated {
                self.nameLbl.text = updatedPlace.name
                self.typeLbl.text = updatedPlace.type.rawValue
                self.addressLbl.text = updatedPlace.address
                
                if let phone = updatedPlace.phone {
                    self.phone = phone
                    self.callBtn.isEnabled = true
                }
                
            } else {
                debugPrint(errorMessage)
            }
        }
    }

    @IBAction func phoneCallBtnPressed(_ sender: Any) {
        
        guard let number = phone else { return }
        let numberOnly = number.split(omittingEmptySubsequences: true) { !"0123456789".contains(String($0))}.map{String($0)}.joined()
        UIApplication.shared.open(NSURL(string: "tel://\(numberOnly)")! as URL)
        
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
