//
//  FeedInteractor.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 16/03/17.
//  Copyright © 2017 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedInteractor: FeedInteractorContract {
    
    private var feedService = FeedService()
    weak var output: FeedInteractorOutputContract?
    
    init() {
        
    }
    
    func attachOutput(output: FeedInteractorOutputContract) {
        self.output = output
    }
    
    func getFeeds(loadMode: LoadMode, params: [String: Any]?) {
//        // Fetch feeds
        feedService.getFeeds(params: params, onSuccess: { (response) -> Void in
            
            
            // Parse json
            let json = JSON(response)
            
            if(json["success"].boolValue){
                // parse items
                let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                    return Item(json: jsonItem)
                })
                
                self.output?.foundFeeds(feeds: items, timestamp: json["t"].numberValue, loadMode: loadMode)
                
                
            } else {
                // Return empty array to reload using setFeed, in case the error happens
                self.output?.errorOnGetFeeds(loadMode: loadMode, message: "Houve um erro ao buscar as publicações")
            }
        }, onFail: { (error) -> Void in
            self.output?.errorOnGetFeeds(loadMode: loadMode, message: "Algo estranho aconteceu :(")
        })
    }
}
