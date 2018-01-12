//
//  AttandanceViewController.swift
//  tmi-ios
//
//  Created by Saransh Mittal on 25/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit
import Charts
import Alamofire

class AttandanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var attdanceTableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!

    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor =  UIColor.black
        self.navigationController?.navigationBar.barTintColor =  UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor =  UIColor.white
        self.navigationController?.navigationBar.barTintColor =  UIColor.white
        self.tabBarController?.tabBar.tintColor = UIColor.black
        UIApplication.shared.statusBarStyle = .default
    }
    
    func attendanceGraph(){
        var present:Double = 0
        var total:Double = 0
        if Data.attandance.count != 0{
            for i in 0...Data.attandance.count-1{
                if String(describing: Data.attandance[i]["attendance"]!) == "present" {
                    present = present+1
                }
                total = total + 1
            }
        }
        print(present)
        let status = ["Present", "Absent"]
        let totalDays = [present, total-present]
        setChart(dataPoints: status, values: totalDays)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attdanceTableView.delegate = self
        attdanceTableView.dataSource = self
        // Do any additional setup after loading the view.
        let urlAttandance = "https://api.tmivit.com/info/attendance"
        Alamofire.request(urlAttandance, method: .post, headers : ["accessToken" : Data.accessToken]).responseJSON{ res in
            if res.result.isSuccess{
                let result:NSDictionary = res.result.value as! NSDictionary
                let check:Bool = result["success"]! as! Bool
                if check == true{
                    print("Successully fetched attandance")
                    Data.attandance = result["attendance"] as! [NSDictionary]
                    let urlSessions = "https://api.tmivit.com/info/sessions"
                    Alamofire.request(urlSessions, method: .post, parameters : ["clubId" : Data.clubId], headers : ["accessToken" : Data.accessToken]).responseJSON{ response in
                        if response.result.isSuccess{
                            let results:NSDictionary = response.result.value as! NSDictionary
                            let check:Bool = results["success"]! as! Bool
                            if check == true{
                                print("Successully fetched sessions")
                                Data.sessions = results["sessions"] as! [NSDictionary]
                                self.attdanceTableView.reloadData()
                                self.attendanceGraph()
                            }else{
                                print("Failed to fetch sessions")
                            }
                        }else{
                            print("Failed JSON response")
                        }
                    }
                }else{
                    print("Failed to fetch attandance")
                }
            }else{
                print("Failed JSON response")
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attandance", for: indexPath) as! AttandanceTableViewCell
        if String(describing: Data.attandance[indexPath.row]["attendance"]!) == "present"{
            cell.statusLabel.text = "Present"
        } else {
            cell.statusLabel.text = "Absent"
        }
        let milisecond = Data.sessions[indexPath.row]["date"]! as! Int
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        let date = dateFormatter.string(from: dateVar)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: dateVar)
        let month = calendar.component(.month, from: dateVar)
        let day = calendar.component(.day, from: dateVar)
        cell.dateLabel.text = String(day) + " " + getMonth(monthInNumber: month) + " " + String(year)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.attandance.count
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
