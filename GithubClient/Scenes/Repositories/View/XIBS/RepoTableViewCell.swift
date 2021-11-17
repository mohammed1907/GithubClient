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
        selectionStyle = .none
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
        repoOwnerName.text = viewModel.ownerName
        repoOwnerImage.setImage(imageURL: viewModel.avatar)
        creationDate.text = viewModel.date
    }
}
