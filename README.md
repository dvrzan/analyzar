![Front Banner](Documentation/FrontBanner.png)

## About the app

<p align="center">
  <img src="Documentation/preview.gif">
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
|---    |---   |
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
* HTTP requests with URLSession
* Getting data from Twitter API
* Searchbar advanced filtering options
* Regular expressions for checking correct user input
* Activity spinner using DispatchQueue
* In-app dark mode switch with UserDefaults
* Privacy Policy view using WebKit
* Fully ready App Store app

---

### Dependencies

To successfully run the application on your machine you need to Sign up as a Twitter Developer and get the API keys.
Create a new plist file called **APIKeys.plist** with 2 keys and assign those values to **API_KEY** and **API_SECRET_KEY**.   
Also check for any external libraries you might need to install.   

---

### TO-DO:

- [ ] Refactor code to support MVC Design Pattern
- [ ] Refactor to remove SwiftyJSON and Alamofire

<br />
<br />

>This is a learning project created by expanding my Bachelor's Thesis application and implementing different Swift components.</br>
>Check my portfolio at [danijelavrzan.com](https://danijelavrzan.com).

<br />
   
![End Banner](Documentation/EndBanner.png)
