//
//  MemeEditorViewController.swift
//  MemeMe 2.0
//
//  Created by Rinalds Domanovs on 13/06/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UITextFieldDelegate {

    @IBOutlet var memeImage: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var navigation: UINavigationItem!
    @IBOutlet var toolbar: UIToolbar!
    
    var memedImage: UIImage?
    // MARK: App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initAppSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func initAppSettings() {
        memeImage.image = nil
        memeImage.contentMode = .scaleAspectFit

        // Navigation bar buttons
        navigation.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped))
        navigation.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareItem))
        navigation.leftBarButtonItem?.isEnabled = false
        navigation.title = Constants.TextField.appName

        initTextFields()
    }

    func initTextFields() {
        configureTextField(topTextField, with: Constants.TextField.topText)
        configureTextField(bottomTextField, with: Constants.TextField.bottomText)
    }

    func configureTextField(_ textField: UITextField, with defaultText: String) {
        textField.delegate = self
        textField.text = defaultText
        textField.borderStyle = .none
        textField.autocapitalizationType = .allCharacters
        textField.defaultTextAttributes = [
            .font: UIFont(name: Constants.TextField.font, size: CGFloat(Constants.TextField.size))!,
            .foregroundColor: Constants.TextField.foreGroundColor,
            .strokeColor: Constants.TextField.strokeColor,
            .strokeWidth: Constants.TextField.strokeWidth
        ]
        textField.textAlignment = .center
    }

    // MARK: Image methods
    @IBAction func pickAlbumImage(_ sender: UIBarButtonItem) {
        pickAnImage(from: .photoLibrary)
    }

    @IBAction func pickCameraImage(_ sender: UIBarButtonItem) {
        pickAnImage(from: .camera)
    }

    func pickAnImage(from source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            memeImage.image = image
            navigation.leftBarButtonItem?.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }

    // MARK: Text fields methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        if textField.tag == 1 {
            subscribeToKeyboardNotifications()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        unsubscribeFromKeyboardNotification()
        return true
    }

    // MARK: Keyboard methods

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
            selector:  #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
            as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    // MARK: Misc methods

    @objc func cancelTapped() {
        initAppSettings()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "InitialViewController") as? UITabBarController {
            present(vc, animated: true)
        }
    }

    @objc func shareItem() {
        memedImage = generateImage()
        let ac = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        ac.completionWithItemsHandler = {
            (activityType, completed, returnedItems, activityError) in
            if completed {
                self.saveMeme()
            }
        }
        present(ac, animated: true)
    }

    func saveMeme() {
        if memeImage != nil {
            let meme = Meme(topString: topTextField.text!,
                            bottomString: bottomTextField.text!,
                            originalImage: memeImage.image!,
                            updatedImage: memedImage!)

            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
        }

    }

    func generateImage() -> UIImage {
        showNavAndToolbar(false)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        showNavAndToolbar(true)

        return memedImage
    }


    func showNavAndToolbar(_ show: Bool) {
        if show {
            navigationBar.isHidden = false
            toolbar.isHidden = false
        } else {
            navigationBar.isHidden = true
            toolbar.isHidden = true
        }
    }
    
}
