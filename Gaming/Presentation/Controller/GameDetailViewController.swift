//
//  GameDetailViewController.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit
import Kingfisher
import Game
import Core


class GameDetailViewController: UIViewController {


    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDescription: UITextView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    private let assembly = AppAssembly()

    var gameDetail = DetailModel?.self
    var viewModel : DetailViewModel?
    var game: GamingModel?

    var favoriteState = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = assembly.assembler.resolver.resolve(DetailViewModel.self)
        viewModel?.delegate = self
        
    
        if let idGame = game?.id {
            viewModel?.checkGame(game: "\(idGame)")
            viewModel?.showDetail(idGame: "\(idGame)")
        }
        
        favoriteState = viewModel?.isFavorite ?? false
        setupUI()
        
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(favoriteGame))
        doubleTap.numberOfTapsRequired = 2
        bannerImage.addGestureRecognizer(doubleTap)
        
        let tapUnfavorite = UITapGestureRecognizer(target: self, action: #selector(unFavoriteGame))
        favoriteImageView.addGestureRecognizer(tapUnfavorite)
        
    
    }
    
    
    @objc func unFavoriteGame() {
        if favoriteState == true {
            favoriteAction()
        }
    }
    
    
    @objc func favoriteGame() {
        if favoriteState == false {
            favoriteAction()
        }
    }
    
    
    func favoriteAction() {
        viewModel?.updateFavorite(game: game!)
        favoriteState = viewModel?.isFavorite ?? false
        favoriteImageView.isHidden = !favoriteState
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
    }
    
    func setupUI()  {
        favoriteImageView.isHidden = !favoriteState
        spinnerStart(state: true)
        let imageUrl = URL(string: game?.backgroundImage ?? GameViewModelStatic.dummyImage)
        bannerImage.kf.setImage(with: imageUrl)
        gameTitle.text = game?.name
        
    }
    func spinnerStart(state: Bool)  {
        if state {spinner.startAnimating()} else {
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


func setHTMLFromString(htmlText: String) -> NSAttributedString {
    
    let modifiedFont = String(format: GameViewModelStatic.htmlFormat, htmlText)
    guard let attrStr = (try? NSAttributedString(
                            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                            documentAttributes: nil)) else { return NSAttributedString() }
    return attrStr
 
    
}


extension GameDetailViewController: DetailViewModelDelegate {
    func completedFetchDetailGame(game: DetailGameModel?) {
        spinnerStart(state: false)
        gameDescription.attributedText = setHTMLFromString(htmlText: game?.description ?? "")
    }
    
    
    func errorData(err: Error) {
        showAlert(title: "Error", message: err.localizedDescription)
    }
    
    func completedFetchDetail() {
        
    }
}
