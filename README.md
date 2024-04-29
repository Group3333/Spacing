# Spacing
![Static Badge](https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white)
![logo](https://github.com/Group3333/Spacing/assets/12388297/218684f2-4b7b-4ab2-9615-e81249c65021)
---
## 설명 :

다양한 종류의 장소를 쉽게 대여하고 등록할 수 있는 iOS 어플리케이션

---
## 실제 작동화면  
|![스크린샷 2024-04-27 14 45 36](https://github.com/Group3333/Spacing/assets/12388297/e71cc2a0-31db-48e6-92a9-cc013e2db47a) | ![스크린샷 2024-04-27 14 46 04](https://github.com/Group3333/Spacing/assets/12388297/d04ec480-5eca-4ac3-9798-184022cf4bee) |![스크린샷 2024-04-27 14 46 30](https://github.com/Group3333/Spacing/assets/12388297/6552ca50-b043-4115-9fdf-d6bff9eb4984)|
|---|---|---|

|![스크린샷 2024-04-27 14 46 20](https://github.com/Group3333/Spacing/assets/12388297/65dbd108-205b-436c-a33c-3573a1e09629)  |![스크린샷 2024-04-27 14 46 32](https://github.com/Group3333/Spacing/assets/12388297/4352d9f4-5e88-4f82-abad-bec3710054ce)|![스크린샷 2024-04-27 14 46 35](https://github.com/Group3333/Spacing/assets/12388297/fc88e6b4-27a7-4741-8e60-c6eadeb8eff2)|
|---|---|---|

---

### MVC 정의

|ViewController|용도|Model|용도|
|---|---|---|---|
|**ViewController**|시작 로그인 화면|**User**|사용자 정보 저장 (이름, 이메일, 프로필 이미지, 등등)|
|**SignUpViewController**| 회원가입 화면|**LoginUser**|로그인 하는 사용자 정보 저장 (UserDefault용)|
|**MapViewController**|지도화면 및 앱 메인 화면|**Place**| 장소 정보 저장 (주소, 이름, 이미지, 좌표, 가격 등등)|
|**MyPageViewController**|마이페이지 화면|**BookPlace**|예약내역 정보 저장 (Place, 가격 및 시간)|
|**DetailViewController**|장소 세부 화면|**Address**|지도 마커 표시위한 좌표 저장(GeoCoder API 받기용)|
|**PlaceViewController**|장소 검색 화면 (검색, 즐겨찾기, 등록한 장소 같은 화면)|**MyPageMenu**|마이 페이지 메뉴 저장|
|**AddPlaceViewController**|잠소 추가 및 수정 화면|---|---|




---
### 개발 기능 정리:
#### 사용한 외부 API, 라이브러리, SDK, 등
- [네이버 지도 SDK](https://navermaps.github.io/ios-map-sdk/guide-ko/0.html)
- [네이버 GeoCoder](https://navermaps.github.io/maps.js.ncp/docs/tutorial-Geocoder-Geocoding.html)
- [SnapKit](https://github.com/SnapKit/SnapKit) (5.7.1)
- [Alamofire](https://github.com/Alamofire/Alamofire) (5.9.1)
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager) (7.0.2)
- [Kakao-PostCode](https://postcode.map.daum.net/guide) 


### 겪었던 문제점 및 소감 :
- API 사용하는것에는 큰 문제가 없었던 것 같습니다. 처음에는 Alamofire를 사용했는데, 과제 제한사항에 URLSession만 사용해서 구현을 하라는걸 나중에 봐서, 다시 변경을 했습니다. 
- CoreData를 사용하는게 이번이 처음이라서 과제로 사용하기 전에 먼저 연습으로 구현을 계속 해봤습니다. 
    - NSManagedObjectModel, NSManagedObjectContext, NSPersistentStoreCoordinator 그리고 NSPersistentContainer에 대해서 충분히 공부를 하고 진행했습니다. 
- 다른 과제의 대한 피드백이 대체적으로 가독성의 관한 피드백이 많아서, 해당 과제에서는 가능한 가독성과 사용성 면에서 신경을 써서, 모듈화 할 수 있는 코드는 모듈화를 하고, 데이터는 무조건 모델에서만 추가, 변경을 하게끔 하도록 변경했습니다. 
- 추후에는 CoreData 프레임워크가 아닌 다른 데이터베이스를 사용해서 과제를 진행해보면 좋겠다는 생각을 했습니다.  

## 담당 파트
|ProfileImageSelectViewr|AddPlaceViewController|PHPicker|
|---|---|---|
|![](https://velog.velcdn.com/images/sam98528/post/cffedb1a-5c59-4a82-a37c-923632804e03/image.png)|![](https://velog.velcdn.com/images/sam98528/post/4ddc7f35-0f98-4fae-89d7-bb7b79a691b3/image.png)|![](https://velog.velcdn.com/images/sam98528/post/483b84bc-3164-424a-8888-7a1843bfc0f3/image.png)|

---

### ProfileImageSelectViewController
- 프로필이미지를 제공해주기 위해서 전체 View를 다 보여주는것 보다는, 조금만 보여주는것이 좋을꺼 같다는 생각이 들었는데, 마침 팀원 중에서 HalfModalPResentController를 구현을 해주셔서, 해당 UIPresentationController를 받아와서 나의 View를 만들고 구현을 했습니다.
- 이미지는 CollectionView로 구현했습니다. 

### AddPlaceViewController
- 해당 VC는 새로운 장소를 등록하거나 기존 장소를 수정할때 사용하는 VC입니다. Collectionview를 이용해서 장소 이미지를 등록하고, 밑에 말할 PHPicker를 이용해서 사용자 앨범에서 사진을 불러와서 저장합니다. 그리고 주소검색 버튼을 누르게 되면 KakaoPostCodeViewController를 호출하게 되는데, 해당 VC는 WEBView를 띄워주는 VC입니다. 
- WebView가 필요했던 이유는 카카오 우편번호 검색 서비스를 사용하기 위해서 입니다. 그 이유는 지도에서 마커를 하기 위해서는 좌표가 필요했고, 사용자가 임의로 주소를 입력했을때 정확한 좌표가 뜨지 않을 수 있기 때문에, 정확한 주소를 받기 위해 카카오 우편번호 검색 서비스를 사용했습니다. 
- WebView에서 사용되는 Web은 Github Page를 통해 카카오 우편번호 검색 서비스를 구현을 해서 서버처럼 사용을 했습니다. 해당 기능은 직접 구현을 하지는 않았고, 블로그를 참고해서 구현했습니다. 
- 카카오 우편번호 검색 서비스에서 데이터를 보내주면, 해당 데이터를 받아서 장소 정보의 등록을 하게 됩니다.
- 그리고 최종적으로 등록을 하는 시점에서 해당 주소롤 GeoCoder API를 호출해서 좌표를 받아서 저장을 하게 됩니다. 

### PHPicker
- 원래는 사용자 프로필 이미지를 앨범에서 선택할 수 있는 기능으로 구현하려고 했지만, 내부 저장소 저장의 문제 때문에 해당 기능을 새로운 장소 등록할때 장소 이미지로 사용했습니다. 
- PHPicker는 PhotosUI에서 제공되는 아주 좋은 기능으로, 간편하게 사용자의 앨범에서 사진을 로드해올 수 있다. PHPicker이전에는 사용자의 앨범을 접근하기 위한 권한을 설정을 해줘야했지만, PHPicker는 사용자가 선택한 사진의 대한 접근을 하기 떄문에 접근 권한을 따로 할 필요가 없는것으로 알고 있다.
- 사진을 최대 몇장을 받아오고, 받아오고 처리하는 방식까지 구현을 해서 사용했습니다.
- PHPickerViewControlerDelegate를 사용하면 Picker: Didfinishpicking 함수를 사용하면 간편하게 사진을 불러올수 있다. 하지만 사진이기 때문에 용량이 클 수도 있기 떄문에, DisPatchQueue.main.async를 사용해야 합니다.

|MyPageViewController|PlaceViewController|DetailViewController|
|---|---|---|
|![](https://velog.velcdn.com/images/sam98528/post/b11cca62-88b3-466f-aef4-685560680b62/image.png) |![스크린샷 2024-04-27 14 46 30](https://github.com/Group3333/Spacing/assets/12388297/6552ca50-b043-4115-9fdf-d6bff9eb4984)|![](https://velog.velcdn.com/images/sam98528/post/ee5ef5c0-ab46-4f53-b2f4-747290ea5df2/image.png)|

### MyPageViewController
- 저는 우선 마이페이지 파트를 맡게 되었습니다.
- 마이 페이지에는 아래와 같은 기능을 구현했습니다.
    - 사용자 정보 보여주기
    - 프로필 이미지 변경
    - 즐겨찾기 / 등록 / 이용한 장소 확인
    - 로그아웃
    - 새로운 장소 등록
- 마이페이지를 처음에는 더 추가적인 기능을 구현할 수 있다고 생각해서, MyPageMenu 구조체를 생성해서, 해당 구조체에 데이터를 추가하면 자동으로 메뉴가 추가될 수 있도록 구현을 했지만, 시간적 제약 떄문에 실제로는 따로 추가한 기능은 없고 위에 말한 기능들이 전부입니다.
- 마이페이지는 TableView 하나로 구현을 했고, Section을 나눠서, 각각 세션별로 다른 메뉴를 추가 했습니다. 각각의 Section은 다른 TableViewCell를 사용해서 디자인을 다르게 했습니다. 
- **Section 0** 
    - 사용자 정보를 보여주는 Section입니다. 해당 Section은 사용자 프로필 이미지와 이름 그리고 이메일이 보이게끔 구현을 했습니다.
    - 추가적으로 프로필 이미지를 클릭하면 프로필 이미지를 변경할 수 있도록 추가했습니다. 
- **Section 1**
    - 이부분에서는 실질적으로 메뉴들을 나열하는 용도로 사용했습니다. 개인정보, 즐겨찾기, 등록된 Place, 이용내역 메뉴를 추가했습니다. 하지만 개인정보 페이지는 시간적 관계로 구현을 하지 못했습니다.
    - 즐겨찾기, 등록된 Place, 이용내역 페이지는 다 같은 ViewController로 연결되게끔 설정했습니다. 다만 데이터가 다르게끔 설정을 해서 ViewController를 재활용했습니다.
- **Section 2**
	- 해당 Section은 로그아웃 버튼을 구현했습니다. NavigationController로 Stack이 쌓아져있기 때문에, RootViewController 즉 로그인 화면으로 넘어가게끔 구현했습니다.
- TableView로 만든 제일 큰 이유는 Scrollview를 상속받기 때문이이었지만, 실질적으로는 Scrollview기능을 사용하지 못할 정도로 메뉴가 적어서 아쉬웠습니다. 

### PlaceViewController
- 해당 ViewController는 NavigationController에다가 SearchController를 추가하였으며, 그 아래는 각각 Collectionview, TableView를 사용했습니다. 
- SearchController에서 텍스트를 인식해서, 장소 이름, 위치를 확인해서 장소를 보여줍니다. 원래는 따로 ViewController를 추가해서 SearchResultViewController를 만들어줘야하지만, 그 과정은 아래에 있는 TableView를 통해 구현을 하였으며, SearchBarDelegate와 SearchControllerDelegate를 이용해서 실시간으로 바뀌는 TableView를 만들었습니다.
- CollectionView도 Place 구조체를 만들때 카테고리를 만들면 좋을꺼 같아서 Enum으로 만든거를 CaseIterable 을 채택해서 배열로 만들어서 Data를 만들었습니다.
- 각각의 테이블뷰를 클릭하면, 해당 장소의 세부 페이지로 넘어갑니다. 

### DetailViewController
- 이 파트는 원래는 제 파트가 아니었지만 팀원이 어려워하고 있어서 전체적인 틀을 잡아줬습니다.
- AutoLayout를 다들 어려워 하는 경향이 있어서 AutoLayout를 잡아줬습니다. 그리고 예약하기 기능 및 즐겨찾기 기능을 추가해서, 다른 VC에서도 해당 정보를 받을 수 있도록 구현했습니다.

---

|ProfileImageSelectViewController|AddPlaceViewController|PHPicker|MapViewController|
|---|---|---|---|
|![](https://velog.velcdn.com/images/sam98528/post/cffedb1a-5c59-4a82-a37c-923632804e03/image.png) |![](https://velog.velcdn.com/images/sam98528/post/4ddc7f35-0f98-4fae-89d7-bb7b79a691b3/image.png)|![](https://velog.velcdn.com/images/sam98528/post/483b84bc-3164-424a-8888-7a1843bfc0f3/image.png)|![](https://velog.velcdn.com/images/sam98528/post/93572d70-671f-4c63-8722-1c947d2792dc/image.png)


### ProfileImageSelectViewController
- 프로필이미지를 제공해주기 위해서 전체 View를 다 보여주는것 보다는, 조금만 보여주는것이 좋을꺼 같다는 생각이 들었는데, 마침 팀원 중에서 HalfModalPResentController를 구현을 해주셔서, 해당 UIPresentationController를 받아와서 나의 View를 만들고 구현을 했습니다.
- 이미지는 CollectionView로 구현했습니다. 

### AddPlaceViewController
- 해당 VC는 새로운 장소를 등록하거나 기존 장소를 수정할때 사용하는 VC입니다. Collectionview를 이용해서 장소 이미지를 등록하고, 밑에 말할 PHPicker를 이용해서 사용자 앨범에서 사진을 불러와서 저장합니다. 그리고 주소검색 버튼을 누르게 되면 KakaoPostCodeViewController를 호출하게 되는데, 해당 VC는 WEBView를 띄워주는 VC입니다. 
- WebView가 필요했던 이유는 카카오 우편번호 검색 서비스를 사용하기 위해서 입니다. 그 이유는 지도에서 마커를 하기 위해서는 좌표가 필요했고, 사용자가 임의로 주소를 입력했을때 정확한 좌표가 뜨지 않을 수 있기 때문에, 정확한 주소를 받기 위해 카카오 우편번호 검색 서비스를 사용했습니다. 
- WebView에서 사용되는 Web은 Github Page를 통해 카카오 우편번호 검색 서비스를 구현을 해서 서버처럼 사용을 했습니다. 해당 기능은 직접 구현을 하지는 않았고, 블로그를 참고해서 구현했습니다. 
- 카카오 우편번호 검색 서비스에서 데이터를 보내주면, 해당 데이터를 받아서 장소 정보의 등록을 하게 됩니다.
- 그리고 최종적으로 등록을 하는 시점에서 해당 주소롤 GeoCoder API를 호출해서 좌표를 받아서 저장을 하게 됩니다. 

### PHPicker
- 원래는 사용자 프로필 이미지를 앨범에서 선택할 수 있는 기능으로 구현하려고 했지만, 내부 저장소 저장의 문제 때문에 해당 기능을 새로운 장소 등록할때 장소 이미지로 사용했습니다. 
- PHPicker는 PhotosUI에서 제공되는 아주 좋은 기능으로, 간편하게 사용자의 앨범에서 사진을 로드해올 수 있다. PHPicker이전에는 사용자의 앨범을 접근하기 위한 권한을 설정을 해줘야했지만, PHPicker는 사용자가 선택한 사진의 대한 접근을 하기 떄문에 접근 권한을 따로 할 필요가 없는것으로 알고 있다.
- 사진을 최대 몇장을 받아오고, 받아오고 처리하는 방식까지 구현을 해서 사용했습니다.
- PHPickerViewControlerDelegate를 사용하면 Picker: Didfinishpicking 함수를 사용하면 간편하게 사진을 불러올수 있다. 하지만 사진이기 때문에 용량이 클 수도 있기 떄문에, DisPatchQueue.main.async를 사용해야 합니다.

### MapViewController
- 실질적으로 네이버 SDK를 적용하는거는 팀원이 해주셨다. 지도를 띄우고 마커를 구현하고, 카메라를 움직이는 방식까지 팀원분이 먼저 구현을 해보고, 제가 해당 기능을 사용해서 추가적인 기능을 구현했습니다. 
- 각각의 마커는 앞서 저장한 좌표대로 표시가 실제 지도에 표시가 되게끔 구현했습니다.
- 아래 CollectionView는 PlaceViewController에서 사용했던 TableViewCell를 그대로 복사해서 CollectionviewCell로 변환해서 사용했습니다. 조금 정보를 뺴고 했지만, 기본적인 틀은 똑같습니다. 
- 제일 시간이 오래 걸렸던 부분은 CollectionView Paging 처리 였던것 같습니다. 양쪽 빈칸 때문에 페이징이 이상하게 보여지는 문제, 그리고 페이징을 하면 자동으로 해당 정보를 담고 있는 좌표로 이동을 해야했는데, 이부분이 제일 오랜 시간이 걸렸던것 같습니다. 
- 결과적으로는 아래 컬렉션뷰를 움직이면 카메라도 같이 움직여서 마커를 중심으로 카메라가 바뀝니다. 이기능도 네이버 SDK에서 제공되는 NMFCameraUpdate 기능으로 구현했습니다. 
- MapViewController는 스토리보드를 사용하지 않고 코드를 구현했기 때문에, 나머지도 전부다 코드로 구현을 했습니다.
- SearchBar는 원래는 SearchController를 사용하려고 했지만, 그러면 위에 여백이 너무 보기 싫어서, SearchBar를 Titleview에 넣어서 사용했으며, 실제로는 그냥 TextField기능이지만, 일단 사용했습니다. Searchbar에서 검색을 하면 PlaceVIewController로 가게됩니다. 
- 오른쪽 상단 버튼을 클릭하면 마이 페이지로 넘어가게 됩니다. 오른쪽 상단 버튼 , Searchbar는 전부 NavigationBar에 추가해서 구현했습니다.

## 소감
- 1주일 동안 정말 많은걸 구현을 했다고 생각합니다. 대부분은 반복적인 작업이라서 이제 슬슬 익숙해지고 있는것 같습니다.
- 그리고 이번 과제에서 제일 뿌듯한 부분은 하나의 ViewController, Cell를 계속 재활용해서 다른 용도로 사용한거였습니다. 매번 새로운 디자인을 하는게 정말 시간을 많이 잡아먹는데, 이렇게 재활용할 수 있게 만들어 놓으면 편하다는걸 다시 한번 느꼈습니다. 
- 다음 프로젝트에서는 최대한 오래 생각해서, 과제 초반에 데이터를 다같이 정하고 하는게 좋겠다는 생각을 했습니다. 구조체나 클래스의 프로퍼티 변경이 자주 일어나면 바꿔야할 부분이 계속 생겨서, 아니면 바뀌어도 되게끔 설정을 하면 좋겠다는 생각이 들었습니다.







