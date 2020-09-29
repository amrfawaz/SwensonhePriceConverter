//
//  PricesApi.swift
//  SwensonhePriceConverter
//
//  Created by AmrFawaz on 9/29/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import UIKit


class PricesApi: Api {
    enum APIRouter: Requestable {
        
        case getLatestPrices(PricesApi)

        var path: String {
            switch self {
            case .getLatestPrices:
                return "/latest"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .getLatestPrices:
                return .get
            }
        }
        
        
        var parameters: Parameters? {
            switch self {
            case let .getLatestPrices(api):
                return api.params?.getParamsAsJson()
            }
        }
    }
}


extension PricesApi {
    

    func getLatestPrices() -> Promise<LatestPrices> {
        return fireRequestWithSingleResponse(requestable: APIRouter.getLatestPrices(self))
    }

}
