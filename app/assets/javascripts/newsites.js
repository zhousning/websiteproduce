$(".draft_edit").ready(function() {

  var K = window.KindEditor;
  var options = {
    width:'100%',
    height:500,
    allowFileManager : true,
    uploadJson : "/kindeditor/upload",
    fileManagerJson : "/kindeditor/filemanager",
    themeType : 'editor',
    items : ['editor_save', 'preview', 'import_word','generate_word','history_version','|',['modify_information','modify_template'],'|',['undo','redo'],'|','title_one','title_two','title_three','title_content','order_list','|',['superscript','subscript'],'|','table','image','formula','|',['category','references'],['assist_tool','hide'],'|','auto_layout'],
    afterCreate : function() {
      var cmd = kindeditor.edit.cmd;
      var doc = cmd.doc;
      var body = doc.body;
      var childs = body.childNodes;
      var range = cmd.range;
      if (body.childNodes.length == 0) {
        var p = K('<p><br/></p>'); 
        body.appendChild(p[0]);
        range.selectNodeContents(p[0]);
        cmd.select();
        cmd.select();
      }

      //kindeditor.addClassToKeNodes();
      //kindeditor.bindEventToKeNodes();
      //updateHeaderAndFooter();

      //setTimeout("document.getElementById('mask-loading').className = 'mask-loader-none'", 500);
    },
    afterChange : function() {
      var doc = kindeditor.edit.cmd.doc;
      var iframe = document.getElementById("editIframe");
      var iframeHeight = K(iframe).height();
      var scrollHeight = doc.body.scrollHeight;
      if(parseFloat(iframeHeight) < parseFloat(scrollHeight)){
        K(iframe).height(scrollHeight);
      }else{
        return;
      }
    },
    afterBlur: function() {
      this.sync();
    }
  };
  var kindeditor = K.create("#kindeditor-content",options);


  //setProtosPartHeight(".edit_content");
  //updateHeaderAndFooter();

  //使用kindediter的sync函数更安全
  //var url = "";
  //var isEditor = false;
  //var isMainBody = $("body.mainbodies");
  //if ($("body.mainbodies").length > 0) {
  //  url = "http://"+window.location.host+"/theses/"+gon.thesisId+"/mainbodies/"+gon.chapterNumber;
  //  isEditor = true;
  //}
  //else if ($("body.endings").length > 0) {
  //  url = "http://"+window.location.host+"/theses/"+gon.thesisId+"/endings/"+gon.category;
  //  isEditor = true;
  //}
  //else if ($("body.openings").length > 0) {
  //  url = "http://"+window.location.host+"/theses/"+gon.thesisId+"/openings/"+gon.category;
  //  isEditor = true;
  //}
  //if (isEditor) {
  //  window.onbeforeunload = function() {
  //    kindeditor.sync();
  //    var content = $("form").serialize();
  //    //必须使用同步调用，异步调用有时会失败，使用async:false
  //    $.ajax({
  //      type: "PUT",
  //      async: false,
  //      url: url,
  //      data: content,
  //      dataType: "json"
  //    });
  //  }
  //}




  $(".js-draft-update").click(function(e) {

    var arr = new Array();
    $(".edit-textarea").each(function(i) {
      var that = $(this);
      var id = that.attr('data-page');
      var content = that.val();

      arr[i]= {id: id, content: content}
    });
    console.log(arr);

    var json = {pages: arr}
    var url = "/newsites/draft_update";
    $.getJSON(url, json, function(result) {
      if (result.state == 'success') {
        window.location = "/newsites/" + gon.draftid + "/prepare";
      } else {
        alert("请稍后再试");
      }
    });
  });
});

function newsite_produce() {
  var url = "/newsites/" + gon.newsiteid + "/produce";
  var loading = "<div class='gearbox mx-auto'><div class='gear one'><div class='gear-inner'><div class='bar'></div><div class='bar'></div><div class='bar'></div></div></div><div class='gear two'><div class='gear-inner'><div class='bar'></div><div class='bar'></div><div class='bar'></div></div></div><div class='gear three'><div class='gear-inner'><div class='bar'></div><div class='bar'></div><div class='bar'></div></div></div><div class='gear four large'><div class='gear-inner'><div class='bar'></div><div class='bar'></div><div class='bar'></div><div class='bar'></div><div class='bar'></div><div class='bar'></div> </div></div></div><h3>天启正在处理中...</h3> " 
  var btn = "<button class='btn btn-icon btn-2 btn-primary js-produce-newsite' onclick='newsite_produce()'><span class='btn-inner--icon display-3'><i class='ni ni-atom'></i>智能生成</span></button>"

  $(".export-btn-container").html(loading);
  $.getJSON(url, function(result) {
    if (result.state == 'success') {
      setTimeout(function() {
        location.href = "/newsites/" + gon.newsiteid + "/prepare";
      }, 6000);
    } else {
      setTimeout(function() {
        alert("请稍后再试");
        $(".export-btn-container").html(btn);
      }, 6000);
    }
  });

}


