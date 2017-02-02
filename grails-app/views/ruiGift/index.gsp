<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">营销管理</a>
        </li>
        <li>
            <a href="#">礼品管理</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 礼品管理</h2>
        <div class="box-icon">
            <a href="javascript:addInfo();" class="btn btn-plus btn-round btn-default"><i
                    class="glyphicon glyphicon-plus"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i
                    class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
</div>
<div class="box-content">
    <form class="form-inline" role="form" action="#">
        <div class="form-group">
            <label class="control-label" for="name">名称:</label>
            <input type="text" class="form-control" id="name">
            <input type="button" class="btn btn-primary" value="查询" id="sercher"/>
        </div>
    </form><br />
    <div id="msgInfo" class="box-content alerts"></div>
    <table class="table table-striped table-bordered search_table" id="dataTable"></table>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">

    <div class="modal-dialog">
        <div class="modal-content" id="modal-content">

        </div>
    </div>
</div>
<script>
    var gridTable;
    var typeTable;
    var goodsId = 0;
    var serverPath = 'http://120.76.74.2/file/file/';
    $(document).ready(function(){
        gridTable=$('#dataTable').DataTable({
            "bLengthChange": true,
            "bFilter": false,
            "lengthMenu": [10, 20, 50, 100],
            "paginate": true,
            "processing": true,
            "pagingType": "full_numbers",
            "serverSide": true,
            "bAutoWidth": true,
            "ajax": {
                "url":"ruiGift/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.name = $("#name").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "ID", "data" : "id", "orderable": true, "searchable": false },
                { "title": "名称", "data" : "name", "orderable": true, "searchable": false },
                { "title": "图片", "data" : function (data) {
                    var picPath = '';
                    var picFileId = data.image;
                    if (picFileId != null && picFileId != "" && picFileId != "null" && picFileId != "NULL") {
                        picPath = serverPath + 'preview/' + picFileId;
                    } else {
                        picPath = '/ys/assets/goods_default_pic.png';
                    }
                    return '<img src="' + picPath + '" width=44 height=44 onclick="selectGiftPic('+data.id+')"/>';
                }, "orderable": false, "searchable": false },
                { "title": "基准价", "data" : "basePrice", "orderable": true, "searchable": false },
                { "title": "售价", "data" : "realPrice", "orderable": true, "searchable": false },
                { "title": "回收价", "data" : "buyPrice", "orderable": true, "searchable": false },
                { "title": "人气值", "data" : "rq", "orderable": true, "searchable": false },
                { "title": "活动值", "data" : "hl", "orderable": true, "searchable": false },
                { "title": "亲善值", "data" : "qs", "orderable": true, "searchable": false },
                { "title": "状态", "data" : function (data) {
                    return data.flag == 1 ? '在售' : '下架';
                }, "orderable": false, "searchable": false },
                { "title": "操作", "data" : function (data) {
                    return  '<a class="btn btn-info" href="javascript:editInfo('+data.id+');" title="编辑">' +
                            '<i class="glyphicon glyphicon-edit icon-white"></i></a>&nbsp;&nbsp;' +
                            '<a class="btn btn-danger" href="javascript:removeInfo('+data.id+');" title="下架">' +
                            '<i class="glyphicon glyphicon-trash icon-white"></i></a>';
                }, "orderable": false, "searchable": false }
            ],
            "language": {
                "zeroRecords": "没有数据",
                "lengthMenu" : "_MENU_",
                "info": "显示第 _START_ 至 _END_ 条记录，共 _TOTAL_ 条",
                "loadingRecords": "加载中...",
                "processing": "加载中...",
                "infoFiltered": "",
                "infoEmpty": "暂无记录",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"
                }
            }
        });
        //查询 重新加载
        $("#sercher").click(function(){
            gridTable.ajax.reload(null, false);
        });
    });

    function addInfo() {
        var content = "" +
                '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal">×</button>' +
                '<h3>新建礼品</h3>' +
                '</div>' +
                '<div class="modal-body">' +
                '<form id="infoForm" role="form">' +
                '<div class="form-group">' +
                '<label for="name">名称</label>' +
                '<input type="text" class="form-control" id="name" name="name" placeholder="名称">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="basePrice">基准价</label>' +
                '<input type="text" class="form-control" id="basePrice" name="basePrice" placeholder="基准价">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="realPrice">售价</label>' +
                '<input type="text" class="form-control" id="realPrice" name="realPrice" placeholder="售价">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="buyPrice">回收价</label>' +
                '<input type="text" class="form-control" id="buyPrice" name="buyPrice" placeholder="回收价">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="rq">人气值</label>' +
                '<input type="text" class="form-control" id="rq" name="rq" placeholder="人气值">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="hl">活动值</label>' +
                '<input type="text" class="form-control" id="hl" name="hl" placeholder="活动值">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="qs">亲善值</label>' +
                '<input type="text" class="form-control" id="qs" name="qs" placeholder="亲善值">' +
                '</div>' +
                '</form>' +
                '</div>' +
                '<div class="modal-footer">' +
                '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                '<a href="javascript:postAjaxForm();" class="btn btn-primary">保存</a>' +
                '</div>';
        $("#modal-content").html("");
        $("#modal-content").html(content);
        $('#myModal').modal('show');
    }

    function editInfo(id) {
        var url = '${createLink(controller: "ruiGift", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "id=" + id,
            success: function (result) {
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>编辑礼品</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<form id="infoForm" role="form">' +
                        '<input type="hidden" id="id" name="id" value="' + result.id + '">' +
                        '<div class="form-group">' +
                        '<label for="name">名称</label>' +
                        '<input type="text" class="form-control" id="name" name="name" value="'+result.name+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="basePrice">基准价</label>' +
                        '<input type="text" class="form-control" id="basePrice" name="basePrice" value="'+result.basePrice+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="realPrice">售价</label>' +
                        '<input type="text" class="form-control" id="realPrice" name="realPrice" value="'+result.realPrice+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="buyPrice">回收价</label>' +
                        '<input type="text" class="form-control" id="buyPrice" name="buyPrice" value="'+result.buyPrice+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="rq">人气值</label>' +
                        '<input type="text" class="form-control" id="rq" name="rq" value="' + result.rq + '">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="hl">活动值</label>' +
                        '<input type="text" class="form-control" id="hl" name="hl" value="' + result.hl + '">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="qs">亲善值</label>' +
                        '<input type="text" class="form-control" id="qs" name="qs" value="' + result.qs + '">' +
                        '</div>' +
                        '</form>' +
                        '</div>' +
                        '<div class="modal-footer">' +
                        '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                        '<a href="javascript:postAjaxForm();" class="btn btn-primary">更新</a>' +
                        '</div>';
                $("#modal-content").html("");
                $("#modal-content").html(content);
                $('#myModal').modal('show');
            },
            error: function (data) {
                showErrorInfo(data.responseText);
            }
        });
    }

    function removeInfo(id) {
        var content = "" +
                '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal">×</button>' +
                '<h3>提示</h3>' +
                '</div>' +
                '<div class="modal-body">' +
                '<p>下架后将无法继续出售,是否继续?</p>' +
                '</div>' +
                '<div class="modal-footer">' +
                '<a href="#" class="btn btn-default" data-dismiss="modal">取消</a>' +
                '<a href="javascript:postAjaxRemove('+id+');" class="btn btn-primary">下架</a>' +
                '</div>';
        $("#modal-content").html("");
        $("#modal-content").html(content);
        $('#myModal').modal('show');
    }

    function postAjaxRemove(id) {
        var url = '${createLink(controller: "ruiGift", action: "delete")}/' + id;
        $.ajax({
            type: "DELETE",
            dataType: "json",
            url: url,
            success: function (result) {
                var isSuccess = result.success;
                var errorMsg = result.msg;
                var content = "";
                if (isSuccess) {
                    content = "" +
                            '<div class="alert alert-success">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            '操作完成' +
                            '</div>';
                } else {
                    content = "" +
                            '<div class="alert alert-danger">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            JSON.stringify(errorMsg) +
                            '</div>';
                }
                $("#myModal").modal('hide');
                gridTable.ajax.reload(null, false);
                $("#msgInfo").html(content);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            },
            error: function (data) {
                var errorContent = "" +
                        '<div class="alert alert-danger">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        data.responseText +
                        '</div>';
                $("#msgInfo").html(errorContent);
                $("#msgInfo").html(errorContent).fadeIn(300).delay(2000).fadeOut(300);
            }
        });
    }

    function postAjaxForm() {
        var url = '${createLink(controller: "ruiGift", action: "save")}';
        $.ajax({
            type: "POST",
            dataType: "json",
            url: url,
            data: $('#infoForm').serialize(),
            success: function (result) {
                var isSuccess = result.success;
                var errorMsg = result.msg;
                var content = "";
                if (isSuccess) {
                    content = "" +
                            '<div class="alert alert-success">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            '操作完成' +
                            '</div>';
                } else {
                    content = "" +
                            '<div class="alert alert-danger">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            JSON.stringify(errorMsg) +
                            '</div>';
                }
                $("#myModal").modal('hide');
                gridTable.ajax.reload(null, false);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            },
            error: function(data) {
                var errorContent = "" +
                        '<div class="alert alert-danger">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        data.responseText +
                        '</div>';
                $("#msgInfo").html(errorContent);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            }
        });
    }

    function selectGiftPic(giftId) {
        var content = "" +
                '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal">×</button>' +
                '<h3>设置图片</h3>' +
                '</div>' +
                '<div class="modal-body">' +
                '<form id="picForm" role="form" enctype="multipart/form-data" method="POST">' +
                '<div class="form-group">' +
                '<label for="name">图片</label>' +
                '<input type="file" class="form-control" id="Filedata" name="Filedata" placeholder="图片">' +
                '</div>' +
                '</form>' +
                '</div>' +
                '<div class="modal-footer">' +
                '<div class="alert alert-danger" id="uploadMsgDiv"></div>' +
                '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                '<a href="javascript:postAjaxPic('+giftId+');" class="btn btn-primary">上传</a>' +
                '</div>';
        $("#modal-content").html("");
        $("#modal-content").html(content);
        $('#myModal').modal('show');
    }

    function postAjaxPic(giftId) {
        var url = serverPath + 'upload';
        var data = new FormData($("#picForm")[0]);
        data.append('folder', 'giftPic');
        $.ajax({
            type: "POST",
            dataType: "json",
            url: url,
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            success: function (result) {
                if (result.status == 200) {
                    updateGoodsPic(giftId, result.fid);
                } else {
                    $("#uploadMsgDiv").html(result.message);
                }
            },
            error: function(data) {
                $("#uploadMsgDiv").html(data.responseText);
            }
        });
    }

    function updateGoodsPic(giftId, picId) {
        var url = '${createLink(controller: "ruiGift", action: "savePic")}';
        $.ajax({
            type: "POST",
            dataType: "json",
            url: url,
            data: 'giftId='+ giftId + '&picId=' + picId,
            success: function (result) {
                var isSuccess = result.success;
                var errorMsg = result.msg;
                var content = "";
                if (isSuccess) {
                    content = "" +
                            '<div class="alert alert-success">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            '操作完成' +
                            '</div>';
                } else {
                    content = "" +
                            '<div class="alert alert-danger">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            JSON.stringify(errorMsg) +
                            '</div>';
                }
                $("#myModal").modal('hide');
                gridTable.ajax.reload(null, false);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            },
            error: function(data) {
                var errorContent = "" +
                        '<div class="alert alert-danger">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        data.responseText +
                        '</div>';
                $("#msgInfo").html(errorContent);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            }
        });
    }
</script>