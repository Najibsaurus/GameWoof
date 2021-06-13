//
//  GameListViewController.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit
import Kingfisher
import Bond

class GameListViewController: UIViewController, Alerta {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private let assembly = AppAssembly()

    
    var gameList = [GameModel]()
    var viewModel : GameViewModel?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = assembly.assembler.resolver.resolve(GameViewModel.self)
        viewModel?.delegate = self
        setupUI()
        getDataGame()
        
    }
                  
    func setupUI()  {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GameViewModelStatic.gameCellnib, bundle: Bundle.main), forCellReuseIdentifier: GameViewModelStatic.cellGameIdentifier)
        
    }

    @IBAction func about(_ sender: UIBarButtonItem) {
        let about = AboutViewController()
        self.navigationController?.pushViewController(about, animated: true)
    }
    
    func getDataGame()  {
        viewModel?.fetchDataGame()
        spinnerStart(state: true)
    }
    
    func spinnerStart(state: Bool)  {
        if state {
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


extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
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



extension GameListViewController: GameViewModelDelegate {
    
    func completedFetchGame(gamesList: [GameModel]?) {
        self.gameList = gamesList ?? [GameModel]()
        self.spinnerStart(state: false)
        self.tableView.reloadData()
    }
    
    func errorData(err: Error) {
        showError(text: err.localizedDescription) { cancelAction in
            self.spinnerStart(state: false)
        } retryAction: { action in
            self.getDataGame()
        }
    }

}

