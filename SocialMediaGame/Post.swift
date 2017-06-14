//
//  Post.swift
//  SocialMediaGame
//
//  Created by Nexusbond on 14/06/2017.
//  Copyright © 2017 Nexusbond. All rights reserved.
//

import Foundation
import Firebase


class Post {

    var authorImageUrl: String
    var authorDisplayName: String
    var authorEmailAddress: String
    var postImageUrl: String
    var postTitle: String
    var postTimeCreated: Double
    var postDescription: String
    
    init(post: DataSnapshot) {
        let postDictionary = post.value as! [String: Any]
        self.postTitle = postDictionary["post_title"] as! String
        self.postTimeCreated = postDictionary["time_created"] as! Double
        self.postDescription = postDictionary["post_description"] as! String
        self.postImageUrl = postDictionary["post_photo_url"] as! String
        let authorInfo = postDictionary["XaVTmBZxPqSz47zsgn19EFTskOb2"] as! String
        let authorArr = authorInfo.components(separatedBy: ",")
        self.authorDisplayName = authorArr[0]
        self.authorEmailAddress = authorArr[1]
        self.authorImageUrl = authorArr[2]
        
    }
    
}
