//
//  MemeDetailsViewController.swift
//  MemeMe 2.0
//
//  Created by Rinalds Domanovs on 13/06/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedImage = selectedImage {
            imageView.image = selectedImage
        }
    }

}
