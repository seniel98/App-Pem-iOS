//
//  QRScannerController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 2/01/2020.
//  Copyright © 2020 Jose Daniel. All rights reserved.
//

import UIKit
import AVFoundation



class QRScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    
    
    var captureSession: AVCaptureSession? //variable for video capturing
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var model: QRSearchModel?
    var data: TableData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Scan QR Code"
        
        model = QRSearchModel()
        

        // Do any additional setup after loading the view.
        // Move the message label and top bar to the front
        view.bringSubviewToFront(messageLabel)
        // get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            let test = "STD0000"
            model?.search(userId: getUserId(id: test), id: getNumberId(id: test)){ (error) in
                    if error{
                        let alertController = UIAlertController(
                                                    title: nil,
                                                    message: "No data found for that id",
                                                    preferredStyle: .alert
                                                    )
                        alertController.addAction(UIAlertAction(title: "Ok",style: .cancel))
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        //Perform segue
                        self.data = self.model?.getData()
                        self.performSegue(withIdentifier: "searchByQRSegue", sender: self)
                    }
                
                }
            
            
            
            print("Failed to get the camera device")
            return
        }

        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
             
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if metadataObjects.count == 0 {
        qrCodeFrameView?.frame = CGRect.zero
        messageLabel.text = "No QR code is detected"
        return
    }
    
    // Get the metadata object.
    let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    
    if metadataObj.type == AVMetadataObject.ObjectType.qr {
        // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
        qrCodeFrameView?.frame = barCodeObject!.bounds
        
        if metadataObj.stringValue != nil {
            //QRsearchModel.search
            messageLabel.text = metadataObj.stringValue
        }
    }
    }
    
    func getUserId(id: String)->String{
        return id.prefix(3).uppercased()
    }
    
    func getNumberId(id: String)->String{
        return String(id.suffix(4))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "searchByQRSegue"{
            if let destinationVC = segue.destination as? UserViewController {
                destinationVC.data = self.data
            }
        }
    }
}
