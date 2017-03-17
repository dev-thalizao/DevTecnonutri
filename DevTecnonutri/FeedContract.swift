//
//  FeedContract.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 16/03/17.
//  Copyright © 2017 Thales Frigo. All rights reserved.
//

import Foundation
import UIKit

class FeedBuilder: FeedBuilderContract {
    // custom vars
    
    internal func buildModule() -> UIViewController? {
        let viewController = FeedViewController()
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
        
        viewController.feedPresenter = presenter
        presenter.feedInteractor = interactor
        
        return viewController
    }
}

protocol FeedBuilderContract {
    func buildModule() -> UIViewController?
}

class FeedWireframe: FeedWirameContract {
    
    internal func presentFeed() {
        
    }
    
    internal func navigateToUserDetail() {
        
    }

    internal func navigateToFeedDetail() {
        
    }
}

// user os termos router source e router destination
protocol FeedWirameContract {
    func presentFeed()
    func navigateToFeedDetail()
    func navigateToUserDetail()
}

protocol FeedViewContract: class {
    func render(viewModel: FeedViewModel)
}

protocol FeedPresenterContract: class {
    func attachView(view: FeedView)
    func detachView()
    func getFeeds(loadMode: LoadMode)
    //    func fetchData()
    //    func loadMoreData()
}

protocol FeedInteractorContract {
    func attachOutput(output: FeedInteractorOutputContract)
    func getFeeds(loadMode: LoadMode, params: [String: Any]?)
}

protocol FeedInteractorOutputContract: class {
    func foundFeeds(feeds: [Item], timestamp: NSNumber, loadMode: LoadMode)
    func errorOnGetFeeds(loadMode: LoadMode, message: String)
}

struct FeedViewModel {
    
}
