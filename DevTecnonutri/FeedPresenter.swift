//
//  FeedPresenter.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum LoadMode: Int {
    case refresh = 1, scrolling
}

class FeedPresenter {
    
    private let feedService: FeedService
    private var feedView: FeedView?
    private var pageNumber = 1
    private var timestamp: Any?
    
    init(feedService: FeedService) {
        self.feedService = feedService
        
    }
    
    func attachView(view: FeedView){
        self.feedView = view;
    }
    
    func detachView(){
        self.feedView = nil
    }
    
    func getFeeds(loadMode: LoadMode){
        let params: [String: Any]?
        if(loadMode != LoadMode.refresh){
            params = ["p": self.pageNumber]
        } else {
            self.pageNumber = 0;
            self.timestamp = 0
            params = nil
        }
        
        self.feedView?.startLoading()
        feedService.getFeeds(params: params, onSuccess: { (response) -> Void in
            // Parse json
            let json = JSON(response)
            
            if(json["success"].boolValue){
                // parse items
                let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                    return Item(json: jsonItem)
                })
                
                self.feedView?.finishLoading()
                self.pageNumber += 1
                self.timestamp = json["t"]
                self.feedView?.setFeed(items: items, loadMode: loadMode)
            } else {
                // Error msg
            }
                
                
        }, onFail: { (error) -> Void in
            // Error msg
        })
    }
}
