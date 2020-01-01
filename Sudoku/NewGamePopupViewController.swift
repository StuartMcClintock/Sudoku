//
//  NewGamePopupViewController.swift
//  Sudoku
//
//  Created by Stuart McClintock on 12/28/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

class NewGamePopupViewController: UIViewController {

    var del: AppDelegate!
    
    @IBOutlet weak var popupView: UIView!
    @IBAction func noPressed(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeAnimate()
    }
    
    @IBAction func yesPressed(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeAnimate()
        del.reset()
    }
    
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.view.alpha = 0}, completion:{(finished: Bool) in
                if (finished){
                    self.view.removeFromSuperview()
        }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 7
        
        let app = UIApplication.shared
        del = app.delegate as? AppDelegate
        
        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.showAnimate()

        // Do any additional setup after loading the view.
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
