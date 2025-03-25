//
//  CreatePostInteractor.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import Foundation
import UIKit

class CreatePostInteractor: CreatePostInteractorInputProtocol {
    
    weak var presenter: CreatePostInteractorOutputProtocol?
    var userProvider: UserProviding?
    var postService: PostServicing?
    
    func getAvailableUsers() -> [User] {
        return userProvider?.users ?? []
    }
    
    func createPost(user: User, content: String, image: UIImage?) {
        let newPost = Post(user: user, content: content, image: image, createdAt: Date())
        postService?.addPost(newPost)
        presenter?.postCreationSucceeded()
    }
}
