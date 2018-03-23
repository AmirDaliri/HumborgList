//
//  Events.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//


import Foundation
import ObjectMapper


struct Events: Mappable {
    
    var error: String?
    var count: Int?
    var items: [EventsItems]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        count <- map["data.count"]
        items <- map["data.items"]
    }
}


struct EventsItems: Mappable {
    
    var id:                 String?
    var title:              String?
    var description:        String?
    var address:            String?
    var location:           Double?
    var chefExplanation:    String?
    var status:             String?
    var rejectionText:      String?
    var reviewsAverageRate: String?
    var reviewsCount:       Int?
    var isDeleted:          Bool?
    var chef:               EventsChef?
    var city:               EventsCity?
    var images:             [EventsImages]?
    var imagesUrl:          [EventsImagesUrls]?

    var schedules:          [EventsSchedules]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id                   <- map["id"]
        title                <- map["title"]
        description          <- map["description"]
        address              <- map["address"]
        location             <- map["location"]
        chefExplanation      <- map["chefExplanation"]
        status               <- map["status"]
        rejectionText        <- map["rejectionText"]
        reviewsAverageRate   <- map["reviewsAverageRate"]
        reviewsCount         <- map["reviewsCount"]
        isDeleted            <- map["isDeleted"]
        chef                 <- map["chef"]
        city                 <- map["city"]
        images               <- map["images"]
        imagesUrl            <- map["images"]
        schedules            <- map["schedules"]
    }
}


struct EventsChef: Mappable {
    
    var id:             String?
    var firstName:      String?
    var lastName:       String?
    var avatarUrl:      String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        firstName   <- map["firstName"]
        lastName    <- map["lastName"]
        avatarUrl   <- map["avatarUrl"]
    }
}

struct EventsCity: Mappable {
    
    var id:             String?
    var name:           String?
    var imageUrl:       String?
    var location:       Double?
    var countryName:    String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        imageUrl        <- map["imageUrl"]
        location        <- map["location"]
        countryName     <- map["countryName"]
    }
}

struct EventsImages: Mappable {
    
    var id:             Int?
    var eventId:        String?
    var title:          String?
    var imageUrl:       String?
    var createdAt:      String?
    var updatedAt:      String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        eventId     <- map["eventId"]
        title       <- map["title"]
        imageUrl    <- map["imageUrl"]
        createdAt   <- map["createdAt"]
        updatedAt   <- map["updatedAt"]
    }
}

struct EventsImagesUrls: Mappable {
    
    var imageUrl:       String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        imageUrl    <- map["imageUrl"]
    }
}


struct EventsSchedules: Mappable {
    
    var id:             Int?
    var eventStart:     String?
    var eventDeadline:  String?
    var servingsSold:   Int?
    var servings:       Int?
    var price:          String?
    var currency:       EventsCurrency?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        eventStart      <- map["eventStart"]
        eventDeadline   <- map["eventDeadline"]
        servingsSold    <- map["servingsSold"]
        servings        <- map["servings"]
        price           <- map["price"]
        currency        <- map["currency"]
    }
}

struct EventsCurrency: Mappable {
    
    var id:     String?
    var name:   String?
    var code:   String?
    var symbol: String?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        code    <- map["code"]
        symbol  <- map["symbol"]
    }
}

