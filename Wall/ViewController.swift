//
//  ViewController.swift
//  Wall
//
//  Created by vanelizarov on 25/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UITableViewController {
    
    var posts = [Post]()
    var postToShow : Post!
    
    var upHeader : UIView!

    func createPost(title: String, text: String) {
        
        print("create \(title), \(text)")
        
    }
    
    func editPost(sender: ActionButton) {
        
        (sender.superview?.superview as! PostCell).post._print()
        
        let editPostViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editPostViewController") as! EditPostViewController
        editPostViewController.post = (sender.superview?.superview as! PostCell).post
        
        self.presentViewController(editPostViewController, animated: true, completion: nil)
        
    }
    
    func deletePost(sender: ActionButton) {
        
        //print("delete \(id)")
        
    }
    
    func showPost(sender: ActionButton) {
        
        (sender.superview?.superview as! PostCell).post._print()
        
        let showPostViewController = self.storyboard?.instantiateViewControllerWithIdentifier("showPostViewController") as! ShowPostViewController
        showPostViewController.post = (sender.superview?.superview as! PostCell).post
        
        self.presentViewController(showPostViewController, animated: true, completion: nil)
        
    }
    
    func addNewPost() {
    
        print("new")
    
    }
    
    func getPosts() {
        
        Alamofire.request(.GET, "http://morning-everglades-5369.herokuapp.com/posts.json", parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) -> Void in
            
            switch response.result {
                
            case .Success(let data):
                let postsData = JSON(data)
                
                //print(postsData)
                
                
                for (_, object) in postsData {
                    
                    
                    if let id = object["id"].int64 {
                        if let title = object["title"].string {
                            if let text = object["text"].string {
                                if let date = object["created_at"].string {
                                    
                                    self.posts.append(Post(id: id, title: title, text: text, date: date))
                                    
                                }
                            }
                        }
                    
                    }
                    
                    
                }
                
            
                self.tableView.reloadData()
                
                break
                
            case .Failure(let error):
                
                print(error.localizedDescription)
                
                break
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let header = TableHeader(frame: CGRectMake(0, 0, tableView.frame.size.width, 122))
        header.newPostButton.addTarget(self, action: "addNewPost", forControlEvents: UIControlEvents.TouchUpInside)
        tableView.tableHeaderView = header
        
        upHeader = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 0))
        upHeader.backgroundColor = UIColor(red: 21 / 255.0, green: 23 / 255.0, blue: 23 / 255.0, alpha: 1.0)
        self.view.addSubview(upHeader)
        
        getPosts()
    
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        upHeader.frame = CGRectMake(0, 0, self.view.frame.size.width, tableView.contentOffset.y)
        upHeader.backgroundColor = UIColor(red: 21 / 255, green: 23 / 255, blue: 23 / 255, alpha: 1.0)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        tableView.delaysContentTouches = false
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 99.0
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        cell.post = posts.reverse()[indexPath.row]
        cell.titleLabel.text = posts.reverse()[indexPath.row].title
        cell.textView.text = posts.reverse()[indexPath.row].text
        cell.dateLabel.text = posts.reverse()[indexPath.row].date
        
        cell.showButton.addTarget(self, action: "showPost:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.editButton.addTarget(self, action: "editPost:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.deleteButton.addTarget(self, action: "deletePost:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

