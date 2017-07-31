//
//  WrldNetworkLayer.swift
//  ARKit+CoreLocation
//
//  Created by Salman Khalid on 31/07/2017.
//  Copyright © 2017 Project Dent. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

protocol Wrld3dNetworkLayerDelegate {
    
    func DidReceiveResponse(response:[PointOfInterest])
    func DidFailedToReceiveResponse(response:String)
    
}
class Wrld3dNetworkLayer  {
    
    var delegate:Wrld3dNetworkLayerDelegate
    
    // NOTE: Detailed documentation related to POI's can be found in this link https://github.com/wrld3d/wrld-poi-api
    
    let basicURL = "https://poi.eegeo.com/v1.1/tag?"
    let searchtag = "Arkit" // Tag based searched
    let searchRadius = 600  // in meters
    let maximumNoOfResults = 50
    let apiKey = "" // To be replaced with your own APIKey
    let minimumpercision = 0.25 // Minimum 'score' to results. the higher the number the fewer results will be matched (default: 0.0)
//  let latitude = 56.4597156
//  let longitude = -2.9775496
    
    init(inputDelegate:Wrld3dNetworkLayerDelegate) {
        delegate = inputDelegate
    }
    
    func fetchPois(currentLocation:CLLocation)    {
        
        let finalURL = basicURL
            + "t=\(searchtag)" + "&"
            + "r=\(searchRadius)" + "&"
            + "lat=\(currentLocation.coordinate.latitude)" + "&"
            + "lon=\(currentLocation.coordinate.longitude)" + "&"
            + "n=\(maximumNoOfResults)" + "&"
            + "ms=\(minimumpercision)" + "&"
            + "apikey=\(apiKey)"
        
        Alamofire.request(finalURL).responseJSON { response in
            print("Request: \(String(describing: response.request))") 
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            let decoder = JSONDecoder()
            do {
                let pois = try decoder.decode([PointOfInterest].self, from: response.data!)
                self.delegate.DidReceiveResponse(response:pois)
            } catch {
                print("error trying to convert data to JSON")
                self.delegate.DidFailedToReceiveResponse(response: error.localizedDescription)                
            }
        }
    }
}
