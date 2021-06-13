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
  
    private let assembly = AppAssembly()

    
    var gameList = [GameModel]()
    var viewModel : GameViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = assembly.assembler.resolver.resolve(GameViewModel.self)
        viewModel?.delegate = self
        setupUI()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
       
        _ = searchBar.reactive.text.observeNext { text in
            let rplace = text?.replacingOccurrences(of: " ", with: "%20")
            if !rplace!.isEmpty   {
                    self.goSearch(game: rplace)
                }
            }
    
    }
    


      
    func goSearch(game: String?){
        viewModel?.searchGame(game: game ?? "")
        spinnerStart(state: true)
    }
    
    func setupUI()  {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GameViewModelStatic.gameCellnib, bundle: Bundle.main), forCellReuseIdentifier: GameViewModelStatic.cellGameIdentifier)
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
        if segue.identifier == GameViewModelStatic.gameDetailIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                let game = self.gameList[indexPath.row]
                let detailVC = segue.destination as? GameDetailViewController
                detailVC?.game = game

            }
        }
    }
    

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = self.gameList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GameViewModelStatic.cellGameIdentifier) as? GameTableViewCell
        cell?.setData(game)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(GameViewModelStatic.defaultRowHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: GameViewModelStatic.gameDetailIdentifier, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension SearchViewController: GameViewModelDelegate {
    func completedFetchGame(gamesList: [GameModel]?) {
        self.gameList = gamesList ?? [GameModel]()
        spinnerStart(state: false)
        if self.gameList.isEmpty {
            showError(text: "Try search another one")
        }
        tableView.reloadData()
    }
    
    func errorData(err: Error) {
        showError(text: err.localizedDescription)
    }
    
}

