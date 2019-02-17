//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by Sean Veal on 2/17/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {

    // Outlets
    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    
    // Variables
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTxt.layer.cornerRadius = 4
        updateButton.layer.cornerRadius = 10
        commentTxt.text = commentData.comment.commentTxt
    }

    @IBAction func updateTapped(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId)
            .collection(COMMENTS_REF).document(commentData.comment.documentId)
            .updateData([COMMENT_TXT : commentTxt.text]) { (error) in
                if let error = error {
                    debugPrint("Unable to update comment: \(error)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
