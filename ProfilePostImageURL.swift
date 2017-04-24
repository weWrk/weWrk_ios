//
//  ProfilePostImageURL.swift
//  weWrk_1
//
//  Created by Pan Guan on 4/20/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import Foundation
import Firebase

class siteImagePost {
    private var _imageUrl: String!
    private var _sitePostKey: String!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    
    
    var imageUrl: String {
        return _imageUrl
    }

    var sitePostKey: String {
        return _sitePostKey
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(imageUrl: String, sitePostKey: String) {
        self._imageUrl = imageUrl
        self._sitePostKey = sitePostKey
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let sitePostKey = postData["sitePostKey"] as? String {
            self._sitePostKey = sitePostKey
        }
        
        _postRef = ProfileDataService.ds.REF_SITE_IMAGE_POSTS.child(_postKey)
        
    }
    
}
