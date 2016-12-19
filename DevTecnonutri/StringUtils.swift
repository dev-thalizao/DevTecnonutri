//
//  StringUtils.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import UIKit

class StringUtils {
    
    static func getTextHeightForView(text: NSString, width: CGFloat, font: UIFont) -> CGFloat {
        let rect = text.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                          options: [.usesLineFragmentOrigin, .usesFontLeading],
                          attributes: [NSFontAttributeName: font],
                          context: nil)
        
        return rect.height
    }
    
    
}
