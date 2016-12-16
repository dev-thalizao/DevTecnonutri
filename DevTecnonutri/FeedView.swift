//
//  FeedView.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation

protocol FeedView {
    func startLoading()
    func finishLoading()
    func setFeed(items: [Item], loadMode: LoadMode)
    func setEmptyFeed()
    func showMessage(message: String)
}
