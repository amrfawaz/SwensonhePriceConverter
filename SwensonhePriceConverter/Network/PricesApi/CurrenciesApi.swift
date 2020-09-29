//
//  CurrenciesApi.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import UIKit


class CurrenciesApi: Api {
    enum APIRouter: Requestable {
        
        case getLatestCurrencies(CurrenciesApi)

        var path: String {
            switch self {
            case .getLatestCurrencies:
                return "/latest"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .getLatestCurrencies:
                return .get
            }
        }
        
        
        var parameters: Parameters? {
            switch self {
            case let .getLatestCurrencies(api):
                return api.params?.getParamsAsJson()
            }
        }
    }
}


extension CurrenciesApi {

    func getLatestCurrencies() -> Promise<LatestCurrencies> {
        return fireRequestWithSingleResponse(requestable: APIRouter.getLatestCurrencies(self))
    }

}
