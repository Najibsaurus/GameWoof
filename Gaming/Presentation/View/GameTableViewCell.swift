//
//  GameTableViewCell.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var releaseTitle: UILabel!
    @IBOutlet weak var ratingTitle: UILabel!
    
    var game: GameModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImage.layer.cornerRadius = thumbnailImage.frame.height / 7.0
        thumbnailImage.clipsToBounds = true
      
    }

    func setData(_ game: GameModel, _ gameVieModel: GameViewModel)  {
        
        self.game = game
        let imageUrl = URL(string: game.backgroundImage )
        let rating = game.rating
        thumbnailImage.kf.indicatorType = .activity
        thumbnailImage.kf.setImage(with: imageUrl)
        gameTitle.text = game.name
        releaseTitle.text = game.released
        ratingTitle.text = "\(rating)"
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
