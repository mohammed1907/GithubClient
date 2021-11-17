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
    @IBOutlet weak var repoOwnerName: UILabel!
    @IBOutlet weak var creationDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var viewModel: RepoViewModel! {
        didSet {
            self.setup()
        }
    }

}

private extension RepoTableViewCell {
    func setup() {
        repoName.text = viewModel.name
    }
}
