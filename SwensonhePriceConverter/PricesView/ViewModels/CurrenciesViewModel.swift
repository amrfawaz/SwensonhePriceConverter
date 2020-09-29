//
//  CurrenciesViewModel.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

protocol CurrenciesView: class {
    func onGetCurrenciesSuccess()
    func onGetCurrenciesFail(error: CustomError)
}
class CurrenciesViewModel {
    private weak var view: CurrenciesView?
    private var currencies: LatestCurrencies?
    let title = "Currencies"
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
    
    func navigateToConvertCurrency(index: IndexPath) {
        let currency = currencies?.rates[index.row]
        
        let convertCurrencyViewController = Router.getDestinationViewController(storyboard: StoryboardMapper.ConvertCurrency.convertCurrency) as? ConvertCurrencyViewController
        
        convertCurrencyViewController?.secnondCurrency = [currency!.key: currency!.value]
        convertCurrencyViewController?.baseCurrency = self.baseCurrency
        
        Router.navigate(destination: convertCurrencyViewController!, presentationType: .push)

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
            self.view?.onGetCurrenciesFail(error: error as! CustomError)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.getCurrenciesRate()
        }
        alertController.addAction(doneAction)
        Router.getCurrentViewController()?.present(alertController, animated: true, completion: nil)
    }
}
