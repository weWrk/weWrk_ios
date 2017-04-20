//
//  profilePost.swift
//  weWrk_1
//
//  Created by Pan Guan on 4/18/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import Foundation
import Firebase

class profilePost {
    private var _description: String!
    private var _imageUrl: String!
    private var _like: Int!
    private var _site: String!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    
    var description: String {
        return _description
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var site: String {
        return _site
    }
    
    var likes: Int {
        return _like
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(description: String, imageUrl: String, like: Int) {
        self._description = description
        self._imageUrl = imageUrl
        self._like = like
        self._site = site
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let description = postData["Description"] as? String {
            self._description = description
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let site = postData["site"] as? String {
            self._site = site
        }
        
        if let like = postData["like"] as? Int {
            self._like = like
        }
        
        
        _postRef = ProfileDataService.ds.REF_PROFILE_POSTS.child(_postKey)
        
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _like = _like + 1
        } else {
            _like = _like - 1
        }
        _postRef.child("like").setValue(_like)
        
    }
    
}
