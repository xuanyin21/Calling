//
//  PlaceCell.swift
//  Calling
//
//  Created by Xuan Yin on 1/25/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var placeDescriptionTitleLbl: UILabel!
    @IBOutlet weak var placeDescriptionDetailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(title: String, detail: String) {
        placeDescriptionTitleLbl.text = title
        placeDescriptionDetailLbl.text = detail
    }

}
