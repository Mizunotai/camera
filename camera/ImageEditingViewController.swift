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
    var startPoint : CGPoint!
    var isImageInside: Bool?
    var imageListArray : [UIImageView] = []
    var imageViewFrame :CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backImageview.image = self.image
        
        self.trimView1 = UIImageView(frame: CGRectMake(0, 20, 40 , 40))
        zahyouset(trimView1)
        
        self.trimView2 = UIImageView(frame: CGRectMake(self.backImageview.frame.size.width-40, 20, 40, 40))
        zahyouset(trimView2)
        
        self.trimView3 = UIImageView(frame: CGRectMake(0, self.backImageview.frame.size.height-40, 40, 40))
        zahyouset(trimView3)
        
        self.trimView4 = UIImageView(frame:
            CGRectMake(self.backImageview.frame.size.width-40,self.backImageview.frame.size.height-40, 40, 40))
        
        zahyouset(trimView4)
        
        
        self.imageListArray.append(trimView1)
        self.imageListArray.append(trimView2)
        self.imageListArray.append(trimView3)
        self.imageListArray.append(trimView4)
        // Do any additional setup after loading the view.
    }

    func zahyouset(view: UIImageView){
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = view.frame.size.width / 2
        self.backImageview.addSubview(view)
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
            if trimView1.center ==  location{
                
                if trimView1.center.x != startPoint.x {
                    trimView3.center.x = trimView1.center.x
                }
                if trimView1.center.y != startPoint.y {
                    trimView2.center.y = trimView1.center.y
                }
            }
            if trimView2.center == location {
                if trimView2.center.x != startPoint.x{
                    trimView4.center.x = trimView2.center.x
                }
                if trimView2.center.y != startPoint.y {
                    trimView1.center.y = trimView2.center.y
                }
            }
            if trimView3.center == location {
                if trimView3.center.x != startPoint.x{
                    trimView1.center.x = trimView3.center.x
                }
                if trimView2.center.y != startPoint.y {
                    trimView4.center.y = trimView3.center.y
                }
            }
            if trimView4.center == location {
                if trimView4.center.x != startPoint.x{
                    trimView2.center.x = trimView4.center.x
                }
                if trimView2.center.y != startPoint.y {
                    trimView3.center.y = trimView4.center.y
                }
            }
            
            
            
            
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


