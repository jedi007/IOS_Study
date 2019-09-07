//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/1.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
//        //因无法访问外网服务器。所以自己构建了diyPhoto
//        store.fetchInterestingPhotos {
//            (photosResult) -> Void in
//
//            switch photosResult {
//            case let .success(photos):
//                print("Successfully found \(photos.count)")
//
//                self.photoDataSource.photos = photos
//            case let .failure(error):
//                print("Error fetching recent photos: \(error)")
//                self.photoDataSource.photos.removeAll()
//            }
//            self.collectionView.reloadSections(IndexSet(integer: 0))
//        }
        
        print("==========Date.init(): \(Date.init())")
        let testUrl = NSURL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1567865978800&di=bf92f4157ed9cae12878ac2a83adbb48&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2F3f8dfe27be1533320233a1a15c307db91637f649.jpg")
        //NSURL(string: "https://c-ssl.duitang.com/uploads/item/201209/03/20120903183740_c5Tar.jpeg")
        
        
        var finalPhotos = [Photo]()
        for i in 1...15 {
            let diyPhoto = Photo(title: "test", photoID: "\(i)", remoteURL: testUrl! as URL, dateTaken: Date.init() )
            finalPhotos.append(diyPhoto)
        }
        photoDataSource.photos = finalPhotos
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate   = self
        
        
        
    }
    
    //MAERK: - UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImage(for: photo){ (result) -> Void in
            
            //下载照片会花一些时间，所有请求完成后index可能会变化，需要获取最新的indexPath
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of:photo),
                case let .Success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            //请求完成后只有当cell仍然可见时才刷新cell
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell
            {
                cell.update(with:image)
            }
            
            
        }
        
    }
}
