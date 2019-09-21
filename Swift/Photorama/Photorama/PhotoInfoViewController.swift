//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/7.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo!{
        didSet{
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo, completion:  { (result) -> Void in
            switch result {
            case let .Success(image):
                self.imageView.image = image
            case let .Failure(error):
                print("Error fecthing image for photo: \(error)")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowTags"?:
            print("go segue")
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            tagController.store = store
            tagController.photo = photo
        default:
            preconditionFailure(" Unexpected segue identifier.")
        }
    }
}
