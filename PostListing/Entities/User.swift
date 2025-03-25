//
//  Untitled.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import UIKit

struct User {
    let id: String
    let name: String
    let username: String
    let profileImage: UIImage
    
    static var current: User? {
        didSet {
            NotificationCenter.default.post(name: .userDidChange, object: nil)
        }
    }
}

extension Notification.Name {
    static let userDidChange = Notification.Name("UserDidChangeNotification")
}

// User Provider Protocol
protocol UserProviding {
    var users: [User] { get }
    func getUser(by id: String) -> User?
}

// Concrete implementation
class UserProvider: UserProviding {
    static let shared = UserProvider()
    
    private init() {}
    
    let users: [User] = [
        User(id: "1", name: "User One", username: "userone", profileImage: UIImage(named: "profile1")!),
        User(id: "2", name: "User Two", username: "usertwo", profileImage: UIImage(named: "profile2")!),
        User(id: "3", name: "User Three", username: "userthree", profileImage: UIImage(named: "profile3")!)
    ]
    
    func getUser(by id: String) -> User? {
        return users.first { $0.id == id }
    }
}
