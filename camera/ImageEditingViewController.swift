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
    @IBOutlet var backImageview :UIImageView!
    var trimView1,trimView2,trimView3,trimView4 : UIImageView!
    var moveView: UIImageView!
    
    var location: CGPoint!
    var currentLocation1,currentLocation2,currentLocation3,currentLocation4 : CGPoint!
    var startPoint : CGPoint!
    var isImageInside: Bool?
    var imageListArray : [UIImageView] = []
    var imageViewFrame :CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backImageview.image = self.image
        
        self.trimView1 = UIImageView(frame: CGRectMake(25, 25, 50 , 50))
        trimView1.backgroundColor = UIColor.whiteColor()
        trimView1.layer.position = CGPoint(x: 25,y: 50)
        self.backImageview.addSubview(trimView1)
        
        
        self.trimView2 = UIImageView(frame: CGRectMake(self.backImageview.frame.size.width-25, 25, 50, 50))
        trimView2.backgroundColor = UIColor.whiteColor()
        trimView2.layer.position = CGPoint(x: self.view.frame.size.width-25 ,y: 50)
        self.backImageview.addSubview(trimView2)
        
        self.trimView3 = UIImageView(frame: CGRectMake(25, self.backImageview.frame.size.height-25, 50, 50))
        trimView3.backgroundColor = UIColor.whiteColor()
        trimView3.layer.position = CGPoint(x: 25,y: self.backImageview.frame.size.height-25)
        self.backImageview.addSubview(trimView3)
        
        self.trimView4 = UIImageView(frame:
            CGRectMake(self.backImageview.frame.size.width-25,self.backImageview.frame.size.height-25, 50, 50))
        trimView4.backgroundColor = UIColor.whiteColor()
        trimView4.layer.position = CGPoint(x: self.backImageview.frame.size.width-25,y: self.backImageview.frame.size.height-25)
        self.backImageview.addSubview(trimView4)
        
        self.imageListArray.append(trimView1)
        self.imageListArray.append(trimView2)
        self.imageListArray.append(trimView3)
        self.imageListArray.append(trimView4)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        startPoint = touch.locationInView(self.view)
               
        for imageView in self.imageListArray {
            if self.compareViewPositon(imageView) {
                self.isImageInside = true
                break
            } else {
                self.isImageInside = false
            }
        }
    }
    
    
    func compareViewPositon(imageView: UIImageView) -> Bool {
        let imageViewFrame = imageView.frame.origin
        
        // イメージの範囲
        let MinX = imageViewFrame.x
        let MaxX = imageViewFrame.x + imageView.frame.width
        let MinY = imageViewFrame.y
        let MaxY = imageViewFrame.y + imageView.frame.height
        
        if (MinX <= startPoint!.x && startPoint!.x <= MaxX) && (MinY <= startPoint!.y && startPoint!.y <= MaxY) {
            print("Inside of Image")
            self.moveView = imageView
            return true
        } else {
            print("Outside of Image")
            return false
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.isImageInside! {
            let touch: UITouch = touches.first!
            location = touch.locationInView(self.view)
            
            // イメージを移動
            
            moveView.center = CGPointMake(location.x,location.y)
        } else {
            
        }
        
        
        
    }
    
    
    
    
}
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/


