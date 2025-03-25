//
//  PostListConfigurator.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import Foundation
import UIKit

class PostListConfigurator {
    static func configure() -> UIViewController {
        return PostListRouter.createModule()
    }
}
