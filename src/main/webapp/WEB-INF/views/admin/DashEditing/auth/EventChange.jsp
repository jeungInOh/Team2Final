<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container">
 
   <div class="py-5 text-center">
           <h2>이벤트 페이지 변경</h2>
      </div>
    
      
      <div style="margin:10% 10% 10% 10%;">
         <!--  파일첨부 -->
         <form  action="/tour/upload" method="post"  enctype="multipart/form-data">
             <input type="file" name="file"/>
             <input class="btn btn-primary btn-sm"  type="submit" value="업로드"/>
         </form>
     </div>
 </div>