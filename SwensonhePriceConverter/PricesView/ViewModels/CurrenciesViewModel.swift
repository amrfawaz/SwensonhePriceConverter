//
//  CurrenciesViewModel.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

protocol CurrenciesView: class {
    func onGetCurrenciesSuccess()
    func onGetCurrenciesFail()
}
class CurrenciesViewModel {
    private weak var view: CurrenciesView?
    private var currencies: LatestCurrencies?
    var baseCurrency: String?
    var numberOfCurrencies: Int {
        get {
            return currencies?.rates.keys.count ?? 0
        }
    }
    init(view: CurrenciesView) {
        self.view = view
    }
    
    
    func registerCells(tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: CurrencyCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CurrencyCell.self))
    }
    
    
    func configureCell(cell: CurrencyCell, index: IndexPath) {
        
        let currency = currencies?.rates[index.row]
        
        cell.labelCurrency.text = currency?.key
        cell.labelCurrencyRate.text = String(format: "%.2f", currency?.value ?? "")
    }

    
    func getCurrenciesRate() {
        let ordersApi = CurrenciesApi()
        ordersApi.params = LatestCurrenciesRequestParams()
        ordersApi.getLatestCurrencies().get { [weak self] response in
            guard let self = self else { return }
            self.currencies = response
            self.baseCurrency = response.base
            self.view?.onGetCurrenciesSuccess()
        }.catch { error in
            self.view?.onGetCurrenciesFail()
        }
    }
    

}


extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy: i)];
        }
    }
}
