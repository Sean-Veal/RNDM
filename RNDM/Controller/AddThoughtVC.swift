//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Sean Veal on 2/12/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {

    // Outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTxt: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    //Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView() {
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4;
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        guard let username = userNameTxt.text else {return}
        
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TXT: thoughtTxt.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : username
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    

}
