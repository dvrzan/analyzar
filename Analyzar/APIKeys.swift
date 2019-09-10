//
//  APIKeys.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-09-09.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
