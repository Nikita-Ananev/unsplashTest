//
//  DescriptionVC.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 11.10.2022.
//

import UIKit

class DescriptionVC: UIViewController {
    
    //MARK: Views
    let imageView = UIImageView()
    
    let nameLabel = PaddingLabel()
    let dateLabel = PaddingLabel()
    let location = PaddingLabel()
    let downloads = PaddingLabel()
    
    
    //MARK: Variables
    var photo: Photo! {
        didSet {
            guard let stringUrl = photo?.urls.regular else {
                return
            }
            let dateString = formatDate(date: photo.created_at)
            
            var locationText = ""
            var downloadsText = ""
            
            if let text = photo.location?.city {
                locationText.append("\(text)")
            }
            if let text = photo.location?.country {
                locationText.append(" \(text)")
            }
            if let text = photo?.downloads{
                downloadsText = String(text)
            }
            if locationText == "" {
                locationText = "Не указан"
            }
            
            
            
            imageView.imageFromServerURL(stringUrl, placeHolder: imageView.image)
            nameLabel.text = photo.user?.name
            dateLabel.text = dateString
            downloads.text = "Downloads: \(downloadsText)"
            location.text = locationText
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkBackground")
        setViews()
        setConstraints()

    }
    
    func setViews() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        nameLabel.layer.backgroundColor = UIColor(red: 44/255, green: 63/255, blue: 86/255, alpha: 0.8).cgColor
        nameLabel.textColor = .white
        nameLabel.padding(3, 3, 7, 7)
        nameLabel.layer.cornerRadius = 5.0
        
        dateLabel.layer.backgroundColor = UIColor(red: 44/255, green: 63/255, blue: 86/255, alpha: 0.8).cgColor
        dateLabel.textColor = .white
        dateLabel.padding(3, 3, 7, 7)
        dateLabel.layer.cornerRadius = 5.0
        
        downloads.layer.backgroundColor = UIColor(red: 44/255, green: 63/255, blue: 86/255, alpha: 0.8).cgColor
        downloads.textColor = .white
        downloads.padding(3, 3, 7, 7)
        downloads.layer.cornerRadius = 5.0
        
        location.layer.backgroundColor = UIColor(red: 44/255, green: 63/255, blue: 86/255, alpha: 0.8).cgColor
        location.textColor = .white
        location.padding(3, 3, 7, 7)
        location.layer.cornerRadius = 5.0
        
        
    }
    func setConstraints() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
        
        view.addSubview(downloads)
        downloads.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloads.topAnchor.constraint(greaterThanOrEqualTo: dateLabel.bottomAnchor, constant: 10),
            downloads.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
        
        view.addSubview(location)
        location.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(greaterThanOrEqualTo: downloads.bottomAnchor, constant: 10),
            location.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        //    dateFormatter.locale = Locale(identifier: "en_US") //uncomment if you don't want to get the system default format.
        
        let dateObj: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatter.string(from: dateObj!)
    }
}
