//
//  PromoTableViewController.swift
//  InstaPromo
//
//  Created by Gustavo Leal on 6/24/16.
//  Copyright © 2016 Moip. All rights reserved.
//

import UIKit
import Parse

class PromoTableViewController: UITableViewController {

    var promos = [Promo]()
    
    // MARK: - Private Objects
    var session: NSURLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.get()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return promos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as! PromoTableViewCell

        let index = indexPath.row
        
        cell.local.text = self.promos[index].local
        cell.desc.text = self.promos[index].desc
        cell.preco.text = self.promos[index].preco
    
        let url = NSURL(string: self.promos[index].urlImg!)!
        let imageSession = NSURLSession.sharedSession()
        let imgTask = imageSession.downloadTaskWithURL(url) { (url, response, error) -> Void in
            if (error == nil) {
                    if let imageData = NSData(contentsOfURL: url!) {
                        dispatch_async(dispatch_get_main_queue(), {
                            cell.prmoImage.image = UIImage(data: imageData)
                        })
                    }
                } else {
                    print(error)
                    print("Erro ao baixar imagem")
                }
            }
            imgTask.resume()
        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func get(){
        let query = PFQuery(className:"promo")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) promo.")
                // Do something with the found objects
                if let objects = objects {
                    
                    for object in objects {
                        
                        let promo = Promo()
                        
                        if let local = object["local"] as? String!{
                            promo.local = local
                        }
                        if let desc = object["desc"] as? String{
                            promo.desc = desc
                        }
                        if let urlImg = object["urlImg"] as? String{
                            promo.urlImg = urlImg
                        }
                        if let preco = object["preco"] as? String{
                            promo.preco = preco
                        }
                        
                        if let loc = object["loc"] as? PFGeoPoint{
                            promo.latitude = loc.latitude
                            promo.longitude = loc.longitude
                        }
                        self.promos.append(promo)
                        print(promo.local)
                    }
                }
                
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    
}


