//
//  PhotoCollectionCell.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 10.10.2022.
//
import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    //MARK: UI-elements:
    var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
        
    }()
    
    //MARK: Variables
    var photo: Photo? {
        didSet {
            guard let stringUrl = photo?.urls.thumb else {
                return
            }
            img.imageFromServerURL(stringUrl, placeHolder: img.image)
        }
    }
    
    //MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.setupConstraints()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photo = nil
        img.removeFromSuperview()
    }
    
    //MARK: Set UI
    private func setupViews() {
        layer.backgroundColor = UIColor(named: "darkBackground")?.cgColor
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "darkBackground")?.cgColor
        layer.cornerRadius = 2
        layer.masksToBounds = true
        
        contentView.addSubview(img)
        
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: contentView.topAnchor),
            img.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            img.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    deinit {
        photo = nil
    }
}
