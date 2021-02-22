//
//  VideoPicker.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit

protocol VideoPickerDelegate: class {
    func didSelectVideo(videoUrl: URL?)
}

class VideoPicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: VideoPickerDelegate?
    
    init(presentationController: UIViewController, delegate: VideoPickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.videoQuality = .type640x480
        self.pickerController.mediaTypes = ["public.movie"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] (_) in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true, completion: nil)
        }
    }
    
    func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Tomar video") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Video library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.presentationController?.present(alertController, animated: true, completion: nil)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect videoUrl: URL?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelectVideo(videoUrl: videoUrl)
    }
}

extension VideoPicker: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let urlVideo = info[.mediaURL] as? URL else {
            return self.pickerController(picker, didSelect: nil)
        }
        
        self.pickerController(picker, didSelect: urlVideo)
    }
    
}

extension VideoPicker: UINavigationControllerDelegate {
    
}

