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
                q_gf('', 'z_cudp_uj');
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_cudp_uj',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    }, {
                        type : '1', //[2][3]
                        name : 'xdate',
                    }, {
                        type : '1', //[4][5]
                        name : 'xnoa',
                    }, {
						type : '5', //[6]
						name : 'xmechno1',
						value : [q_getPara('report.all')].concat('分1,分2,分3,分4,覆1,覆2,覆3,其他'.split(','))
					}, {
						type : '5', //[7]
						name : 'xsource1',
						value : [q_getPara('report.all')].concat('成品,不良品,零碼,餘料'.split(','))
					}, {
						type : '5', //[8]
						name : 'xmechno2',
						value : [q_getPara('report.all')].concat('A,B'.split(','))
					}, {
						type : '5', //[9]
						name : 'xsource2',
						value : [q_getPara('report.all')].concat('5@上皮,4@上紙,3@下料'.split(','))
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
				
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate2').mask(r_picd);
				
				$('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				
                //$('#txtXnoa1').val(q_getHref()[1]);
                //$('#txtXnoa2').val(q_getHref()[1]);
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

