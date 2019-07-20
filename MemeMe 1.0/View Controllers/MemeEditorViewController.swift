//
//  MemeEditorViewController.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/4/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UIToolbar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    let imagePicker = UIImagePickerController()
    var image: UIImage?
    var activeField: UITextField?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Checking if device has a camera
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Observing when keyboard shows/hides to shifting up/down a view
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Add a meme
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        switch (sender.tag) {
        case 0:
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
            break
        case 1:
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
            break
        default:
            break
        }
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        setupView()
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        setupTextFields()
        if image != nil {
            imageView.image = image
            shareButton.isEnabled = true
        }
        else {
            imageView.image = nil
            shareButton.isEnabled = false
        }
        view.backgroundColor = .white
    }
    
    // MARK: Share a meme
    @IBAction func shareMeme(_ sender: Any) {
        let sharedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [sharedImage!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        self.present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.save()
                self.setupView()
            }
            
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Generate a meme
    func generateMemedImage()-> UIImage? {
        hideBars(true)
        
        // Render view to an image
        imageView.backgroundColor = .white
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        if let memedImage = UIGraphicsGetImageFromCurrentImageContext() {
            hideBars(false)
            return memedImage
        }
        hideBars(false)
        UIGraphicsEndImageContext()
        return nil
    }
    
    func hideBars(_ state: Bool) {
        navigationBar.isHidden = state
        toolbar.isHidden = state
    }
    
    // MARK: Save an image
    func save() {
        if let memedImage = generateMemedImage(), let image = image, let top = topTextField.text, let bottom = bottomTextField.text {
            MemeStorage.shared.save(originalImage: image, topText: top, bottomText: bottom, memedImage: memedImage)
            showSentMemes()
        }
        else {
            let alert = UIAlertController(title: "No meme found", message: "Add some text and image to your meme:).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
    }
    
    func showSentMemes() {
        guard let tabController = storyboard?.instantiateViewController(withIdentifier: "tabController") else {
            print ("Unable to instatiate tab controller")
            return
        }
        present(tabController, animated: true)
    }
    
    // MARK: Configuring TextFields
    func setupTextFields() {
        setupTextField(topTextField, text: "TOP")
        setupTextField(bottomTextField, text: "BOTTOM")
    }
    
    // MARK: Setting up observers
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()  {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Shifting up view when keyboard shows
    @objc func keyboardWillShow(_ notification: Notification) {
        // Checking if keyboard covers one of the texfields
        guard let activeField = activeField else { return }
        
        let keyboardSize = getKeyboardFrame(notification)
        if (keyboardSize.intersects(activeField.frame) && view.frame.origin.y == 0){
            view.frame.origin.y -= keyboardSize.height
        }
    }
    
    // MARK: Shifting down view when keyboard hides
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    // helper function to get a keyboard frame
    func getKeyboardFrame(_ notification: Notification)-> CGRect {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue
    }

}
