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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        imageview = UIImageView(image: image)
            self.imageview.image = self.image
      
//        self.view.addSubview(imageview)
        
        
        
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
