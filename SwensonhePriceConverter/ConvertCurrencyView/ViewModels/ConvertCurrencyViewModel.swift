//
//  ConvertCurrencyViewModel.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation

protocol ConvertCurrencyView: class {
}
class ConvertCurrencyViewModel {
    private weak var view: ConvertCurrencyView?

    let title = "Convert Currency"
    
    init(view: ConvertCurrencyView) {
        self.view = view
    }

    func convert(rate: Double, value: Double) -> String {
        let result = value * rate
        return String(format: "%.2f", result)
    }
    
}
