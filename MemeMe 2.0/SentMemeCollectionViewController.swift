//
//  SentMemeCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Rinalds Domanovs on 13/06/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentMemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addMeme))

        initiateGridSettings()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! SentMemeCollectionViewCell
        cell.imageView.image = memes[indexPath.row].updatedImage
        return cell
    }

    @objc func addMeme() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as? MemeEditorViewController {
            present(vc, animated: true)
        }
    }

    func initiateGridSettings() {
        let space: CGFloat = 3.0
        let dimension: CGFloat
        let width: CGFloat = view.frame.size.width
        let height: CGFloat = view.frame.size.height

        if ( height > width ) { // portrait
            dimension = (width - (2 * space)) / 3.0
        } else { // landscape
            dimension = (height - (2 * space)) / 3.0
        }

        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.minimumLineSpacing = space
        flowLayout?.itemSize = CGSize(width: dimension, height: dimension)
    }
}
