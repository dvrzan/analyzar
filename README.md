![Front Banner](Documentation/FrontBanner.png)

![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey) ![Swift](https://img.shields.io/badge/Swift%20Version-5.1-blue)

## About the app

<p align="center">
  <img src="Documentation/analyzar-preview-app.gif">
</p>

### Analyzar and Twitter

Analyzar uses Twitter API to fetch 100 most recent tweets from Twitter, currently only in English language.

### Analyzing sentiment

Find out how people feel about a company or a person by using @ handle and writing a name in the text field.
If you are interested in how people feel about a specific topic, use # tag and write a tag name in the text field.
By pressing the Check button, Analyzar analyzes sentiment for you and presents you with a result.

Text field instantly validates your entry. If you did not provide a handle or have used invalid characters you will not be able to press the button, until you correct your entry.

### How score is calculated

There are 3 different labels in which tweets are categorized:

* For every positive label, +1 is added to the total score.
* For every negative label, -1 is deducted from the total score.
* For every neutral label, the score does not change.

The final score is presented with an emoji.

|      | Score range breakdown     |
|---    |---------------------------------------------------------------------------------    |
| ❤️     | > 50     |
| 😍     | > 20     |
| 😃     | > 10     |
| 🙂     | > 0      |
| 😐     | = 0      |
| 🙁     | < 0      |
| 😤     | < -10    |
| 😡     | < -20    |
| ☠️     | < -50    |


## Concepts used

* MVC Design Pattern
* Custom made machine learning model using Core ML
* External libraries:
    * [Alamofire](https://github.com/Alamofire/Alamofire)
    * [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
    * [Swifter](https://github.com/mattdonnelly/Swifter)
    * [SwiftRichString](https://github.com/malcommac/SwiftRichString)
* JSON parsing using Codable
* Getting data from Twitter API
* Searchbar advanced filtering options
* Regular expressions for checking correct user input
* Activity spinner using GCD
* In-app dark mode switch using UserDefaults
* Privacy Policy view using WebKit

 <br />
 <br />

>This is a learning project created by expanding my Bachelor's Thesis application and implementing different Swift components. Check my portfolio at [dvrzan.github.io](https://dvrzan.github.io)

 <br />

![End Banner](Documentation/EndBanner.png)
