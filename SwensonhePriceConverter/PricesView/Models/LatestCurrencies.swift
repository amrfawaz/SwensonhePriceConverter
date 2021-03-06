//
//  LatestPricesResponse.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation

class LatestCurrencies: Codable {
    let success: Bool?
    let base: String?
    var rates: [String: Double]
}
