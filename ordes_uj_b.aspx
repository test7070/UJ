<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'view_ordes', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
            var t_sqlname = 'view_ordes_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            q_desc=1;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

			function mainPost(){
                
			}

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        var t_id = $(this).attr('id').split('_')[1];
                        if (!emp($('#txtNoa_' + t_id).val()))
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center"><a id='lblNoa'> </a></td>
					<td align="center"><a id='lblProductno_uj'>品號</a></td>
					<td align="center"><a id='lblProduct_uj'>品名</a></td>
					<td align="center"><a id='lblUnit_uj'>單位</a></td>
					<td align="center"><a id='lblMount_uj'>數量</a></td>
					<td align="center"><a id='lblMemo_uj'>備註</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:30px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:130px;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;" /></td>
					<td style="width:170px;"><input class="txt" id="txtProductno.*" type="text" style="width:98%;" /></td>
					<td style="width:180px;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
					<td style="width:50px;"><input class="txt" id="txtUnit.*" type="text" style="width:98%;" /></td>
					<td style="width:80px;"><input class="txt" id="txtMount.*" type="text" style="width:98%;text-align: right;" /></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>


