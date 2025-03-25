//
//  PostListInteractor.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import UIKit
import Foundation

class PostListInteractor: PostListInteractorInputProtocol {
    
    weak var presenter: PostListInteractorOutputProtocol?
    var postService: PostServicing?
    
    func fetchPosts() {
        let posts = postService?.fetchPosts() ?? []
        presenter?.postsFetched(posts)
    }
    
    func numberOfPosts() -> Int {
        return postService?.posts.count ?? 0
    }
    
    func post(at index: Int) -> Post {
        guard let posts = postService?.posts, index < posts.count else {
            return Post(user: User(id: "", name: "", username: "", profileImage: UIImage()), content: "", image: nil, createdAt: Date())
        }
        return posts[index]
    }
}
