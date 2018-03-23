//
//  AppDelegate.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setupNavbar()
        return true
    }

    func setupNavbar() {
        let navigationBarAttributedStringKey = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        let barButtonItemAttributedStringKey = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]
        UINavigationBar.appearance().titleTextAttributes = navigationBarAttributedStringKey
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonItemAttributedStringKey, for: .normal)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -2), for:UIBarMetrics.default)
        UINavigationBar.appearance().barTintColor = UIColor.blackTint
        UINavigationBar.appearance().tintColor = UIColor.white
    }

}

