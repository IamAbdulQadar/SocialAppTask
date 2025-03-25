//
//  CreatePostPresenter.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import UIKit
import Foundation

class CreatePostPresenter: CreatePostPresenterProtocol {
    
    weak var view: CreatePostViewProtocol?
    var interactor: CreatePostInteractorInputProtocol?
    var router: CreatePostRouterProtocol?
    
    private var selectedUser: User?
    private var hasText: Bool = false
    private var hasImage: Bool = false
    private var txtViewPlaceHolder = "What's in your mind?"
    
    func viewDidLoad() {
        if let firstUser = interactor?.getAvailableUsers().first {
            selectedUser = firstUser
            view?.updateUserUI(with: firstUser)
        }
    }
    
    func didSelectUser(_ user: User) {
        selectedUser = user
        view?.updateUserUI(with: user)
    }
    
    func getAvailableUsers() -> [User] {
        return interactor?.getAvailableUsers() ?? []
    }
    
    func didChangeText(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        hasText = !trimmedText.isEmpty && text != self.txtViewPlaceHolder
        validatePostButton()
    }
    
    // Add this new method:
    func adjustTextViewHeight(_ height: CGFloat) {
        view?.adjustTextViewHeight(height)
    }
    
    func didSelectImage(_ image: UIImage) {
        hasImage = true
        view?.displaySelectedImage(image)
        view?.updatePostImageHeight(150) // Set your desired height here
        validatePostButton()
    }
    
    func didTapPostButton(content: String, image: UIImage?) {
        guard let user = selectedUser else { return }
        interactor?.createPost(user: user, content: content, image: image)
    }
    
    func didTapSelectPhoto() {
        view?.openPhotoGallery()
    }
    
    func textViewDidBeginEditing() {
        view?.clearTextViewPlaceholder()
    }
    
    func textViewDidEndEditing(text: String) {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            view?.setTextViewPlaceholder()
        }
        validatePostButton()
    }
    
    private func validatePostButton() {
        view?.enablePostButton(hasText || hasImage)
    }
}

extension CreatePostPresenter: CreatePostInteractorOutputProtocol {
    func postCreationSucceeded() {
        router?.navigateBack(from: view!)
    }
    
    func postCreationFailed(error: Error) {
        // Handle error
    }
}
