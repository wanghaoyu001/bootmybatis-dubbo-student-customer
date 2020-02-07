<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/16 0016
  Time: 23:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生管理</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
	$(function(){
		/****给下拉列表设置值*****/
		$.getJSON("doinit_Student.do",function(lsca){
			for(var i=0;i<lsca.length;i++){
				var ca=lsca[i];
				$("#classid").append("<option value="+ca.cid+">"+ca.cname+"</option>");
			}
		});
		/***********************/
		
		showAll();
	});
	
	/****************学生列表**********************/
	var page=1;
	var maxpage=1;
	var rows=5;
	function showAll(){
		$.getJSON('findPageAll_Student.do?page='+page+'&rows='+rows,function(map){
			page=map.page;
			rows=map.rows;
			maxpage=map.maxpage;
			lsst=map.lsst;
			
			var tablehead="<table width='800' border='1' align='center' cellpadding='1' cellspacing='0'>"
				+"<tr align='center' bgcolor='#FFFF99'>"
				+"<td width='89'>编号</td>"
				+"<td width='89'>姓名</td>"
				+"<td width='89'>性别</td>"
				+"<td width='89'>地址</td>"
				+"<td width='152'>生日</td>"
				+"<td width='109'>班级</td>"
				+"<td width='137'>操作</td>"
				+"</tr>";
				
			var ttrows="";
			for(var i=0;i<lsst.length;i++){
				var st=lsst[i];
				ttrows+="<tr align='center'>"
					+"<td>"+st.sid+"</td>"
					+"<td>"+st.sname+"</td>"
					+"<td>"+st.sex+"</td>"
					+"<td>"+st.address+"</td>"
					+"<td>"+st.sdate+"</td>"
					+"<td>"+st.cname+"</td>"
					+"<td><input type='button' name='btdel' id='btdel' value='删除' />"
					+"<input type='button' name='btfind' id='btfind' value='修改' /></td>";
					+"</tr>";
			}
				
			var endtable=tablehead+ttrows+"</table>"
			$("#ttable").html(endtable);
			
			$("#pagelable").html(page+"/"+maxpage+"页");
		});
	}
	/*********************************************/
	
	/******************保存事件****************/
	$(function(){
		$("#btsave").click(function(){
			var sname=$("#sname").val();
			var sex=$(":radio[name='sex']:checked").val();
			var address=$("#address").val();
			var sdate=$("#sdate").val();
			var classid=$("#classid").val();
			
			var jsonobj={
					"sname":sname,
					"sex":sex,
					"address":address,
					"sdate":sdate,
					"classid":classid
				};
			$.post('save_Student.do',jsonobj,function(code){
				if(code!=''&&code>0){
					alert('保存成功！');
					showAll();
				}else{
					alert('保存失败！');	
				}
			});	
		});
	});
	/******************************************/
	/************分页******************************/
	$(function(){
		$("#btfirst").click(function(){
			page=1;
			showAll();
		});
		$("#btup").click(function(){
			page=page-1;
			if(page<1)page=1;
			showAll();
		});
		$("#btnext").click(function(){
			page=page+1;
			if(page>maxpage)page=maxpage;
			showAll();
		});
		$("#btlaster").click(function(){
			page=maxpage;
			
			showAll();
		});
	});
	/******************************************/
</script>
</head>

<body>
<p align="center">学生列表</p>
<hr />
<div align="center" id="ttable">
 
   	
</div>
  <table width="800" border="1" align="center" cellpadding="1" cellspacing="0">
    <tr align="center" bgcolor="#CCFFFF">
      <td>
      	<input type="button" name="btfirst" id="btfirst" value="首页" />
     </td>
      <td>
     <input type="button" name="btup" id="btup" value="上页" /></td>
      <td>
     <input type="button" name="btnext" id="btnext" value="下页" /></td>
      <td>
     <input type="button" name="btlaster" id="btlaster" value="末页" /></td>
      <td>每页
        <label for="rows"></label>
      <input name="rows" value="" type="text" id="rows" size="1" />
      条记录 
      <input type="button" name="btchangrow" id="btchangrow" value="确定" /></td>
      <td>跳转到第
        <label for="page"></label>
        <input name="page" value="${pb.page}" type="text" id="page" size="1" />
        页
<input type="button" name="btchangepage" id="btchangepage" value="确定" /></td>
      <td><span id="pagelable">1/1页</span></td>
    </tr>
  </table>
<hr />
<form id="form1" name="form1" method="post" action="">
  <table width="450" border="1" align="center">
    <tr>
      <td colspan="2" align="center" bgcolor="#FFFF99">学生管理</td>
    </tr>
    <tr>
      <td width="91">姓名</td>
      <td width="343"><label for="sname"></label>
      <input type="text" name="sname" id="sname" />
      <input type="hidden" name="sid" id="sid" />
      </td>
    </tr>
    <tr>
      <td>性别</td>
      <td><input name="sex" type="radio" id="radio" value="男" checked="checked" />

        <input type="radio" name="sex" id="radio2" value="女" />
      女</td>
    </tr>
    <tr>
      <td>地址</td>
      <td><input type="text" name="address" id="address" /></td>
    </tr>
    <tr>
      <td>生日</td>
      <td><input type="date" name="sdate" id="sdate" value="1990-01-01"/></td>
    </tr>
    <tr>
      <td>班级</td>
      <td><label for="classid"></label>
        <select name="classid" id="classid">
      </select></td>
    </tr>
    <tr>
      <td colspan="2" align="center" bgcolor="#FFFF99"><input type="button" name="btsave" id="btsave" value="保存" />
      <input type="button" name="btupdate" id="btupdate" value="更新" />
      <input type="reset" name="button" id="button" value="重置" /></td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
</body>
</html>