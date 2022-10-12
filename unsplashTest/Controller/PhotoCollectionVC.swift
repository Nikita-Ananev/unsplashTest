//
//  ViewController.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 09.10.2022.
//

import UIKit

class PhotoCollectionVC: UIViewController {
    
    //MARK: Views
    private var header: UIView!
    private var searchBackground: UIView!
    private var searchTextField: UITextField!
    private var collectionView: UICollectionView!
    private var imageView: UIImageView!
    //MARK: Variables
    var photos = [Photo]()
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchTextField()
        setCollectionView()
        getRandomPhotos()
    }
    @objc func changedTextFieldValue(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.executeAction), userInfo: nil, repeats: false)
    }
    @objc func executeAction(){
        if searchTextField.text?.count == 0 {
            return
        }
        UnsplashApiService.shared.getSearchingPhotos(text: searchTextField.text ?? "") { result in
            if let result = result as? Result {
                DispatchQueue.main.async {
                    self.photos = result.results
                    self.collectionView.reloadData()
                }
            }
        }
    }
    func getRandomPhotos() {
        UnsplashApiService.shared.getRandomPhotos { photos in
            if let photos = photos as? [Photo] {
                DispatchQueue.main.async {
                    self.photos = photos
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    func calculateImageHeight (sourceImage : Photo, scaledToWidth: CGFloat) -> CGFloat {
        let oldWidth = CGFloat( sourceImage.width)
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = CGFloat(sourceImage.height) * scaleFactor
        return newHeight
    }
    private func setSearchTextField() {
        header = UIView()
        header.backgroundColor = .red
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = UIColor(named:"mainBackgroundColor")
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 0),
            header.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: 0),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        searchBackground = UIView()
        searchBackground.backgroundColor = UIColor(named: "collectionViewBackground")
        searchBackground.layer.cornerRadius = 5
        header.addSubview(searchBackground)
        searchBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBackground.topAnchor.constraint(equalTo: header.topAnchor, constant: 15),
            searchBackground.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -15),
            searchBackground.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 10),
            searchBackground.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -10)
        ])
        
        imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = UIColor(named: "textColor")
        searchBackground.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: searchBackground.leftAnchor, constant: 10)
        ])
        
        searchTextField = UITextField()
        searchBackground.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.borderStyle = .none
        searchTextField.placeholder = "Search..."
        searchTextField.textColor = UIColor(named: "textColor")
        NSLayoutConstraint.activate([
            searchTextField.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            searchTextField.rightAnchor.constraint(lessThanOrEqualTo: searchBackground.rightAnchor, constant: -10),
            searchTextField.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor),
            searchTextField.widthAnchor.constraint(equalTo: searchBackground.widthAnchor, multiplier: 0.8)
        ])
        searchTextField.addTarget(self, action: #selector(changedTextFieldValue), for: .editingChanged)
    }
    private func setCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UnsplashLayout.init())
        collectionView.backgroundColor = UIColor(named: "darkBackground")
        let layout = UnsplashLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}





extension PhotoCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UnsplashLayoutDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let imgHeight = calculateImageHeight(sourceImage: photos[indexPath.row] , scaledToWidth: cellWidth)
        
        return (imgHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
        cell.photo = photos[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DescriptionVC()
        vc.photo = photos[indexPath.row]
        self.present(vc, animated: true)
    }
}
