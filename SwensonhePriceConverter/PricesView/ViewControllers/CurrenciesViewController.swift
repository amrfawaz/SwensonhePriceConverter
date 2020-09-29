//
//  CurrenciesViewController.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import UIKit

class CurrenciesViewController: UIViewController {
    @IBOutlet weak var labelBaseCurrrency: UILabel!
    @IBOutlet weak var tableViewCurrencies: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: CurrenciesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        title = viewModel.title
        viewModel.registerCells(tableView: tableViewCurrencies)
        self.viewModel.getCurrenciesRate()
    }
    
    private func initViewModel() {
        viewModel = CurrenciesViewModel(view: self)
    }
        
    func setBaseCurrency() {
        self.labelBaseCurrrency.text = viewModel.baseCurrency
    }
    
    @IBAction func buttonBaseCurrencyAction(_ sender: Any) {
    }
}

extension CurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCurrencies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyCell.self)) as? CurrencyCell
        viewModel.configureCell(cell: cell!, index: indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToConvertCurrency(index: indexPath)
    }
}


extension CurrenciesViewController: CurrenciesView {
    func onGetCurrenciesSuccess() {
        self.indicatorView.stopAnimating()
        setBaseCurrency()
        tableViewCurrencies.reloadData()
    }
    
    func onGetCurrenciesFail(error: CustomError) {
        self.indicatorView.stopAnimating()
        viewModel.showAlert(message: error.message ?? "")
    }
    

}
