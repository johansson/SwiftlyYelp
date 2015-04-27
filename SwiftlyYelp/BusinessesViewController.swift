//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var businesses: [Business]! {
        didSet {
            bizTableView.reloadData()
        }
    }
    
    let searchBarView: UISearchBar = UISearchBar()
    var isSearching: Bool = false
    
    @IBOutlet weak var bizTableView: UITableView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    @IBAction func onTap(sender: AnyObject) {
        searchBarView.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bizTableView.dataSource = self
        bizTableView.delegate = self
        bizTableView.rowHeight = UITableViewAutomaticDimension
        bizTableView.estimatedRowHeight = 120
        
        searchBarView.delegate = self
        
        navigationItem.titleView = searchBarView
//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
//        })
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                println(business.name!)
                println(business.address!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businesses {
            return businesses.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let contentView: UIView = tableView.dataSource!.tableView(tableView, cellForRowAtIndexPath: indexPath)
        contentView.updateConstraintsIfNeeded()
        contentView.layoutIfNeeded()
        return contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BusinessCell.reuseId) as! BusinessCell

        if indexPath.row >= businesses.count {
            cell.businessNameLabel.text = ""
            cell.businessAddressLabel.text = ""
            cell.businessCategoryLabel.text = ""
            cell.businessDistanceLabel.text = ""
            cell.businessPricinessLabel.text = ""
            return cell
        }
        
        let business = businesses[indexPath.row]
        cell.businessNameLabel.text = "\(indexPath.row + 1). \(business.name!)"
        cell.businessAddressLabel.text = business.address
        cell.businessReviewCountLabel.text = "\(business.reviewCount!) reviews"
        cell.businessCategoryLabel.text = business.categories
        cell.businessDistanceLabel.text = business.distance
        cell.businessPricinessLabel.text = "$$$"
        cell.businessRatingImageView.setImageWithURL(business.ratingImageURL!)
        cell.businessImageView.setImageWithURL(business.imageURL!)
        println(business.ratingImageURL!.absoluteString)
        return cell
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(searchText)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearching = false
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
