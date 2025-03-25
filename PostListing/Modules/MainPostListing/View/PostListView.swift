//
//  PostListView.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import UIKit

import UIKit

class PostListView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTableView: UITableView!
    
    // MARK: - Properties
    var presenter: PostListPresenterProtocol!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureTableView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter.viewWillAppear()
    }
    
    // MARK: - UI Setup Methods
    private func configureTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.contentInsetAdjustmentBehavior = .never
        postTableView.contentInset = .zero
        postTableView.register(UINib(nibName: "PostCellTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCellTableViewCell")
        postTableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        self.title = "All Posting"
        let createPostButton = UIBarButtonItem(title: "Create Post", style: .plain, target: self, action: #selector(createPostButtonTapped))
        navigationItem.rightBarButtonItem = createPostButton
    }
    
    // MARK: - Actions
    @objc private func createPostButtonTapped() {
        presenter.didTapCreatePost()
    }
}

// MARK: - PostListViewProtocol
extension PostListView: PostListViewProtocol {
    func showPosts(_ posts: [Post]) {
        postTableView.reloadData()
    }
    
    func showEmptyState() {
        postTableView.setEmptyView(imageName: "emptyViewIcon", message: "No posts yet! Tap the top-right button to add your first post!")
    }
    
    func hideEmptyState() {
        postTableView.restore()
    }
    
    func reloadData() {
        postTableView.reloadData()
    }
}

// MARK: - UITableView Delegate & DataSource
extension PostListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell", for: indexPath) as? PostCellTableViewCell else {
            return UITableViewCell()
        }
        let post = presenter.post(at: indexPath.row)
        cell.configureCell(post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PostListView: XIBInstantiable {
    static var xibName: String {
        return "PostListView" // Name of your XIB file
    }
}
