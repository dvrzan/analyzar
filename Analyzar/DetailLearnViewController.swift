//
//  DetailLearnViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-17.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class DetailLearnViewController: UIViewController {
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
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
            let detailDescriptionLabel = detailDescriptionLabel,
            let detailImageView = detailImageView {
            detailTitleLabel.text = learningMaterial.title
            detailDescriptionLabel.text = learningMaterial.description
            detailImageView.image = UIImage(named: learningMaterial.title)
            title = learningMaterial.category.rawValue
        }
    }
    
}
