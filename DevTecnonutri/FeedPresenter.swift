//
//  FeedPresenter.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedPresenter: FeedPresenterContract, FeedInteractorOutputContract {
    
    private weak var feedView: FeedView?
    var feedInteractor: FeedInteractorContract?
    var wireframe: FeedWirameContract?
    
    private var firstLoad = true
    private var pageNumber = 0
    private var timestamp: NSNumber = 0
    private var scrollIsOver = false
    
    init() {
        self.feedInteractor = FeedInteractor()
        self.feedInteractor?.attachOutput(output: self)
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
        
        feedInteractor?.getFeeds(loadMode: loadMode, params: params)
    }
    
    func foundFeeds(feeds: [Item], timestamp: NSNumber, loadMode: LoadMode) {
        self.feedView?.finishLoading()
        // Verify if feed is over
        if(feeds.count > 0){
            self.pageNumber += 1
            self.timestamp = timestamp
        } else {
            self.scrollIsOver = true
        }
        // Update view
        self.feedView?.setFeed(items: feeds, loadMode: loadMode)
    }
    
    func errorOnGetFeeds(loadMode: LoadMode, message: String){
        self.feedView?.finishLoading()
        // Return empty array to reload using setFeed
        self.feedView?.setFeed(items: [], loadMode: loadMode)
        self.feedView?.showMessage(message: message, isError: true)
    }
}
