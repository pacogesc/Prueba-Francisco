//
//  Extensions.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import Foundation
import LBTATools
import AVFoundation

//MARK: - UIButton extension

extension UIButton {
    /// Custom initializer for buttons with underlined text
    /// - Parameters:
    ///   - title: The text that the button will display
    ///   - titleColor: The color of the text and the underline
    ///   - target: The current target for the button
    ///   - action: The current action for the button
    convenience init(title: String, titleColor: UIColor, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                                              NSAttributedString.Key.foregroundColor: titleColor,
                                                                              NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                              NSAttributedString.Key.underlineColor: titleColor])
        setAttributedTitle(attributedString, for: .normal)
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    convenience init(title: String, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        
        setImage(UIImage(named: "down_arrow"), for: .normal)
        imageEdgeInsets = .init(top: 4, left: 200, bottom: 6, right: 34)
        titleEdgeInsets = .init(top: 0, left: -30, bottom: 0, right: 34)
        setTitle(title, for: .normal)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        tintColor = .lightGray
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    func roundedButton(cornerRadius: CGFloat, color: UIColor, borderWidth: CGFloat = 1, contentAlignment: ContentHorizontalAlignment = .center, padding: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.contentHorizontalAlignment = contentAlignment
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0)
    }
}

//MARK: - UIViewController

extension UIViewController {
    func setupNavBar(title: String, color: UIColor = .black, largeTitle: Bool = true) {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
        navigationController?.navigationBar.tintColor = color
        
        navigationItem.title = title
        
        navigationController?.navigationBar.prefersLargeTitles = largeTitle
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
    }
}

//MARK: - FileManager

extension FileManager {
    func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {
           //catch the error somehow
        }
    }
}

//MARK: - AVURLAsset

extension AVURLAsset
{
    func exportVideo(presetName: String = AVAssetExportPresetHighestQuality, outputFileType: AVFileType = .mp4, fileExtension: String = "mp4", then completion: @escaping (URL?) -> Void) {
        let filename = url.deletingPathExtension().appendingPathExtension(fileExtension).lastPathComponent
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        if let session = AVAssetExportSession(asset: self, presetName: presetName) {
            session.outputURL = outputURL
            session.outputFileType = outputFileType
            let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
            let range = CMTimeRangeMake(start: start, duration: duration)
            session.timeRange = range
            session.shouldOptimizeForNetworkUse = true
            session.exportAsynchronously {
                switch session.status {
                case .completed:
                    completion(outputURL)
                case .cancelled:
                    debugPrint("Video export cancelled.")
                    completion(nil)
                case .failed:
                    let errorMessage = session.error?.localizedDescription ?? "n/a"
                    debugPrint("Video export failed with error: \(errorMessage)")
                    completion(nil)
                default:
                    break
                }
            }
        } else {
            completion(nil)
        }
    }
}

