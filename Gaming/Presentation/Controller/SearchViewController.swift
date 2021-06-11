//
//  SearchViewController.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit
import Bond

class SearchViewController: UIViewController, UISearchBarDelegate, Alerta {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var gameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
       
        _ = searchBar.reactive.text.observeNext { text in
            let rplace = text?.replacingOccurrences(of: " ", with: "%20")
                if rplace!.count > 0 {
                    self.gameViewModel.searchGame(game: rplace ?? "")
                    self.spinnerStart(state: true)
                }
            }
    
    }
    


      
    func goSearch(game: String?){
        gameViewModel.searchGame(game: game ?? "")
        spinnerStart(state: true)
    }
    
    func setupUI()  {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: gameViewModel.gameCellnib, bundle: Bundle.main), forCellReuseIdentifier: gameViewModel.cellGameIdentifier)
        gameViewModel.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        spinner.isHidden = true
    
    }
    
    func spinnerStart(state: Bool)  {
        if state {
            spinner.isHidden = false
            spinner.startAnimating()
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == gameViewModel.gameDetailIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                let game = gameViewModel.gameList[indexPath.row]
                let detailVC = segue.destination as? GameDetailViewController
                detailVC?.game = game

            }
        }
    }
    

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameViewModel.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gameViewModel.gameList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: gameViewModel.cellGameIdentifier) as? GameTableViewCell
        cell?.setData(game, gameViewModel)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(gameViewModel.defaultRowHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: gameViewModel.gameDetailIdentifier, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension SearchViewController: GameViewModelDelegate {
    func errorData(err: Error) {
        showError(text: err.localizedDescription)
    }
    
    func completedFetchDetail() {
        return
    }
    
    func completedFetchGame() {
        spinnerStart(state: false)
        if gameViewModel.gameList.count == 0 {
            showError(text: "Try search another one")
        }
        tableView.reloadData()
    }
}
