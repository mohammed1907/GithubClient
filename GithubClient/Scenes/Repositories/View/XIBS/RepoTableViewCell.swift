//
//  RepoTableViewCell.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoOwnerImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
