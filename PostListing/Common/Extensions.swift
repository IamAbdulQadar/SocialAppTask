//
//  Extensions.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
/// NOTE: This is generic Extension. For big project we can keep every Object extension in seperate file.

import UIKit

protocol XIBInstantiable: AnyObject {
    static var xibName: String { get }
    static var bundle: Bundle? { get }
}

extension XIBInstantiable where Self: UIViewController {
    static var bundle: Bundle? {
        return Bundle(for: Self.self)
    }
    
    static func instantiate() -> Self {
        return Self(nibName: xibName, bundle: bundle)
    }
}

extension UIView {
    static func instantiate() -> Self {
        let nibName = String(describing: self)
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}

extension UIImage {
    func circularImage() -> UIImage? {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = min(imageView.frame.size.width, imageView.frame.size.height) / 2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
    
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIImageView {
    func makeImgCircular() {
        self.layer.cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2
        self.clipsToBounds = true
    }
}

extension UITableView {
    func setEmptyView(imageName: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let imageView = UIImageView()
        let messageLabel = UILabel()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(messageLabel)
        
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        imageView.image = UIImage(named: imageName)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
