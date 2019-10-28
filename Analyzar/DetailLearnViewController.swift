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
        
        self.detailDescriptionTextView?.attributedText = detailDescriptionTextView.text.set(style: style)
    }
    
}
