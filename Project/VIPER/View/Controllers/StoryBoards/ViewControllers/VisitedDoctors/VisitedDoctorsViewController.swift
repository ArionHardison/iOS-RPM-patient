//
//  VisitedDoctorsViewController.swift
//  Project
//
//  Created by Hari Haran on 03/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class VisitedDoctorsViewController: UIViewController {
    
    @IBOutlet weak var visitedDoctorsTable: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    
    var visitedDoctors : [Appointments] = [Appointments]()
    var isUpdate : Bool = false
    lazy var loader : UIView = {
        return createActivityIndicator(self.view.window ?? self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getVisitedhDoctorList(count: 0)
    }
    
    
}

//MARK: View Setups
extension VisitedDoctorsViewController {
    
    private func initialLoads() {
        setupNavigationBar()
        registerCell()
        self.noDataView.isHidden = false
        self.visitedDoctorsTable.isHidden = true
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Visited Doctors"
    }
    
    private func registerCell() {
        self.visitedDoctorsTable.tableFooterView = UIView()
        self.visitedDoctorsTable.register(UINib(nibName: XIB.Names.UpcomingTableviewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.UpcomingTableviewCell)
    }
}

//MARK: Tabelview delegates and datasources

extension VisitedDoctorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visitedDoctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingTableviewCell) as? UpcomingTableviewCell else{
            return UITableViewCell()
        }
        self.populateData(cell: cell, data: self.visitedDoctors[indexPath.row],index: indexPath.row)

//        cell.customizeStatusColor(indexPath: indexPath)
//        self.populateCell(cell: cell, data: self.visitedDoctors[indexPath.row])
//        cell.doctorNameLabel.text = (self.visitedDoctors[indexPath.row].hospital?.first_name ?? "") + (self.visitedDoctors[indexPath.row].hospital?.last_name ?? "")
//        cell.hospitalNameLabel.text = self.visitedDoctors[indexPath.row].hospital?.clinic?.name ?? ""
//        cell.dateLabel.text = dateConvertor(self.visitedDoctors[indexPath.row].scheduled_at ?? "", _input: .date_time, _output: .DM)
//        cell.timeLabel.text =  dateConvertor(self.visitedDoctors[indexPath.row].scheduled_at ?? "", _input: .date_time, _output: .N_hour)
//        cell.statusLabel.text = self.visitedDoctors[indexPath.row].status ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
    func populateData(cell : UpcomingTableviewCell , data : Appointments,index:Int){
        cell.labelDate.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DM)
        cell.labelTime.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .N_hour)
        cell.labeldoctorName.text = "Dr.\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
        cell.labelSubtitle.text = "\(data.hospital?.clinic?.name ?? ""),\(data.hospital?.clinic?.address ?? "")"  //"\(data.hospital?.email ?? "")"
        cell.selectionStyle = .none
        cell.makeVideoCallButton.tag = index
        cell.buttonCancel.isHidden = true
        cell.labelStatus.isHidden = false
//        cell.statusWidth.constant = isFirstBlockSelected ? 0 : 81
//        cell.labelStatus.layer.cornerRadius = 4
        if data.status ?? "" == "CANCELLED"{
            cell.labelStatus.backgroundColor = UIColor.red.withAlphaComponent(0.2) //UIColor(named: "LightGreen") //
            cell.labelStatus.textColor = UIColor.red.withAlphaComponent(0.2)//UIColor(named: "ConfirmedGreenColor") //UIColor(named: "")
        }else{
            cell.labelStatus.backgroundColor = UIColor(named: "LightGreen") //UIColor.LightGreen
            cell.labelStatus.textColor = UIColor(named: "ConfirmedGreenColor") //UIColor.AppBlueColor
        }
        if data.status == "CHECKEDOUT"{
            cell.labelStatus.text = ("Consulted").uppercased()
        }else {
        cell.labelStatus.text = data.status ?? "".uppercased()
        }

    }
    
//    func populateCell(cell : VisitedDoctorsCell , data : Visited_doctors){
//        cell.doctorNameLabel.text = "\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
//        cell.hospitalNameLabel.text = "\(data.hospital?.clinic?.name ?? "") \(data.hospital?.clinic?.address ?? "")"
//        cell.dateLabel.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DM)
//        cell.timeLabel.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .N_hour)
//        cell.statusLabel.text = data.status ?? ""
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppointmentDetailsViewController.initVC(storyBoardName: .main, vc: AppointmentDetailsViewController.self, viewConrollerID: Storyboard.Ids.AppointmentDetailsViewController)
//        vc.visitedDetail = self.visitedDoctors[indexPath.row]
        vc.updatedVisitedDetail = self.visitedDoctors[indexPath.row]
        vc.isFromVisited = true
        self.push(from: self, ToViewContorller: vc)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.visitedDoctors.count >= 10{
            self.isUpdate = true
            if indexPath.row == self.visitedDoctors.count - 3{
                self.getVisitedhDoctorList(count: self.visitedDoctors[self.visitedDoctors.count - 1].id ?? 0)
            }
        }
    }
    
}



//Api calls
extension VisitedDoctorsViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.UpdatedVistedDoctor:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? UpdatedVistedDoctor
                if data?.vistedDoctors?.appointments?.count ?? 0 > 0{
                    self.noDataView.isHidden = true
                    self.visitedDoctorsTable.isHidden = false
                    self.visitedDoctors = data?.vistedDoctors?.appointments ?? []
                    if !isUpdate{
                        self.visitedDoctors = data?.vistedDoctors?.appointments ?? []
    //                self.searchDoctors = data?.search_doctors ?? [Search_doctors]()
                    }else{
                        for i in 0...((data?.vistedDoctors?.appointments?.count ?? 0)){
                            if i == 10{
                            guard let data = data?.vistedDoctors?.appointments?[i - 1] else { return  }
    //                        self.searchDoctors.append(data)
                            }else{
                                guard let data = data?.vistedDoctors?.appointments?[i] else { return  }
                                self.visitedDoctors.append(data)
                            }
                        }
                       
                    }
                    self.visitedDoctorsTable.reloadInMainThread()
                }else{
                    self.noDataView.isHidden = false
                    self.visitedDoctorsTable.isHidden = true
                }
               
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getVisitedhDoctorList(count:Int){
        let url = "\(Base.visitedDoctor.rawValue)?page=\(count)"
        self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: UpdatedVistedDoctor.self, token: true)
        self.loader.isHidden = false
    }
    
}

