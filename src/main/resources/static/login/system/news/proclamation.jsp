<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
	String newsNo = request.getParameter("newsNo");
%>

<div id='NewsReadAndConfirmShowData'> 
    <form method="put">
        <table style=" padding-left: 300px;">
            <br>

            <tr>
                <td style="  padding-top:50px;  padding-left:10px; white-space: nowrap;"><div align="right"><font size=3>消息标题：</></div></td>
                <td style=" padding-top:50px; "> <input class="easyui-validatebox" type="text" id="receiveNewsTitle" readonly="readonly" name="newsTitle"  style="width: 450px;height:20px;font-size:20px" />
            </tr>
            <tr>
                <td style="  padding-top:30px;  padding-left:10px; white-space: nowrap;"><div align="right"></div><font size=3>消息内容：</></div></td>
                <td style=" padding-top:30px; ">
                    <textarea type="text" id="NewsReadAndConfirmShowDetailData" name="newsTxt" type="text" readonly="readonly" style="height:160px; width: 450px;font-size:20px"></textarea>

                </td>
            </tr>
            <tr>
                <td style="  padding-top:30px;  padding-left:10px; white-space: nowrap;"><div align="right"><font size=3>发送人：</></div></td>
                <td style=" padding-top:30px; ">
                    <input type="text" id="receiveNewsSendMan"   style="width:230px;height:20px;font-size:20px" readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td style="  padding-top:30px;  padding-left:10px; white-space: nowrap;"><div align="right"><font size=3>发送时间：</></div></td>
                <td style=" padding-top:30px; ">
                    <input type="text" id="receiveNewsDte"  name="validDte"  style="width:230px;height:20px;font-size:20px" readonly="readonly"/>
                </td>
            </tr>
        </table>
    </form> 
</div>
 <script type="text/css"> 
.font14red {
	font-size: 40px;
	font-weight: bold;
	color: #990000;
}
</script>
    <script type="text/javascript"> 
    $(document).ready(function() {
        var newsNo=<%=newsNo%>;
         $.ajax({
            method: "post",
            url: "../webresources/login/news/NewsReleaseResource/getNotice?newsNo="+newsNo,
            success: function(data) {
                    var datas = data.rows[0];
                    $('#receiveNewsTitle').val(datas.NEWS_TITLE);
                    $('#NewsReadAndConfirmShowDetailData').val(datas.NEWS_TXT);
                    $('#receiveNewsSendMan').val(datas.NEWS_NAM);
                    function   formatDate(now)   {     
                        var   year=now.getYear()+1900;     
                        var   month=now.getMonth()+1;     
                        var   date=now.getDate();     
                       
                        return   year+"-"+month+"-"+date;     
                        }     
                        var  d=new  Date(datas.NEWS_DTE);     
                    var date=formatDate(d);
                    $('#receiveNewsDte').val(date);


            }
        });
    });
    
    
    </script>
  
     
    
  
