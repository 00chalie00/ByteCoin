//
//  ByteCoinViewController.swift
//  ByteCoin
//
//  Created by formathead on 2020/03/13.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController {

    @IBOutlet weak var bytePrice: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var coinManager = CoinManager()
    var coinData: CoinModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        coinManager.delegate = self
        
    }
    
}//End Of The Class

//MARK: - UIPickerViewDelegate

extension ByteCoinViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let countryString = coinManager.currencyArray[row]
        coinManager.getCoinPrice(countryString)
    }
}

//MARK: - CoinManagerDelegate

extension ByteCoinViewController: CoinManagerDelegate {
    func didUpdate(price: String, country: String) {
        DispatchQueue.main.async {
            
            print(price, country)
            self.bytePrice.text = price
            self.countryLbl.text = country
        }
    }
}
