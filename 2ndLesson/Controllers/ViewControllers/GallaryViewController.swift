//
//  GallaryViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

class GallaryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let fotoCollectionViewReuseIdentifier = "fotoCollectionViewReuseIdentifier"
    var fotoAlbum = [String] ()//инициализировали фотольбом
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: fotoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: fotoCollectionViewReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) { //перед показом, чтобы обновилась инфа
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}
