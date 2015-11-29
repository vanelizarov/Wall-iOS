//
//  PostCell.swift
//  Wall
//
//  Created by vanelizarov on 25/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit

@IBDesignable class PostCell: UITableViewCell {

    var post : Post!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textView: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var showButton: ActionButton!
    @IBOutlet var editButton: ActionButton!
    @IBOutlet var deleteButton: ActionButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    
    
}
