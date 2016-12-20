//
//  AlertUtils.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/20/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import UIKit

class AlertUtils {
    static func getAlertOnlyForOkButton(title: String, message: String, isError: Bool) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let style: UIAlertActionStyle = isError ? .destructive : .default
        let action = UIAlertAction.init(title: "Ok", style: style, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}
