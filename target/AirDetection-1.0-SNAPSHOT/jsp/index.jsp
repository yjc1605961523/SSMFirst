<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/1
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        pagination {
            margin: 18px 0;
        }

        .pagination ul {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            margin-left: 0;
            margin-bottom: 0;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }

        .pagination ul>li {
            display: inline;
        }

        .pagination ul>li>a, .pagination ul>li>span {
            float: left;
            padding: 4px 12px;
            line-height: 18px;
            text-decoration: none;
            background-color: #ffffff;
            border: 1px solid #dddddd;
            border-left-width: 0;
        }

        .pagination ul>li>a:hover, .pagination ul>.active>a, .pagination ul>.active>span
        {
            background-color: pink;
        }

        .pagination ul>.active>a, .pagination ul>.active>span {
            color: #999999;
            cursor: default;
        }

        .pagination ul>.disabled>span, .pagination ul>.disabled>a, .pagination ul>.disabled>a:hover
        {
            color: #999999;
            background-color: transparent;
            cursor: default;
        }

        .pagination ul>li:first-child>a, .pagination ul>li:first-child>span {
            border-left-width: 1px;
            -webkit-border-top-left-radius: 4px;
            -moz-border-radius-topleft: 4px;
            border-top-left-radius: 4px;
            -webkit-border-bottom-left-radius: 4px;
            -moz-border-radius-bottomleft: 4px;
            border-bottom-left-radius: 4px;
        }

        .pagination ul>li:last-child>a, .pagination ul>li:last-child>span {
            -webkit-border-top-right-radius: 4px;
            -moz-border-radius-topright: 4px;
            border-top-right-radius: 4px;
            -webkit-border-bottom-right-radius: 4px;
            -moz-border-radius-bottomright: 4px;
            border-bottom-right-radius: 4px;
        }

        .pagination-centered {
            text-align: center;
        }

        .pagination-right {
            text-align: right;
        }

        .pagination-large ul>li>a, .pagination-large ul>li>span {
            padding: 11px 19px;
            font-size: 15px;
        }

        .pagination-large ul>li:first-child>a, .pagination-large ul>li:first-child>span
        {
            -webkit-border-top-left-radius: 6px;
            -moz-border-radius-topleft: 6px;
            border-top-left-radius: 6px;
            -webkit-border-bottom-left-radius: 6px;
            -moz-border-radius-bottomleft: 6px;
            border-bottom-left-radius: 6px;
        }

        .pagination-large ul>li:last-child>a, .pagination-large ul>li:last-child>span
        {
            -webkit-border-top-right-radius: 6px;
            -moz-border-radius-topright: 6px;
            border-top-right-radius: 6px;
            -webkit-border-bottom-right-radius: 6px;
            -moz-border-radius-bottomright: 6px;
            border-bottom-right-radius: 6px;
        }

        .pagination-mini ul>li:first-child>a, .pagination-small ul>li:first-child>a,
        .pagination-mini ul>li:first-child>span, .pagination-small ul>li:first-child>span
        {
            -webkit-border-top-left-radius: 3px;
            -moz-border-radius-topleft: 3px;
            border-top-left-radius: 3px;
            -webkit-border-bottom-left-radius: 3px;
            -moz-border-radius-bottomleft: 3px;
            border-bottom-left-radius: 3px;
        }

        .pagination-mini ul>li:last-child>a, .pagination-small ul>li:last-child>a,
        .pagination-mini ul>li:last-child>span, .pagination-small ul>li:last-child>span
        {
            -webkit-border-top-right-radius: 3px;
            -moz-border-radius-topright: 3px;
            border-top-right-radius: 3px;
            -webkit-border-bottom-right-radius: 3px;
            -moz-border-radius-bottomright: 3px;
            border-bottom-right-radius: 3px;
        }

        .pagination-small ul>li>a, .pagination-small ul>li>span {
            padding: 2px 10px;
            font-size: 10.2px;
        }

        .pagination-mini ul>li>a, .pagination-mini ul>li>span {
            padding: 1px 6px;
            font-size: 9px;
        }
    </style>
</head>
<body>
<div>
    <h2>空气质量监测信息库</h2>
    <form action="" method="post">
        <span>按区域查询</span>
        <select id="mySelect">
            <option value='0'>请选择</option>
        </select>
        <input type="button" value="查找">&nbsp;&nbsp;
        <a href="">添加空气质量信息</a><br/><br/>
        <table id="myTable">
            <tr>
                <th>序号</th>
                <th>区域</th>
                <th>检测时间</th>
                <th>PM10数据</th>
                <th>PM2.5数据</th>
                <th>检测站</th>
            </tr>
        </table>
        <div style="float: right;" class="pagination" id="pagination" style="margin: 4px 0 0 0" class="M-box"></div>
    </form>
</div>
<script src="/js/jquery-1.8.3.min.js"></script>
<script src="/js/jquery.pagination.js"></script>
<script>
    $(function () {
        bindSelect();
        getPageAir();
        $("input[type=button]").click(function () {
            alert("选中的下拉框的值为" + $("#mySelect").val());
            getPageAir();
        })
    });
    function bindSelect() {
        $.ajax({
            url:"/district/bind",
            type:"GET",
            dataType:"JSON",
            success:function (data) {
                $.each(data,function (index,dom) {
                    $("#mySelect").append("<option value='"+dom.id+"' >"+dom.name+"</option>")
                })
            }
        });
    }
  function getPageAir(pageIndex){

            $.ajax({
                url:"/airQualityIndex/getPageAir",
                type:"GET",
                dataType:"JSON",
                data:{"districtId":$("#mySelect").val(),"pageIndex":pageIndex},
                success:function (pageUtil) {
                    $("#myTable").html("");
                    $("#myTable").append("  <tr>\n" +
                        "                        <th>序号</th>\n" +
                        "                        <th>区域</th>\n" +
                        "                        <th>检测时间</th>\n" +
                        "                        <th>PM10数据</th>\n" +
                        "                        <th>PM2.5数据</th>\n" +
                        "                        <th>检测站</th>\n" +
                        "                        </tr>");
                    $.each(pageUtil.list,function (index,dom) {
                        $("#myTable").append("<tr><td>"+dom.id+"</td><td>"+dom.district.name+"</td><td>"+dom.monitorTime+"</td><td>"+dom.pm10+"</td><td>"+dom.pm25+"</td><td>"+dom.monitoringStation+"</td></tr>");
                    });
                    $('#pagination').pagination(pageUtil.total,{
                        current_page : pageIndex,		//从0开始显示
                        items_per_page : pageUtil.pageSize,
                        num_display_entries : 5,
                        callback : getPageAir,
                        prev_text : '上一页',
                        next_text : '下一页',
                    });
                }
            })

    }
</script>
</body>
</html>
