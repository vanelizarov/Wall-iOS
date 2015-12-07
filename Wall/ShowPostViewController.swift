//
//  ShowPostViewController.swift
//  Wall
//
//  Created by vanelizarov on 26/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit

class ShowPostViewController: UIViewController {

    @IBOutlet var header: TableHeader!
    @IBOutlet var textView: UITextView!
    
    var post = Post(id: 0, title: "Not available", text: "Not Available", date: "N/A")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        header.labelText = post.title
        textView.text = post.text
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPost(sender: AnyObject) {
        
        let editPostViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editPostViewController") as! EditPostViewController
        editPostViewController.post = self.post
        
        self.presentViewController(editPostViewController, animated: true, completion: nil)

        
    }
    
    @IBAction func goBack(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
