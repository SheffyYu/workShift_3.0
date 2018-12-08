/**
 * Created by yushihui on 2018/12/7.
 */
//上传文件方法
document.write("<script language=javascript src='../../js/huadong/tips.js'></script>");
function UpladFile() {
  var fileObj = document.getElementById("selectFilePath").files[0]; // js 获取文件对象
  console.log(fileObj);
  var form = new FormData(); // FormData 对象
  form.append("file", fileObj); // 文件对象

  $.ajax({
    url: "/test/excel/daily",
    type: "POST",
    data:form,
    processData:false,
    contentType:false,
    success:function (data) {
      showTips("上传成功！",200,0.5);
      //在弹出框结束之后刷新界面
      setTimeout(function(){
        location.reload();
      },700);
    }
  });

}
