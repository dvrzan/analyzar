//
//  DetailLearnViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-17.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit
import SwiftRichString

class DetailLearnViewController: UIViewController {
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionTextView: UITextView!
    
    let baseFontSize: CGFloat = 16
    
    
    var learningMaterial: LearningMaterial? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        if let learningMaterial = learningMaterial,
            let detailTitleLabel = detailTitleLabel,
            let detailDescriptionTextView = detailDescriptionTextView,
            let detailImageView = detailImageView {
            detailTitleLabel.text = learningMaterial.title
            detailDescriptionTextView.text = learningMaterial.description
            detailImageView.image = UIImage(named: learningMaterial.title)
            title = learningMaterial.category.rawValue
        }
        
        let boldStyle = Style {
            $0.font = UIFont.boldSystemFont(ofSize: self.baseFontSize)
        }
        
        let italicStyle = Style {
            $0.font = UIFont.italicSystemFont(ofSize: self.baseFontSize)
        }
        
        let link = Style {
            $0.color = UIColor.red
            $0.linkURL = URLRepresentable.tagAttribute("href")
        }
        
        let style = StyleGroup(base: Style {
            if #available(iOS 13.0, *) {
                $0.color = UIColor.label
            } else {
                // Fallback on earlier versions
                //Remain black - no Dark Mode
            }
            $0.font = UIFont.systemFont(ofSize: self.baseFontSize)
            $0.lineSpacing = 2
            $0.kerning = Kerning.adobe(-15)
            }, [
                "strong": boldStyle,
                "em": italicStyle,
                "a": link,
                "li": Style {
                    $0.paragraphSpacingBefore = self.baseFontSize / 2
                    $0.firstLineHeadIndent = self.baseFontSize
                    $0.headIndent = self.baseFontSize * 1.71
                },
                "superscript": Style {
                    $0.font = UIFont.systemFont(ofSize: self.baseFontSize / 1.2)
                    $0.baselineOffset = Float(self.baseFontSize) / 3.5
                },
                "quote": Style {
                    $0.alignment = .center
                    if #available(iOS 13.0, *) {
                        $0.color = UIColor.secondaryLabel
                    } else {
                        // Fallback on earlier versions
                        //Remain black - no Dark Mode
                    }
                }
            ])
        
        self.detailDescriptionTextView?.attributedText = detailDescriptionTextView.text.set(style: style)
    }
    
}
