//
//  CreatePostView.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import UIKit

class CreatePostView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var txtViewHeight: NSLayoutConstraint!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postImgHeight: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!

    // MARK: - Properties
    var presenter: CreatePostPresenterProtocol!
    private var menuButton: UIButton!
    private let txtViewPlaceHolder = "What's in your mind?"
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup View
    private func setupView() {
        configureTextView()
        configurePostButton()
        configureNavigationProfileMenu()
    }
    
    private func configureTextView() {
        contentText.textContainer.lineBreakMode = .byWordWrapping
        contentText.text = txtViewPlaceHolder
        contentText.textColor = UIColor.systemGray2
    }
    
    private func configurePostButton() {
        postButton.isEnabled = false
        postButton.alpha = 0.5
    }
    
    private func configureNavigationProfileMenu() {
        menuButton = createMenuButton()
        
        let iconImageView = UIImageView(image: UIImage(named: "down-arrow"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        let stackView = UIStackView(arrangedSubviews: [menuButton, iconImageView])
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.layer.borderColor = UIColor.systemBlue.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stackView)
        self.title = "Create Post"
        updateMenu()
    }
    
    private func createMenuButton() -> UIButton {
        let button = UIButton(type: .system)
        button.imageView?.layer.cornerRadius = 17
        button.imageView?.layer.masksToBounds = true
        button.semanticContentAttribute = .forceRightToLeft
        button.showsMenuAsPrimaryAction = true
        return button
    }
    
    private func updateMenu() {
        let users = presenter.getAvailableUsers()
        menuButton.menu = UIMenu(
            title: "Select User",
            children: users.map { user in
                UIAction(
                    title: user.name,
                    image: user.profileImage.circularImage()?.resized(to: CGSize(width: 35, height: 35)),
                    handler: { _ in
                        self.presenter.didSelectUser(user)
                    }
                )
            }
        )
    }
    
    // MARK: - Actions
    @IBAction func didTapPostButton(_ sender: Any) {
        let content = contentText.text == txtViewPlaceHolder ? "" : contentText.text
        presenter.didTapPostButton(content: content ?? "", image: postImg.image)
    }
    
    @IBAction func didTapSelectPhoto(_ sender: Any) {
        presenter.didTapSelectPhoto()
    }
}

// MARK: - CreatePostViewProtocol
extension CreatePostView: CreatePostViewProtocol {
    func updateUserUI(with user: User) {
        let newImage = user.profileImage.withRenderingMode(.alwaysOriginal)
        menuButton.setImage(newImage, for: .normal)
        profileImgView.image = newImage.circularImage()
        nameLabel.text = user.name
        userNameLabel.text = "@\(user.username)"
        updateMenu()
    }
    
    func enablePostButton(_ enabled: Bool) {
        postButton.isEnabled = enabled
        postButton.alpha = enabled ? 1.0 : 0.5
    }
    
    func adjustTextViewHeight(_ height: CGFloat) {
        txtViewHeight.constant = max(40, height)
    }
    
    func adjustPostImageHeight(_ height: CGFloat) {
        postImgHeight.constant = height
    }

    func setTextViewPlaceholder() {
        if contentText.text.isEmpty {
            contentText.text = txtViewPlaceHolder
            contentText.textColor = UIColor.systemGray2
        }
    }

    func clearTextViewPlaceholder() {
        if contentText.text == txtViewPlaceHolder {
            contentText.text = ""
            contentText.textColor = .black
        }
    }

    func openPhotoGallery() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    func displaySelectedImage(_ image: UIImage) {
        postImg.image = image
    }
    
    func updatePostImageHeight(_ height: CGFloat) {
        postImgHeight.constant = height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITextViewDelegate
extension CreatePostView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        presenter.textViewDidBeginEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.textViewDidEndEditing(text: textView.text)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let estimatedSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .infinity))
        presenter.didChangeText(textView.text)
        self.adjustTextViewHeight(estimatedSize.height)  // This should now work
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension CreatePostView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            presenter.didSelectImage(selectedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension CreatePostView: XIBInstantiable {
    static var xibName: String {
        return "CreatePostView"
    }
}
