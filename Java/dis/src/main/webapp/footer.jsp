
<script type="text/javascript">
         window.onscroll = function() {myFunction()};
        // Get the navbar
        var navbar = document.getElementById("navbar");
        var head = document.getElementById("head");
        // Get the offset position of the navbar
        var sticky = navbar.offsetTop;

        // Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position.. 
        function myFunction() {
          var width = window.innerWidth;
          var menu = document.getElementById("show-menu");
          if (window.pageYOffset >= sticky) {
             navbar.classList.add("sticky");
            if(width>950)
              head.style.marginTop = "100px";
            else{
              if(!menu.checked)
                head.style.marginTop = "100px";
              else
                head.style.marginTop = "406px";
            }
          } else {
            navbar.classList.remove("sticky");
            head.style.marginTop = "0px";
          }
        }

</script>
<footer class="footer fixed-bottom">
	<div class="container-fluid">
		<span style="color: #031424;">VGEC, Chandkheda</span>
	</div>
</footer>

</body>
</html>
