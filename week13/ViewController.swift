//
//  ViewController.swift
//  week10
//
//  Created by admin on 05/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        
    @IBOutlet weak var imageView: UIImageView!
    
    let imgPick = UIImagePickerController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPick.delegate = self
    }
    
   
    @IBAction func photoAlbumPressed(_ sender: UIButton) {
        imgPick.sourceType = .photoLibrary
        imgPick.allowsEditing = true
        present(imgPick, animated: true, completion: nil)
    }
    
    @IBAction func videoPressed(_ sender: UIButton) {
        imgPick.mediaTypes = ["public.movie"]
        imgPick.videoQuality = .typeMedium
        getCamera()
    }
    
    fileprivate func getCamera(){
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertControl = UIAlertController(title: nil, message: "No camera availble for this device", preferredStyle: .alert)
            
            let agree = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in})
            
            alertControl.addAction(agree)
            self.present(alertControl, animated: true, completion: nil)
        }
        else{
            imgPick.sourceType = .camera
            imgPick.showsCameraControls = true
            imgPick.allowsEditing = true
            present(imgPick, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        guard let selectedImg = imageView.image else{
            print("No image available")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImg, self, #selector(imageMessages(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imageMessages(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
        alerts(title: "Save Error", message: "\(error.localizedDescription)")
        }
        else{
            alerts(title: "Photo saved to Library", message: "Did save photo")
        }
    }

    func alerts(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    @IBAction func photoPressed(_ sender: UIButton) {
        getCamera()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    
        if let url = info[.mediaURL] as? URL {
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
            }
        }
            else {
                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                imageView.image = image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
    var startingPoint = CGFloat(0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: view) {
            startingPoint = point.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: view){
            let diff = point.x - startingPoint
            
            imageView.transform = CGAffineTransform(translationX: diff, y: 0)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func txtOnImg(txt: String, img: UIImage, point: CGPoint) -> UIImage {
        
        let txtColor = UIColor.white
        let txtFont = UIFont(name: "Helvetica", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(img.size, false, scale)
        
        let txtFontAttr = [
            NSAttributedString.Key.font: txtFont,
            NSAttributedString.Key.foregroundColor: txtColor
        ] as [NSAttributedString.Key: Any]
        
        img.draw(in: CGRect(origin: CGPoint.zero, size: img.size))
        
        let rect = CGRect(origin: point, size: img.size)
        
        txt.draw(in: rect, withAttributes: txtFontAttr)
        
        guard let newImg = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        
        return newImg
    }
    
    @IBAction func editWithTxt(_ sender: UIButton) {
        
        imageView.image = txtOnImg(txt: "Here", img: imageView.image!, point: CGPoint(x: 20, y: 20))
        
    }
    
    
}

