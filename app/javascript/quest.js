function initMap() {

  let marker = [];
  let jdata = JSON.parse(gon.json);
  let infoWindow = [];
  yuusya_img = gon.yuusya_img
  
  // 初期位置
  const Tokyo = { lat: 35.681427904704975, lng: 139.76717844133614 };
  map = new google.maps.Map(document.getElementById("map"), {
    zoom: 12,
    center: Tokyo,
    disableDefaultUI: true,
    gestureHandling: 'greedy',
  });

map.controls[google.maps.ControlPosition.BOTTOM].push(document.getElementById('bar2'));
map.controls[google.maps.ControlPosition.TOP_RIGHT].push(document.getElementById('bar3'));
  // 投稿データをマーカーに代入する
  for (var i = 0; i < jdata.length; i++) {
    // 投稿ごとの緯度経度
    markerLatLng = {lat: parseFloat(jdata[i]['latitude']), lng: parseFloat(jdata[i]['longitude'])};
    // マーカーに投稿ごとの緯度経度を代入
    marker[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map,
      icon: new google.maps.MarkerImage(
        '/assets/icon2.png',
        new google.maps.Size(100,100),
      ),
    });
    // 情報ウィンドウには投稿情報モーダルへのリンクを入れる
    infoWindow[i] = new google.maps.InfoWindow({
      content: '<div class=show-btn>'+'<h2 class="font-bold text-lg">'+jdata[i]["title"]+'</h2>'+'<label for="my-modal-'+jdata[i]["id"]+'" class="btn btn-warning modal-button-'+jdata[i]["id"]+' mb-4 w-full">詳細をみる</label>'+'</div>'
    });
    // マーカー毎にクリックイベントを追加
    markerEvent(i);
  }

  // マーカーがクリックされたら投稿情報へのリンクを表示させる
  function markerEvent(i) {
    marker[i].addListener('click', function() { // マーカーをクリックしたとき
      infoWindow[i].open(map, marker[i]); // 吹き出しの表示
    });
  }
};

  function getCurrent(){
  // 現在位置が取得できるとき初期位置に設定
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        //　現在位置を取得
        currentPosition = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
        // 現在位置は黄色の丸マーク
        let currentMarker = new google.maps.Marker({
        position: currentPosition,
        map: map,
          icon: new google.maps.MarkerImage(
          yuusya_img,
          ),
        });
        // 現在位置はクリックすると消えるようにする
        currentMarker.addListener("click", () => {
          currentMarker.setMap(null);
        });
        // 現在位置は中央にセット
        map.setCenter(currentPosition);
      },
      () => {
        handleLocationError(true, infoWindow, map.getCenter());
      }
    );
  } else {
    // ブラウザがGPSをサポートしていなかった場合
    handleLocationError(false, infoWindow, map.getCenter());
  }
};
// 現在位置とスタンプの距離をはかる
function calculateDistance(latlng,id){
  latlng_arr = latlng.split(',');

  let stampPosition = {
        lat: parseFloat(latlng_arr[0]),
        lng: parseFloat(latlng_arr[1]),
      };

  let calculateBtnId = id
  let stampBtnId = id + "-stamp";
  let stampValidate = document.querySelectorAll('.stamp_validate')
  let undefinedValidate = document.querySelectorAll('.undefined_validate')
  let calculateBtn = document.getElementById(calculateBtnId);
  let stampBtn = document.getElementById(stampBtnId);

  if ( typeof currentPosition !== 'undefined') {
    let distance = google.maps.geometry.spherical.computeDistanceBetween(currentPosition, stampPosition);
    if (distance <= 50.0) {
      calculateBtn.setAttribute("disabled", true);
      stampBtn.removeAttribute("disabled");
    } else {
      stampValidate.forEach(function (element) {
        element.classList.remove("disable");
      });
    };    
  } else {
    undefinedValidate.forEach(function (element) {
      element.classList.remove("disable");
    });
  }
};

function closeValidate(){
  let stampValidate = document.querySelectorAll('.stamp_validate')
  stampValidate.forEach(function (element) {
    element.classList.add("disable");
  });
}

function closeUndefined(){
  let undefinedValidate = document.querySelectorAll('.undefined_validate')
  undefinedValidate.forEach(function (element) {
    element.classList.add("disable");
  });
}