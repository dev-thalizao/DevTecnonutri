//
//  FeedService.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FeedService {
    
    func getFeeds(params: [String : Any]?,  onSuccess: @escaping (Any) -> Void, onFail: @escaping (NSError) -> Void){
        Alamofire.request(Endpoint.feed, method: .get, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                onFail(error as NSError)
            }
        }
    }
}
