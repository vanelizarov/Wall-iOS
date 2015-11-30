//
//  Post.swift
//  Wall
//
//  Created by vanelizarov on 29/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import Foundation

class Post: NSObject {
    
    var id : Int64!
    var title : String!
    var text : String!
    var date : String!
    
    init(id: Int64, title: String, text: String, date: String) {
        
        self.id = id
        self.title = title
        self.text = text
        self.date = date
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
        print(dateFormatter.dateFromString(self.date)!.description)
        
    }
    
    init(post: Post) {
        
        self.id = post.id
        self.title = post.title
        self.text = post.text
        self.date = post.date
        
    }
    
    func _print() {
        
        print("Post:\n\tid: \(self.id)\n\ttitle: \(self.title)\n\ttext: \(self.text)\n\tdate: \(self.date)")
        
    }

}

