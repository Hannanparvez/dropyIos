//
//  ViewController.swift
//  dropy
//
//  Created by hannan parvez on 26/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet var bg: SKView!
    @IBOutlet var coment: UILabel!
    var howdificult:difficulty?
    var displaytime=0
    @IBAction func back(_ sender: Any) {
        var lev=""
        if howdificult == difficulty.beginner{
            lev="beginner"
        }
        else if howdificult == difficulty.intermediate{
            lev="intermediate"
        }
        else if howdificult == difficulty.expert{
            lev="expert"
        }
        else{
            
        }
        UserDefaults.standard.set(true, forKey: "pendinggame")
        UserDefaults.standard.set(totalscore, forKey: "pendinggamescore")
        
        UserDefaults.standard.set(lev, forKey: "pendinggamelevel")
        
             
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var score: UILabel!
    var shape=UIView()
    var Xcordinate:Int?
    var Ycordinate:Int?
    var totalscore:Int?
    override func viewDidLoad() {
        switch howdificult {
        case difficulty.beginner?:
            displaytime=900
        case difficulty.intermediate?:
            displaytime=800
        case difficulty.expert?:
            displaytime=700
        default:
            displaytime=900
        }
        super.viewDidLoad()
        if totalscore == nil{
            totalscore=0
            score.text=totalscore?.description
            
        }
        else{
            score.text=totalscore?.description
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let startlabel=UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 80))
        startlabel.center = CGPoint(x: self.view.center.x  , y: self.view.center.y-400)
        startlabel.textAlignment = .center
        startlabel.text="GO CORONA G0!!!"
        startlabel.font = UIFont(name: "Gill Sans", size: 25)
        startlabel.textColor=UIColor.init(red: 0/255, green: 102/255, blue: 0/255, alpha: 1)
        self.view.addSubview(startlabel)
            UIView.animate(withDuration: 1.0, animations: {
                
                
                startlabel.center = CGPoint(x: self.view.center.x , y: self.view.center.y-200)
            }, completion: { done in
                startlabel.alpha=0
            })
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
            self.nextIteration()
        })
            
        
        
    }
        var i = 0

    func nextIteration() {

                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(displaytime)) {
                    if self.totalscore!<0{
                        let alert=UIAlertController(title: "Game Ober", message: "Game Over", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {
                            al in
                            self.dismiss(animated: true, completion: nil)
//                            self.totalscore=0
//                             DispatchQueue.main.async {
//                                       self.nextIteration()
//                                   }
                        }))
                        self.present(alert, animated: true)
                        UserDefaults.standard.set(false, forKey: "pendinggame")
                        return
                    }
                        self.makeshape()
                        self.nextIteration()
                    
                    
                }
            
        }

        
    
    var hit=false
    func makeshape(){
        hit=false
        self.Xcordinate = Int.random(in: 30 ..< Int(self.view.frame.width - 100))
        self.Ycordinate = Int.random(in: 100 ..< Int(self.view.frame.height - 200))
        let madeshape=UIView(frame: CGRect(x: self.Xcordinate! , y: self.Ycordinate! , width: 50, height: 50))
        madeshape.layer.cornerRadius=20
        madeshape.backgroundColor=UIColor(patternImage: UIImage(named: "angry.png")!)
        view.addSubview(madeshape)
        
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(displaytime)) {
                if !self.hit{
                    self.totalscore!-=1
                    if self.totalscore!>=0{
                        self.score.text=self.totalscore?.description
                    }
                    UIView.animate(withDuration: 1) {
                        
                        madeshape.alpha=0
                        madeshape.removeFromSuperview()
                        self.coment.alpha=1
                        self.coment.text="OOPS!!!"
                        self.coment.textColor=UIColor.red
                        UIView.animate(withDuration: 0.3, animations: {
                            self.coment.alpha=0
                        })
                    }
                       
                }
                   }
        
       
        let tap=UITapGestureRecognizer(target: self, action: #selector(self.hit(_:)))
        madeshape.addGestureRecognizer(tap)
    }
    @objc func hit(_ sender: UITapGestureRecognizer)
    {
        self.coment.alpha=1
        coment.text="WOW!!!"
        coment.textColor=UIColor.init(red: 0/255, green: 102/255, blue: 0/255, alpha: 1)
        UIView.animate(withDuration: 0.3, animations: {
            self.coment.alpha=0
        })
        hit=true
        totalscore!+=1
        if howdificult==difficulty.beginner{
            if UserDefaults.standard.object(forKey: "beginnerhighscore") as? Int == nil{
                UserDefaults.standard.set(0, forKey: "beginnerhighscore")
            }
            if UserDefaults.standard.integer(forKey: "beginnerhighscore") < totalscore!{
                UserDefaults.standard.set(totalscore, forKey: "beginnerhighscore")
            }
            
        }
        else if howdificult==difficulty.intermediate{
            if UserDefaults.standard.object(forKey: "intermediatehighscore") as? Int == nil{
                UserDefaults.standard.set(0, forKey: "intermediatehighscore")
            }
            if UserDefaults.standard.integer(forKey: "intermediatehighscore") < totalscore!{
                UserDefaults.standard.set(totalscore, forKey: "intermediatehighscore")
            }
        }
        else  if howdificult==difficulty.expert{
            if UserDefaults.standard.object(forKey: "experthighscore") as? Int == nil{
                UserDefaults.standard.set(0, forKey: "experthighscore")
            }
            if UserDefaults.standard.integer(forKey: "experthighscore") < totalscore!{
                UserDefaults.standard.set(totalscore, forKey: "experthighscore")
            }
        }
        else{
            
        }
        score.text=totalscore?.description
        sender.view!.backgroundColor=UIColor(patternImage: UIImage(named: "smile.png")!)
        DispatchQueue.main.async{
            UIView.animate(withDuration: 0.3){
                sender.view!.alpha=0.4
            }
            let xx=self.Xcordinate! - 15
            UIView.animate(withDuration: 0.4) {
                
                sender.view?.frame=CGRect(x: xx, y: Int(UIScreen.main.bounds.size.height) - 50, width: 50, height: 50)
                
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                UIView.animate(withDuration: 0.5) {
                    sender.view?.frame=CGRect(x: xx, y: Int(UIScreen.main.bounds.size.height)-150, width: 50, height: 50)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                        UIView.animate(withDuration: 0.5) {
                        sender.view?.frame=CGRect(x: xx, y: 1000, width: 50, height: 50)
                        }
                    })
                }
            })
            
        }
        
        
    }


}

