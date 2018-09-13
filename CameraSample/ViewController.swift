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
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)

        // セッションを開始
        session.startRunning()

        // 撮影ボタンを生成
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("撮影", for: .normal)
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        button.backgroundColor = UIColor.blue
        //button.tintColor = UIColor.grayColor()
        //button.setTitleColor(UIColor.blue, for: UIControlState())
        button.addTarget(self, action: #selector(ViewController.shot(_:)), for: .touchUpInside)
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

