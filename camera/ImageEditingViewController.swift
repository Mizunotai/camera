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
    var trimTopLeltView,trimTopRightView,trimBottomLeftView,trimBottomRightView : UIImageView!
    var moveView: UIImageView!
    var location: CGPoint!
    var startPoint : CGPoint!
    var isImageInside: Bool?
    var imageListArray : [UIImageView] = []
    var imageViewFrame :CGPoint!
    var trimmingView : UIImageView!
    var trimWidth : CGFloat!
    var trimHeight : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backImageview.image = self.image
        
        self.trimTopLeltView = UIImageView(frame: CGRectMake(0, 20, 40 , 40))
        zahyouset(trimTopLeltView)
        
        self.trimTopRightView = UIImageView(frame: CGRectMake(self.backImageview.frame.size.width-40, 20, 40, 40))
        zahyouset(trimTopRightView)
        
        self.trimBottomLeftView = UIImageView(frame: CGRectMake(0, self.backImageview.frame.size.height-40, 40, 40))
        zahyouset(trimBottomLeftView)
        
        self.trimBottomRightView = UIImageView(frame:
            CGRectMake(self.backImageview.frame.size.width-40,self.backImageview.frame.size.height-40, 40, 40))
        
        zahyouset(trimBottomRightView)
        
        self.trimWidth = trimTopRightView.center.x - trimTopLeltView.center.x
        self.trimHeight = trimBottomLeftView.center.y - trimTopLeltView.center.y
//        let trimWidth = trimTopRightView.frame.size.width - trimTopLeltView.center.
        
        trimmingView = UIImageView(frame: CGRectMake(trimTopLeltView.center.x, trimTopLeltView.center.y,
            trimWidth , trimHeight) )
        trimmingView.backgroundColor = UIColor.clearColor()
        trimmingView.layer.borderColor = UIColor.whiteColor().CGColor
        self.trimmingView.layer.borderWidth = 4
        self.backImageview.addSubview(trimmingView)
        
//        self.imageListArray.append(trimTopLeltView)
//        self.imageListArray.append(trimTopRightView)
//        self.imageListArray.append(trimBottomLeftView)
//        self.imageListArray.append(trimBottomRightView)
        // Do any additional setup after loading the view.
        
    }
    
    func zahyouset(view: UIImageView){
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = view.frame.size.width / 2
        self.backImageview.addSubview(view)
        self.imageListArray.append(view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        startPoint = touch.locationInView(self.backImageview)
        
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
            location = touch.locationInView(self.backImageview)
            self.trimWidth = trimTopRightView.center.x - trimTopLeltView.center.x
            self.trimHeight = trimBottomLeftView.center.y - trimTopLeltView.center.y

            trimmingView.frame = CGRectMake(trimTopLeltView.center.x, trimTopLeltView.center.y, trimWidth, trimHeight)
           
            // イメージを移動
            moveView.center = CGPointMake(location.x,location.y)
            if trimTopLeltView.center ==  location{
                if trimTopLeltView.center.x != startPoint.x {
                    trimBottomLeftView.center.x = trimTopLeltView.center.x
                }
                if trimTopLeltView.center.y != startPoint.y {
                    trimTopRightView.center.y = trimTopLeltView.center.y
                }
            }
            if trimTopRightView.center == location {
                if trimTopRightView.center.x != startPoint.x{
                    trimBottomRightView.center.x = trimTopRightView.center.x
                }
                if trimTopRightView.center.y != startPoint.y {
                    trimTopLeltView.center.y = trimTopRightView.center.y
                }
            }
            if trimBottomLeftView.center == location {
                if trimBottomLeftView.center.x != startPoint.x{
                    trimTopLeltView.center.x = trimBottomLeftView.center.x
                }
                if trimTopRightView.center.y != startPoint.y {
                    trimBottomRightView.center.y = trimBottomLeftView.center.y
                }
            }
            if trimBottomRightView.center == location {
                if trimBottomRightView.center.x != startPoint.x{
                    trimTopRightView.center.x = trimBottomRightView.center.x
                }
                if trimTopRightView.center.y != startPoint.y {
                    trimBottomLeftView.center.y = trimBottomRightView.center.y
                }
            }
        } else {
            
        }
        
    }
    @IBAction func trimButoon() {
        self.trimWidth = trimTopRightView.center.x - trimTopLeltView.center.x
        self.trimHeight = trimBottomLeftView.center.y - trimTopLeltView.center.y

        let cropedImage:UIImage = self.cropThumbnailImage(self.image, w: Int(self.trimWidth), h: Int(self.trimHeight))
        self.backImageview.image = cropedImage
    }
    
    func cropThumbnailImage(image :UIImage, w:Int, h:Int) ->UIImage
    {
        // リサイズ処理
        
        let origRef    = image.CGImage;
        let origWidth  = Int(CGImageGetWidth(origRef))
        let origHeight = Int(CGImageGetHeight(origRef))
        var resizeWidth:Int = 0, resizeHeight:Int = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSizeMake(CGFloat(resizeWidth), CGFloat(resizeHeight))
        UIGraphicsBeginImageContext(resizeSize)
        
        image.drawInRect(CGRectMake(0, 0, CGFloat(resizeWidth), CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 切り抜き処理
        
        let cropRect  = CGRectMake(
            CGFloat((resizeWidth - w) / 2),
            CGFloat((resizeHeight - h) / 2),
            CGFloat(w), CGFloat(h))
        let cropRef   = CGImageCreateWithImageInRect(resizeImage.CGImage, cropRect)
        let cropImage = UIImage(CGImage: cropRef!)
        
        return cropImage
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


