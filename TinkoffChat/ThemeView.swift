//
//  ThemeView.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 05.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ThemeView: UIView {
    
    let themeLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    let themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let themeBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(ofType theme: Theme) {
        self.init(frame: .zero)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        
        switch theme {
        case .classic:
            themeLabel.text = "Classic"
            themeImageView.image = UIImage(named: "classicImage")
            themeBackgroundView.layer.backgroundColor = UIColor.white.cgColor
        case .day:
            themeLabel.text = "Day"
            themeImageView.image = UIImage(named: "dayImage")
            themeBackgroundView.layer.backgroundColor = UIColor.white.cgColor
        case .night:
            themeLabel.text = "Night"
            themeImageView.image = UIImage(named: "nightImage")
            themeBackgroundView.layer.backgroundColor = UIColor(red: 0.024, green: 0.024, blue: 0.024, alpha: 1).cgColor
        }
    }
    
    private func setupViews() {
        addSubview(themeLabel)
        addSubview(themeBackgroundView)
        addSubview(themeImageView)
        
        NSLayoutConstraint.activate([
            themeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            themeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 33),
            themeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -27),
            themeImageView.heightAnchor.constraint(equalToConstant: 33),
            
            themeBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            themeBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            themeBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            themeBackgroundView.heightAnchor.constraint(equalToConstant: 57),
            
            themeLabel.topAnchor.constraint(equalTo: themeBackgroundView.bottomAnchor, constant: 20),
            themeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            themeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            themeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            themeLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func selectTheme() {
        themeBackgroundView.layer.borderWidth = 5
        themeBackgroundView.layer.borderColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
