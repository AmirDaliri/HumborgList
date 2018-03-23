//
//  EventDetailViewController.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/23/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var rateControll: RatingControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var deadLineTimeLabel: UILabel!
    
    
    var imageArray: [EventsImagesUrls]?
    var eventName: String!
    var imageArrayString: [String] = []
    var titleArray = [String]()
    var cityImgUrl: String!
    var avatarImgUrl: String!
    var descriptionStr: String!
    var chefStr: String!
    var priceStr: String!
    var addressStr: String!
    var startTime: String!
    var deadLineTime: String!
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        self.setupView()
    }

    
    private func setupView() {
        for item in self.imageArray! {
            self.imageArrayString.append(Constants.ApiConstants.imageURLString+item.imageUrl!)
        }
        print(self.imageArrayString)
        self.collectionView.reloadData()
        self.chefName.text = self.chefStr!
        self.cityImage.af_setImage(withURL: URL(string: self.cityImgUrl)!)
        self.avatar.af_setImage(withURL: URL(string: self.avatarImgUrl)!)
        self.descriptionLabel.text! = self.descriptionStr!
        self.addressLabel.text! = self.addressStr
        self.startTimeLabel.text! = self.convertDate(myDate: self.startTime!)
        self.deadLineTimeLabel.text! = self.convertDate(myDate: self.deadLineTime!)
        self.priceLabel.layer.borderColor = UIColor.white.cgColor
        self.priceLabel.layer.borderWidth = 2.0
        self.priceLabel.layer.cornerRadius = self.priceLabel.layer.frame.height / 2
        self.priceLabel.layer.masksToBounds = true
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 8.0
        avatar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        cityImage.clipsToBounds = true
        cityImage.layer.cornerRadius = 8.0
        cityImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.rateControll.rating = 3
        self.priceLabel.text = self.priceStr
    }

    func convertDate(myDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_us")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:myDate)!
        dateFormatter.dateFormat = "yyyy/MM/dd        hh:mm"
        let dateString = dateFormatter.string(from:date)
        return dateString
    }

}

extension EventDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArrayString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventImagesCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as? EventImagesCollectionViewCell)!
        cell.layer.cornerRadius = 8.0
        cell.layer.masksToBounds = true
        let imageUrl = URL(string: self.imageArrayString[indexPath.row])
        cell.imageView.af_setImage(withURL: imageUrl!)
        cell.eventName.text = self.eventName!
        return cell
    }


}
