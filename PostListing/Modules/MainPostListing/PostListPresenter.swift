//
//  PostListPresenter.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import Foundation
import UIKit

class PostListPresenter: PostListPresenterProtocol {
    
    weak var view: PostListViewProtocol?
    var interactor: PostListInteractorInputProtocol?
    var router: PostListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchPosts()
    }
    
    func viewWillAppear() {
        interactor?.fetchPosts()
    }
    
    func didTapCreatePost() {
        guard let view = view else { return }
        router?.navigateToCreatePost(from: view)
    }
    
    func numberOfPosts() -> Int {
        return interactor?.numberOfPosts() ?? 0
    }
    
    func post(at index: Int) -> Post {
        return interactor?.post(at: index) ?? Post(user: User(id: "", name: "", username: "", profileImage: UIImage()), content: "", image: nil, createdAt: Date())
    }
}

extension PostListPresenter: PostListInteractorOutputProtocol {
    func postsFetched(_ posts: [Post]) {
        if posts.isEmpty {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
            view?.showPosts(posts)
        }
    }
    
    func postsFetchFailed(with error: Error) {
        // Handle error
        view?.showEmptyState()
    }
}
