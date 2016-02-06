//
//  ImageEditingViewController.swift
//  camera
//
//  Created by 大氣 on 2016/01/23.
//  Copyright © 2016年 Taiki. All rights reserved.
//

import UIKit


class ImageEditingViewController: UIViewController {
    
    var image :UIImage!
    @IBOutlet var imageview :UIImageView!
    var trimView1,trimView2,trimView3,trimView4 : UIImageView!
    var location: CGPoint!
    var currentLocation1,currentLocation2,currentLocation3,currentLocation4 : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageview.image = self.image
        
        self.trimView1 = UIImageView(frame: CGRectMake(25, 25, 50 , 50))
        trimView1.backgroundColor = UIColor.whiteColor()
        trimView1.layer.position = CGPoint(x: 25,y: 50)
        trimView1.userInteractionEnabled = true
        let myTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "trimView1Moved:")
        self.trimView1.addGestureRecognizer(myTap)
        self.view.addSubview(trimView1)
        
        
        self.trimView2 = UIImageView(frame: CGRectMake(self.imageview.frame.size.width-25, 25, 50, 50))
        trimView2.backgroundColor = UIColor.whiteColor()
        trimView2.layer.position = CGPoint(x: self.view.frame.size.width-25 ,y: 50)
        self.imageview.addSubview(trimView2)
        
        self.trimView3 = UIImageView(frame: CGRectMake(25, self.imageview.frame.size.height-25, 50, 50))
        trimView3.backgroundColor = UIColor.whiteColor()
        trimView3.layer.position = CGPoint(x: 25,y: self.imageview.frame.size.height-25)
        self.imageview.addSubview(trimView3)
        
        self.trimView4 = UIImageView(frame:
            CGRectMake(self.imageview.frame.size.width-25,self.imageview.frame.size.height-25, 50, 50))
        trimView4.backgroundColor = UIColor.whiteColor()
        trimView4.layer.position = CGPoint(x: self.imageview.frame.size.width-25,y: self.imageview.frame.size.height-25)
        self.imageview.addSubview(trimView4)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.locationInView(self.view)
        currentLocation1 = location
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        location = touch.locationInView(self.view)
        //        print(location)
        trimView1.center = CGPointMake(location.x, location.y)
//        trimView2.center = CGPointMake(location.x, location.y)
        if trimView1.center ==  location{
            
            if trimView1.center.x != currentLocation1.x {
                trimView3.center.x = trimView1.center.x
            }
        }
        
    }
    
    //    func tapGesture(sender:UITapGestureRecognizer){
    ////        self.trimView1sMoved()
    //
    //    }
    //    func trimView1Moved (sender: UITapGestureRecognizer,withEvent touches: Set<UITouch>, withEvent event: UIEvent? ) {
    //
    //         print("touch")
    //    }
}
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/


