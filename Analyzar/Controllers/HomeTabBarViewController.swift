//
//  HomeTabBarViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-31.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")

        if isDarkMode == true {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .dark
            } else {
                     // Fallback on earlier versions
            }
        } else if isDarkMode == false {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        } else {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .unspecified
            } else {
                // Fallback on earlier versions
            }
        }
        
    }

}
