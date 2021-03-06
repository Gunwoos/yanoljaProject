//
//  SearchViewController.swift
//  yanolja
//
//  Created by 임건우 on 2018. 7. 30..
//  Copyright © 2018년 seob. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit


// MARK: - mapView 에 저장될 annotation 구조
final class LocationInfo: MKPointAnnotation{
    var pensionPk: Int!
    var pensionImageURL: String!
    var pensionPrice: String!
    var pensionDiscountRate: Int!
    var pensionRoomNum: Int!
    var pensionSubLocation: String!
}
/*
 서울 37.552498, 126.993661
 인천 37.456837, 126.700434
 강원도 37.817822, 128.170299
 충청북도 37.003812, 127.704601
 충청남도 36.714582, 126.799179
 전라북도 35.715135, 127.166081
 전라남도 34.848930, 126.947868
 경상북도 36.302479, 128.889278
 경상남도 35.462627, 128.217866
 제주도 33.414339, 126.806340
 */

class SearchViewController: BaseViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var LocationInfoView: UIView!
    
    @IBOutlet private weak var PensionListTable: UITableView!
    
    @IBOutlet private weak var PensionLocation: UILabel!
    @IBOutlet private weak var PensionName: UILabel!
    @IBOutlet private weak var PensionRoomOfNum: UILabel!
    @IBOutlet private weak var PensionPrice: UILabel!
    @IBOutlet private weak var PensionDprice: UILabel!
    @IBOutlet private weak var PensionDiscountRate: UILabel!
    @IBOutlet private weak var PensionImage: UIImageView!
    
    @IBOutlet private weak var pensionListButton: UIButton!
    
    
    private let LocationAnnotationID = "LocationAnnotationViewIdentifier"
    private var mapViewLevel = 2
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pensionListButton.layer.borderColor = UIColor.lightGray.cgColor
        pensionListButton.layer.borderWidth = 1
        SetPensionListButton()
        addLocationAnnotations(mapViewLevel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: mapView 에 mapViewLevel 에 따라 annotation 을 다르게 뿌려줌
    func addLocationAnnotations(_ checkMapViewLevel : Int){
        if checkMapViewLevel == 0{
            for i in 0...pensionData.count - 1{
                let newLocation = LocationInfo()
                newLocation.title = pensionData[i].pensionName
                newLocation.coordinate = CLLocationCoordinate2DMake(
                    pensionData[i].pensionLatitude,
                    pensionData[i].pensionLongitude
                )
                newLocation.pensionPk = pensionData[i].pensionPk
                newLocation.pensionImageURL = pensionData[i].pensionImage
                newLocation.pensionPrice = String(pensionData[i].pensionLowestPrice)
                newLocation.pensionDiscountRate = pensionData[i].pensionDiscountRate
                newLocation.pensionSubLocation = pensionData[i].pensionSubLocation
                
                mapView.addAnnotation(newLocation)
            }
        }
        else if checkMapViewLevel == 1{
            removeMK()
            for i in 0...pensionLocationData.count - 1{
                let newLocation = LocationInfo()
                newLocation.title = String(pensionLocationData[i].pensionOfNum)
                if pensionLocationData[i].name == "가평"{
                    newLocation.coordinate = CLLocationCoordinate2DMake(37.818750, 127.451799)
                }
                else if pensionLocationData[i].name == "경기"{
                    newLocation.coordinate = CLLocationCoordinate2DMake(37.294040, 127.155777)
                }
                else{
                    
                }
                mapView.addAnnotation(newLocation)
            }
        }
        else{
            removeMK()
            let newLocation = LocationInfo()
            newLocation.title = String(pensionNum)
            newLocation.coordinate = CLLocationCoordinate2DMake(37.841819, 127.536392)
            
            mapView.addAnnotation(newLocation)
        }
    }
    
    func removeMK(){
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func SetPensionListButton(){
        pensionListButton.center.x = self.view.frame.midX
        pensionListButton.center.y = self.view.frame.maxY - 70
        pensionListButton.backgroundColor = .white
        pensionListButton.layer.cornerRadius = 15
        
    }
    
    @IBAction func ShowPensionList(_ sender: UIButton) {
        if self.PensionListTable.isHidden == true{
            UIView.animateKeyframes(
                withDuration: 1.0,
                delay: 0.0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.25,
                        animations: {
                            self.PensionListTable.isHidden = false
                    })
            },
                completion: { _ in
                    self.pensionListButton.titleLabel?.text = "지도"
            })
        }
        else{
            UIView.animateKeyframes(
                withDuration: 1.0,
                delay: 0.0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.25,
                        animations: {
                            self.PensionListTable.isHidden = true
                    })
            },
                completion: { _ in
            })
        }
    }
    
    func setPensionInfo(_ sender: MKAnnotationView, _ mapView: MKMapView){
        let findLocation = CLLocation(latitude: (sender.annotation?.coordinate.latitude)!, longitude: (sender.annotation?.coordinate.longitude)!)
        let geocoder = CLGeocoder()
        let local = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (placemakers, error) in
            if let address: [CLPlacemark] = placemakers {
                if let name: String = address.last?.name {
                    print(name)
                    self.PensionLocation.text = name
                }
            }
        }
        self.PensionName.text = (sender.annotation?.title)!
        let price = (sender.annotation as? LocationInfo)?.pensionPrice!
        let discount = (sender.annotation as? LocationInfo)?.pensionDiscountRate!
        
        let nprice = Int(price!)! / 100 * discount!
        let dprice = Int(price!)! + nprice
        
        self.PensionPrice.text = "\(price!)원~"
        self.PensionDprice.text = "\(dprice)"
        self.PensionDiscountRate.text = "~\(discount!)%"
        
        self.PensionRoomOfNum.text = "예약가능한 객실 4개"
        
        let url = URL(string: ((sender.annotation as? LocationInfo)?.pensionImageURL)!)!
        print("\(url)")
        if let data = try? Data(contentsOf: url){
            self.PensionImage.image = UIImage(data: data)
        }
        else{
            self.PensionImage.image = UIImage(named: "bg02")
        }

    }
    
}

