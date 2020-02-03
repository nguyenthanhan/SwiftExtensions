//
//  AppImagePicker.swift
//  Tipbros
//
//  Created by An Nguyen Thanh on 11/20/19.
//  Copyright © 2019 Vinova. All rights reserved.
//

import UIKit

protocol AppImagePickerDelegate: class {
    func didSelect(image: UIImage?)
    func deletePhoto()
    func invalidFormat()
}

class AppImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: AppImagePickerDelegate?
    private var preImage = UIImage()
    
    init(presentationController: UIViewController, delegate: AppImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    func present(from sourceView: UIView, preImage: UIImage) {
        self.preImage = preImage
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Delete Photo", style: .destructive, handler: { _ in
            self.delegate?.deletePhoto()
        }))
//        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
//            alertController.addAction(action)
//        }
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Choose Photo") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
    }
}

@available(iOS 11.0, *)
extension AppImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        
        /** Check image format*/
        if let assetPath = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
            if !(assetPath.absoluteString?.lowercased().hasSuffix("jpeg"))! && !(assetPath.absoluteString?.lowercased().hasSuffix("png"))! {
                picker.dismiss(animated: true, completion: nil)
                self.delegate?.invalidFormat()
                return
            }
        }
        
        return self.pickerController(picker, didSelect: image)
        
    }
}

extension AppImagePicker: UINavigationControllerDelegate {
}
