//
//  PromotionViewController.swift
//  RPBApp
//  NOTE: CLASS IS INCOMPLETE
//  Created by Michael Perkins and Ellen Studer on 5/3/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import Alamofire
import UIKit

class PromotionViewController: UIViewController {

    let topBarController: TopBarViewController = TopBarViewController()

   
    
    //Promo details retrieved from API
    var promoDesc: String! = ""
    var imageURL: String! = ""
    var promoTitle:String! = ""
    var promoImage: UIImage! = UIImage()
    var promoImageView: UIImageView! = UIImageView()
    
    //Text fields for view
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(35)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoImageView.translatesAutoresizingMaskIntoConstraints = false
        getPromotion()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getPromotion()
    }
    func setUpView(){
        self.titleLabel.text = promoTitle
        self.descLabel.text = promoDesc
        self.view.addSubview(descLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(topBarController.view)
        self.view.addSubview(promoImageView!)
        self.setViewConstraints()
        
    }
    func getPromotion(){
        
        
        let url = "http://www.ellenstuder.com/ellen/getPromo.php"
        Alamofire.request(url, method: .post).responseJSON { response in
            print(response.timeline) //metrics for testing
            switch(response.result) {
            //if successful check the contents
            case .success(_):
                //if the JSON can become a dictionary
                if let JSON = response.result.value as? [[String:AnyObject]]{
                    //if the dictionary isnt empty
                    if JSON.isEmpty == false{
                        print(JSON)
                        self.promoDesc = JSON[0]["description"] as! String
                        self.promoTitle = JSON[0]["title"] as! String
                        self.imageURL = JSON[0]["img"] as! String
                        
                        self.image(fromUrl: self.imageURL)
                        
                        
                        
                        
                    }
                    
                }
                break
            case .failure(_):
                break
                
            }
            
            
        }
        
        
    }
   
    public func image(fromUrl urlString: String) {
        print("HERE !")
        print(urlString)

        guard let url = URL(string: urlString) else {
            print("Couldn't create URL from \(urlString)")
            return
        }
        let theTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    print("HEREEEEE")
                    self.promoImage = UIImage(data: response)!
                    print(self.promoImage)
                    self.promoImageView!.image = self.promoImage!
                    self.setUpView()
                }
            }
        }
        theTask.resume()
    }
    
    /// Sets the view constraints of elements within the view.
    func setViewConstraints() {
        
        //image view button constraints
        NSLayoutConstraint(
            item: promoImageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: promoImageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 175.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: promoImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: promoImageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .height,
            multiplier: 0.3,
            constant: 0.0)
            .isActive = true
        
        //title constraints
        NSLayoutConstraint(
            item: titleLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: promoImageView,
            attribute: .top,
            multiplier: 1.0,
            constant: -20.0)
            .isActive = true
        NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: titleLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: promoImageView,
            attribute: .width,
            multiplier: 2.0,
            constant: 0.0)
            .isActive = true
        
        
        
        //description constraints
        NSLayoutConstraint(
            item: descLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: promoImageView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
            .isActive = true
        NSLayoutConstraint(
            item: descLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: descLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: promoImageView,
            attribute: .width,
            multiplier: 2.0,
            constant: 0.0)
            .isActive = true
        
        
        
        
        //top Bar constraints
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.08,
            constant: 0.0)
            .isActive = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
