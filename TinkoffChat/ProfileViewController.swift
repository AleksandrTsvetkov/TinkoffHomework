//
//  ProfileViewController.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 11.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    private let defaults = UserDefaults.standard
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let frame = editButton?.frame {
            print("Frame is \(frame) at \(#function)")
        } else {
            print("Frame is nil at \(#function)")
        }
        // Frame равен nil, как и сама кнопка edit, так как к этому моменту root view ещё не загружено.
    }
    
    @IBAction func editButtonTapped() {
        let addPhotoAlertController = UIAlertController(title: "Какое фото добавить?", message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Из галлереи", style: .default) { [weak self] _ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self?.present(imagePickerController, animated: true)
        }
        let cameraAction = UIAlertAction(title: "С камеры", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                self?.present(imagePickerController, animated: true)
            } else {
                let errorAlertController = UIAlertController(title: "Ошибка", message: "Камера недоступна", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                errorAlertController.addAction(okAction)
                errorAlertController.removeNegativeWidthConstraints()
                self?.present(errorAlertController, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        addPhotoAlertController.addAction(galleryAction)
        addPhotoAlertController.addAction(cameraAction)
        addPhotoAlertController.addAction(cancelAction)
        addPhotoAlertController.removeNegativeWidthConstraints()
        present(addPhotoAlertController, animated: true)
    }
    
    
    //MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("View is loaded into memory.")
        #endif
        
        photoView.layer.cornerRadius = photoView.frame.width / 2
        if let frame = editButton?.frame {
            print("Frame is \(frame) at \(#function)")
        } else {
            print("Frame is nil at \(#function)")
        }
        //Frame принимает не nil значение, кнопка edit получила свой фрейм при инициализации. В данный момент он равен значению из storyboard.
        //setTheme()
        switch defaults.string(forKey: "theme") {
        case "classic":
            view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
            saveButton.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
            saveButton.setTitleColor(.black, for: .normal)
            editButton.setTitleColor(.black, for: .normal)
            nameLabel.textColor = .black
            userInfoLabel.textColor = .black
        case "day":
            view.backgroundColor = .white
            saveButton.backgroundColor = .white
            saveButton.setTitleColor(.black, for: .normal)
            editButton.setTitleColor(.black, for: .normal)
            nameLabel.textColor = .black
            userInfoLabel.textColor = .black
        case "night":
            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
            saveButton.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
            saveButton.setTitleColor(.white, for: .normal)
            editButton.setTitleColor(.white, for: .normal)
            nameLabel.textColor = .white
            userInfoLabel.textColor = .white
        default:
            view.backgroundColor = .white
            saveButton.backgroundColor = .white
            saveButton.setTitleColor(.black, for: .normal)
            editButton.setTitleColor(.black, for: .normal)
            nameLabel.textColor = .black
            userInfoLabel.textColor = .black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        print("View is about to be added to a view hierarchy.")
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        print("View was added to a view hierarchy.")
        #endif
        if let frame = editButton?.frame {
            print("Frame is \(frame) at \(#function)")
        } else {
            print("Frame is nil at \(#function)")
        }
        // Здесь frame имеет другое значение начальной точки, так как она изменилась в соответствии с размерами экрана и констрейнтами.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        #if DEBUG
        print("View is about to layout its subviews.")
        #endif
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        #if DEBUG
        print("View has just laid out its subviews.")
        #endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        #if DEBUG
        print("View is about to be removed from a view hierarchy.")
        #endif
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        #if DEBUG
        print("View was removed from a view hierarchy.")
        #endif
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        photoView.image = image
        initialsLabel.isHidden = true
    }
}

//extension ProfileViewController: ThemePickerDelegate {
//    func setTheme() {
//        switch defaults.string(forKey: "theme") {
//        case "classic":
//            view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
//        case "day":
//            view.backgroundColor = .white
//        case "night":
//            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
//        default:
//            view.backgroundColor = .white
//        }
//    }
//}
