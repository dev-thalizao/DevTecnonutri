//
//  UserView.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/18/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation

protocol UserDetailView {
    func startLoading()
    func finishLoading()
    func setEmptyFeed()
    func setUser(user: User)
    func showMessage(message: String, isError: Bool)
}
