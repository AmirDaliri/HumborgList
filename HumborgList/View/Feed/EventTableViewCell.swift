//
//  EventTableViewCell.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventFirstImage: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var avatarNameLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var rateView: RatingControl!
    @IBOutlet weak var descriptionLable: UILabel!
    
    
    override func layoutSubviews() {
        if #available(iOS 11.0, *) {
            eventFirstImage.clipsToBounds = true
            eventFirstImage.layer.cornerRadius = 8.0
            eventFirstImage.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            
            avatar.clipsToBounds = true
            avatar.layer.cornerRadius = 8.0
            avatar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            
            dateView.clipsToBounds = true
            dateView.layer.borderColor = UIColor.borderGray.cgColor
            dateView.layer.borderWidth = 1.0
            dateView.layer.cornerRadius = 8.0
            dateView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        }
    }
}
