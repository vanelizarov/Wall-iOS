//
//  ResposiveViewController.swift
//  Wall
//
//  Created by vanya elizarov on 05/12/15.
//  Copyright © 2015 vanelizarov. All rights reserved.
//

import UIKit

class ResponsiveViewController: UIViewController {
    
    var activeTextView : UITextView!
    var constraintToChange : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
             
                if activeTextView.isFirstResponder() {
                    
                    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
                    self.view.frame.origin.y = 0 - self.activeTextView.frame.origin.y + 16 + 24
                    self.constraintToChange.constant = keyboardSize.height - 40 - 5 - 137
                    
                } /*else {
                    print("Ha-ha, got ya")
                }*/
                //self.activeTextView.frame.size.height = UIScreen.mainScreen().bounds.size.height - keyboardSize.height - self.activeTextView.frame.origin.y
                
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        self.view.frame.origin.y = 0
        self.constraintToChange.constant = 8
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
