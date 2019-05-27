//
//  ViewController.swift
//  MemeMeApp
//
//  Created by Fares Alharbi on 13/08/1440 AH.
//  Copyright © 1440 Fares Alharbi. All rights reserved.
//

import UIKit

class memeEditor: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var memeArray = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        topTF.delegate = self
        bottomTF.delegate = self
        
        setup(TextField: topTF, withInitialText: "TOP")
        setup(TextField: bottomTF, withInitialText: "BOTTOM")
        
   
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    func setup(TextField: UITextField , withInitialText: String ){
        
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor:UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -3
        ]
        
        
        TextField.defaultTextAttributes = memeTextAttributes
        TextField.delegate = self
        TextField.textAlignment = .center
        TextField.text = withInitialText
 
        
    }
    

    @IBAction func pickClicked(_ sender: UIBarButtonItem) {
        
        pickImageClicked(sender: sender)
        
    }
    
    @IBAction func cameraClicked(_ sender: UIBarButtonItem) {
        
        pickImageClicked(sender: cameraBtn)
        
    }
    
    func pickImageClicked( sender: UIBarButtonItem){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
      
        present(imagePicker, animated: true, completion: nil)
        
        
        if sender == cameraBtn {
            
              imagePicker.sourceType = .camera
            
        } else {
            
              imagePicker.sourceType = .photoLibrary
            
        }
        
        
        
    }
    


    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTF.isFirstResponder {
            
        view.frame.origin.y -= getKeyboardHeight(notification)
            
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        
        
        
        view.frame.origin.y = 0
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
             NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    

    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
//        toolBar.isHidden = true
        
        
        // Render view to an image
        
        /*
          UIGraphicsBeginImageContext(mainImageView.frame.size)
         we choose mainImaegView to render the imageView bounds only
         if we choose view instead of mainImaegView it'll make screenshot for whole screen includes navigationbar and tabbar ( which we do not want)
         */
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        view.drawHierarchy(in: self.mainImageView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
//        toolBar.isHidden = false
        
        return memedImage
    }
    
    

    
    //MARK: To save image
    // create the memem object & save it on the meme array
    
    private func save(_ memedImage: UIImage) {
        //update meme
        
        let meme = Meme(topText: topTF.text! , bottomText: bottomTF.text! , originalImg: mainImageView.image! , memeImg: generateMemedImage())
        
        
        memeArray.append(meme)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.memes.append(meme)
    }

    
    @IBAction func shareClicked(_ sender: UIBarButtonItem) {
        
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (_, success, _, error) in
            
            if error == nil {
                
                
                
            }
            if(success) {
                self.save(self.generateMemedImage())
                self.dismiss(animated: true, completion: nil)
               print("successed")
            }
        }
        
        self.present(activityController, animated: true, completion: nil)
        
    
    }
    
    
    
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        
        topTF.text = "TOP"
        bottomTF.text = "BOTTOM"
        mainImageView.image = nil
 
    }
    
}


extension memeEditor: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            
            mainImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil
        )
    }
 
}

extension memeEditor: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topTF && topTF.text == "TOP" {
            
            textField.text = ""
        } else if textField == bottomTF && bottomTF.text == "BOTTOM" {
            
            textField.text = ""
        }
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == topTF && topTF.text == "" {
            
            textField.text = "TOP"
        } else if textField == bottomTF && bottomTF.text == "" {
            
            textField.text = "BOTTOM"
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
