//
//  ViewController.swift
//  Stretchy Snacks
//
//  Created by Jaewon Kim on 2017-08-31.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var navHeightConstraint: NSLayoutConstraint!
    var isOpned:Bool = false
    var stackView:UIStackView! = nil
    var itemArray:Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView1:UIImageView = UIImageView(image: #imageLiteral(resourceName: "oreos"))
        let imageView2:UIImageView = UIImageView(image: #imageLiteral(resourceName: "pizza_pockets"))
        let imageView3:UIImageView = UIImageView(image: #imageLiteral(resourceName: "pop_tarts"))
        let imageView4:UIImageView = UIImageView(image: #imageLiteral(resourceName: "popsicle"))
        let imageView5:UIImageView = UIImageView(image: #imageLiteral(resourceName: "ramen"))
        
        let imageViewArray = [imageView1,imageView2,imageView3,imageView4,imageView5]
        
        for imageView in imageViewArray{
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
        }
        

        let tapGestrue1 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped1))
        let tapGestrue2 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped2))
        let tapGestrue3 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped3))
        let tapGestrue4 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped4))
        let tapGestrue5 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped5))

        imageView1.addGestureRecognizer(tapGestrue1)
        imageView2.addGestureRecognizer(tapGestrue2)
        imageView3.addGestureRecognizer(tapGestrue3)
        imageView4.addGestureRecognizer(tapGestrue4)
        imageView5.addGestureRecognizer(tapGestrue5)
        
        
        
        
        stackView = UIStackView(arrangedSubviews: [imageView1, imageView2, imageView3, imageView4, imageView5])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        
        imageView1.widthAnchor.constraint(equalTo: imageView1.heightAnchor, multiplier: 1.0).isActive = true
        
        self.stackView.isHidden = true
        
        navView.addSubview(stackView)
        
        
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.stackView.leadingAnchor.constraint(equalTo: self.navView.leadingAnchor, constant: 0).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.navView.trailingAnchor, constant: 0).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.navView.bottomAnchor, constant: 0).isActive = true
        
        
        let navTitleLabel:UILabel = UILabel()
        navView.addSubview(navTitleLabel)
        
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        navTitleLabel.text = "Snacks"
        navTitleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        let constraint = navTitleLabel.centerYAnchor.constraint(equalTo: navView.centerYAnchor)
        
        constraint.isActive = true
        constraint.identifier = "centerY"
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }

    
    func imageViewTapped1(_ sender: UITapGestureRecognizer){
        itemArray.insert("Oreos", at: 0)
        insertNewRow()
    }
    
    func imageViewTapped2(_ sender: UITapGestureRecognizer){
        itemArray.insert("Pizza Pockets", at: 0)
        insertNewRow()
    }
    
    func imageViewTapped3(_ sender: UITapGestureRecognizer){
        itemArray.insert("Pop Tarts", at: 0)
        insertNewRow()
    }
    
    func imageViewTapped4(_ sender: UITapGestureRecognizer){
        itemArray.insert("Popsicle", at: 0)
        insertNewRow()
    }
    
    func imageViewTapped5(_ sender: UITapGestureRecognizer){
        itemArray.insert("Ramen", at: 0)
        insertNewRow()
    }
    
    func insertNewRow()
    {
        let newIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }

    @IBAction func addButton(_ sender: UIButton) {
        
        print("plus icon pressed")
        
        if isOpned {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [], animations: {
                self.navHeightConstraint.constant = 64
                self.view.layoutIfNeeded()
            }, completion: nil)
            UIView.animate(withDuration: 0.5) {
                self.addButton.transform = CGAffineTransform(rotationAngle: 0)
            }
            
            for constraint in navView.constraints as [NSLayoutConstraint] {
                if constraint.identifier == "centerY" {
                    constraint.constant = 0
                    constraint.isActive = true
                }
            }
            
            isOpned = false

            
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [], animations: {
                self.navHeightConstraint.constant = 200
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5) {
                self.addButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
            }
            
            for constraint in navView.constraints as [NSLayoutConstraint] {
                if constraint.identifier == "centerY" {
                    constraint.constant = -40
                    constraint.isActive = true
                }
            }
            
            isOpned = true

        }
        
        self.stackView.isHidden = !self.stackView.isHidden
    }
    

}

