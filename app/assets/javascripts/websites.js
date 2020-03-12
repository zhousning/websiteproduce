$(".newsites, .websites").ready(function() {
  $("[name='page_parent']").change(function(e) {
    var target = e.currentTarget;
    var id = target.dataset.current;
    var parent_id = target.value;
    
    var url = "/pages/set_parent";
    var url = "/websites/" + gon.id + "/pages/set_parent"
    $.getJSON(url, {id: id, parent_id: parent_id}, function(result) {
      if (result.state == 'success') {
        var data = result.data
        construct_tree(data);
        //reset_options(data);
      } else if (result.state == 'repeat') {
        alert("请勿交叉设置");
      } else if (result.state == 'param_error') {
        alert("参数错误");
      }
    });

    function construct_tree(data) {
      tree = "";
      for (var j=0; j < data.length; j++) {
        tree += "<li><a href='#'>" + data[j].key + "</a>"
        
        child = data[j].child
        if (child.length > 0) {
          tree += "<ul>"
          for(var i=0; i< child.length; i++) {
            tree += "<li><a href='#'>" + child[i] + "</a></li>"
          }
          tree += "</ul>"
        }
        tree += "</li>"
      }
      $("#menu-tree-container").html(tree);
    }

    function reset_options(data) {
      $("select[name='page_parent']").each(function() {
        var that = $(this);
        var current = that.attr("data-current");
        var options = "";
        for (var j=0; j < data.length; j++) {
          if (data[j].value != current) {
            options += "<option value='" + data[j].value + "'>" + data[j].key + "</option>";
          }
        }
        that.html(options);
      });
    }
  });
});

