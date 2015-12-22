<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="paper_write01.aspx.cs" Inherits="BTCDProject.paper_write01" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="calendar.css" />
    <link rel="stylesheet" type="text/css" href="common.css" />
    <title></title>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
   
     <%-- 맵 스크립트--%>
    <script src="https://apis.daum.net/maps/maps3.js?apikey=f333e298a02ed205a65a9b5858c36d21&libraries=services"></script>
    <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=79fff6a6-68dd-39f1-a694-e99ed450544a"></script>
   
     <script>
        $(document).ready(function () {
            $("#cal_Date1").datepicker({
                showOn: 'button',
                    //buttonText: 'Show Date',
                    buttonImageOnly: true,
                    buttonImage: 'img/calendar.png',
                    dateFormat: 'yy/mm/dd',
                    constrainInput: true
            });
            $(".ui-datepicker-trigger").mouseover(function () {
                $(this).css('cursor', 'pointer');
            });
            $("#cal_Date2").datepicker({
                showOn: 'button',
                //buttonText: 'Show Date',
                buttonImageOnly: true,
                buttonImage: 'img/calendar.png',
                dateFormat: 'yy/mm/dd',
                constrainInput: true
            });
            $(".ui-datepicker-trigger").mouseover(function () {
                $(this).css('cursor', 'pointer');
            });
            window.onbeforeunload = function() {
                return "페이지를 벗어나시곘습니까?";
            }

            $("#keyword").on("keydown", function (e) {
                if (e.keyCode == 13) {
                    //alert(e.keyCode);
                    e.preventDefault();
                    searchPlaces();
                    return false;
                }
            })
            $("form#form1").on("submit", function (e) {
                window.onbeforeunload = null;
            })

            $("#carCck").click(function () {
                var state = $('#map').css('display');
                var state2 = $('#menu_wrap').css('display');
                if (state && state2 == 'none') { // state가 none 상태일경우 
                    $('#map').show();
                    $('#menu_wrap').show(); // ID가 menu_wrap인 요소를 show();
                    $('.select_result2').show();
                    $('.under_text').show();

                    
                } else { // 그 외에는
                    $('#map').hide();
                    $('#menu_wrap').hide();// ID가 menu_wrap인 요소를 hide();    
                    $('.select_result2').hide();
                    $('.under_text').hide();
                }
            });

            $("#reset").click(reset);

        });
        function reset() {
            flag_reset = false;
            console.log(flag_reset);

            count = 0;
            sum_dis = 0;
            sum_fare = 0;
            sum_time = 0;
            total_pay = 0;

            for (var i = 0; i < resultDis.length; i++) {
                resultDis[i] = 0;
                resultFare[i] = 0;
            }

            console.log(count + ", " + sum_dis + ", " + sum_fare + ", " + sum_time);
            flag_reset = true;

            document.getElementById("start").value = "";
            document.getElementById("mid_loc1").value = "";
            document.getElementById("mid_loc2").value = "";
            document.getElementById("mid_loc3").value = "";
            document.getElementById("mid_loc4").value = "";
            document.getElementById("mid_loc5").value = "";
            document.getElementById("departure").value = "";
            document.getElementById("mid_dis1").value = " Km";
            document.getElementById("mid_dis2").value = " Km";
            document.getElementById("mid_dis3").value = " Km";
            document.getElementById("mid_dis4").value = " Km";
            document.getElementById("mid_dis5").value = " Km";
            document.getElementById("total_dis2").value = " Km";
            document.getElementById("pay_memo").value = "";
            document.getElementById("pay_trans1").value = "";
            document.getElementById("pay_toll1").value = "";

        }

    </script>
    
