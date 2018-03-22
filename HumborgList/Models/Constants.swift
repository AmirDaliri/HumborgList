//
//  Constants.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Cache {
        static let imageCache = NSCache<AnyObject, AnyObject>()
    }
    
    struct ApiConstants {  
        static let baseURLString = "http://c2-backend-dev.eu-central-1.elasticbeanstalk.com/"
        static let imageURLString = "https://static.chef.one/"
    }
    
    struct UrlConstants {
    }
    
    struct UserDefaults {
        static let debugMode = false
        static let apiToken = " "
    }
    
    struct ImageDefaults {
        static let imagePlaceHolder: UIImage = UIImage(named: " ")!
    }
}