extension SearchViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // 여기서 체크
        print(mapView.centerCoordinate)
        print(mapView.region.span)
        if mapView.region.span.latitudeDelta > 3 && mapView.region.span.longitudeDelta > 3{
            mapViewLevel = 2
            addLocationAnnotations(mapViewLevel)
            print("mapViewLevel : \(mapViewLevel)")
            PensionListTable.reloadData()
            
        }
        else if mapView.region.span.latitudeDelta < 1 && mapView.region.span.longitudeDelta < 1{
            mapViewLevel = 0
            addLocationAnnotations(mapViewLevel)
            print("mapViewLevel : \(mapViewLevel)")
        }
        else{
            mapViewLevel = 1
            addLocationAnnotations(mapViewLevel)
            print("mapViewLevel : \(mapViewLevel)")
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is LocationInfo{
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: LocationAnnotationID)
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: LocationAnnotationID)
            }
            else{
                annotationView?.annotation = annotation
            }
            
            annotationView?.image = #imageLiteral(resourceName: "icon_pin")
            annotationView?.frame.size = CGSize(width: 50, height: 50)
            
            annotationView?.canShowCallout = true
            
            return annotationView
        }
        return MKAnnotationView(frame: .zero)
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if mapViewLevel == 0{
            let center = CLLocationCoordinate2D(
                latitude: (view.annotation?.coordinate.latitude)!,
                longitude: (view.annotation?.coordinate.longitude)!
            )
            let span = MKCoordinateSpan(
                latitudeDelta: mapView.region.span.latitudeDelta,
                longitudeDelta: mapView.region.span.longitudeDelta
            )
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
            
            UIView.animateKeyframes(
                withDuration: 1.0,
                delay: 0.0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.25,
                        animations: {
                            view.transform = view.transform.scaledBy(x: 1.5, y: 1.5)
                    })
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.75,
                        relativeDuration: 0.5,
                        animations: {
                            self.pensionListButton.center.y = self.view.frame.midY + 70
                    })
            },
                completion: { _ in
                    if self.LocationInfoView.isHidden == true{
                        self.LocationInfoView.isHidden = false
                        self.setPensionInfo(view, mapView)
                    }
                    else{
                        self.LocationInfoView.isHidden = true
                    }
            })
        }
        else if mapViewLevel == 1 {
            let center = CLLocationCoordinate2D(
                latitude: (view.annotation?.coordinate.latitude)!,
                longitude: (view.annotation?.coordinate.longitude)!
            )
            //            region.span.latitudeDelta
            
            let span = MKCoordinateSpan(
                latitudeDelta: 0.5,
                longitudeDelta: 0.5
            )
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
        }
        else if mapViewLevel == 2 {
            let center = CLLocationCoordinate2D(
                latitude: (view.annotation?.coordinate.latitude)!,
                longitude: (view.annotation?.coordinate.longitude)!
            )
            let span = MKCoordinateSpan(
                latitudeDelta: 1.5,
                longitudeDelta: 1.5
            )
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
        }
        else{
            return
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard mapViewLevel == 0 else { return }
        UIView.animateKeyframes(
            withDuration: 0.75,
            delay: 0.0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.25,
                    animations: {
                        self.LocationInfoView.center.y = self.view.frame.maxY + 100
                })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.25,
                    relativeDuration: 0.5,
                    animations: {
                        view.transform = CGAffineTransform.identity
                })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.75,
                    animations: {
                        self.pensionListButton.center.y = self.view.frame.maxY - 110
                })
        },
            completion: { _ in
                self.LocationInfoView.isHidden = true
        })
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        pensionDetailDataArray.removeAll()
        
        let idx = pensionData[row].pensionPk
        let sublocationNum = pensionData[row].pensionSubLocation
        
        m_appDelegate.m_pensionInfo.pk = idx
        m_appDelegate.m_pensionInfo.sublocation = sublocationNum
        
        //fetchPensionDetail(subLocation: sublocationNum, pk: idx)
        
        self.pushVC("PensionDetailViewController", storyboard: "Main", animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.rowHeight = 280
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mapViewLevel == 2{
            return pensionData.count
        }
        else if mapViewLevel == 1 {
            return pensionData.count
        }
        else if mapViewLevel == 0 {
            return pensionData.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchViewCell
        
        tableView.rowHeight = 300
        
        let url = URL(string: pensionData[indexPath.row].pensionImage)!
        if let data = try? Data(contentsOf: url){
            cell.pensionImageView.image = UIImage(data: data)
        }
        else{
            cell.pensionImageView.image = UIImage(named: "bg02")
        }
        
        cell.pensionImageView.contentMode = .scaleToFill
        cell.pensionLocation.text = pensionData[indexPath.row].pensionSubLocation
        let findLocation = CLLocation(
            latitude: pensionData[indexPath.row].pensionLatitude,
            longitude: pensionData[indexPath.row].pensionLongitude
        )
        let geocoder = CLGeocoder()
        let local = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (placemakers, error) in
            if let address: [CLPlacemark] = placemakers {
                if let name: String = address.last?.name {
                    cell.pensionLocation.text = name
                }
            }
        }
        cell.pensionLocation.textColor = UIColor.lightGray
        cell.pensionName.text = pensionData[indexPath.row].pensionName
        cell.pensionRoomOfNub.text = "예약가능한 객실 4개"
        cell.pensionRoomOfNub.textColor = UIColor.lightGray
        cell.pensionPrice.text = "\(pensionData[indexPath.row].pensionLowestPrice)~"
        let price = pensionData[indexPath.row].pensionLowestPrice
        let discount = pensionData[indexPath.row].pensionDiscountRate
        let nprice = price / 100 * discount
        let dprice = price + nprice
        cell.pensionPrice.text = "\(price)원~"
        cell.pensionDprice.text = "\(dprice)원"
        cell.pensionDiscountRate.text = "~\(discount)%"
        
        return cell
    }
}
