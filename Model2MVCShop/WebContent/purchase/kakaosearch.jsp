<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script>

    $(document).ready(function(){
        $(":button").click(function(){
            $.ajax({
                url: "https://apis.daum.net/search/blog",
                type: "get",
                data: {
                    apikey: "3da55e6834c34ceb659c4ac9c8f17462  ",
                    q:'서울 맛집',
                    result: 5,
                    output: "json"
                },
                dataType: "jsonp",
                success: callback,
                error: function(){
                    alert('error'); 
                }
            });
        });
    });
    function callback(data){
        var itemList = data.channel.item;
        for(var i=0; i<itemList.length; i++){
            var item = itemList[i];
            var title = item.title;
            var link = item.link;
            var desc = item.description;

            $('#searchResult').append('<hr/>');
            $('#searchResult').append("<a href='" + link + "'>" + title + "</a>");
            $('#searchResult').append("<br/>");
            $('#searchResult').append(desc + '<br/>')
            $('#searchResult').append('<hr/>');    
        }
    }
</script>


<body>

    <h2>블로그 검색페이지</h2>
    검색어 입력 : <input type="text" name="search" size="40"/>
    <input type="button" value="검색"/><br/>
    <h4>검색결과</h4>
    <div id="searchResult"></div> 

</body>
</html>