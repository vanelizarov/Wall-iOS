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
import MBProgressHUD

class ViewController: UITableViewController {
    
    var posts = [Post]()
    var postToShow : Post!
    
    var refreshView : UIView!
    
    func editPost(sender: ActionButton) {
        
        (sender.superview?.superview as! PostCell).post._print()
        
        let editPostViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editPostViewController") as! EditPostViewController
        editPostViewController.post = (sender.superview?.superview as! PostCell).post
        
        self.presentViewController(editPostViewController, animated: true, completion: nil)
        
    }
    
    func deletePost(sender: ActionButton) {
        
        (sender.superview?.superview as! PostCell).post._print()
        
        let deleteAlertController = UIAlertController(title: "Are you sure?", message: "This cannot be undone", preferredStyle: UIAlertControllerStyle.ActionSheet)
        deleteAlertController.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            
            Alamofire.request(.DELETE, "http://morning-everglades-5369.herokuapp.com/posts/\((sender.superview?.superview as! PostCell).post.id)", parameters: nil, encoding: .JSON, headers: nil)
            
            self.updateData()
            
        }))
        deleteAlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(deleteAlertController, animated: true, completion: nil)
        
    }
    
    func showPost(sender: ActionButton) {
        
        (sender.superview?.superview as! PostCell).post._print()
        
        let showPostViewController = self.storyboard?.instantiateViewControllerWithIdentifier("showPostViewController") as! ShowPostViewController
        showPostViewController.post = (sender.superview?.superview as! PostCell).post
        
        self.presentViewController(showPostViewController, animated: true, completion: nil)
        
    }
    
    func addNewPost() {
    
        let newPostViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newPostViewController") as! NewPostViewController
        
        self.presentViewController(newPostViewController, animated: true, completion: nil)
    
    }
    
    func getPosts() {
        
        posts.removeAll()
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Loading"
        hud.labelFont = UIFont(name: "8-bit Operator+ 8", size: 15)
        hud.cornerRadius = 0
        hud.dimBackground = true
        
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
                hud.hide(true)
                
                self.refreshControl!.endRefreshing()
                
                break
                
            case .Failure(let error):
                
                print(error.localizedDescription)
                
                let errorAlertController = UIAlertController(title: "Something goes wrong", message: "Error getting posts", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                self.presentViewController(errorAlertController, animated: true, completion: nil)
                
                hud.hide(true)
                self.refreshControl!.endRefreshing()
                
                break
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        let header = TableHeader(frame: CGRectMake(0, 0, tableView.frame.size.width, 122))
        header.newPostButton.addTarget(self, action: "addNewPost", forControlEvents: UIControlEvents.TouchUpInside)
        tableView.tableHeaderView = header
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clearColor()
        refreshControl?.backgroundColor = UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1.0)
        tableView.addSubview(refreshControl!)
        
        loadRefreshControlView()
        
        refreshControl!.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateData", name: "postsUpdated", object: nil)
        
        updateData()
    
    }
    
    func loadRefreshControlView() {
        
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshView", owner: self, options: nil)

        refreshView = refreshContents[0] as! UIView
        refreshView.frame = refreshControl!.bounds
        
        refreshControl?.addSubview(refreshView)
        
    }
    
    func updateData() {
        
        getPosts()
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
        cell.textView.text = posts.reverse()[indexPath.row].text.truncate(200, trailing: "...")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.dateFromString(posts.reverse()[indexPath.row].date)
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        
        cell.dateLabel.text = formatter.stringFromDate(date!)
        
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

