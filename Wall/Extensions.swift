//
//  Extensions.swift
//  Wall
//
//  Created by vanelizarov on 29/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    convenience init(color: UIColor, size: CGSize = CGSizeMake(1, 1)) {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
        
    }
    
}

public extension String {
    
    func truncate(length: Int, trailing: String? = nil) -> String {
        
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
        
    }
    
}