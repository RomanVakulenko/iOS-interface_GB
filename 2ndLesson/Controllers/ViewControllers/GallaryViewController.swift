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

    var fotoAlbum = [MyFoto] ()//инициализировали фотольбом, 8L1h22m вместо String вставили MyFoto
    var fotoAlbumIndex = 0 //8L1h53m можем передавать не фотоальбом, а индекс
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: fotoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: fotoCollectionViewReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        fotoAlbum = Storage.shared.friends[fotoAlbumIndex].fotoAlbum //8L1h55m
    }
    
    override func viewWillAppear(_ animated: Bool) { //перед показом, чтобы обновилась инфа
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}
