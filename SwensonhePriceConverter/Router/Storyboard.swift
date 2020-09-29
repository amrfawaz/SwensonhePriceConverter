//
//  Storyboard.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation

struct StoryboardName {
    static let convertCurrency = "ConvertCurrency"
}

struct StoryboardIdentifire {
    // Convert Currency Storyboard
    static let convertCurrencyView = "ConvertCurrencyViewController"
}

struct Storyboard {
    let name: String
    let identifire: String?
}

struct StoryboardMapper {
    struct ConvertCurrency {
        static let convertCurrency = Storyboard(name: StoryboardName.convertCurrency, identifire: StoryboardIdentifire.convertCurrencyView)
    }
}
