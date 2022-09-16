//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 16.03.2022.
//

import UIKit
//Задание 5: импортировал фреймворк
import iOSIntPackage

class PhotosViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {

    var carsPhoto: [UIImage] = []
    //Задание 5: создал экземпляр класса ImagePublisherFacade
    var imagePublisherFacade = ImagePublisherFacade()

    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        
    

        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collection.backgroundColor = .white
        return collection
    }()
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carsPhoto.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell
        else {
        return UICollectionViewCell()
        }
        
        cell.imageImageView.image = carsPhoto[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let x = (collectionView.bounds.width - 8*4)/3
        return CGSize(width: x, height: x)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Photo Gallery"
//        carsPhoto = CarsData.carsPhotos
        setupCollectionView()
        //Задание 5: подписался на изменение и запустил добавления картинок
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: CarsData.carsPhotos)
    }

    //Задание 5: отписался от изменений
    override func viewDidDisappear(_ animated: Bool) {
        imagePublisherFacade.removeSubscription(for: self)
    }

}

//Задание 5: через extension подписался на ImageLibrarySubscriber и реализовал функцию: после добавление новой картинки в паблишер - обновляй свой массив, затем перегружаю колекшенВью для появление картинок
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        carsPhoto = images
        collectionView.reloadData()
    }

    
}
