//
//  MainPostingModuleProtocols.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import UIKit

protocol PostListViewProtocol: AnyObject {
    func showPosts(_ posts: [Post])
    func showEmptyState()
    func hideEmptyState()
    func reloadData()
}

protocol PostListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didTapCreatePost()
    func numberOfPosts() -> Int
    func post(at index: Int) -> Post
}

protocol PostListInteractorInputProtocol: AnyObject {
    func fetchPosts()
    func numberOfPosts() -> Int
    func post(at index: Int) -> Post
}

protocol PostListInteractorOutputProtocol: AnyObject {
    func postsFetched(_ posts: [Post])
    func postsFetchFailed(with error: Error)
}

protocol PostListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToCreatePost(from view: PostListViewProtocol)
}
