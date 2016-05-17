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
    
    @IBOutlet weak var trickView: UIView!
    @IBOutlet weak var playerTableView: UITableView!
    
    var players = [Player]()
    let PCIdentifier = "PlayerCell"
    let timeoutKey = "TimeoutKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGestureRecognizers()
        setupTableView()
        let presetPlayer = Player()
        players.append(presetPlayer)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initGestureRecognizers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(animateTrickGeneration))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.trickView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(animateTrickGeneration))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.trickView.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(animateTrickGeneration))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.trickView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(animateTrickGeneration))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.trickView.addGestureRecognizer(swipeDown)
    }
    
    func setupTableView() {
        playerTableView.delegate = self
        playerTableView.dataSource = self
        playerTableView.alwaysBounceVertical = false;
        
        let playerCellNib = UINib(nibName: "BDPlayerCell", bundle: nil)
        playerTableView.registerNib(playerCellNib, forCellReuseIdentifier: PCIdentifier)
    }
    
    func animateTrickGeneration() {
        let timeout = NSDate().dateByAddingTimeInterval(1.0)
        _ = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(generateRandomTrick), userInfo: [timeoutKey:timeout], repeats: true)
    }
    
    func generateRandomTrick(timer: NSTimer) {
        
        let userInfo = timer.userInfo as! Dictionary<String, NSDate>
        let timeout = userInfo[timeoutKey]
        
        if(timeout!.compare(NSDate()) == .OrderedAscending) {
            timer.invalidate()
        }
        
        let trickDict = TrickGenerator.generateRandomTrick()
        
        spinLabel.text = trickDict[Constants.spinKey]
        sideLabel.text = trickDict[Constants.sideKey]
        trickLabel.text = trickDict[Constants.trickNameKey]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if(indexPath.row < players.count) {
            cell = tableView.dequeueReusableCellWithIdentifier(PCIdentifier) as! BDPlayerCell
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

