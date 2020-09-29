//
//  Dictionary+Extension.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy: i)];
        }
    }
}
