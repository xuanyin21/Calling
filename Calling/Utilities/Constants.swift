//
//  Constants.swift
//  Calling
//
//  Created by Xuan Yin on 1/25/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias CompletionHandler = ([Place]?, String) -> ()
typealias DetailCompletionHandler = (Place, String) -> ()

// Api keys
let API_KEY_GOOGLE_PLACES = "AIzaSyCEGE9fo-WWnvqQcbE4k0wmDbUFMNG4R94"

// URLs
let GOOGLE_PLACES_BASE_URL = "https://maps.googleapis.com/maps/api/place"
let URL_GOOGLE_PLACES_AUTOCOMPLETE = "\(GOOGLE_PLACES_BASE_URL)/autocomplete/json"
let URL_GOOGLE_PLACES_DETAILS = "\(GOOGLE_PLACES_BASE_URL)/details/json"

// Segues
let TO_DETAIL = "toDetail"
