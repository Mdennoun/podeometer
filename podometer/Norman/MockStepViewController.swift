//
//  MockStepViewController.swift
//  Podomètre
//
//  Created by Mohamed dennoun on 23/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class MockStepViewController: UIViewController {

  
    @IBOutlet var step: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mock"

        step.text = "0"
      }
    
    @IBAction func add(_ sender: Any) {
        
        var cur = Int(self.step.text!)
        cur! += 1
        self.step.text = cur?.description
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