</head>
<body>
    <form id="form1" runat="server" >
        <div id="Container">
            <div class="headerwrap">
                <div class="Top_bar">
                    <a href="" class="com_logo"></a>
                    <div id="status">
                        <asp:Button ID="logoutBtn" Text="로그아웃" runat="server" CssClass="out_btn" />
                        <asp:Label CssClass="idLbl" Text="&nbsp;님&nbsp;|&nbsp;" runat="server"></asp:Label><asp:Label ID="userLbl" CssClass="idLbl" Text="송슬기" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="navimenu">
                <div class="menu_title">
                    <a href="" class="write_icon"></a>
                    <a href="./list.aspx" class="list_icon"></a>
                </div>
            </div>
            <div class="contentBox">
                <div class="content">
                    <div class="content_title">출 장 명 령 서</div>
                    <div class="content_att">
                        <div class="label">1. 출장 기간을 입력하세요.</div>
                        <div class="yearsearch">
                            <asp:TextBox ID="cal_Date1" CssClass="dateresult" runat="server"></asp:TextBox>
                        </div>
                        <span>~</span>
                        <div class="yearsearch">
                            <asp:TextBox ID="cal_Date2" CssClass="dateresult" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="content_att">
                        <div class="label">2.교통수단을 체크하세요.</div>
                        <div class="expense_select">
                            <asp:CheckBox ID="carCck" runat="server" /><span>자차</span>
                            <asp:CheckBox ID="trainCck" runat="server" /><span>기차</span>
                            <asp:CheckBox ID="busCck" runat="server" /><span>버스</span>
                            <asp:CheckBox ID="boatCck" runat="server" /><span>선박</span>
                            <asp:CheckBox ID="airCck" runat="server" /><span>항공</span>
                        </div>
                    </div>
                    <div class="content_att">
                        <div class="label">3. 출장지를 입력하세요.</div>
                            <div id="map"></div>
                            <div id="menu_wrap" class="bg_white">
                                <div class="option">
                                    <input type="text" value="남춘천역" id="keyword" class="search_text" onsubmit="return false;"/>
                                    <input type="button" value="검 색" class="searchbtn btnhover" onclick="searchPlaces();"/>
                                </div>
                                <hr />
                                <ul id="placesList"></ul>
                                <div id="pagination"></div>
                                <div id="tmap"></div>
                            </div>
                        <script src="https://apis.daum.net/maps/maps3.js?apikey=f333e298a02ed205a65a9b5858c36d21"></script>
                        <script type="text/javascript">
      
                            /*
                                좌표계
                                다음 : EPSG:4326
                                Tmap : EPSG:3857
                                 -> 다음에서 EPSG:4326의 형식인 좌표를 얻어와서 EPSG:3857(Tmap)으로 convert해서 
                                 경로 출력 및 거리계산 하는 함수에 파라미터로 넣어준다.
                            */

                            // 마커를 담을 배열입니다
                            var markers = [];
                            var count = 0;                  // 출발,도착을 확인 하기위한 count
                            var startX, startY;
                            var endX, endY;
                            var start_point, end_point;
                            var convert_x, convert_y;
                            var total_Dis, total_Fare, total_time;

                            var resultDis = new Array();
                            var resultFare = new Array();
                            var resultTime = new Array();

                            var sum_dis = 0;
                            var sum_fare = 0;
                            var sum_time = 0;
                            var total_pay = 0;

                            var mapT;

                            var flag_reset;

                            function initTmap() {
                                // 4560197.7989427,
                                centerLL = new Tmap.LonLat(14145677.4, 4511257.6);
                                mapT = new Tmap.Map({
                                    div: 'tmap',
                                    width: '80%',
                                    height: '600px',
                                    transitionEffect: "resize",
                                    animation: true
                                });

                                //mapT.events.register("click", null, onClickMap);
                                $("#tmap").hide();
                            };
                            initTmap();

                            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                                mapOption = {
                                    center: new daum.maps.LatLng(37.868950, 127.738227), // 지도의 중심좌표
                                    level: 4 // 지도의 확대 레벨
                                };

                            // 지도를 생성합니다    
                            var map = new daum.maps.Map(mapContainer, mapOption);

                            // 장소 검색 객체를 생성합니다
                            var ps = new daum.maps.services.Places();

                            // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
                            var infowindow = new daum.maps.InfoWindow({ zIndex: 1 });

                            // 키워드로 장소를 검색합니다
                            searchPlaces();

                            // 키워드 검색을 요청하는 함수입니다
                            var keyword;
                            var keywordS = new Array();

                            // 마커 title을 담기 위한 배열
                            var titleS = new Array();

                            function searchPlaces() {

                                keyword = document.getElementById('keyword').value;

                                //if (!keyword.replace(/^\s+|\s+$/g, '')) {

                                //}

                                if (!keyword) {
                                    //alert('키워드를 입력해주세요!');
                                    return false;
                                }

                                // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
                                console.log("● 검색 키워드 : " + keyword);

                                ps.keywordSearch(keyword, placesSearchCB);
                            }

                            // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
                            function placesSearchCB(status, data, pagination) {
                                if (status === daum.maps.services.Status.OK) {

                                    // 정상적으로 검색이 완료됐으면
                                    // 검색 목록과 마커를 표출합니다
                                    displayPlaces(data.places);

                                    // 페이지 번호를 표출합니다
                                    displayPagination(pagination);

                                } else if (status === daum.maps.services.Status.ZERO_RESULT) {
                                    alert('검색 결과가 존재하지 않습니다.');
                                    return;
                                } else if (status === daum.maps.services.Status.ERROR) {
                                    alert('검색 결과 중 오류가 발생했습니다.');
                                    return;
                                }
                            }

                            // 검색 결과 목록과 마커를 표출하는 함수입니다
                            function displayPlaces(places) {


                                var listEl = document.getElementById('placesList'),
                                menuEl = document.getElementById('menu_wrap'),
                                fragment = document.createDocumentFragment(),
                                bounds = new daum.maps.LatLngBounds(),
                                listStr = '';

                                // 검색 결과 목록에 추가된 항목들을 제거합니다
                                removeAllChildNods(listEl);

                                // 지도에 표시되고 있는 마커를 제거합니다
                                removeMarker();

                                for (var i = 0; i < places.length; i++) {

                                    // 마커를 생성하고 지도에 표시합니다
                                    var placePosition = new daum.maps.LatLng(places[i].latitude, places[i].longitude),
                                        marker = addMarker(placePosition, i),
                                        itemEl = getListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성합니다

                                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                                    // LatLngBounds 객체에 좌표를 추가합니다
                                    bounds.extend(placePosition);

                                    // 마커와 검색결과 항목에 mouseover 했을때
                                    // 해당 장소에 인포윈도우에 장소명을 표시합니다
                                    // mouseout 했을 때는 인포윈도우를 닫습니다
                                    (function (marker, title) {

                                        daum.maps.event.addListener(marker, 'mouseover', function () {
                                            displayInfowindow(marker, title);
                                        });

                                        daum.maps.event.addListener(marker, 'mouseout', function () {
                                            infowindow.close();
                                        });

                                        // 검색 list를 click 했을때
                                        itemEl.onmousedown = function () {
                                            displayInfowindow(marker, title);

                                            titleS.push(title);
                                            var message = '클릭한 위치의 위도는 ' + marker.getPosition().zb + ' 이고, ';
                                            message += '경도는 ' + marker.getPosition().Ab + ' 입니다';

                                            var cgMsg = '변환 위도 : ' + get3857LonLat(marker.getPosition().zb) + ' 이고, ';
                                            cgMsg += '경도는 ' + get3857LonLat(marker.getPosition().Ab) + ' 입니다';

                                            $("#result").html(message);

                                            // 출발점과 도착점 구분
                                            if (count % 2 == 0) {       // 출발점을 때의 좌표

                                                convert_X = get3857LonLat(marker.getPosition().zb);
                                                convert_Y = get3857LonLat(marker.getPosition().Ab);

                                                startX = convert_X.lon
                                                startY = convert_Y.lon;

                                                console.log("시작점 확인 :" + startX + ", " + startY);
                                            } else {                    // 도착점일 때의 좌표

                                                convert_X = get3857LonLat(marker.getPosition().zb);
                                                convert_Y = get3857LonLat(marker.getPosition().Ab);

                                                endX = convert_X.lon;
                                                endY = convert_Y.lon;

                                                console.log("도착점 확인 :" + endX + ", " + endY);
                                            }

                                            var routeFormat = new Tmap.Format.KML({ extractStyles: true, extractAttributes: true });

                                            var urlStr = "https://apis.skplanetx.com/tmap/routes?version=1&format=xml";
                                            urlStr += "&startX=" + startX;
                                            urlStr += "&startY=" + startY;
                                            urlStr += "&endX=" + endX;
                                            urlStr += "&endY=" + endY;
                                            urlStr += "&appKey=79fff6a6-68dd-39f1-a694-e99ed450544a";

                                            var prtcl = new Tmap.Protocol.HTTP({
                                                url: urlStr,
                                                format: routeFormat
                                            });

                                            var routeLayer = new Tmap.Layer.Vector("route", { protocol: prtcl, strategies: [new Tmap.Strategy.Fixed()] });
                                            var tdata = new Tmap.TData();

                                            routeLayer.events.register("loadend", routeLayer, onCompleteLoadGetDistanceLonLat);
                                            tdata.events.register("onComplete", tdata, onCompleteLoadGetDistanceLonLat);
                                            mapT.addLayer(routeLayer);

                                            console.log(titleS[count]);

                                            if (count == 0) {
                                                console.log("●출발지는 " + title + " 입니다");
                                                document.getElementById("start").value = title;
                                            }

                                            if (count >= 1) {
                                                if (confirm("도착지 입니까?")) {
                                                    console.log("●도착지는 " + title);
                                                    document.getElementById("departure").value = title;
                                                } else {
                                                    console.log("●경유지는 " + titleS[(count)]);

                                                    switch (count) {
                                                        case 1:
                                                            document.getElementById("mid_loc1").value = titleS[(count)];
                                                            break;
                                                        case 2:
                                                            document.getElementById("mid_loc2").value = titleS[(count)];
                                                            break;
                                                        case 3:
                                                            document.getElementById("mid_loc3").value = titleS[(count)];
                                                            break;
                                                    }
                                                }
                                            }
                                            count++;
                                            console.log("마우스 클릭 수 : " + count);
                                        }

                                        itemEl.onmouseover = function () {
                                            displayInfowindow(marker, title);
                                        };

                                        itemEl.onmouseout = function () {
                                            infowindow.close();
                                        };

                                        // 검색 마커 click 했을때
                                        daum.maps.event.addListener(marker, 'click', function () {

                                            displayInfowindow(marker, title);

                                            titleS.push(title);
                                            console.log(titleS);

                                            var message = '클릭한 위치의 위도는 ' + marker.getPosition().zb + ' 이고, ';
                                            message += '경도는 ' + marker.getPosition().Ab + ' 입니다';

                                            var cgMsg = '변환 위도 : ' + get3857LonLat(marker.getPosition().zb) + ' 이고, ';
                                            cgMsg += '경도는 ' + get3857LonLat(marker.getPosition().Ab) + ' 입니다';

                                            $("#result").html(message);

                                            // 출발점과 도착점 구분
                                            if (count % 2 == 0) {       // 출발점을 때의 좌표

                                                convert_X = get3857LonLat(marker.getPosition().zb);
                                                convert_Y = get3857LonLat(marker.getPosition().Ab);

                                                startX = convert_X.lon
                                                startY = convert_Y.lon;

                                                console.log("시작점 확인 :" + startX + ", " + startY);
                                            } else {                    // 도착점일 때의 좌표

                                                convert_X = get3857LonLat(marker.getPosition().zb);
                                                convert_Y = get3857LonLat(marker.getPosition().Ab);

                                                endX = convert_X.lon;
                                                endY = convert_Y.lon;

                                                console.log("도착점 확인 :" + endX + ", " + endY);
                                            }

                                            var routeFormat = new Tmap.Format.KML({ extractStyles: true, extractAttributes: true });

                                            var urlStr = "https://apis.skplanetx.com/tmap/routes?version=1&format=xml";
                                            urlStr += "&startX=" + startX;
                                            urlStr += "&startY=" + startY;
                                            urlStr += "&endX=" + endX;
                                            urlStr += "&endY=" + endY;
                                            urlStr += "&appKey=79fff6a6-68dd-39f1-a694-e99ed450544a";

                                            var prtcl = new Tmap.Protocol.HTTP({
                                                url: urlStr,
                                                format: routeFormat
                                            });

                                            var routeLayer = new Tmap.Layer.Vector("route", { protocol: prtcl, strategies: [new Tmap.Strategy.Fixed()] });
                                            var tdata = new Tmap.TData();

                                            routeLayer.events.register("loadend", routeLayer, onCompleteLoadGetDistanceLonLat);
                                            tdata.events.register("onComplete", tdata, onCompleteLoadGetDistanceLonLat);
                                            mapT.addLayer(routeLayer);

                                            //// keyword 도착,경유지 구분
                                            // 도착지와 경유지 구분을 위해 keyword 배열에 담기
                                            console.log(titleS[count]);

                                            if (count == 0) {
                                                console.log("●출발지는 " + title + " 입니다");
                                                document.getElementById("start").value = title;
                                            }

                                            if (count >= 1) {
                                                if (confirm("도착지 입니까?")) {
                                                    console.log("●도착지는 " + title);
                                                    document.getElementById("departure").value = title;
                                                } else {
                                                    console.log("●경유지는 " + titleS[(count)]);
                                                    //document.getElementById("mid_loc1").value = keywordS[(count)];
                                                    switch (count) {
                                                        case 1:
                                                            document.getElementById("mid_loc1").value = titleS[(count)];
                                                            break;
                                                        case 2:
                                                            document.getElementById("mid_loc2").value = titleS[(count)];
                                                            break;
                                                        case 3:
                                                            document.getElementById("mid_loc3").value = titleS[(count)];
                                                            break;
                                                    }
                                                }
                                            }
                                            count++;
                                            console.log("마우스 클릭 수 : " + count);
                                        });
                                    })(marker, places[i].title);
                                    fragment.appendChild(itemEl);
                                }

                                // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
                                listEl.appendChild(fragment);
                                menuEl.scrollTop = 0;

                                // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                                map.setBounds(bounds);
                            }

                            // 검색결과 항목을 Element로 반환하는 함수입니다
                            function getListItem(index, places) {

                                var el = document.createElement('li'),
                                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                                            '<div class="info">' +
                                            '   <h5>' + places.title + '</h5>';

                                if (places.newAddress) {
                                    itemStr += '    <span>' + places.newAddress + '</span>' +
                                                '   <span class="jibun gray">' + places.address + '</span>';
                                } else {
                                    itemStr += '    <span>' + places.address + '</span>';
                                }

                                itemStr += '  <span class="tel">' + places.phone + '</span>' +
                                          '</div>';

                                el.innerHTML = itemStr;
                                el.className = 'item';

                                return el;
                            }

                            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다

                            function addMarker(position, idx, title) {

                                var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                                     imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
                                     imgOptions = {
                                         spriteSize: new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
                                         spriteOrigin: new daum.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                                         offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                                     },
                                     markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                                         marker = new daum.maps.Marker({
                                             position: position, // 마커의 위치
                                             image: markerImage,
                                             map: map
                                         });

                                marker.setMap(map); // 지도 위에 마커를 표출합니다
                                markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                                return marker;
                            }

                            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
                            function removeMarker() {
                                for (var i = 0; i < markers.length; i++) {
                                    markers[i].setMap(null);
                                }
                                markers = [];
                            }

                            // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
                            function displayPagination(pagination) {
                                var paginationEl = document.getElementById('pagination'),
                                    fragment = document.createDocumentFragment(),
                                    i;

                                // 기존에 추가된 페이지번호를 삭제합니다
                                while (paginationEl.hasChildNodes()) {
                                    paginationEl.removeChild(paginationEl.lastChild);
                                }

                                for (i = 1; i <= pagination.last; i++) {
                                    var el = document.createElement('a');
                                    el.href = "#";
                                    el.innerHTML = i;

                                    if (i === pagination.current) {
                                        el.className = 'on';
                                    } else {
                                        el.onclick = (function (i) {
                                            return function () {
                                                pagination.gotoPage(i);
                                            }
                                        })(i);
                                    }
                                    fragment.appendChild(el);
                                }
                                paginationEl.appendChild(fragment);
                            }

                            // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
                            // 인포윈도우에 장소명을 표시합니다
                            function displayInfowindow(marker, title) {
                                var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

                                infowindow.setContent(content);
                                infowindow.open(map, marker);
                            }

                            // 검색결과 목록의 자식 Element를 제거하는 함수입니다
                            function removeAllChildNods(el) {
                                while (el.hasChildNodes()) {
                                    el.removeChild(el.lastChild);
                                }
                            }

                            // 지도를 클릭했을 때 evt 
                            daum.maps.event.addListener(map, 'click', function (mouseEvent) {

                                // 클릭한 위도, 경도 정보를 가져옵니다                                 
                                var latlng = mouseEvent.latLng;

                                var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
                                message += '경도는 ' + latlng.getLng() + ' 입니다';

                                var cgMsg = '변환 위도 : ' + get3857LonLat(latlng.getLng()) + ' 이고, ';
                                cgMsg += '경도는 ' + get3857LonLat(latlng.getLat()) + ' 입니다';

                                $("#result").html(message);

                                // 출발점과 도착점 구분
                                if (count % 2 == 0) {       // 출발점을 때의 좌표

                                    convert_X = get3857LonLat(latlng.getLng());
                                    convert_Y = get3857LonLat(latlng.getLat());

                                    startX = convert_X.lon
                                    startY = convert_Y.lon;

                                    console.log("시작점 확인 :" + startX + ", " + startY);
                                } else {                    // 도착점일 때의 좌표

                                    convert_X = get3857LonLat(latlng.getLng());
                                    convert_Y = get3857LonLat(latlng.getLat());

                                    endX = convert_X.lon;
                                    endY = convert_Y.lon;

                                    console.log("도착점 확인 :" + endX + ", " + endY);
                                }

                                var routeFormat = new Tmap.Format.KML({ extractStyles: true, extractAttributes: true });

                                var urlStr = "https://apis.skplanetx.com/tmap/routes?version=1&format=xml";
                                urlStr += "&startX=" + startX;
                                urlStr += "&startY=" + startY;
                                urlStr += "&endX=" + endX;
                                urlStr += "&endY=" + endY;
                                urlStr += "&appKey=79fff6a6-68dd-39f1-a694-e99ed450544a";

                                var prtcl = new Tmap.Protocol.HTTP({
                                    url: urlStr,
                                    format: routeFormat
                                });

                                var routeLayer = new Tmap.Layer.Vector("route", { protocol: prtcl, strategies: [new Tmap.Strategy.Fixed()] });
                                var tdata = new Tmap.TData();
                                //routeLayer.events.register("featuresadded", routeLayer, onDrawnFeatures);
                                routeLayer.events.register("loadend", routeLayer, onCompleteLoadGetDistanceLonLat);
                                tdata.events.register("onComplete", tdata, onCompleteLoadGetDistanceLonLat);
                                mapT.addLayer(routeLayer);

                                //// keyword 도착,경유지 구분
                                // 도착지와 경유지 구분을 위해 keyword 배열에 담기
                                keywordS.push(keyword);


                                if (count == 0) {
                                    console.log("●출발지는 " + keyword + " 입니다");
                                    document.getElementById("start").value = keyword;
                                }

                                if (count >= 1) {
                                    if (confirm("도착지 입니까?")) {
                                        console.log("●도착지는 " + keyword);
                                        document.getElementById("departure").value = keyword;
                                    } else {
                                        console.log("●경유지는 " + keywordS[(count)]);
                                        switch (count) {
                                            case 1:
                                                document.getElementById("mid_loc1").value = keywordS[(count)];
                                                break;
                                            case 2:
                                                document.getElementById("mid_loc2").value = keywordS[(count)];
                                                break;
                                            case 3:
                                                document.getElementById("mid_loc3").value = keywordS[(count)];
                                                break;
                                        }
                                    }
                                }

                                count++;
                                console.log("마우스 클릭 수 : " + count);

                            });

                            function loadGetDistanceLonLat(lonlat) {

                                var tData = new Tmap.TData();
                                var Address = tData.getAddressFromLonLat(lonlat, option);
                                console.log("loadGetDistanceLonLat");
                                console.log(jQuery(this.responseXML).find("coordinateInfocoordType").text());

                                console.log("loadGetDistanceLonLat");

                            }

                            function onCompleteLoadGetDistanceLonLat(o) {
                                console.log("onCompleteLoadGetDistanceLonLat_start");
                                var xml = $(this.responseXML);

                                /*
                                 sum_dis : 총 거리값
                                 sum_fare : 톨비 값
                                 sum_time : 총 이동시간
                                */

                                total_Dis = (($(o.response.priv.responseXML).find("totalDistance").text()) / 1000).toFixed(0);
                                total_Fare = $(o.response.priv.responseXML).find("totalFare").text();
                                total_time = (($(o.response.priv.responseXML).find("totalTime").text()) / 60).toFixed(0);

                                resultDis.push(total_Dis);
                                resultFare.push(total_Fare);
                                resultTime.push(total_time);

                                console.log(resultDis);

                                sum_dis += Number(resultDis[resultDis.length - 1]);
                                sum_fare += Number(resultFare[resultFare.length - 1]);
                                sum_time += Number(resultTime[resultTime.length - 1]);

                                // 교통운임 = (거리 * 휘발유)/연비
                                total_pay = ((sum_dis * 1400) / 10).toFixed(0);

                                // data textbox에 넣기

                                if (count >= 2) {
                                    var hour;
                                    console.log("●이동거리 : " + sum_dis + "km");
                                    console.log("●총 통행료 : " + sum_fare + "원");

                                    if (sum_time > 60) {

                                        hour = parseInt(sum_time / 60);
                                        sum_time = parseInt(sum_time % 60);
                                        console.log("●총 이동시간 : " + hour + "시간 " + sum_time + "분");

                                    } else
                                        console.log("●총 이동시간 : " + sum_time + "분");
                                }

                                var city_do = jQuery(this.responseXML).find("coordinateInfocity_do").text();
                                var gu_gun = jQuery(this.responseXML).find("coordinateInfogu_gun").text();
                                // var label = new Tmap.Label("&nbsp;주소 : " + city_do + " " + gu_gun + " " + legalDong + " " + bunji);

                                var pay_memo = "(ℓ당 1400원 x " + sum_dis + " ) / 10(평균연비) = " + total_pay;

                                // 경유지들 dis text box에 넣기
                                document.getElementById("pay_trans1").value = total_pay;
                                document.getElementById("pay_toll1").value = sum_fare;
                                document.getElementById("total_dis2").value = sum_dis + " Km";
                                document.getElementById("pay_memo").value = pay_memo;

                                switch (count) {
                                    case 2: document.getElementById("mid_dis1").value = resultDis[count - 1]+" Km";
                                        break;
                                    case 3: document.getElementById("mid_dis2").value = resultDis[count - 1] + " Km";
                                        break;
                                    case 4: document.getElementById("mid_dis3").value = resultDis[count - 1] + " Km";
                                        break;
                                    case 5: document.getElementById("mid_dis4").value = resultDis[count - 1] + " Km";
                                        break;
                                    case 5: document.getElementById("mid_dis5").value = resultDis[count - 1] + " Km";
                                        break;
                                }
                                console.log("onCompleteLoadGetDistanceLonLat_end");
                            }

                            function onLoadSuccess() {
                                var totalDistance = this.loadGetDistanceLonLat();

                                console.log("onLoadSuccess");
                            }

                            // 좌표계 변환 부분

                            var pr_3857 = new Tmap.Projection("EPSG:3857");
                            var pr_4326 = new Tmap.Projection("EPSG:4326");

                            function get3857LonLat(coordX, coordY) {
                                return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
                            }

                            function get4326LonLat(coordX, coordY) {
                                return new Tmap.LonLat(coordX, coordY).transform(pr_3857, pr_4326);
                            }



                        </script>
                        <div class="map_result">
                            <div class="expensewrap">
                                <div class="select_result">
                                    <div class="label">출발</div>
                                    <div class="label">경유</div>
                                    <div class="label">경유</div>
                                    <div class="label">경유</div>
                                    <div class="label">경유</div>
                                    <div class="label">경유</div>
                                    <div class="label">도착</div>
                                </div>
                                <div class="select_result">
                                    <asp:TextBox ID="start" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="mid_loc1" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="mid_loc2" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="mid_loc3" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="mid_loc4" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="mid_loc5" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="departure" runat="server"></asp:TextBox>
                                </div>
                                <div class="select_result2">
                                    <asp:TextBox ID="start_dis" runat="server" CssClass="under_text" value="자차이용"></asp:TextBox>
                                    <asp:TextBox ID="mid_dis1" runat="server" CssClass="under_text" value="Km"></asp:TextBox>
                                    <asp:TextBox ID="mid_dis2" runat="server" CssClass="under_text" value="Km"></asp:TextBox>
                                    <asp:TextBox ID="mid_dis3" runat="server" CssClass="under_text" value="Km"></asp:TextBox>
                                    <asp:TextBox ID="mid_dis4" runat="server" CssClass="under_text" value="Km"></asp:TextBox>
                                    <asp:TextBox ID="mid_dis5" runat="server" CssClass="under_text" value="Km"></asp:TextBox>
                                    <asp:TextBox ID="total_dis2" runat="server" CssClass="under_text" value="Km"></asp:TextBox>
                                    <asp:Label ID="pay_memoL" runat="server" CssClass="pay_memoL">*교통운임 공식</asp:Label>
                                    <asp:TextBox ID="pay_memo" runat="server" CssClass="under_text pay_memoC"></asp:TextBox>
                                    <input type="button" value="초기화" id="reset"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="content_att">
                        <div class="label">4. 여비 항목을 입력하세요. (동승자가 있을 경우 추가 입력 가능.) </div>
                        <div class="expensewrap">
                            <div class="select_result">
                                <div class="label">이름</div>
                                <div class="label">직급</div>
                                <div class="label">교통운임</div>
                                <div class="label">통행료</div>
                                <div class="label">숙박비</div>
                                <div class="label">식비</div>
                                <div class="label">일비</div>
                            </div>
                            <div class="select_result">
                                <asp:TextBox ID="user_name1" runat="server"></asp:TextBox>
                                <asp:TextBox ID="position1" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_trans1" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_toll1" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_room1" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_food1" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_work1" runat="server"></asp:TextBox>
                            </div>
                            <div class="select_result">
                                <asp:TextBox ID="user_name2" runat="server"></asp:TextBox>
                                <asp:TextBox ID="position2" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_trans2" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_toll2" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_room2" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_food2" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_work2" runat="server"></asp:TextBox>
                            </div>
                            <div class="select_result">
                                <asp:TextBox ID="user_name3" runat="server"></asp:TextBox>
                                <asp:TextBox ID="position3" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_trans3" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_toll3" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_room3" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_food3" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_work3" runat="server"></asp:TextBox>
                            </div>
                            <div class="select_result">
                                <asp:TextBox ID="user_name4" runat="server"></asp:TextBox>
                                <asp:TextBox ID="position4" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_trans4" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_toll4" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_room4" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_food4" runat="server"></asp:TextBox>
                                <asp:TextBox ID="pay_work4" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="content_att">
                        <div class="label">5. 영수증을 체크하세요.</div>
                        <div class="expense_select">
                            <asp:CheckBox ID="card_bill" runat="server" /><span>신용카드 영수증</span>
                            <asp:CheckBox ID="toll_bill" runat="server" /><span>통행료 영수증</span>
                            <asp:CheckBox ID="transe_bill" runat="server" /><span>기차/버스/선박/항공기 영수증</span>
                            <asp:CheckBox ID="etc_bill" runat="server" /><span>기타 영수증</span>
                        </div>
                        <%--<div class="bill_upload">
                            <asp:FileUpload ID="billload1" runat="server" />
                            <asp:FileUpload ID="billload2" runat="server" />
                            <asp:FileUpload ID="billload3" runat="server" />
                            <asp:FileUpload ID="billload4" runat="server" />
                            <asp:FileUpload ID="billload5" runat="server" />
                        </div>--%>
                    </div>
                </div>
                <div class="bottom_btn">
                    <asp:Button ID="save" runat="server" Text="등록" CssClass="save_btn btnhover" OnClick="save_Click" />
                    <asp:Button ID="cancel" runat="server" Text="취소" CssClass="cancel_btn btnhover" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
