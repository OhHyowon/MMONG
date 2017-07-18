<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>MMONG</title>
 	<script src="/MMONG/resource/assets/js/jquery.js"></script>
    <!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">

    <script src="/MMONG/resource/assets/js/chart-master/Chart.js"></script>
   <script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
   <script type="text/javascript">

   </script>
   
     
    </head>

  <body>

  <section id="container">
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      <header class="header black-bg">
              <tiles:insertAttribute name="header"/>
        </header>
      <!--header end-->
      
 <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
 *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse" >
              <tiles:insertAttribute name="menu"/>
          </div>
      </aside>
      <!--sidebar end-->
<<<<<<< HEAD
        </section>
      <!-- **********************************************************************************************************************************************************
=======
      
<!-- **********************************************************************************************************************************************************
>>>>>>> branch 'master' of https://github.com/OhHyowon/MMONG
      MAIN CONTENT
 *********************************************************************************************************************************************************** -->
      <!--main content start-->
<section id="main-content" >
      <tiles:insertAttribute name="content"/>
</section>
      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
<tiles:insertAttribute name="footer"/>
      </footer>
      <!--footer end-->
<!--   </section> -->

    <!-- js placed at the end of the document so the pages load faster -->
<<<<<<< HEAD
=======
   
>>>>>>> branch 'master' of https://github.com/OhHyowon/MMONG
    <script src="/MMONG/resource/assets/js/bootstrap.min.js"></script>
    <script src="/MMONG/resource/assets/js/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="/MMONG/resource/assets/js/jquery.ui.touch-punch.min.js"></script>
    <script class="include" type="text/javascript" src="/MMONG/resource/assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="/MMONG/resource/assets/js/jquery.scrollTo.min.js"></script>
    <script src="/MMONG/resource/assets/js/jquery.nicescroll.js" type="text/javascript"></script>


    <!--common script for all pages-->
    <script src="/MMONG/resource/assets/js/common-scripts.js"></script>

    <!--script for this page-->
    
  <script>
      //custom select box

     /*  $(function(){
          $('select.styled').customSelect();
      }); */

  </script>

  </body>
</html>
