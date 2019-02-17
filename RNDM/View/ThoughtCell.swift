//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Sean Veal on 2/12/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLbl: UILabel!
    @IBOutlet weak var commentsNumLbl: UILabel!
    
    
    // Variables
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImg.addGestureRecognizer(tap)
        likesImg.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
        // Method 1
//        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId)
//            .setData([NUM_LIKES : thought.numLikes + 1], merge: true)
        
        // Method 2
        Firestore.firestore().document("\(THOUGHTS_REF)/\(thought.documentId!)")
            .updateData([NUM_LIKES : thought.numLikes + 1])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(thought: Thought) {
        self.thought = thought
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        timestampLbl.text = timestamp
        
        
        
    }

}
