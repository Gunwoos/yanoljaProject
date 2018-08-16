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

final class LocationInfo: MKPointAnnotation{
    var fensionTitle : String!
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
class SearchViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var LocationInfoView: UIView!
    
    @IBOutlet private weak var PensionListTable: UITableView!
    
    @IBOutlet private weak var PensionLocation: UILabel!
    @IBOutlet private weak var PensionName: UILabel!
    @IBOutlet private weak var PensionRoomOfNum: UILabel!
    @IBOutlet private weak var PensionPrice: UILabel!
    
    @IBOutlet private weak var pensionListButton: UIButton!
    
    
    private let LocationAnnotationID = "LocationAnnotationViewIdentifier"
    private var mapViewLevel = 2
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetPensionListButton()
        addLocationAnnotations(mapViewLevel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func addLocationAnnotations(_ checkMapViewLevel : Int){
        
        if checkMapViewLevel == 0{
            //37.841819, 127.536392
            let newLocation = LocationInfo()
            newLocation.title = "sample"
            newLocation.coordinate = CLLocationCoordinate2DMake(37.841819, 127.536392)
            //37.624683, 126.386889
            let newLocation2 = LocationInfo()
            newLocation2.title = "sample"
            newLocation2.coordinate = CLLocationCoordinate2DMake(37.624683, 126.386889)
            // 37.807951, 128.902604
            let newLocation3 = LocationInfo()
            newLocation3.title = "sample"
            newLocation3.coordinate = CLLocationCoordinate2DMake(37.807951, 128.902604)
            
            mapView.addAnnotation(newLocation)
            mapView.addAnnotation(newLocation2)
            mapView.addAnnotation(newLocation3)
            
        }
        else if checkMapViewLevel == 1{
            removeMK()
        }
        else{
            removeMK()
            let newLocation = LocationInfo()
            newLocation.title = "3"
            newLocation.coordinate = CLLocationCoordinate2DMake(37.841819, 127.536392)
            
            mapView.addAnnotation(newLocation)
        }
    }
    
    func removeMK(){
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func SetPensionListButton(){
        pensionListButton.center.x = self.view.frame.midX
        pensionListButton.center.y = self.view.frame.maxY - 110
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
//                    self.pensionListButton.titleLabel?.text = "목록"
            })
        }
    }
    
    func setPensionInfo(_ sender: MKAnnotationView){
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
    }
    
}

extension SearchViewController: MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // 여기서 체크
        print(mapView.centerCoordinate)
        print(mapView.region.span)
        if mapView.region.span.latitudeDelta > 3 && mapView.region.span.longitudeDelta > 3{
            mapViewLevel = 2
            addLocationAnnotations(mapViewLevel)
            print("mapViewLevel : \(mapViewLevel)")
            
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
        guard mapViewLevel == 0 else { return }
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
                        self.pensionListButton.center.y = self.view.frame.midY + 100
                })
        },
            completion: { _ in
                self.setPensionInfo(view)
                if self.LocationInfoView.isHidden == true{
                    self.LocationInfoView.isHidden = false
                }
                else{
                    self.LocationInfoView.isHidden = true
                }
        })
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("mapView count : \(mapView.annotations.count)")
        return mapView.annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchViewCell
        cell.pensionImageView.image = #imageLiteral(resourceName: "Kermit_Muppets")
        cell.pensionImageView.contentMode = .scaleToFill
        cell.pensionLocation.text = "Pension Location"
        cell.pensionName.text = "Pension Name"
        cell.pensionRoomOfNub.text = "예약 가능한 객실 2개"
        cell.pensionPrice.text = "Pension Price"
        
        return cell
    }
}