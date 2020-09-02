//
//  CurrencyConversionViewModel.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift

class CurrencyConversionViewModel: DefaultViewModel<CurrencyConversionProtocol> {
    
    func rx_updateListValues() -> Observable<Void> {
        if self.getBusinessModel().hasCurrencies {
            return self.getBusinessModel().rx_liveCurrencyValuesOfUSD().map { json -> Void in
                for updatedCurrency in json {
                    guard let code = updatedCurrency.dictionaryValue.first?.key, let value = updatedCurrency.double else { continue }
                    self.getBusinessModel().updateCurrency(value: value, by: code)
                }
            }
        } else {
            return Observable.just(())
        }
    }
}