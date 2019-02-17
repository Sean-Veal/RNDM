//
//  CommentCell.swift
//  RNDM
//
//  Created by Sean Veal on 2/14/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase

protocol CommentCellDelegate {
    func commentMenuTapped(comment: Comment)
}

class CommentCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var timestampTxt: UILabel!
    @IBOutlet weak var commentTxt: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    // Variables
    private var comment: Comment!
    private var delegate: CommentCellDelegate?
    
    func configureCell(comment: Comment, delegate: CommentCellDelegate?) {
        optionsMenu.isHidden = true
        self.comment = comment
        self.delegate = delegate
        usernameTxt.text = comment.username
        commentTxt.text = comment.commentTxt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timestampTxt.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentMenuTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func commentMenuTapped() {
        delegate?.commentMenuTapped(comment: comment)
    }

}
