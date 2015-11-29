//
//  ActionButton.swift
//  Wall
//
//  Created by vanelizarov on 29/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
        
    }
    
    private func setup() {
        self.setBackgroundImage(UIImage(color: UIColor(red: 253.0 / 255.0, green: 227.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0), size: self.bounds.size), forState: UIControlState.Normal)
        self.setBackgroundImage(UIImage(color: UIColor(red: 236.0 / 255.0, green: 240.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0), size: self.bounds.size), forState: UIControlState.Highlighted)
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
