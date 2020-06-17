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
    
    
    var visitedDoctors : [Visited_doctors] = [Visited_doctors]()

    
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
        cell.customizeStatusColor(indexPath: indexPath)
        self.populateCell(cell: cell, data: self.visitedDoctors[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func populateCell(cell : VisitedDoctorsCell , data : Visited_doctors){
        cell.doctorNameLabel.text = "\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
        cell.hospitalNameLabel.text = "\(data.hospital?.clinic?.name ?? "") \(data.hospital?.clinic?.address ?? "")"
        cell.dateLabel.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DM)
        cell.timeLabel.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .N_hour)
        cell.statusLabel.text = data.status ?? ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppointmentDetailsViewController.initVC(storyBoardName: .main, vc: AppointmentDetailsViewController.self, viewConrollerID: Storyboard.Ids.AppointmentDetailsViewController)
        vc.visitedDetail = self.visitedDoctors[indexPath.row]
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
            case model.type.DoctorsListModel:
                let data = dataDict as? DoctorsListModel
                self.visitedDoctors = data?.visited_doctors ?? [Visited_doctors]()
                self.visitedDoctorsTable.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getVisitedhDoctorList(){
        self.presenter?.HITAPI(api: Base.searchDoctors.rawValue, params: nil, methodType: .GET, modelClass: DoctorsListModel.self, token: true)
    }
    
}

