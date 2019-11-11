//
//  String+RegEx.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-11-11.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

extension String {
    var isValidInput: Bool {
        let checkUserInputRegex = "^[@][A-z0-9]+|^[#][A-z0-9]+"
        return NSPredicate(format: "SELF MATCHES %@", checkUserInputRegex).evaluate(with: self)
    }
}
