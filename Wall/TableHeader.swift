//
//  TableHeader.swift
//  Wall
//
//  Created by vanelizarov on 25/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit

@IBDesignable class TableHeader: UIView {

    private var view : UIView!
    
    @IBOutlet var label: UILabel!
    @IBInspectable var labelText : String = "WALL" {
        
        didSet {
            label.text = labelText
        }
        
    }
    
    @IBOutlet var newPostButton: ActionButton!
    @IBOutlet var newPostButtonHeight: NSLayoutConstraint!
    @IBInspectable var buttonHeight : CGFloat = 40.0 {
        
        didSet {
            newPostButtonHeight.constant = buttonHeight
            
            if buttonHeight == 0 {
                newPostButton.hidden = true
            } else {
                newPostButton.hidden = false
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        xibSetup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        xibSetup()
        
    }
    
    private func xibSetup() {
        
        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
        
        //
                
    }
    
    private func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TableHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
        
    }

}
