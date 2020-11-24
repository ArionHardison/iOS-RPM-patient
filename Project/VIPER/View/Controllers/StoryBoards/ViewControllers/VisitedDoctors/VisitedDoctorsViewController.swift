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
    
    
    var visitedDoctors : [Appointments] = [Appointments]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getVisitedhDoctorList()
    }
    
    
}

//MARK: View Setups
extension VisitedDoctorsViewController {
    
    private func initialLoads() {
        setupNavigationBar()
        registerCell()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Visited Doctors"
    }
    
    private func registerCell() {
        self.visitedDoctorsTable.tableFooterView = UIView()
        self.visitedDoctorsTable.register(UINib(nibName: XIB.Names.VisitedDoctorsCell, bundle: nil), forCellReuseIdentifier: XIB.Names.VisitedDoctorsCell)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.VisitedDoctorsCell) as? VisitedDoctorsCell else{
            return UITableViewCell()
        }
//        cell.customizeStatusColor(indexPath: indexPath)
        cell.customizeStatusColor(status: self.visitedDoctors[indexPath.row].status ?? "")
//        self.populateCell(cell: cell, data: self.visitedDoctors[indexPath.row])
        cell.doctorNameLabel.text = (self.visitedDoctors[indexPath.row].hospital?.first_name ?? "") + (self.visitedDoctors[indexPath.row].hospital?.last_name ?? "")
        cell.hospitalNameLabel.text = self.visitedDoctors[indexPath.row].hospital?.clinic?.name ?? ""
        cell.dateLabel.text = dateConvertor(self.visitedDoctors[indexPath.row].scheduled_at ?? "", _input: .date_time, _output: .DM)
        cell.timeLabel.text =  dateConvertor(self.visitedDoctors[indexPath.row].scheduled_at ?? "", _input: .date_time, _output: .N_hour)
        cell.statusLabel.text = self.visitedDoctors[indexPath.row].appointment_type ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
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
    
}



//Api calls
extension VisitedDoctorsViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.UpdatedVistedDoctor:
                let data = dataDict as? UpdatedVistedDoctor
                self.visitedDoctors = data?.vistedDoctors?.appointments ?? []
                self.visitedDoctorsTable.reloadInMainThread()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getVisitedhDoctorList(){
        self.presenter?.HITAPI(api: Base.visitedDoctor.rawValue, params: nil, methodType: .GET, modelClass: UpdatedVistedDoctor.self, token: true)
    }
    
}

