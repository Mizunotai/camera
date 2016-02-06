//
//  ViewController.swift
//  camera
//
//  Created by 大氣 on 2016/01/23.
//  Copyright © 2016年 Taiki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    //カメラセッション
    var captureSession: AVCaptureSession!
    //デバイス
    var cameraDevices: AVCaptureDevice!
    //画像のアウトプット
    var imageOutput: AVCaptureStillImageOutput!
    
    var Image :UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //セッションの作成
        captureSession = AVCaptureSession()
        
        //デバイス一覧の取得
        let devices = AVCaptureDevice.devices()
        
        //バックカメラをcameraDevicesに格納
        for device in devices {
            if device.position == AVCaptureDevicePosition.Back {
                cameraDevices = device as! AVCaptureDevice
            }
        }
        
        //バックカメラからVideoInputを取得
        let videoInput: AVCaptureInput!
        do {
            videoInput = try AVCaptureDeviceInput.init(device: cameraDevices)
        } catch {
            videoInput = nil
        }
        
        //セッションに追加
        captureSession.addInput(videoInput)
        
        //出力先を生成
        imageOutput = AVCaptureStillImageOutput()
        
        //セッションに追加
        captureSession.addOutput(imageOutput)
        
        //画像を表示するレイヤーを生成
        let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        captureVideoLayer.frame = self.view.bounds
        captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //Viewに追加
        self.view.layer.addSublayer(captureVideoLayer)
        
        //セッション開始
        captureSession.startRunning()
        
        // UIボタンを作成.
        let myButton = UIButton(frame: CGRectMake(0,0,120,50))
        myButton.backgroundColor = UIColor.redColor();
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", forState: .Normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
  
        // UIボタンをViewに追加.
        self.view.addSubview(myButton);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ボタンイベント.
    func onClickMyButton(sender: UIButton){
        //ビデオ出力に接続
        let captureVideoConnection = imageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        //接続から画像を取得
        self.imageOutput.captureStillImageAsynchronouslyFromConnection(captureVideoConnection) { (imageDataBuffer, error) -> Void in
            //取得したImageのDataBufferをJPEGを変換
            let capturedImageData: NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            //JPEGからUIImageを作成
            self.Image = UIImage(data: capturedImageData)!
            //            //アルバムに追加
//          UIImageWriteToSavedPhotosAlbum(self.Image, self, nil, nil)
            
            self.performSegueWithIdentifier("sugue", sender: self)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let viewController2 = segue.destinationViewController as! ImageEditingViewController
        
       if segue.identifier == "sugue"{
            //遷移先のインスタンスをsegueから取り出す
            let viewController2 = segue.destinationViewController as! ImageEditingViewController

            //ここでいろいろ処理みたいなことをする
            viewController2.image = self.Image

        }
    }
    
}



