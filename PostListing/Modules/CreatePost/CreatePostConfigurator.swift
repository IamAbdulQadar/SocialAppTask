//
//  CreatePostConfigurator.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//
import UIKit
import Foundation

class CreatePostConfigurator {
    static func configure() -> UIViewController {
        return CreatePostRouter.createModule()
    }
}
