//
//  CommentCell.swift
//  RNDM
//
//  Created by Sean Veal on 2/14/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var timestampTxt: UILabel!
    @IBOutlet weak var commentTxt: UILabel!
    
    func configureCell(comment: Comment) {
        usernameTxt.text = comment.username
        commentTxt.text = comment.commentTxt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timestampTxt.text = timestamp
    }

}
