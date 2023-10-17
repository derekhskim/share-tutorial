//
//  ViewController.swift
//  share-tutorial
//
//  Created by Derek Kim on 2023-10-16.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var imageView: UIImageView!
    private var shareButton: UIButton!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureViewController()
        configureUI()
    }
    
    // MARK: - Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Share Image"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI() {
        setupImageView()
        setupShareButton()
        setupConstraints()
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatar")
        
        view.addSubview(imageView)
    }
    
    private func setupShareButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemPink
        
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 20)
        configuration.attributedTitle = AttributedString("Share Image", attributes: container)
        
        var container2 = AttributeContainer()
        container2.foregroundColor = UIColor.white.withAlphaComponent(0.75)
        configuration.attributedSubtitle = AttributedString("Press the button to share image!", attributes: container2)
        configuration.image = UIImage(systemName: "square.and.arrow.up")
        configuration.imagePadding = 15
        
        shareButton = UIButton(configuration: configuration)
        shareButton.addAction(
            UIAction { [weak self] _ in
                guard let self = self else { return }
                guard let image = imageView.image else { return }
                
                let shareable = ShareableImage(image: image, title: "Check out this awesome image 🥰")
                presentShareActivityView(withShareable: shareable, withButton: shareButton)
            }, for: .touchUpInside)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 40
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            shareButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func presentShareActivityView(withShareable shareable: ShareableImage, withButton: UIButton) {
        let activityVC = UIActivityViewController(activityItems: [shareable], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = { (activityHandler, completed, returnedItems, error) in
            if completed {
                self.showAlert(titleMessage: "Success! 🥳", description: "Image was successfully shared.", buttonTitle: "Nice!") {
                    self.dismiss(animated: true)
                }
            }
        }
        
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = withButton
            popoverController.sourceRect = withButton.bounds
        }
        
        self.present(activityVC, animated: true)
    }
}
