//
//  ViewController.swift
//  CameraSample
//
//  Created by Naoyoshi Aikawa on 2018/09/12.
//  Copyright © 2018年 Naoyoshi Aikawa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var device: AVCaptureDevice!
    var session: AVCaptureSession!
    var output: AVCaptureVideoDataOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        session = AVCaptureSession()
        output = AVCaptureVideoDataOutput()
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("Caught exception!")
            return
        }
        session.addInput(input)
        session.addOutput(output)

        session.sessionPreset = .photo
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
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
        //let connection = output.connection(with: .video)

    }
}

