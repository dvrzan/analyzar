//
//  Style.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-22.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation
import SwiftRichString

let baseFontSize: CGFloat = 15

let boldStyle = Style {
    $0.font = UIFont.boldSystemFont(ofSize: baseFontSize)
}
       
let italicStyle = Style {
    $0.font = UIFont.italicSystemFont(ofSize: baseFontSize)
}

let underlineStyle = Style {
    if #available(iOS 13.0, *) {
        $0.underline = (.patternDash, UIColor.label)
    } else {
        // Fallback on earlier versions
        //Remain black - no Dark Mode
    }
}
       
let style = StyleGroup(base: Style {
    if #available(iOS 13.0, *) {
        $0.color = UIColor.label
    } else {
        // Fallback on earlier versions
        //Remain black - no Dark Mode
    }
    $0.font = SystemFonts.HelveticaNeue.font(size: baseFontSize)
    $0.lineSpacing = 2
    }, [
        "strong": boldStyle,
        "em": italicStyle,
        "underline": underlineStyle,
        "li": Style {
            $0.paragraphSpacingBefore = baseFontSize / 2
            $0.firstLineHeadIndent = baseFontSize
            $0.headIndent = baseFontSize * 1.71
        },
        "superscript": Style {
            $0.font = SystemFonts.HelveticaNeue.font(size: baseFontSize / 1.2)
            $0.baselineOffset = Float(baseFontSize) / 3.5
        },
        "subLabel": Style {
            $0.alignment = .center
            if #available(iOS 13.0, *) {
                $0.color = UIColor.secondaryLabel
            } else {
                // Fallback on earlier versions
                //Remain black - no Dark Mode
            }
        },
        "h1": Style {
            $0.alignment = .center
            $0.font = SystemFonts.HelveticaNeue.font(size: baseFontSize * 1.2)
        }
])

