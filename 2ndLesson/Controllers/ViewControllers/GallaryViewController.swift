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
    var fotoAlbum = [MyFoto] ()//инициализировали фотольбом  
    
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



extension GallaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    { return self.fotoAlbum.count }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotoCollectionViewReuseIdentifier, for: indexPath) as? FotoCollectionViewCell else {return UICollectionViewCell()}
        
//        cell.configure(image: UIImage(named: self.fotoAlbum[indexPath.item])) //рисует не просто Петра какого-то, а чтото из фотоальбома; то, откуда он возьмет имя файла, в котором будут лежать фотос
        let image = UIImage(named: self.fotoAlbum[indexPath.item].url)
        cell.configure(image: image, isLiked: true, likeCounter: 5, onlikeClosure: {isLikePressed, currentCounter in // 8.2.2 (нажатый лайк и счет надо передать в GallaryViewController closure5) 1ч40 а уже в GallaryViewController в клоужер прилетают 2 параметра
            print("counter \(currentCounter)")
            print(isLikePressed ? "true" : "false")
        })
        return cell
    }
}


extension GallaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

// если нужно, чтобы в строке было всегда фиксированное число ячеек и большее переходило на новую строку, то:
extension GallaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 32
        let cellWidth = width/3 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
