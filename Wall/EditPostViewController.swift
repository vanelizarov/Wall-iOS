//
//  EditPostViewController.swift
//  Wall
//
//  Created by vanelizarov on 26/11/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit
import Alamofire

class EditPostViewController: ResponsiveViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var textView: UITextView!
    @IBOutlet var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var updateButton: ActionButton!
    @IBOutlet var titlePrompt: UILabel!
    @IBOutlet var textPrompt: UILabel!
    
    var post = Post(id: 0, title: "Not Available", text: "Not Available", date: "N/A")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activeTextView = textView
        self.constraintToChange = textViewBottomConstraint
        
        titleTextField.delegate = self
        
        
        let cancelButton = UIBarButtonItem(title: "Hide Keyboard", style: .Plain, target: self, action: "doneEditing")
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.bounds.size.width, 50))
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil), cancelButton]
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
        
        textView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        
        titleTextField.text = post.title
        textView.text = post.text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func doneEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func updatePost(sender: AnyObject) {
        
        if titleTextField.text?.characters.count < 4 {
            
            titlePrompt.text = "Title must be at least 4 characters long"
            titlePrompt.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            
        } else if textView.text.characters.count < 4 {
            
            textPrompt.text = "Text must be at least 4 characters long"
            textPrompt.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            
        } else {
        
            let parameters = [
                
                "title" : titleTextField.text!,
                "text" : textView.text!
                
            ]
            
            let headers = [
                
                "Content-Type" : "application/json",
                
            ]
            
            Alamofire.request(.PATCH, "http://morning-everglades-5369.herokuapp.com/posts/\(self.post.id)", parameters: parameters, encoding: .JSON, headers: headers)
            
            NSNotificationCenter.defaultCenter().postNotificationName("postsUpdated", object: nil)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
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
