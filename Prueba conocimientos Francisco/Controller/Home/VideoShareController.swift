//
//  VideoShareController.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit
import AVKit
import AVFoundation

class VideoShareController: UIViewController {

    //MARK: - Properties
    
    var urlVideo: URL
    let playerViewController = AVPlayerViewController()
    let titleLabel = UILabel(text: "Comprte tu rutina", font: .boldSystemFont(ofSize: 16), textColor: .black)
    
    //MARK: - Init
    
    init(urlVideo: URL) {
        self.urlVideo = urlVideo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar(title: "Compartir", largeTitle: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let fileManager = FileManager()
        fileManager.clearTmpDirectory()
    }
    
    //MARK: - Helpers
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(playerViewController.view)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        playerViewController.view.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        playerViewController.view.withHeight(view.frame.height * 0.3)
        
        let player = AVPlayer(url: urlVideo)
        playerViewController.player = player
        
    }
    
    //MARK: - Selector

}
