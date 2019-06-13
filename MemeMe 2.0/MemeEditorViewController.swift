//
//  MemeEditorViewController.swift
//  MemeMe 2.0
//
//  Created by Rinalds Domanovs on 13/06/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet var memeImage: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var navigation: UINavigationItem!
    
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
        
    }

    @objc func cancelTapped() {
        print("Cancel")
    }

    @objc func shareItem() {
        print("Share")
    }
    
}
