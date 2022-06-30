//
//  FullScreenFotoViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 30.06.2022.
//

import UIKit

class FullScreenFotoViewController: UIViewController {
    
    @IBOutlet weak var fullScreenSwipingView: FotoHorizontalView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = [UIImage(named: "cat1")!, UIImage(named: "cat2")!, UIImage(named: "dog1")!, UIImage(named: "dog2")!]
        fullScreenSwipingView.setImages(images: images)
    }
}

