//
//  FavoriteViewController.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var gameViewModel = GameViewModel()
    var favoriteViewModel = FavoriteViewModel()
    var resultsController : NSFetchedResultsController<Gaming>?
    

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
                let game = favoriteViewModel.resultsController?.object(at: indexPath)
                let dataSet = Results(id: NSNumber(value: game?.id ?? 0).intValue, backgroundImage: game?.background_image, name:game?.name, released:game?.released,rating:game?.rating)
                let detailVC = segue.destination as? GameDetailViewController
                detailVC?.game = dataSet
            }
        }
    }
    

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.resultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = favoriteViewModel.resultsController?.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: gameViewModel.cellGameIdentifier) as! GameTableViewCell
        let dataSet = Results(id: NSNumber(value: game?.id ?? 0).intValue, backgroundImage: game?.background_image, name:game?.name, released:game?.released,rating:game?.rating)
        cell.setData(dataSet, gameViewModel)
        return cell
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
    func completedFetchFavorite() {
         tableView.reloadData()
    }
    func fetchDataDelegate() {
        tableView.reloadData()
    }
}
