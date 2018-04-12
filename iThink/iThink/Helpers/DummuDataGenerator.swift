//
//  DummuDataGenerator.swift
//  iThink
//
//  Created by Radi Shikerov on 19.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class DummuDataGenerator: NSObject {

    public static func getTextQuotes(count: Int = 10) -> [TextQuote] {
        var quotes : [TextQuote] = []
        for _ in 0...count {
            quotes.append(self.getTextQuote())
        }
        return quotes
    }
    
    public static func getImageQuotes(count: Int = 10) -> [ImageQuote] {
        var quotes : [ImageQuote] = []
        for _ in 0...count {
            quotes.append(self.getImageQuote())
        }
        return quotes
    }
    
    public static func getTextQuote() -> TextQuote {
        return TextQuote(
            id: self.getRandomID(),
            text: self.getRandomText(),
            categoryID: "\(self.getRandomInt(max: 1))",
            userID: self.getRandomID(),
            lastModified: Date().toDateTimeString(),
            author: nil)
    }
    
    public static func getImageQuote() -> ImageQuote {
        return ImageQuote(
            id: self.getRandomID(),
            imageUrl: self.getRandomImageUrl(),
            categoryID: "\(self.getRandomInt(max: 1))",
            userID: self.getRandomID(),
            lastModified: Date().toDateTimeString(),
            author: nil)
    }
    
    private static func getRandomText() -> String {
        let quotes = ["Life is great", "Enjoy the little things", "If you cannot stop thinking about something, get it, whatever the cost"]
        return quotes[self.getRandomInt(max: UInt32(quotes.count))]
    }
    
    private static func getRandomName() -> String {
        let names = ["Gosho", "Pesho", "Tosho"]
        return names[self.getRandomInt(max: UInt32(names.count))]
    }
    
    private static func getRandomImageUrl() -> String {
        let urls = [
            "http://img.picturequotes.com/1/248/time-doesnt-heal-anything-it-just-teaches-us-how-to-live-with-the-pain-quote-2.jpg",
            "https://i.pinimg.com/736x/05/90/b7/0590b78792f9f95bc886a9acf9b06bae--blue-quotes-quotes-about-change.jpg",
            "http://www.success.com/sites/default/files/5_1.jpg",
            "https://www.brainyquote.com/photos_tr/en/h/hjacksonbrownjr/382774/hjacksonbrownjr1-2x.jpg"
        ]
        return urls[self.getRandomInt(max: UInt32(urls.count))]
    }
    
    
    private static func getRandomID() -> String {
        return "\(self.getRandomInt(max: 123456))"
    }
    
    private static func getRandomInt(max: UInt32? = nil) -> Int {
        return Int(arc4random_uniform(max ?? 123456))
    }
}
