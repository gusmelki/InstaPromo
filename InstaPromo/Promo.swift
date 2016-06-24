//
//  Promo.swift
//  InstaPromo
//
//  Created by Gustavo Leal on 6/24/16.
//  Copyright © 2016 Moip. All rights reserved.
//

import UIKit
import Parse

class Promo: NSObject {

    var local: String?
    var desc: String?
    var urlImg: String?
    var latitude: Double?
    var longitude: Double?
    
    func post(){
    
        let point = PFGeoPoint(latitude: latitude!, longitude: longitude!)
        
        let promo = PFObject(className: "promo")
        promo["local"] = local
        promo["desc"] = desc
        promo["urlImg"] = urlImg
        promo["loc"] = point
        
        promo.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error != nil{
                print("Object has been saved.")
            }else{
                print("Error")
            }
        }
    }
}
