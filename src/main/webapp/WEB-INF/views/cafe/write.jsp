<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%@ include file="../include/head.jsp"%>


<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
</style>

<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->


<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap {
    position: relative;
    width: 50%;
    height: 350px;
    border: 1.5px solid;
    margin: 20px 0;
}

#category {
	position: absolute;
	top: 10px;
	left: 10px;
	border-radius: 5px;
	border: 1px solid #909090;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
	background: #fff;
	overflow: hidden;
	z-index: 2;
}

#category li {
	float: left;
	list-style: none;
	width: 50px; px;
	border-right: 1px solid #acacac;
	padding: 6px 0;
	text-align: center;
	cursor: pointer;
}

#category li.on {
	background: #eee;
}

#category li:hover {
	background: #ffe6e6;
	border-left: 1px solid #acacac;
	margin-left: -1px;
}

#category li:last-child {
	margin-right: 0;
	border-right: 0;
}

#category li span {
	display: block;
	margin: 0 auto 3px;
	width: 27px;
	height: 28px;
}

#category li .category_bg {
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
		no-repeat;
}

#category li .cafe {
	background-position: -10px -144px;
}

#category li.on .category_bg {
	background-position-x: -46px;
}

.placeinfo_wrap {
	position: absolute;
	bottom: 28px;
	left: -150px;
	width: 300px;
}

.placeinfo {
	position: relative;
	width: 100%;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
	background: #fff;
}

.placeinfo:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
	content: '';
	position: relative;
	margin-left: -12px;
	left: 50%;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
	color: #fff;
	text-decoration: none;
}

