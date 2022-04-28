//
//  ViewController.swift
//  CustomCamera
//
//  Created by Coditas on 21/04/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let captureSession = AVCaptureSession()
    var preViewLayer : CALayer!

    var captureDevice : AVCaptureDevice!
    var takePhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCamera()
    }

    func prepareCamera(){
        captureSession.sessionPreset = .photo
        if let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .front).devices.first{
            //captureDevice = availableDevices.first
            self.captureDevice = availableDevices
            
        }
    }
    
    func beginSession(){
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        }
        catch{
            print(error.localizedDescription)
        }
         let preViewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.preViewLayer = preViewLayer
            self.view.layer.addSublayer(preViewLayer)
            self.preViewLayer.frame = self.view.frame
            captureSession.startRunning()
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if captureSession.canAddOutput(dataOutput){
                captureSession.addOutput(dataOutput)
            }
            
            captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "okkk")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if takePhoto {
            takePhoto = false
            
             let image = self.getImageFromSampleBuffer(buffer: sampleBuffer)
                let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
                photoVC?.selectedImages.append(image)
                DispatchQueue.main.async {
                    self.present(photoVC!, animated: true, completion: nil)
                }
            
        }
        
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer)-> UIImage{
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer){
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer, options: .none)
            let context = CIContext()
            
            let imageRect = CGRect(x: 50, y: 50, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect){
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
                
        }
        return .add
    }
}

