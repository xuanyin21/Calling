//
//  GooglePlacesService.swift
//  Calling
//
//  Created by Xuan Yin on 1/25/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import Foundation

class GooglePlacesService {
    
    static let instance = GooglePlacesService()
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var places: [Place] = []
    var errorMessage = ""

    func getSearchResults(searchTerm: String, completion: @escaping CompletionHandler) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: URL_GOOGLE_PLACES_AUTOCOMPLETE) {
            
            urlComponents.query = "input=\(searchTerm)&types=establishment&key=\(API_KEY_GOOGLE_PLACES)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSearchResults(data)

                    DispatchQueue.main.async {
                        completion(self.places, self.errorMessage)
                    }
                }
            }

            dataTask?.resume()
        }
    }
    
    func getPlaceDetail(place: Place, completion: @escaping DetailCompletionHandler) {
        dataTask?.cancel()
        var updatedPlace = place
        
        if var urlComponents = URLComponents(string: URL_GOOGLE_PLACES_DETAILS) {
            
            urlComponents.query = "placeid=\(place.id!)&key=\(API_KEY_GOOGLE_PLACES)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    var response: JSONDictionary?
                    
                    do {
                        response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                    } catch let parseError as NSError {
                        self.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                        return
                    }
                    
                    guard let res = response!["result"] as? JSONDictionary else {
                        self.errorMessage += "Dictionary does not contain result key"
                        return
                    }
                    
                    if let name = res["name"] as? String,
                        let address = res["formatted_address"] as? String,
                        let types = res["types"] as? [String] {
                        
                        var placeType = PlaceType.other
                        if types.contains("car_rental") {
                            placeType = PlaceType.rentalCar
                        } else if types.contains("lodging") {
                            placeType = PlaceType.hotel
                        }
                        let phone = res["international_phone_number"] as? String
                        
                        updatedPlace.updatePlace(name: name, phone: phone, address: address, type: placeType)
                        
                    } else {
                        self.errorMessage += "Problem parsing place detail result\n"
                    }
                    
                    DispatchQueue.main.async {
                        
                        completion(updatedPlace, self.errorMessage)
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        places.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["predictions"] as? [Any] else {
            errorMessage += "Dictionary does not contain predictions key\n"
            return
        }
        
        for placeDictionary in array {
            if let placeDictionary = placeDictionary as? JSONDictionary,
                let placeId = placeDictionary["place_id"] as? String,
                let description = placeDictionary["description"] as? String {
                places.append(Place(id: placeId, description: description))
                
            } else {
                errorMessage += "Problem parsing placeDictionary\n"
            }
        }
    }
}
