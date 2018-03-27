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
                q_gf('', 'z_ucc_uj');
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ucc_uj',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    },{
                        type : '0', //[2]
                        name : 'rlen',
                        value : r_len
                    },{
                        type : '0', //[3]
                        name : 'qdate',
                        value : q_date()
                    }, {//1-1
						type : '1',
						name : 'xdate' //[4][5]
					}, {//1-2
						type : '2',
						name : 'xpno', //[6][7]
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {//1-3
						type : '2',
						name : 'xstoreno', //[8][9]
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {//1-4
						type : '5',
						name : 'xypea', //[10]
						value : [q_getPara('report.all')].concat('1@成品,5@半成品,6@再製品,7S8S8P@皮料,7L8L@離型紙,9C@紙箱,9P@紙管,9B@塞頭,9W@棧板,Z@零碼'.split(','))
					}, {//2-1
						type : '6',
						name : 'xuno' //[11]
					}, {//2-2
						type : '6',
						name : 'xedate' //[12]
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
				
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate2').mask(r_picd);
				$('#txtXedate').mask(r_picd);
				
				$('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				$('#txtXedate').val(q_date());
				
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

