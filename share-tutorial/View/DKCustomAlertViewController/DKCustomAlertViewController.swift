//
//  DKCustomAlertViewController.swift
//  share-tutorial
//
//  Created by Derek Kim on 2023-10-16.
//

import UIKit

class DKCustomAlertViewController: UIViewController {
    var buttonAction: (() -> Void)?
    
    init(title: String, description: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        setupCustomAlert(title: title, description: description, buttonTitle: buttonTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomAlert(title: String, description: String, buttonTitle: String) {
        let customView = UIView()
        customView.layer.cornerRadius = 24
        customView.backgroundColor = .systemBackground
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.backgroundColor = UIColor.systemMint
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(titleLabel)
        customView.addSubview(descriptionLabel)
        customView.addSubview(button)
        self.view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            customView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            customView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
            
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 37),
            button.widthAnchor.constraint(equalToConstant: 120),
            
            customView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        self.dismiss(animated: true) {
            self.buttonAction?()
        }
    }
    
}
