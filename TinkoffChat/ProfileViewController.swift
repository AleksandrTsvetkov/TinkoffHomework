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
        //Frame принимает финальное значение, кнопка edit получила свой фрейм при инициализации. Если верстать без storyboard, использую только констрейнты и не задавая frame вручную, на этом моменте он был бы равен нулю.
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
        // Здесь также frame имеет окончательное значение.
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
