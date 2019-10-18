//
//  TwitterViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-09-06.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class TwitterViewController: UIViewController {
    
    @IBOutlet weak var twitterSentimentLabel: UILabel!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var checkTwitterButton: UIButton! {
        didSet{
            checkTwitterButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var sentimentScoreLabel: UILabel!
    
    
    let tweetCount = 100
    let sentimentClassifier = AnalyzarSentimentClassifier()
    
    //Initialize new instance of Swifter framework and authenticate with API key and API secret key
    let swifter = Swifter(consumerKey: valueForAPIKey(named: "API_KEY_TWITTER"), consumerSecret: valueForAPIKey(named: "API_SECRET_KEY_TWITTER"))

    override func viewDidLoad() {
        super.viewDidLoad()
        checkTwitterButton.isEnabled = false
        
        //Hide keyboard on tap
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
    }
    
    @IBAction func twitterTextFieldEditingDidChange(_ sender: UITextField) {
        if let userInput = sender.text, userInput.isValidInput == false {
            return checkTwitterButton.isEnabled = false
        } else {
            return checkTwitterButton.isEnabled = true
        }
    }
    
    @IBAction func checkTwitterButtonPressed(_ sender: Any) {
        self.showSpinner(onView: self.view)
        getTweets()
    }
    
    func getTweets() {
        if let searchText = twitterTextField.text {
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [AnalyzarSentimentClassifierInput]()
                
                for i in 0..<self.tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetClassification = AnalyzarSentimentClassifierInput(text: tweet)
                        tweets.append(tweetClassification)
                    }
                }
                self.predictSentiment(with: tweets)
            }) { (error) in
                print("Twitter API Request error, \(error)")
            }
        }
    }
    
    func predictSentiment(with tweets: [AnalyzarSentimentClassifierInput]) {
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for p in predictions {
                let sentiment = p.label
                if sentiment == "positive" {
                    sentimentScore += 1
                } else if sentiment == "negative" {
                    sentimentScore -= 1
                }
            }
            self.removeSpinner()
            showSentimentUI(with: sentimentScore)
        } catch {
            print("There was an error with prediction, \(error)")
        }
    }
    
    func showSentimentUI(with sentimentScore: Int) {
        if sentimentScore > 50 {
            self.twitterSentimentLabel.text = "❤️"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nTrue love knows no boundaries."
        } else if sentimentScore > 20 {
            self.twitterSentimentLabel.text = "😍"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nThe positivity is though the roof!"
        } else if sentimentScore > 10 {
            self.twitterSentimentLabel.text = "😃"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nPeople can't stop talking about it."
        } else if sentimentScore > 0 {
            self.twitterSentimentLabel.text = "🙂"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nAs long as it's smile, it's good."
        } else if sentimentScore == 0 {
            self.twitterSentimentLabel.text = "😐"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nIt could have been worse, you know..."
        } else if sentimentScore > -10 {
            self.twitterSentimentLabel.text = "🙁"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nOh, oh, people don't quite like it."
        } else if sentimentScore > -20 {
            self.twitterSentimentLabel.text = "😤"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nPeople are frustrated with this one!"
        } else if sentimentScore > -50 {
            self.twitterSentimentLabel.text = "😡"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nThere has to be a good reason behind this."
        } else {
            self.twitterSentimentLabel.text = "☠️"
            self.sentimentScoreLabel.text = "Final score is \(sentimentScore). \nNot good! Run for your life!"
        }
    }
    
}

extension String {
    var isValidInput: Bool {
        let checkUserInputRegex = "^[@][A-z0-9]+|^[#][A-z0-9]+"
        return NSPredicate(format: "SELF MATCHES %@", checkUserInputRegex).evaluate(with: self)
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
