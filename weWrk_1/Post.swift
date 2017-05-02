//
//  Post.swift
//  weWrk_1
//
//  Created by Jose Guerrero on 3/24/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit
import Firebase

class Post: NSObject {
    // Class that will hold any type of post
    
    var title: String?
    var image: UIImage?
    var date: Date?
    var employer: String?
    var location: String?
    var contact_info: String?
    var postDescription: String?
    
    init(with title:String, image:UIImage, description: String? = nil, date:Date? = nil, employer:String? = nil, location:String? = nil, contact_info:String? = nil){
        self.title = title
        self.image = image
        // Sample template - not final //
        self.date = date ?? Date.distantPast
        self.employer = employer ?? "who knows?"
        self.location = location ?? "somewhere in the middle"
        self.contact_info = contact_info ?? "123-456-7890"
        self.postDescription = description ?? "Work for us as a valued employee."
        
    }
    
    
    // TODO HERE GOES A FUNCTION THAT INITIALIZES THIS POST FROM AN OBJECT
    // FROM FIREBASE
}
