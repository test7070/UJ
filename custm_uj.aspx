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
			var q_name = 'custm', t_bbsTag = 'tbbs', t_content = " ", afilter = [], t_count = 0, as, brwCount2 = 15;
			var t_sqlname = 'custm_load'; t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			aPop = new Array(
				
			);
			
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbmKey = ['noa'], bbsKey = ['noa', 'noq'];
			q_tables = 's';
			
			$(document).ready(function () {
				if (location.href.indexOf('?') < 0)   // debug
				{
					location.href = location.href + "?;;;noa='0015'";
					return;
				}
				if (!q_paraChk()) {
					return;
				}
				main();
			});                  /// end ready
			
			function main() {
				if (dataErr)
				{
					dataErr = false;
					return;
				}
				
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}
			
			function mainPost(){
				q_mask(bbmMask);
				$('#txtNoa').val(q_getHref()[1]);
				
				q_cmbParse("cmbStype", '1@內銷,3@外銷');
				q_cmbParse("cmbInvomemo", '@,隨貨附發票@要');
				q_gt('acomp', '', 0, 0, 0, "");
			}
			
			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function () { 
						btnMinus($(this).attr('id')); 
					});
				} //j
			}
			
			function btnOk() {
				t_key = q_getHref();
				
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2); 
			}
			
			function bbsSave(as) {
				if (!as['account'] && !as['bankno'] && !as['bank'] ) {  // Dont Save Condition
					as[bbsKey[0]] = '';   /// noa  empty --> dont save
					return;
				}
				t_key = q_getHref();
				as[bbmKey[0]] = t_key[1];
				q_getId2( '' , as);  // write keys to as
				return true;
			}
			
			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi();
			}
			
			function refresh() {
				_refresh();
			}
						
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
			}
			
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
			
			function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'acomp':
						var as = _q_appendData("acomp", "", true);
		                var t_item = " @不指定";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' +as[i].noa+'.'+as[i].nick;
						}
						q_cmbParse("cmbPostmemo", t_item);
						if (abbm[q_recno] != undefined)
							$("#cmbPostmemo").val(abbm[q_recno].postmemo);
						break;
            	}
            }

		</script>
	</head>
	<body>
		<div style="float:left;width:100%;margin-bottom: 10px;">
			<div class='dbbm' style="width: 100%;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr style="height: 1px;">
						<td style="width: 80px;"> </td>
						<td style="width: 20%;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 20%;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 20%;"> </td>
					</tr>
					<tr>
						<td><a id="lblStype_uj" style="float:right;">內外銷</a></td>
						<td><select id="cmbStype"  style='width:98%;'> </select></td>
						<td><a>隨貨附發票</a></td>
						<td><select id="cmbInvomemo"  style='width:98%;'> </select></td>
						<td><a>票本代號</a></td>
						<td><select id="cmbPostmemo"  style='width:98%;'> </select></td>
						<td><input id="txtNoa" type="hidden" /></td>
					</tr>
				</table>
			</div>
			<div id="dbbs" class='dbbs' style="display: none;">
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
						<td align="center"><a id='lblAccount'> </a></td>
						<td align="center"><a id='lblBankno'> </a></td>
						<td align="center"><a id='lblBank'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;"  align="center">
							<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
							<input id="txtNoa.*" type="hidden" />
							<input id="txtNoq.*" type="hidden" />
							<input id="recno.*" type="hidden" />
						</td>
						<td style="width:10%;"><input class="txt" id="txtAccount.*" maxlength='23'type="text" style="width:98%;"/></td>
						<td style="width:10%;"><input class="txt" id="txtBankno.*" maxlength='16'type="text" style="width:98%;"/></td>
						<td style="width:10%;"><input class="txt" id="txtBank.*" maxlength='28'type="text" style="width:98%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>