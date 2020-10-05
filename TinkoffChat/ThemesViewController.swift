//
//  ThemesViewController.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 05.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    private let classicThemeView = ThemeView(ofType: .classic)
    private let dayThemeView = ThemeView(ofType: .day)
    private let nightThemeView = ThemeView(ofType: .night)
    private let defaults = UserDefaults.standard
    // Если здесь не поставить weak, этот VC будет держать сильную ссылку на ConversationsListVC и возникнет retain cycle.
    //weak var delegate: ThemePickerDelegate!
    var changeTheme: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
    }
    
    private func setupActions() {
        let classicTap1 = UITapGestureRecognizer(target: self, action: #selector(classicThemeTapped))
        let classicTap2 = UITapGestureRecognizer(target: self, action: #selector(classicThemeTapped))
        let classicTap3 = UITapGestureRecognizer(target: self, action: #selector(classicThemeTapped))
        classicThemeView.themeBackgroundView.addGestureRecognizer(classicTap1)
        classicThemeView.themeLabel.addGestureRecognizer(classicTap2)
        classicThemeView.themeImageView.addGestureRecognizer(classicTap3)
        
        let dayTap1 = UITapGestureRecognizer(target: self, action: #selector(dayThemeTapped))
        let dayTap2 = UITapGestureRecognizer(target: self, action: #selector(dayThemeTapped))
        let dayTap3 = UITapGestureRecognizer(target: self, action: #selector(dayThemeTapped))
        dayThemeView.themeBackgroundView.addGestureRecognizer(dayTap1)
        dayThemeView.themeLabel.addGestureRecognizer(dayTap2)
        dayThemeView.themeImageView.addGestureRecognizer(dayTap3)
        
        let nightTap1 = UITapGestureRecognizer(target: self, action: #selector(nightThemeTapped))
        let nightTap2 = UITapGestureRecognizer(target: self, action: #selector(nightThemeTapped))
        let nightTap3 = UITapGestureRecognizer(target: self, action: #selector(nightThemeTapped))
        nightThemeView.themeBackgroundView.addGestureRecognizer(nightTap1)
        nightThemeView.themeLabel.addGestureRecognizer(nightTap2)
        nightThemeView.themeImageView.addGestureRecognizer(nightTap3)
    }
    
    private func setupViews() {
        //setTheme()
        
        switch defaults.string(forKey: "theme") {
        case "classic":
            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
            classicThemeView.themeLabel.textColor = .black
            dayThemeView.themeLabel.textColor = .black
            nightThemeView.themeLabel.textColor = .black
        case "day":
            view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
            classicThemeView.themeLabel.textColor = .black
            dayThemeView.themeLabel.textColor = .black
            nightThemeView.themeLabel.textColor = .black
        case "night":
            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
            classicThemeView.themeLabel.textColor = .white
            dayThemeView.themeLabel.textColor = .white
            nightThemeView.themeLabel.textColor = .white
        default:
            break
        }
        
        navigationController?.navigationBar.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [classicThemeView, dayThemeView, nightThemeView])
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
    
    @objc private func classicThemeTapped() {
        defaults.set("classic", forKey: "theme")
        //setTheme()
        //delegate.setTheme()
        changeTheme()
        view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
        classicThemeView.themeLabel.textColor = .black
        dayThemeView.themeLabel.textColor = .black
        nightThemeView.themeLabel.textColor = .black
    }
    
    @objc private func dayThemeTapped() {
        defaults.set("day", forKey: "theme")
        //setTheme()
        changeTheme()
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        classicThemeView.themeLabel.textColor = .black
        dayThemeView.themeLabel.textColor = .black
        nightThemeView.themeLabel.textColor = .black
    }
    
    @objc private func nightThemeTapped() {
        defaults.set("night", forKey: "theme")
        //setTheme()
        //delegate.setTheme()
        changeTheme()
        view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
        classicThemeView.themeLabel.textColor = .white
        dayThemeView.themeLabel.textColor = .white
        nightThemeView.themeLabel.textColor = .white
    }
    
}

//extension ThemesViewController: ThemePickerDelegate {
//    func setTheme() {
//        switch defaults.string(forKey: "theme") {
//        case "classic":
//            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            classicThemeView.themeLabel.textColor = .black
//            dayThemeView.themeLabel.textColor = .black
//            nightThemeView.themeLabel.textColor = .black
//        case "day":
//            view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
//            classicThemeView.themeLabel.textColor = .black
//            dayThemeView.themeLabel.textColor = .black
//            nightThemeView.themeLabel.textColor = .black
//        case "night":
//            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
//            classicThemeView.themeLabel.textColor = .white
//            dayThemeView.themeLabel.textColor = .white
//            nightThemeView.themeLabel.textColor = .white
//        default:
//            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            classicThemeView.themeLabel.textColor = .black
//            dayThemeView.themeLabel.textColor = .black
//            nightThemeView.themeLabel.textColor = .black
//            defaults.set("classic", forKey: "theme")
//        }
//    }
//}
