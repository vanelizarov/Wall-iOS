//
//  RefreshView.swift
//  Wall
//
//  Created by vanya elizarov on 06/12/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit

@IBDesignable class RefreshView: UIView {

    private var view : UIView!

    @IBOutlet var label: UILabel!
    
    @IBInspectable var scale : CGFloat = 1.0 {
        
        didSet {

            if scale <= 1.0 {
                label.font = UIFont(name: "8-bit Operator+ 8", size: 20 * scale)
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
        let nib = UINib(nibName: "RefreshView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
        
    }

}