.placeinfo a, .placeinfo span {
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.placeinfo span {
	margin: 5px 5px 0 5px;
	cursor: default;
	font-size: 13px;
}

.placeinfo .title {
	font-weight: bold;
	font-size: 14px;
	border-radius: 6px 6px 0 0;
	margin: -1px -1px 0 -1px;
	padding: 10px;
	color: #fff;
	background: #d95050;
	background: #d95050
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.placeinfo .tel {
	color: #0f7833;
}

.placeinfo .jibun {
	color: #999;
	font-size: 11px;
	margin-top: 0;
}

.address-search label{
display: block;
}

.address-search input{
display: inline-block;
}

.addressbtn{
    background-color: #0c0c0c;
    box-shadow: none;
    border: 1px solid #0c0c0c;
    width: 100px;
    height: 35px;
    color: #fff;
    text-align: center;
    margin: 0 10px;
}

.form-control{
 width: 50%;
}

#content {
height: 300px;
}

</style>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@ include file="../include/main_header.jsp"%>
		<%@ include file="../include/footerjs.jsp"%>
		<script>
			$(document).ready(function() {
				$(".listBtn").on("click", function() {
					self.location = "/cafe/list";
				});
			});
		</script>
		<!--
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>동네의 카페를 소개 해 주세요!</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->

				<div class="col-lg-12">
					<form id="writeForm" method="POST" action="${path}/cafe/write">
						<div class="box box-primary">
							<div class="box-body">
								<div class="form-group address-search">
									<label for="locationAddr">카페 지역부터 먼저 검색해 주세요!</label> <input
										class="form-control" id="locationAddr" name="locationAddr" readonly>
									<input type="button" class="addressbtn" onclick="searchAddress()" value="주소 검색" ><br>

									<div class="map_wrap">
										<div id="map"
											style="width: auto; height: 100%; position: relative; overflow: hidden; display: none"></div>
										<ul id="category">
											<li id="CE7" data-order="4"><span
												class="category_bg cafe"></span> 카페</li>

										</ul>
									</div>

								</div>
								<div class="form-group">
									<label for="cafename">카페명</label> <input class="form-control"
										id="cafename" name="cafename" placeholder="카페명을 입력 해 주세요"
										readonly>
								</div>
								<div class="form-group">
									<label for="content">카페 소개</label>
									<textarea class="form-control" id="content" name="content"
										placeholder="내용을 입력해 주세요" style="resize: none;"></textarea>
								</div>
								<div class="form-group">
									<label for="writer">작성자</label> <input class="form-control"
										id="writer" name="writer" value="${login.uid}" readonly>
								</div>
								<div class="form-group">
									<label for="location">위치</label> <input class="form-control"
										id="location" name="location" readonly>
								</div>
								<input type="hidden" id="cimage" name="cimage"/>
								<div class="form-group">
									<div class="fileDrop">
										<br /> <br /> <br /> <br />
										<p>
											<i class="fa fa-paperclip"></i> 이미지를 드래그하여 등록해 주세요. 가장 먼저 등록한 이미지가 대표 이미지가 됩니다.
										</p>
									</div>
								</div>
							</div>

							<div class="box-footer">
								<ul class="mailbox-attachments clearfix uploadedList"></ul>
							</div>
							<div class="box-footer">
								<button type="button" class="btn btn-primary listBtn">
									<i class="fa fa-list"></i>목록
								</button>
								<button type="reset" class="btn btn-warning">
								<i class="fa fa-reply"></i>초기화
							</button>
							<button type="submit" class="btn btn-success">
								<i class="fa fa-save"></i>저장
							</button>
							</div>
							
						</div>
					</form>
				</div>
			</section>

			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<%@ include file="../include/main_footer.jsp"%>
	</div>
	<!-- ./wrapper -->
	<!-- REQUIRED JS SCRIPTS -->
	<%@ include file="../include/footerjs.jsp"%>
	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
	<%--Handlebars JS--%>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9619937fadbc25cf54f5d5e469cc0c2a&libraries=services"></script>

	<script>
		// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
		var placeOverlay = new daum.maps.CustomOverlay({
			zIndex : 1
		}), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
		markers = [], // 마커를 담을 배열입니다
		currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);

		//주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new daum.maps.Marker({
			position : new daum.maps.LatLng(37.537187, 127.005476),
			map : map
		});

		// 장소 검색 객체를 생성합니다
		var ps = new daum.maps.services.Places(map);

		// 지도에 idle 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'idle', searchPlaces);

		// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
		contentNode.className = 'placeinfo_wrap';

		// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
		// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 daum.maps.event.preventMap 메소드를 등록합니다 
		addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
		addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);

		// 커스텀 오버레이 컨텐츠를 설정합니다
		placeOverlay.setContent(contentNode);

		// 각 카테고리에 클릭 이벤트를 등록합니다
		addCategoryClickEvent();

		// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
		function addEventHandle(target, type, callback) {
			if (target.addEventListener) {
				target.addEventListener(type, callback);
			} else {
				target.attachEvent('on' + type, callback);
			}
		}

		// 카테고리 검색을 요청하는 함수입니다
		function searchPlaces() {
			if (!currCategory) {
				return;
			}

			// 커스텀 오버레이를 숨깁니다 
			placeOverlay.setMap(null);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();

			ps.categorySearch(currCategory, placesSearchCB, {
				useMapBounds : true
			});
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === daum.maps.services.Status.OK) {

				// 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
				displayPlaces(data);
			} else if (status === daum.maps.services.Status.ZERO_RESULT) {
				// 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

			} else if (status === daum.maps.services.Status.ERROR) {
				// 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

			}
		}

		// 지도에 마커를 표출하는 함수입니다
		function displayPlaces(places) {

			// 몇번째 카테고리가 선택되어 있는지 얻어옵니다
			// 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
			var order = document.getElementById(currCategory).getAttribute(
					'data-order');

			for (var i = 0; i < places.length; i++) {

				// 마커를 생성하고 지도에 표시합니다
				var marker = addMarker(new daum.maps.LatLng(places[i].y,
						places[i].x), order);

				// 마커와 검색결과 항목을 클릭 했을 때
				// 장소정보를 표출하도록 클릭 이벤트를 등록합니다
				(function(marker, place) {
					daum.maps.event.addListener(marker, 'click', function() {
						displayPlaceInfo(place);
					});
				})(marker, places[i]);
			}
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, order) {
			var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new daum.maps.Size(27, 28), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
				spriteOrigin : new daum.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new daum.maps.Point(11, 28)
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			}, markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new daum.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
		function displayPlaceInfo(place) {

			var content = '<div class="placeinfo">'
					+ '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
					+ place.place_name + '</a>';

			if (place.road_address_name) {
				content += '    <span title="' + place.road_address_name + '">'
						+ place.road_address_name
						+ '</span>'
						+ '  <span class="jibun" title="' + place.address_name + '">(지번 : '
						+ place.address_name + ')</span>';
				$("#location").val(place.road_address_name);
			} else {
				content += '    <span title="' + place.address_name + '">'
						+ place.address_name + '</span>';
				$("#location").val(place.address_name);
			}

			content += '    <span class="tel">' + place.phone + '</span>'
					+ '</div>' + '<div class="after"></div>';

			contentNode.innerHTML = content;
			placeOverlay.setPosition(new daum.maps.LatLng(place.y, place.x));
			placeOverlay.setMap(map);
			// 카페 이름 
			$("#cafename").val(place.place_name);

		}

		// 각 카테고리에 클릭 이벤트를 등록합니다
		function addCategoryClickEvent() {
			var category = document.getElementById('category'), children = category.children;

			for (var i = 0; i < children.length; i++) {
				children[i].onclick = onClickCategory;
			}
		}

		// 카테고리를 클릭했을 때 호출되는 함수입니다
		function onClickCategory() {
			var id = this.id, className = this.className;

			placeOverlay.setMap(null);

			if (className === 'on') {
				currCategory = '';
				changeCategoryClass();
				removeMarker();
			} else {
				currCategory = id;
				changeCategoryClass(this);
				searchPlaces();
			}
		}

		// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
		function changeCategoryClass(el) {
			var category = document.getElementById('category'), children = category.children, i;

			for (i = 0; i < children.length; i++) {
				children[i].className = '';
			}

			if (el) {
				el.className = 'on';
			}

		}

		function searchAddress() {
			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.address; // 최종 주소 변수

					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("locationAddr").value = addr;
					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results,
							status) {
						// 정상적으로 검색이 완료됐으면
						if (status === daum.maps.services.Status.OK) {

							var result = results[0]; //첫번째 결과의 값을 활용

							// 해당 주소에 대한 좌표를 받아서
							var coords = new daum.maps.LatLng(result.y,
									result.x);
							// 지도를 보여준다.
							mapContainer.style.display = "block";
							map.relayout();
							// 지도 중심을 변경한다.
							map.setCenter(coords);
							// 마커를 결과값으로 받은 위치로 옮긴다.
							marker.setPosition(coords)
						}
					});
				}
			}).open();
		}
	</script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
	<%--파일업로드 JS--%>
	<script type="text/javascript" src="/resources/dist/js/upload.js"></script>
	<%--첨부파일 하나의 영역--%>
	<%--이미지--%>
	<script id="templatePhotoAttach" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name" data-lightbox="uploadImages"><i class="fa fa-camera"></i> {{fileName}}</a>
            <a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn"><i class="fa fa-fw fa-remove"></i></a>
        </div>
    </li>
