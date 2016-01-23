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
    var trimView1,trimView2,trimgView3,trimView4 : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageview.image = self.image
        
        self.trimView1 = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        trimView1.backgroundColor = UIColor.whiteColor()
        trimView1.layer.position = CGPoint(x: 0,y: 0)
        self.imageview.addSubview(trimView1)
        
        self.trimView2 = UIImageView(frame: CGRectMake(self.view.frame.origin.x, 0, 100, 100))
        trimView2.backgroundColor = UIColor.whiteColor()
        trimView2.layer.position = CGPoint(x: self.view.frame.origin.x ,y: 0)
        self.imageview.addSubview(trimView2)

        
        // Do any additional setup after loading the view.
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
