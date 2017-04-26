//
//  getPostImageByPostKey.swift
//  weWrk_1
//
//  Created by Pan Guan on 4/21/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import Foundation
import UIKit
import Firebase

func getPostImageByPostKey(IDKey: String) -> [siteImagePost]{
    print("IDkey1: \(IDKey)")
    var countNum = 0
    var imagePosts:[siteImagePost] = []
    
    ProfileDataService.ds.REF_SITE_IMAGE_POSTS.observe(.value, with: { (snapshot) in
        
        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            for snap in snapshot {
                print("SNAP: \(snap)")
                
                if let postDict = snap.value as? Dictionary<String, AnyObject> {
                    let key = snap.key
                    
                    let sitePostKey = snap.childSnapshot(forPath:"sitePostKey").value as? String
                    print("sitePostKey: \(sitePostKey)")
                    
                    let imageURL = snap.childSnapshot(forPath:"imageURL").value as? String
                    
                    if sitePostKey == IDKey {
                        countNum = countNum + 1
                        print("countNum: \(countNum)")
                        let imagePost = siteImagePost(postKey: key, postData: postDict)
                        print("imagePost: \(imagePost)")
                        imagePosts.append(imagePost)
                    }
                
                }
            }
        
        }
        print("imagePosts5: \(imagePosts.count)")
 //       return imagePosts
        
    })
    print("imagePosts5: \(imagePosts.count)")
    return imagePosts
}