</script>
	<%--일반 파일--%>
	<script id="templateFileAttach" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> {{fileName}}</a>
            <a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn"><i class="fa fa-fw fa-remove"></i></a>
        </div>
    </li>
</script>
	<script>
		/*====================================================게시판 첨부파일 업로드 관련======================================*/
		$(document)
				.ready(
						function() {
							var fileDropDiv = $(".fileDrop");
							var templatePhotoAttach = Handlebars.compile($(
									"#templatePhotoAttach").html());
							var templateFileAttach = Handlebars.compile($(
									"#templateFileAttach").html());
							// 전체 페이지 파일 끌어 놓기 기본 이벤트 방지 : 지정된 영역외에 파일 드래그 드랍시 페이지 이동방지
							$(".content-wrapper").on("dragenter dragover drop",
									function(event) {
										event.preventDefault();
									});
							// 파일 끌어 놓기 기본 이벤트 방지
							fileDropDiv.on("dragenter dragover",
									function(event) {
										event.preventDefault();
									});
							// 파일 드랍 이벤트 : 파일 전송 처리, 파일 화면 출력
							fileDropDiv
									.on(
											"drop",
											function(event) {
												event.preventDefault();
												var files = event.originalEvent.dataTransfer.files;
												var file = files[0];
												var formData = new FormData();
												formData.append("file", file);
												$
														.ajax({
															url : "/file/upload",
															data : formData,
															dataType : "text",
															processData : false,
															contentType : false,
															type : "POST",
															success : function(
																	data) {
																// 파일정보 가공
																var fileInfo = getFileInfo(data);
																// 이미지 파일일 경우
																if (data
																		.substr(
																				12,
																				2) == "s_") {
																	var html = templatePhotoAttach(fileInfo);
			
																	if(!$("#cimage").val()){
																		$("#cimage").val(fileInfo.fullName); // 첫번째 값을 가져옴
																	}

																	// 이미지 파일이 아닐 경우
																} 
																$(".uploadedList").append(html);
															},
														     error:function(request,status,error){
														         alert("이미지 파일만 등록 가능합니다"); // 실패 시 처리
														        }

														});
											});
							// 글 저장 버튼 클릭 이벤트 : 파일명 DB 저장 처리
							$("#writeForm")
									.submit(
											function(event) {
												event.preventDefault();
												var that = $(this);
												var str = "";
												$(".uploadedList .delBtn")
														.each(
																function(index) {
																	str += "<input type='hidden' name='files["
																			+ index
																			+ "]' value='"
																			+ $(this).attr("href")
																			+ "'>"
																});
												that.append(str);
												that.get(0).submit();
												console.log("파일명 저장 처리 성공");
											});
							// 파일 삭제 버튼 클릭 이벤트 : 파일삭제, 파일명 DB 삭제 처리
							$(document).on("click", ".delBtn", function(event) {
								event.preventDefault();
								var that = $(this);
								$.ajax({
									url : "/file/delete",
									type : "post",
									data : {
										fileName : $(this).attr("href")
									},
									dataType : "text",
									success : function(result) {
										if (result == "DELETED") {
											alert("삭제되었습니다.");
											that.parents("li").remove();
											$("#cimage").val($(".uploadedList .delBtn:first").attr("href")); // 다음 값을 받아옴
										}
									}
								});
							});
						});
	</script>
</body>
</html>