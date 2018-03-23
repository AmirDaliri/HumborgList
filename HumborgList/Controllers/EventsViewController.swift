//
//  EventsViewController.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndiactor: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    let showEventDetailIdentifire = "show detail"
    var eventItems: [EventsItems]?
    var imageItems: [String]?
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        self.getData()
        self.tableView.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.showEventDetailIdentifire {
            let vc: EventDetailViewController = segue.destination as! EventDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let felan = self.eventItems![(indexPath?.row)!].imagesUrl
            vc.eventName = self.eventItems![(indexPath?.row)!].images![0].title!
            vc.descriptionStr = self.eventItems![(indexPath?.row)!].description!
            vc.chefStr = self.eventItems![(indexPath?.row)!].chef!.firstName! + "\n" + self.eventItems![(indexPath?.row)!].chef!.lastName!
            vc.avatarImgUrl = self.eventItems![(indexPath?.row)!].chef!.avatarUrl!
            vc.cityImgUrl = self.eventItems![(indexPath?.row)!].city!.imageUrl!
            vc.priceStr = self.eventItems![(indexPath?.row)!].schedules![0].price! + self.eventItems![(indexPath?.row)!].schedules![0].currency!.symbol!
            vc.addressStr = self.eventItems![(indexPath?.row)!].address!
            vc.startTime = self.eventItems![(indexPath?.row)!].schedules![0].eventStart
            vc.deadLineTime = self.eventItems![(indexPath?.row)!].schedules![0].eventDeadline
            vc.imageArray = felan
        }
    }

    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell
        let pathArray = self.eventItems![indexPath.row].images![0].imageUrl
        cell.selectionStyle = .none
        if let imageUrl = URL(string: Constants.ApiConstants.imageURLString+pathArray!) {
            cell.eventFirstImage.af_setImage(withURL: imageUrl)
        } else {
            let imageurl = URL(string: self.eventItems![indexPath.row].city!.imageUrl!)
            cell.eventFirstImage.af_setImage(withURL: imageurl!)
        }
        let avatarurl = URL(string: self.eventItems![indexPath.row].chef!.avatarUrl!)
        cell.avatar.af_setImage(withURL: avatarurl!)
        cell.avatarNameLabel.text! = self.eventItems![indexPath.row].chef!.firstName! + "\n" + self.eventItems![indexPath.row].chef!.lastName!
        if let dateString = self.eventItems![indexPath.row].schedules![0].eventStart {
            cell.dateLabel.text! = self.convertDate(myDate: dateString)
        }
        cell.cityNameLable.text! = self.eventItems![indexPath.row].city!.name!
//        cell.rateView.rating = self.eventItems![indexPath.row].reviewsCount!
        cell.rateView.rating = 3
        cell.eventNameLabel.text! = self.eventItems![indexPath.row].title!
        cell.descriptionLable.text! = self.eventItems![indexPath.row].description!
        //optional method
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: self.showEventDetailIdentifire, sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    func convertDate(myDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_us")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:myDate)!
        dateFormatter.dateFormat = "yyyy/MM/dd \nhh:mm"
        let dateString = dateFormatter.string(from:date)
        return dateString
    }

    
    // MARK: - Api Reauest
    
    func getData() {
        if !Reachability.connectedToNetwork() {
            Helpers.alertWithTitle(self, title: nil, message: Strings.connectionError)
            return
        }
        Alamofire.request(ApiRouter.Router.getEvents(pageSize: "20", pageNumber: "1", cityId: "88da18ae-dccd-4a8a-83d4-6c6afd5bc346")).responseObject { (response: DataResponse<Events>) in
            self.activityIndiactor.startAnimating()
            guard let res = response.result.value else { return }
            if Constants.UserDefaults.debugMode { debugPrint(response) }
            if response.result.isSuccess {
                self.activityIndiactor.stopAnimating()
                self.eventItems = res.items
                self.tableView.reloadData()
            }else {
                self.activityIndiactor.stopAnimating()
                if Constants.UserDefaults.debugMode { debugPrint(response) }
                Helpers.alertWithTitle(self, title: nil, message: Strings.unknown)
            }
        }
        
    }
}



