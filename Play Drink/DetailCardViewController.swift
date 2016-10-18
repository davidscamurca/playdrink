//
//  DetailCardViewController.swift
//  Play Drink
//
//  Created by Anderson Oliveira on 23/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class DetailCardViewController: UIViewController {

    
    var titleTxt : String!
    var descriptionTxt : String!
    var image : UIImage!
    
    
    //Mark: IBOutlets
    
    @IBOutlet var titles: UILabel!
    @IBOutlet var descripitions: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titles.text = self.titleTxt
        self.descripitions.text = self.descriptionTxt
        self.imageView.image = self.image
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailCardViewController.goBack))
        self.view.addGestureRecognizer(tap)
    }
    
    func goBack() {
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.titles.alpha = 0
            self.descripitions.alpha = 0
            self.imageView.alpha = 0
            }, completion: { (fin) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
