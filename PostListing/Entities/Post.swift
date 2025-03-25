//
//  Post.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import UIKit

struct Post {
    let user: User
    let content: String
    let image: UIImage?
    let createdAt: Date
}

// Post Service Protocol
protocol PostServicing {
    var posts: [Post] { get }
    func addPost(_ post: Post)
    func fetchPosts() -> [Post]
}

// Concrete implementation
class PostService: PostServicing {
    static let shared = PostService()
    
    private init() {}
    
    private(set) var posts: [Post] = []
    
    func addPost(_ post: Post) {
        posts.insert(post, at: 0) // Add to beginning for chronological order
    }
    
    func fetchPosts() -> [Post] {
        return posts
    }
}
