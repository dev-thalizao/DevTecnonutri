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

class FeedPresenter {
    
    private let feedService: FeedService
    private var feedView: FeedView?
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    func attachView(view: FeedView){
        self.feedView = view;
    }
    
    func detachView(){
        self.feedView = nil
    }
    
    func getFeed(){
        self.feedView?.startLoading()
        feedService.getFeed { (items, error) -> Void in
            self.feedView?.finishLoading()
            
            self.feedView?.setFeed(items: items)
        }
    }
}
