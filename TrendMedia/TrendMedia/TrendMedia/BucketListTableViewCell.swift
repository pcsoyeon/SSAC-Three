//
//  BucketListTableViewCell.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/19.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBOutlet weak var bucketListLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
