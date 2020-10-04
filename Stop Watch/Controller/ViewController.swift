//
//  ViewController.swift
//  Stop Watch
//
//  Created by Karthik on 9/25/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var watch : StopWatch!

    override func viewDidLoad() {
        super.viewDidLoad()
        watch = StopWatch(totalTime: 0, timeString: "00:00.00", lastLapTime: 0, currentLapTime: 0)
        
        tableView.dataSource = self
        
        startButton.layer.cornerRadius=startButton.frame.width/2
        resetButton.layer.cornerRadius=resetButton.frame.width/2
        startButton.setTitleColor(.green, for: .normal)
        
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 80, weight: UIFont.Weight.regular)
        startButton.titleLabel?.textColor = .green
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        if watch.notStarted {
            watch.resetTime()
            timeLabel.text = watch.formatTime(time: watch.currentTime)
            tableView.reloadData()
        } else {
            watch.currentLapTime = watch.totalTime - watch.lastLapTime
            let time = watch.convertTime(time: watch.currentLapTime)
            let timeString = watch.formatTime(time: time)
            watch.laps.append(timeString)
            tableView.reloadData()
            watch.lastLapTime = watch.lastLapTime+watch.currentLapTime
            
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        runStopwatch()
    }
    
    func runStopwatch() {
        if watch.notStarted {
            watch.timer = Timer(timeInterval: watch.interval, target: self, selector: #selector(UpdateUI), userInfo: nil, repeats: true)
            RunLoop.current.add(watch.timer!, forMode: .common)
            watch.notStarted = false
            startButton.setTitle("Pause", for: .normal)
            resetButton.setTitle("Lap", for: .normal)
            startButton.setTitleColor(.red, for: .normal)
        } else {
            watch.timer?.invalidate()
            watch.timer = nil
            watch.notStarted = true
            startButton.setTitle("Start", for: .normal)
            resetButton.setTitle("Reset", for: .normal)
            startButton.setTitleColor(.green, for: .normal)
            
        }
    }
    
    @objc func UpdateUI() {
        self.watch.updateTimer()
        let timeString = self.watch.formatTime(time: self.watch.currentTime)
        self.timeLabel.text = timeString
        
    }
    
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watch.laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let reverseIndex = watch.laps.count - indexPath.row-1
        cell.lapLabel.text = "Lap "+"\(reverseIndex+1)"
        cell.timeLabel.text = watch.laps[reverseIndex]
        return cell
    }
    
    
}
