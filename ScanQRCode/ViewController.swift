//
//  ViewController.swift
//  ScanQRCode
//
//  Created by John Sansoucie on 3/3/19.
//  Copyright © 2019 John Sansoucie. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet var square: UIImageView!
    //display video to user
    var video = AVCaptureVideoPreviewLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create session variable
        let session = AVCaptureSession()
        
 //       //define capture device
 //      // let captureDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
 //       //AVCaptureDevice.default(for: AVMediaType.video)
 //       let captureDevice = AVCaptureDevice.default(for: .video)

 //       do {
 //           let input =  try AVCaptureDeviceInput(device: captureDevice!)
 //           session.addInput(input)
            
            
 //       }
 //       catch {
 //           print("ERROR")
 //       }
        var defaultVideoDevice: AVCaptureDevice?
        
        // Choose the back dual camera if available, otherwise default to a wide angle camera.
        if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .back) {
            defaultVideoDevice = dualCameraDevice
        }
            
        else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
            defaultVideoDevice = backCameraDevice
        }
            
        else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
            defaultVideoDevice = frontCameraDevice
        }
        do {
            let input = try AVCaptureDeviceInput(device: defaultVideoDevice!)
            session.addInput(input)        }
        catch {
            print("ERROR")
        }
        
        
        
        
        
        
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        //run on main thread
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //Bar codes assigned below code39 code128 etc
        //output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.code128
                , AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.qr
                , AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43
                , AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8              ]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubviewToFront(square)
        
        session.startRunning()
        
        
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            //if metadataObjects[0] is AVMetadataMachineReadableCodeObject {
             //   let object =  metadataObjects[0] as? AVMetadataMachineReadableCodeObject
              //  let alert = UIAlertController(title: "QR Code", message: object!.stringValue, preferredStyle: .alert)
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.code128
                {
                    let alert = UIAlertController(title: "code128 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                
                    present(alert, animated: true, completion: nil)
                }
                else if object.type == AVMetadataObject.ObjectType.qr
                {
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                     present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.code39
                {
                    let alert = UIAlertController(title: "code39 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.code93
                {
                    let alert = UIAlertController(title: "code93 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.code39Mod43
                {
                    let alert = UIAlertController(title: "code39Mod43 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.ean13
                {
                    let alert = UIAlertController(title: "ean13 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.ean8
                {
                    let alert = UIAlertController(title: "ean8 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                        
                    }))
                    present(alert, animated: true, completion: nil)
                    
                }
                
            }
        }
    }

}

