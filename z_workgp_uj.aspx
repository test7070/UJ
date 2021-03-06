<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsbarcode/3.6.0/JsBarcode.all.js"></script>
		<script type="text/javascript">
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_workgp_uj');
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workgp_uj',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    },{
                        type : '0', //[2]
                        name : 'ndate',
                        value : q_date()
                    }, {
                        type : '6', //[3]
                        name : 'xbdate',
                    }, {
                        type : '6', //[4]
                        name : 'ydate1',
                    }, {
                        type : '6', //[5]
                        name : 'ydate2',
                    }, {
                        type : '6', //[6]
                        name : 'ydate3',
                    }, {
                        type : '6', //[7]
                        name : 'ydate4',
                    }, {
                        type : '6', //[8]
                        name : 'ydate5',
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
				
				$('#txtXbdate').mask(r_picd);
				$('#txtYdate1').mask(r_picd);
				$('#txtYdate2').mask(r_picd);
				$('#txtYdate3').mask(r_picd);
				$('#txtYdate4').mask(r_picd);
				$('#txtYdate5').mask(r_picd);
				
				$('#txtXbdate').val(q_date());
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
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

