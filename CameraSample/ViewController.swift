//
//  ViewController.swift
//  CameraSample
//
//  Created by Naoyoshi Aikawa on 2018/09/12.
//  Copyright © 2018年 Naoyoshi Aikawa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var device: AVCaptureDevice!
    var session: AVCaptureSession!
    var output: AVCaptureStillImageOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // セッションを生成
        session = AVCaptureSession()
        // バックカメラを選択
        for d in AVCaptureDevice.devices() {
            // Swift 3まで
            // if (d as AnyObject).position == AVCaptureDevicePosition.back {
            if (d as AnyObject).position == AVCaptureDevice.Position.back {
                // Swift 3まで
                // device = d as? AVCaptureDevice
                device = d as AVCaptureDevice
                print("\(device!.localizedName) found.")
            }
        }
        // バックカメラからキャプチャ入力生成
        // Swift 3まで
        // let input: AVCaptureDeviceInput?
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("Caught exception!")
            return
        }
        session.addInput(input)
        output = AVCaptureStillImageOutput()
        session.addOutput(output)
        // Swift 3まで
        // session.sessionPreset = AVCaptureSessionPresetPhoto
        session.sessionPreset = .photo
        // プレビューレイヤを生成
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        // Swift 3まで
        // previewLayer?.frame = view.bounds
        // view.layer.addSublayer(previewLayer!)
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        // セッションを開始
        session.startRunning()
        // 撮影ボタンを生成
        let button = UIButton()
        button.setTitle("撮影", for: .normal)
        button.contentMode = .center
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.backgroundColor = UIColor.blue
        //button.tintColor = UIColor.grayColor()
        //button.setTitleColor(UIColor.blue, for: UIControlState())
        button.layer.position = CGPoint(x: view.frame.width / 2, y: self.view.bounds.size.height - 80)
        button.addTarget(self, action: #selector(ViewController.shot(_:)), for: .touchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Swift 3まで
    // func shot(_ sender: AnyObject) {
    @objc func shot(_ sender: AnyObject) {
        // Swift 3まで
        // let connection = output.connection(withMediaType: AVMediaTypeVideo)
        // output.captureStillImageAsynchronously(from: connection) {(imageDataBuffer, error) -> Void in
        //     let imageData: Data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
        let connection = output.connection(with: .video)
        output.captureStillImageAsynchronously(from: connection!) {(imageDataBuffer, error) -> Void in
            if error == nil, let imageData: Data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer!) {
                let image = UIImage(data: imageData)!
                // 画像をカメラロールに保存
                UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            }
        }
    }
}

