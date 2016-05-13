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
    public class func analyze(input: String) -> SentimentResult {
        var afinn = affindData
        var value:SentimentResult = SentimentResult()
        do {
            let regex:NSRegularExpression = try NSRegularExpression(pattern: "\\W",
                options: NSRegularExpressionOptions.CaseInsensitive);

            let cleaned = regex.stringByReplacingMatchesInString(input,
                options: NSMatchingOptions.WithoutAnchoringBounds,
                range: NSMakeRange(0, input.characters.count),
                withTemplate: " ");
            
            let words = cleaned.componentsSeparatedByString(" ");
            
            for word in words {
                if ((afinn[word]) != nil) {
                    value.total += afinn[word]!;
                    value.matches += 1
                }
            }
            print(value);
        } catch {
        }
        return value
    }
}