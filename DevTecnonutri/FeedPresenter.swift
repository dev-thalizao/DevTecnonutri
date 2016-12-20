//
//  FeedPresenter.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedPresenter {
    
    private let feedService: FeedService
    private var feedView: FeedView?
    private var firstLoad = true
    private var pageNumber = 0
    private var timestamp: NSNumber = 0
    private var scrollIsOver = false
    
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
        // Prevent request when feed is over
        if(self.scrollIsOver){
            print("Scroll is over")
            self.feedView?.finishLoading()
            return
        }
        
        // Create a query http paramters if needed
        let params: [String: Any]?
        if(loadMode != LoadMode.refresh){
            params = ["p": self.pageNumber, "t": self.timestamp]
        } else {
            self.pageNumber = 0;
            self.timestamp = 0
            params = nil
            self.scrollIsOver = false
        }
        
        // Start SVProgressHUD if it is the first load
        if(self.firstLoad){
            self.feedView?.startLoading()
            self.firstLoad = false
        }
        
        // Fetch feeds
        feedService.getFeeds(params: params, onSuccess: { (response) -> Void in
            self.feedView?.finishLoading()
            
            // Parse json
            let json = JSON(response)
            
            if(json["success"].boolValue){
                // parse items
                let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                    return Item(json: jsonItem)
                })
                
                // Verify if feed is over
                if(items.count > 0){
                    self.pageNumber += 1
                    self.timestamp = json["t"].numberValue
                } else {
                    self.scrollIsOver = true
                }
                // Update view
                self.feedView?.setFeed(items: items, loadMode: loadMode)
            } else {
                // Return empty array to reload using setFeed, in case the error happens
                self.feedView?.setFeed(items: [], loadMode: loadMode)
                self.feedView?.showMessage(message: "Houve um erro ao buscar o feed!", isError: true)
            }
        }, onFail: { (error) -> Void in
            self.feedView?.finishLoading()
            // Return empty array to reload using setFeed
            self.feedView?.setFeed(items: [], loadMode: loadMode)
            self.feedView?.showMessage(message: "Algo estranho aconteceu :(", isError: true)
        })
    }
}
