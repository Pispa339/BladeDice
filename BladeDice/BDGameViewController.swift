//
//  BDGameViewController.swift
//  BladeDice
//
//  Created by Juho Pispa on 15.5.2016.
//  Copyright © 2016 Juho Pispa. All rights reserved.
//

import UIKit

class BDGameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var spinLabel: UILabel!
    @IBOutlet weak var trickLabel: UILabel!
    
    @IBOutlet weak var playerTableView: UITableView!
    
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerTableView.delegate = self
        playerTableView.dataSource = self
        
        let playerCellNib = UINib(nibName: "BDPlayerCell", bundle: nil)
        playerTableView.registerNib(playerCellNib, forCellReuseIdentifier: "PlayerCell")
        
        let presetPlayer = Player()
        players.append(presetPlayer)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if(indexPath.row < players.count) {
            cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell") as! BDPlayerCell
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("AddPlayerCell")!
            cell.textLabel?.text = "+"
            cell.textLabel?.center = cell.contentView.center
            cell.textLabel?.textAlignment = .Center
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let presetPlayer = Player()
        players.append(presetPlayer)
        playerTableView.reloadData()
    }

    
}

