//
//  MailViewController.swift
//  test
//
//  Created by Meijia Gao on 10/23/15.
//  Copyright (c) 2015 walmart. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {

    @IBOutlet weak var feedScrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var messageView: UIImageView!
    
    @IBOutlet weak var leftIconView: UIView!
    
    @IBOutlet weak var archiveIconView: UIImageView!
    
    @IBOutlet weak var deleteIconView: UIImageView!
    

    @IBOutlet weak var rightIconView: UIView!
    
    @IBOutlet weak var laterIconView: UIImageView!
    
    @IBOutlet weak var listIconView: UIImageView!
    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    @IBOutlet weak var listImageView: UIImageView!
    
    var initialCenter: CGPoint!
    
    var initialIconCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listIconView.hidden = true
        
        deleteIconView.hidden = true
        
        rescheduleView.alpha = 0.0
        
        listImageView.alpha = 0.0

        feedScrollView.contentSize = CGSize(width: 320, height: 1202)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        println("\(location), \(translation)")
        
        if sender.state == UIGestureRecognizerState.Began {
            
            initialCenter = messageView.center
            
            initialIconCenter = archiveIconView.center
            
            leftIconView.hidden = false
            
            rightIconView.hidden = false
            
            println("Gesture began at: \(initialIconCenter)")
            
        }
        
        else if sender.state == UIGestureRecognizerState.Changed {
            
            println("Gesture changed at: \(location)")
            
            messageView.center.x = initialCenter.x + translation.x
            
            
            if messageView.center.x > 420.0
            {
                archiveIconView.hidden = true
                
                deleteIconView.hidden = false
                
                rightIconView.hidden = true
                
                containerView.backgroundColor = UIColorFromHex(0xEA563B, alpha: 1.0)
                
                leftIconView.center.x = messageView.center.x - 173.0
            }
            
            else if messageView.center.x > 220.0
            {
                deleteIconView.hidden = true
                
                archiveIconView.hidden = false
                
                containerView.backgroundColor = UIColorFromHex(0x74D868, alpha: 1.0)
                
                leftIconView.center.x = messageView.center.x - 173.0
            }
                
            else if messageView.center.x < -100.0
            {
                laterIconView.hidden = true
                
                listIconView.hidden = false
                
                leftIconView.hidden = true
                
                containerView.backgroundColor = UIColor.brownColor()
                
                rightIconView.center.x = messageView.center.x + 183.0
            }
                
            else if messageView.center.x < 100.0
            {
                
                laterIconView.hidden = false
                
                listIconView.hidden = true
                
                containerView.backgroundColor = UIColorFromHex(0xEFFEB8B, alpha: 1.0)
                
                rightIconView.center.x = messageView.center.x + 183.0
                
                
            }
            
            else {
                containerView.backgroundColor = UIColorFromHex(0xDADADA, alpha: 1.0)
                
            }
            
        }

        
    
        else if sender.state == UIGestureRecognizerState.Ended {

            println("Gesture ended at: \(location)")
            
            if messageView.center.x > 100.0 && messageView.center.x < 220.0
            {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = 160.0
                })
            }
                
            else if messageView.center.x < -100.0
            {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.listImageView.alpha = 1.0
                })
            }
            
            else if messageView.center.x < 100.0
            {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.rescheduleView.alpha = 1.0
                })
            }
            
            else if messageView.center.x > 220.0
            {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = 420.0
                    self.leftIconView.center.x = self.messageView.center.x - 173.0
                    
                })
            }
        }
        
        
    }
    
    

    @IBAction func onTapRescheduleGesture(sender: UITapGestureRecognizer) {
        
        println("the reschedule view is tapped.")
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleView.alpha = 0.0
            self.messageView.center.x = 160.0
            self.rightIconView.center.x = 282.5
        })
        
    }
    
    
    @IBAction func onTapListGesture(sender: UITapGestureRecognizer) {
        
        println("the list view is tapped.")
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listImageView.alpha = 0.0
            self.messageView.center.x = 160.0
            self.rightIconView.center.x = 282.5
            self.laterIconView.hidden = false
            self.listIconView.hidden = true
        })
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
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
