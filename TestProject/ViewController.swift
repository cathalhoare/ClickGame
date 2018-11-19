//
//  ViewController.swift
//  TestProject
//
//  Created by NewTrends on 19/10/2018.
//  Copyright © 2018 UCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var gameOverLabel: UILabel!
   
    var timer:Timer? 
    var startSeconds:Int? = 0
    var endSeconds:Int? = 0
    var score:Int? = 0
    var tapCount:Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tapCount! = 0
        self.startSeconds! = 0
        self.endSeconds! = 0
        self.targetView.isHidden = true
        self.gameOverLabel.isHidden = true
    }

    @IBAction func handleStart(_ sender: Any) {
    
        //start 2 second timer
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false){_ in
                
                let date = Date()
                let calendar = Calendar.current
                self.startSeconds = calendar.component(.second, from: date)
                
                let maxx = self.view.bounds.maxX
                let maxy = self.view.bounds.maxY
                
                let newx = Int.random(in: 0 ... Int(maxx))
                let newy = Int.random(in: 0 ... Int(maxy))
                
                self.targetView.center = CGPoint(x:newx, y:newy)
                
                self.targetView.isHidden = false
            }
        }
    }
    
    @IBAction func tapped(_ gestureRecognizer:UITapGestureRecognizer){
        guard gestureRecognizer.view != nil else { return }
        
        self.tapCount! = self.tapCount! + 1
        
        self.targetView.isHidden = true
        
        if(self.tapCount! < 5){
            //Calculate time
            
            let date = Date()
            let calendar = Calendar.current
            self.endSeconds = calendar.component(.second, from: date)
            
            if self.endSeconds! - self.startSeconds! <= 2{
                self.score = self.score! + 1
                self.scoreLabel.text = String(self.score!)
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false){_ in
                    
                let date = Date()
                let calendar = Calendar.current
                self.startSeconds = calendar.component(.second, from: date)
                    
                let maxx = self.view.bounds.maxX
                let maxy = self.view.bounds.maxY
                    
                let newx = Int.random(in: 60 ... Int(maxx))
                let newy = Int.random(in: 60 ... Int(maxy))
                    
                self.targetView.center = CGPoint(x:newx, y:newy)
                    
                self.targetView.isHidden = false
            }
        }
        else{
            self.gameOverLabel.isHidden = false
            self.gameOverLabel.text = "Your Score Was " + String(self.score!)
        }
    }
    
    
    
}

