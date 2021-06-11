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
    var gameViewModel = GameViewModel()
    var favoriteViewModel = FavoriteViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: gameViewModel.gameCellnib, bundle: Bundle.main), forCellReuseIdentifier: gameViewModel.cellGameIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        favoriteViewModel.delegate = self
        fetchFavoriteData()
     
    }
    
    func fetchFavoriteData()  {
        favoriteViewModel.fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == gameViewModel.gameDetailIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                let game = favoriteViewModel.gameList[indexPath.row]
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
        return favoriteViewModel.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = favoriteViewModel.gameList[indexPath.row]
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


extension FavoriteViewController: FavoriteViewModelDelegate {
    func errorData(error: Error) {
        showError(text: error.localizedDescription)
    }
    
    func completedFetchFavorite() {
         tableView.reloadData()
    }
    func fetchDataDelegate() {
        tableView.reloadData()
    }
}
