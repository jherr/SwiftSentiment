//
//  Sentiment.swift
//  Sentiment
//
//  Created by Jack Herrington on 5/11/16.
//  Copyright © 2016 Jack Herrington. All rights reserved.
//

import Foundation

public struct SentimentResult {
    var matches = 0;
    var total = 0;
}

public class Sentiment {
    private static var __afinnData: [String: String]? = nil
    
    public static var afinnData: [String: String] {
        get {
            // load up our data if we don't have it.
            if __afinnData == nil {
                let bundle = NSBundle(forClass: self)
                let file = bundle.pathForResource("DefaultAFINN.json", ofType: nil)
                let data = NSData(contentsOfFile: file!)
                do {
                    __afinnData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String,String>
                } catch let error {
                    fatalError("Unable to load AFINN data!, error = \(error)")
                }
            }
            
            if let result = __afinnData {
                return result
            } else {
                // i don't think we'd ever get here, but just in case...
                return [String: String]()
            }
        }
    }
    
    public static func analyze(input: String) -> SentimentResult {
        var value = SentimentResult()
        do {
            let regex = try NSRegularExpression(pattern: "\\W", options: NSRegularExpressionOptions.CaseInsensitive)

            let cleaned = regex.stringByReplacingMatchesInString(input,
                options: NSMatchingOptions.WithoutAnchoringBounds,
                range: NSMakeRange(0, input.characters.count),
                withTemplate: " ")
            
            let words = cleaned.componentsSeparatedByString(" ")
            
            for word in words {
                if let afinnValue = afinnData[word] {
                    value.total += Int(afinnValue)!
                    value.matches += 1
                }
            }
        } catch let error {
            // if we get an error here, it'll be from the regex above.
            fatalError("Regex failed, data is likely not formatted correctly, error = \(error)")
        }
        return value
    }
}