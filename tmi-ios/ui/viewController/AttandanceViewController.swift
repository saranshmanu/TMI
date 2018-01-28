//
//  AttandanceViewController.swift
//  tmi-ios
//
//  Created by Saransh Mittal on 25/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class AttandanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var attendances:[NSDictionary] = []
    @IBOutlet weak var attendanceTableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    func attendanceGraph(){
        var present:Double = 0
        var total:Double = 0
        if attendances.count != 0{
            for i in 0...attendances.count-1{
                if String(describing: attendances[i]["attendanceImpl"]!) == "present" {
                    present = present + 1
                }
                total = total + 1
            }
        }
        let status = ["Present", "Absent"]
        let totalDays = [present, total-present]
        setChart(dataPoints: status, values: totalDays)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.centerText = ""
        pieChartView.chartDescription?.text = ""
        pieChartView.drawCenterTextEnabled = true
        pieChartView.holeColor = UIColor.clear
        pieChartView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0)
        let colorGreen = UIColor(red: 21/255, green: 120/255, blue: 121/255, alpha: 1)
        let colorBlack = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)
        let color: [UIColor] = [colorBlack, colorGreen]
        pieChartDataSet.colors = color
    }
    
    func queryAttendance() {
        let realm = try! Realm()
        let attendance = realm.objects(Attendance.self)
        var temp:NSDictionary
        var tempSession:NSDictionary
        var tempUser:NSDictionary
        for i in attendance {
            tempSession = [
                "sessionId": i.session?.sessionId,
                "date": i.session?.date,
                "wordOfDay": i.session?.wordOfDay,
                "wordMeaning": i.session?.wordMeaning,
                "wordUsage": i.session?.wordMeaning,
                "genEvalReport": i.session?.genEvalReport
            ]
            tempUser = [
                "userId" : i.user?.userId,
                "name" : i.user?.userId
            ]
            temp = [
                "session": tempSession,
                "user": tempUser,
                "attendanceImpl": i.attendanceImpl,
            ]
            attendances.append(temp)
        }
        attendanceTableView.reloadData()
        attendanceGraph()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        attendanceTableView.reloadData()
        attendanceGraph()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        attendanceTableView.delegate = self
        attendanceTableView.dataSource = self
        queryAttendance()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attandance", for: indexPath) as! AttandanceTableViewCell
        let x = attendances[indexPath.row] as NSDictionary
        let y = x["session"] as! NSDictionary
        let z = Constants.findDate(milliSeconds: y[Constants.date]! as! Int)
        cell.dateLabel.text = String(z.date) + " " + Constants.getMonth(monthInNumber: z.month) + " " + String(z.year)
        if String(describing: x["attendanceImpl"]!) == "present"{
            cell.statusLabel.text = "Present"
        } else {
            cell.statusLabel.text = "Absent"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendances.count
    }
}
