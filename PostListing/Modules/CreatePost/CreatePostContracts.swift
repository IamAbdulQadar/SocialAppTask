//
//  CreatePostModuleProtocols.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import UIKit
import Foundation

protocol CreatePostViewProtocol: AnyObject {
    func updateUserUI(with user: User)
    func enablePostButton(_ enabled: Bool)
    func adjustTextViewHeight(_ height: CGFloat)  // Add this line
    func adjustPostImageHeight(_ height: CGFloat)
    func setTextViewPlaceholder()
    func clearTextViewPlaceholder()
    func openPhotoGallery()
    func displaySelectedImage(_ image: UIImage)
    func updatePostImageHeight(_ height: CGFloat)
}

protocol CreatePostPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectUser(_ user: User)
    func getAvailableUsers() -> [User]  // Add this line
    func didChangeText(_ text: String)
    func didSelectImage(_ image: UIImage)
    func didTapPostButton(content: String, image: UIImage?)
    func didTapSelectPhoto()
    func textViewDidBeginEditing()
    func textViewDidEndEditing(text: String)
}

protocol CreatePostInteractorInputProtocol: AnyObject {
    func getAvailableUsers() -> [User]
    func createPost(user: User, content: String, image: UIImage?)
}

protocol CreatePostInteractorOutputProtocol: AnyObject {
    func postCreationSucceeded()
    func postCreationFailed(error: Error)
}

protocol CreatePostRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateBack(from view: CreatePostViewProtocol)
}
