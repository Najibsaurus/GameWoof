//
//  FavoriteViewController.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit


class FavoriteViewController: UIViewController, Alerta {

    @IBOutlet weak var tableView: UITableView!
  
    private let assembly = AppAssembly()
    var gameList = [GameModel]()
    var viewModel : FavoriteViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = assembly.assembler.resolver.resolve(FavoriteViewModel.self)
        viewModel?.delegate = self
        
        tableView.register(UINib(nibName: GameViewModelStatic.gameCellnib, bundle: Bundle.main), forCellReuseIdentifier: GameViewModelStatic.cellGameIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchFavoriteData() 
     
    }
    
    func fetchFavoriteData()  {
        viewModel?.fetchData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GameViewModelStatic.gameDetailIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                let game = viewModel?.gameList[indexPath.row]
                let detailVC = segue.destination as? GameDetailViewController
                detailVC?.game = game

            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.fetchFavoriteData()
        }
    }
}


extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
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


extension FavoriteViewController: FavoriteViewModelDelegate {
    func completedFetchFavorite(gamesList: [GameModel]?) {
        self.gameList = gamesList ?? [GameModel]()
        tableView.reloadData()
    }
    
    func errorData(error: Error) {
        showError(text: error.localizedDescription)
    }
}

