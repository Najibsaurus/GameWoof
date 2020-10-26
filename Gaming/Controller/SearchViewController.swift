//
//  SearchViewController.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    
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
        if searchBar.text!.count > 0 {
            gameViewModel.searchGame(Game: searchBar.text ?? "")
            spinnerStart(state: true)
        }
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
    
    func showAlert() {
        let alert = UIAlertController(title: "Not found", message: "Try search another one", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    func completedFetchDetail() {
        return 
    }
    
    func completedFetchGame() {
        spinnerStart(state: false)
        if gameViewModel.gameList.count == 0 {
            showAlert()
        }
        tableView.reloadData()
    }
}
