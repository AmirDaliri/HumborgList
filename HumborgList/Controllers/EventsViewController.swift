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
    
    var eventItems: [EventsItems]?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        self.getData()
        self.tableView.tableFooterView = UIView()
    }
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
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



