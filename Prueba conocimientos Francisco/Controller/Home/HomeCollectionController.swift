//
//  HomeCollectionController.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit
import JGProgressHUD
import AVFoundation

class HomeCollectionController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let optionsView = [ImageName.optionOne, ImageName.optionTwo, ImageName.optionThree, ImageName.optionFour]
    private let textOptions = ["Noticias", "GYM", "Comparte", "Rutinas"]

    private let reuseIdentifier = "Cell"
    
    var videoPicker: VideoPicker!
    
    //MARK: - Init
    
    init(collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    //MARK: - Helpers
    
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.3351675868, green: 0.2796953321, blue: 0.4996795654, alpha: 1)
        self.collectionView!.register(OptionsHomeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        videoPicker = VideoPicker(presentationController: self, delegate: self)
    }

}

//MARK: - Extensions

extension HomeCollectionController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionsView.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OptionsHomeCell
        cell.backgroundImageView.image = UIImage(named: optionsView[indexPath.item])
        cell.textLabel.text = textOptions[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            videoPicker.present(from: self.view)
        default:
            print("Debug default")
        }
    }
    
}

//MARK: - Extension UICollectionViewDelegateFlowLayout

extension HomeCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = view.frame.width - 32
        var height = (view.frame.height * 0.3) - 24
        
        switch indexPath.item {
        case 0:
            width = view.frame.width - 32
            height = (view.frame.height * 0.3) - 64
        case 1, 2:
            width = (view.frame.width * 0.5) - 24
            height = (view.frame.height * 0.3) - 24
        case 3:
            width = (view.frame.width) - 32
            height = (view.frame.height * 0.3) - 64
        default:
            width = view.frame.width - 32
            height = (view.frame.height * 0.3) - 64
        }
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension HomeCollectionController: VideoPickerDelegate {
    func didSelectVideo(videoUrl: URL?) {
        guard let selectedFileURL = videoUrl else {
            return
        }
        
        let hud = JGProgressHUD(style: .light)
        hud.show(in: view)
        
        let avAsset = AVURLAsset(url: selectedFileURL, options: nil)
        avAsset.exportVideo(outputFileType: .mp4, fileExtension: "mp4") { [weak self] (url) in
            DispatchQueue.main.async {
                hud.dismiss()
                if let urlVideo = url {
                    self?.navigationController?.pushViewController(VideoShareController(urlVideo: urlVideo), animated: true)
                }
            }
        }
        hud.dismiss()
    }
}
