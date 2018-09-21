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
    var imageView: UIImageView!

    fileprivate var currentSampleBuffer: CMSampleBuffer?
    var currentFrame: UIImage? { return self.currentSampleBuffer?.toUIImage() }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cameraQueue = DispatchQueue(label: "camera.queue")
        session = AVCaptureSession()
        output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: cameraQueue)
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

        session.startRunning()

        imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -300.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        currentSampleBuffer = sampleBuffer
        DispatchQueue.main.async {
            if let currentFrame = self.currentFrame {
                self.imageView.image = OpenCVWrapper.saturation(currentFrame)
            }
        }
    }
}

