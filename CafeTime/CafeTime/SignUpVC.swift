//
//  SignUpVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/26/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import PKHUD

class SignUpVC: UIViewController, SignUpViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Vars
    
    private let mainView = SignUpView()
    private let stringsChecker = StringsChecker.shared

    //image picker
    private lazy var libraryImagePicker : UIImagePickerController = {
        let myVar = UIImagePickerController()
        myVar.delegate = self
        myVar.sourceType = .photoLibrary
        myVar.allowsEditing = true
        return myVar
    }()
    
    private lazy var cameraImagePicker : UIImagePickerController = {
        let myVar = UIImagePickerController()
        myVar.delegate = self
        myVar.sourceType = .camera
        myVar.allowsEditing = true
        return myVar
    }()
    
    //action sheet
    private lazy var logoActionSheet : UIAlertController = {
        let myVar = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let viewPhoto = UIAlertAction(title: NSLocalizedString("sighnpvc.actionsheet.viewphoto", comment: ""), style: .default, handler: { [weak self] (action) in
            guard let weakSelf = self else { return }
            if let image = weakSelf.mainView.cafeLogo.image {
                let imageVC = ImageVC(withImage: image)
                weakSelf.present(imageVC, animated: true, completion: nil)
            }
        })
        
        let choosePhotoAction = UIAlertAction(title: NSLocalizedString("sighnpvc.actionsheet.choosephoto", comment: ""), style: .default, handler: { [weak self] (action) in
            guard let weakSelf = self else { return }
            weakSelf.present(weakSelf.libraryImagePicker, animated: true, completion: nil)
        })
        
        let pickPhotoFromCameraAction = UIAlertAction(title: NSLocalizedString("sighnpvc.actionsheet.takephoto", comment: ""), style: .default, handler: { [weak self] (action) in
            guard let weakSelf = self else { return }
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                weakSelf.present(weakSelf.cameraImagePicker, animated: true, completion: nil)
            } else {
                return
            }
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("sighnpvc.actionsheet.cancel", comment: ""), style: .cancel, handler: nil)
        
        myVar.addActions([viewPhoto, choosePhotoAction, pickPhotoFromCameraAction, cancelAction])
        
        return myVar
    }()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        mainView.delegate = self
        
        self.navigationItem.title = NSLocalizedString("signupvc.navigation.title", comment: "")
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
    //MARK: Main View Delegate
    
    func signUpUser(user: User) {
    
        let errorString = stringsChecker.checkSignUpFieldsForUser(user: user)
        
        if let err = errorString {
            self.presentAlert(message: err)
            return
        }
        
        HUD.show(.progress)
    
        user.myImageData = Utils.shared.imageToJpegCompressed(image: mainView.cafeLogo.image)
                
        AuthManager.shared.createUser(user: user, rememberUser: mainView.autoLoginCheckBox.isChecked()) { [weak self] (error, success) in
            
            guard let weakSelf = self else { return }
            
            if success {
                HUD.flash(.success,delay: 1)
                weakSelf.dismiss(animated: true, completion:nil)
            }
            else {
               // HUD.flash(.error, delay: 0.2)
                HUD.flash(.error, onView: self?.view, delay: 0.1, completion: { (end) in
                    weakSelf.presentAlert(message: error)
                })
            }
        }
    }
    
    func chooseLogoTapped() {
        self.present(logoActionSheet, animated: true, completion: nil)
    }
    
    //MARK: Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            mainView.cafeLogo.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
        
    
    deinit {
        print("object \( String(describing: (self))) dealloced")
    }
    
}
