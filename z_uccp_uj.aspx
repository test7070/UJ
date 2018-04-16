<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_uccp_uj'); //123
            });

            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_uccp_uj',
                        options : [{
	                        type : '0', //[1]
	                        name : 'accy',
	                        value : r_accy
	                    }, {
                            type : '2', //[2][3]
                            name : 'spno',
                            dbf : 'ucc',
                            index : 'noa,product',
                            src : 'ucc_b.aspx'
                        }, {
                            type : '5', //[4]
                            name : 'xtypea',
                            value : [q_getPara('report.all')].concat(q_getPara('ucc.typea').split(','))
                        }, {
                            type : '5', //[5]
                            name : 'xgroupdno',
                            value : (',計畫,訂單').split(',')
                        }]
                    });
                q_popAssign();
                q_getFormat();
                	
	            $('#txtSpno1a').val(q_getHref()[1]);
                $('#txtSpno2a').val(q_getHref()[1]);
                $('#txtSpno1b').val(q_getHref()[3]);
                $('#txtSpno2b').val(q_getHref()[3]);     
            }

            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          