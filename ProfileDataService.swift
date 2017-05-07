//
//  ProfileDataService.swift
//  weWrk_1
//
//  Created by Pan Guan on 4/18/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import Foundation
import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class ProfileDataService {
    
    static let ds = ProfileDataService()
    
    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_PROFILE_POSTS = DB_BASE.child("userProfilePost")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_SITE_IMAGE_POSTS = DB_BASE.child("userSiteImagePost")
    
    // Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_PROFILE_POSTS: FIRDatabaseReference {
        return _REF_PROFILE_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        //let uid = KeychainWrapper.stringForKey(KEY_UID)
        //let uid = KeychainWrapper.set(KEY_UID)
        let uid = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_SITE_IMAGE_POSTS: FIRDatabaseReference {
        return _REF_SITE_IMAGE_POSTS
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
/*    func createFirbaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
 */
    
}
