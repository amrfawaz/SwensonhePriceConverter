//
//  ConvertCurrencyViewController.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import UIKit

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet weak var textfieldBaseCurrency: UITextField!
    @IBOutlet weak var labelBaseCurrency: UILabel!
    @IBOutlet weak var labelConvertResult: UILabel!
    @IBOutlet weak var labelConvertCurrency: UILabel!
    
    private var viewModel: ConvertCurrencyViewModel!
    var baseCurrency: String?
    var secnondCurrency: [String: Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        title = viewModel.title
        setDate()
        textfieldBaseCurrency.becomeFirstResponder()
    }
    
    private func initViewModel() {
        viewModel = ConvertCurrencyViewModel(view: self)
    }

    func setDate() {
        self.labelBaseCurrency.text = baseCurrency
        self.labelConvertCurrency.text = secnondCurrency?.keys.first
        self.labelConvertResult.text = String(format: "%.2f", secnondCurrency?.values.first ?? "")
    }
    
    @IBAction func textFiledBaseCurrencyValueChanged(_ sender: Any) {
        guard let value = Double(textfieldBaseCurrency.text!), value > 0 else { return }
        self.labelConvertResult.text = viewModel.convert(rate: secnondCurrency?.values.first ?? 0, value: value)
    }
    
}


extension ConvertCurrencyViewController: ConvertCurrencyView {
    
}
