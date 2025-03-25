//
//  PostListRouter.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import Foundation
import UIKit

class PostListRouter: PostListRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = PostListView.instantiate() // This will now work with XIB
        let presenter = PostListPresenter()
        let interactor = PostListInteractor()
        let router = PostListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.postService = PostService.shared
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func navigateToCreatePost(from view: PostListViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let backButton = UIBarButtonItem()
        backButton.title = ""
        view.navigationItem.backBarButtonItem = backButton
        view.navigationController?.navigationBar.prefersLargeTitles = false
        let createPostVC = CreatePostRouter.createModule()
        view.navigationController?.pushViewController(createPostVC, animated: true)
    }
}
