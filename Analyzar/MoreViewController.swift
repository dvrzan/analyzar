//
//  MoreViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-24.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    
    @IBOutlet var switchThemeButton: UISwitch!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchThemeButton.isOn = defaults.bool(forKey: "isDarkMode")
        isDarkMode()
    }
    
    @IBAction func switchThemeButtonValueChanged(_ sender: UISwitch) {
        isDarkMode()
    }
    
    func isDarkMode() {
        if switchThemeButton.isOn == true {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .dark
            } else {
                // Fallback on earlier versions
            }
            defaults.set(true, forKey: "isDarkMode")
        } else {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
            defaults.set(false, forKey: "isDarkMode")
        }
    }

}
