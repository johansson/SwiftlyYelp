//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {

    var businesses: [Business]! {
        didSet {
            bizTableView.reloadData()
        }
    }
    
    var searchedBusinesses: [Business]! {
        didSet {
            bizTableView.reloadData()
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String]) {
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: filters, deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                println(business.name!)
                println(business.address!)
            }
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
        bizTableView.estimatedRowHeight = 150
        
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
    
    /* not sure if i need this? seems to work without??? */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let contentView: UIView = tableView.dataSource!.tableView(tableView, cellForRowAtIndexPath: indexPath)
        contentView.updateConstraintsIfNeeded()
        contentView.layoutIfNeeded()
        return contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BusinessCell.reuseId) as! BusinessCell
        
        let dollarChar : Character = "$"
        let expensive = String(count:Int(arc4random_uniform(6) + 1), repeatedValue: dollarChar)
        
        let business = businesses[indexPath.row]
        cell.businessNameLabel.text = "\(indexPath.row + 1). \(business.name!)"
        cell.businessAddressLabel.text = business.address
        cell.businessReviewCountLabel.text = "\(business.reviewCount!) reviews"
        cell.businessCategoryLabel.text = "asdlk asdk; adslk; ads;lk asd;lk;asd lh hkdakshj kasdjkh jsdhk asdkjh asdkjh kasdjh kasdjkh asdkjh asdkjhak sdjh k sdakjh asdkjh asdk hjkjhasd khjs dkhjasd kajhs sd kjhasd kahjsd kjh sd askdj aksdja ksjda kj ds askjda kjsdh akjsd   kj dhskajds kajhsd k  kjsd kjahsd kajhsd kjhads k kj sdkajhd kasjhdak jshdak sjdh"//business.categories
        cell.businessDistanceLabel.text = business.distance
        cell.businessPricinessLabel.text = expensive
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
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nc = segue.destinationViewController as! UINavigationController
        let fvc = nc.topViewController as! FiltersViewController
        fvc.delegate = self
    }

}
