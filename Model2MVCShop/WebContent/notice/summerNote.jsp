<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
      $('#summernote').summernote({
        height: 300,
        minHeight: null,
        maxHeight: null,
        focus: true,
        callbacks: {
          onImageUpload: function(files, editor, welEditable) {
            for (var i = files.length - 1; i >= 0; i--) {
              sendFile(files[i], this);
            }
          }
        }
      });
    });
    
    function sendFile(file, el) {
      var form_data = new FormData();
      form_data.append('file', file);
      $.ajax({
        data: form_data,
        type: "POST",
        url: '/notice/json/summerNote',
        cache: false,
        contentType: false,
        enctype: 'multipart/form-data',
        processData: false,
        success: function(url) {
        	alert(url);
        	$(el).summernote('editor.insertImage', url);
           /*  $('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>'); */
        	$('#imageBoard > ul').append('<li>qweqweqwe</li>');
        }
      });
    }
</script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<form id="articleForm" role="form" action="/article" method="post">
  <br style="clear: both">
  <h3 style="margin-bottom: 25px;">Article Form</h3>
  <div class="form-group">
    <input type="text" class="form-control" id="subject" name="subject" placeholder="subject" required>
  </div>
  <div class="form-group">
    <textarea class="form-control" id="summernote" name="content" placeholder="content" maxlength="140" rows="7">
    </textarea>
  </div>
  <button type="submit" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
</form>

</body>
</html>