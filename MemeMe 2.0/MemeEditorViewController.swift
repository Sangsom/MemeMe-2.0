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

    // MARK: Keyboard methods

    // MARK: Misc methods

    @objc func cancelTapped() {
        initAppSettings()
    }

    @objc func shareItem() {
        print("Share")
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
