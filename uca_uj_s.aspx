<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "uca_s";
			
			aPop = new Array(
				['txtNoa', '', 'uca', 'noa,product', 'txtNoa,txtProduct', "uca_b.aspx"]
			);

			$(document).ready(function() {	
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
				$('#btnSearch').before($('#btnSearch').clone().attr('id', 'btnSearch2').show()).hide();
				$('#btnSearch2').click(function(){
					var t_noa = $.trim($('#txtNoa').val());
					var t_product = $.trim($('#txtProduct').val());
					if(t_noa.length > 0){
						var t_where = "where=^^ left(noa,"+t_noa.length+")='" + t_noa + "' ^^ stop=10 ";
						q_gt('uca', t_where, 0, 0, 0, "SeekNoaInUca", r_accy);
					}else if(t_product.length > 0){
						var t_where = "where=^^ product like '%" + t_product + "%' ^^ stop=10 ";
						q_gt('uca', t_where, 0, 0, 0, "SeekProductInUca", r_accy);
					}else{
						$('#btnSearch').click();
					}
				});
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				q_cmbParse("cmbTypea", '@全部,' + q_getPara('uca.typea'));
				q_cmbParse("cmbGroupdno", ',訂單,全-訂,半-訂,共-訂,成-計,半-計');	
				$('#txtNoa').focus();
				
			}

			function q_gtPost(s2){
				switch(s2){
					case 'SeekNoaInUca':
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							$('#btnSearch').click();
						}else{
							var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
							parent.b_window = false;
							parent.q_box("ucc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucc', "95%", "95%", q_getMsg('popUcc'));
						}
						break;
					case 'SeekProductInUca':
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							$('#btnSearch').click();
						}else{
							var t_where = "product like '%" + $.trim($('#txtProduct').val()) + "%'";
							parent.b_window = false;
							parent.q_box("ucc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucc', "95%", "95%", q_getMsg('popUcc'));
						}
						break;
				}
			}
			
			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_product = $('#txtProduct').val();
				t_typea = $('#cmbTypea').val();
				t_groupdno = $('#cmbGroupdno').val();

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +
										q_sqlPara2("typea", t_typea)+
                                        q_sqlPara2("groupdno", t_groupdno);
				
				if (t_product.length > 0)
					t_where += " and charindex('" + t_product + "',product)>0";
					
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			.c1{
				width:215px;
				font-size:medium;
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt c1" id="txtNoa" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProduct'> </a></td>
					<td><input class="txt c1" id="txtProduct" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" class="c1" > </select></td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek' style="width:20%;"><a id='lblGroupdno_uj'>銷售屬性</a></td>
                    <td><select id="cmbGroupdno" class="c1" > </select></td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>