//
//  Place.swift
//  Calling
//
//  Created by Xuan Yin on 1/25/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import Foundation

enum PlaceType: String {
    case rentalCar
    case hotel
    case other
}

struct Place {
    public private(set) var id: String!
    public private(set) var descriptionTitle: String!
    public private(set) var descriptionDetail: String!
    public private(set) var phone: String?
    public private(set) var name: String!
    public private(set) var address: String!
    public private(set) var type: PlaceType!
    public private(set) var isUpdated: Bool!
    
    init(id: String, description: String) {
        self.id = id
        let separated = description.split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
        
        if let first = separated.first {
            self.descriptionTitle = String(first)
        }
        
        if let last = separated.last {
            self.descriptionDetail = String(last)
        }
        
        self.isUpdated = false
    }
    
    mutating func updatePlace(name: String, phone: String?, address: String, type: PlaceType) {
        self.phone = phone
        self.type = type
        self.address = address
        self.name = name
        self.isUpdated = true
    }
}
