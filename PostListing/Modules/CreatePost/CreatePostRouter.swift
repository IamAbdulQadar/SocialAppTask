//
//  CreatePostRouter.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import UIKit
import Foundation

class CreatePostRouter: CreatePostRouterProtocol {

    static func createModule() -> UIViewController {
        let view = CreatePostView.instantiate() // This will now work with XIB
        let presenter = CreatePostPresenter()
        let interactor = CreatePostInteractor()
        let router = CreatePostRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.userProvider = UserProvider.shared
        interactor.postService = PostService.shared
        
        return view
    }
    
    func navigateBack(from view: CreatePostViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
