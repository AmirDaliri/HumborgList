//
//  Helpers.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import UIKit
import Foundation

class Helpers {
    
    static func alertWithTitle(_ viewController: UIViewController, title: String!, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "dismiss", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion:nil)
    }
    
    
    
    static func alertWithAction(_ viewController: UIViewController, title: String!, message: String, handler: ((UIAlertAction) -> Swift.Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "yea", style: .destructive, handler: {(Bool) in })
        let action = UIAlertAction(title: "nop", style: .default, handler: handler)
        alert.addAction(cancel)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion:nil)
    }
    
    
    
    
    static func alertWithOneBttnAction(_ viewController: UIViewController, title: String!, message: String ,BttnTitle: String ,handler: ((UIAlertAction) -> Swift.Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: BttnTitle, style: .default, handler: handler)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion:nil)
    }
    
    
    
    static func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
        return
    }
    
}




