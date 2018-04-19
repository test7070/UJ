<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
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
		<script type="text/javascript">
				
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_desc = 1;
			q_tables = 's';
			var q_name = "cng";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtClass','txtSpec','txtStyle'];
			var bbmNum = [['txtTranmoney', 10, 0, 1]];
			var bbsNum = [['txtMount', 10, 0, 1], ['txtWeight', 15, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			
			brwCount2 = 6;
			
			aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
				, ['txtStoreinno', 'lblStorein', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx']
				, ['txtStoreno_', '', 'store', 'noa,store', 'txtStoreno_', 'store_b.aspx']
				, ['txtStoreinno_', '', 'store', 'noa,store', 'txtStoreinno_', 'store_b.aspx']
				, ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
				, ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']
				, ['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
			);
						
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				var t_weight = 0, t_mount = 0,t_price = 0;
				
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('cng.typea'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				
				
				$('#txtPrice').change(function(e) {
					sum();
				});
				
				$('#btnOrde').click(function(e){
					if(q_cur==1 || q_cur==2){
						var t_ordeno=$('#txtWorkkno').val();
						if(t_ordeno.length>0){
							var t_where = "noa='"+t_ordeno+"'";
							q_box("ordes_uj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'import', "75%", "95%", "");
						}else{
							alert('請輸入訂單號碼!!');
						}
					}
	            });
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'import':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							ret = q_gridAddRow(bbsHtm, 'tbbs','txtProductno,txtProduct,txtUnit,txtMount', b_ret.length, b_ret
							,'productno,product,unit,mount','txtProductno,txtUno');
							
							for (var j = 0; j < q_bbsCount; j++) {
								$('#txtProductno_'+j).change()
							}
                    	}
                    	break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}/// end Switch
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						if(t_name.substring(0, 11) == 'getproduct_'){
     						var t_seq = parseInt(t_name.split('_')[1]);
	                		as = _q_appendData('dbo.getproduct', "", true);
	                		if(as[0]!=undefined){
	                			$('#txtProduct_'+t_seq).val(as[0].product);
	                		}else{
	                			$('#txtProduct_'+t_seq).val('');
	                		}
	                		break;
                        }
				}  /// end switch
			}

			function q_popPost(s1) {
				switch (s1) {
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				//日期檢查
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				var t_storeno = $.trim($('#txtStoreno').val());
				var t_storeinno = $.trim($('#txtStoreinno').val());
				for(var i=0;i<q_bbsCount;i++){
					if($('#txtStoreno_'+i).val().length==0)
						$('#txtStoreno_'+i).val(t_storeno);
					if($('#txtStoreinno_'+i).val().length==0)
						$('#txtStoreinno_'+i).val(t_storeinno);
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cng') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cng_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var t_pno=$.trim($(this).val());
							var t_typea='';
							if(t_pno.length>0){
								switch (t_pno.substr(0,1).toUpperCase()) {
									case '1':
									case '2':
									case '3':
									case '4':
									case 'P':
									case 'C':
									case 'S':
										t_typea='成品';
										break;
									case 'Z':
										t_typea='零碼';
										break;
									case '6':
										t_typea='再製品';
										break;
									case '5':
										t_typea='半成品';
										break;
									case '#':
										t_typea='再製品';
										break;
								}
								if(t_typea.length==0){
									switch (t_pno.substr(0,2).toUpperCase()) {
										case '7S':
										case '8S':
										case '8P':
											t_typea='皮料';
											break;
										case '7L':
										case '8L':
											t_typea='離型紙';
											break;
										case '8G':
											t_typea='膠水';
											break;
										case '9C':
											t_typea='紙箱';
											break;
										case '9P':
											t_typea='管芯';
											break;
										case '9B':
											t_typea='塞頭';
											break;
										case '9W':
											t_typea='棧板';
											break;
									}
								}
							}
							$('#txtClass_'+b_seq).val(t_typea);
							
						});
						
						$('#txtUno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var t_datea=emp($('#txtDatea').val())?q_date():$.trim($('#txtDatea').val());
							var t_uno=emp($('#txtUno_'+b_seq).val())?'':$.trim($('#txtUno_'+b_seq).val());
							if(t_uno.length>0){
								q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(t_datea)+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI($('#txtNoa').val())+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								if (as[0] != undefined) {
									$('#txtProductno_'+b_seq).val(as[0].productno);
									$('#txtProductno_'+b_seq).change();
									$('#txtSpec_'+b_seq).val(as[0].spec);
									$('#txtStyle_'+b_seq).val(as[0].style);
									$('#txtUnit_'+b_seq).val(as[0].unit);
									$('#txtStoreno_'+b_seq).val(as[0].storeno);
									$('#txtMount_'+b_seq).val(as[0].mount);
									$('#txtWeight_'+b_seq).val(as[0].weight);
								}else{
									alert('無此批號!!');
									$('#txtUno_'+b_seq).val('');
								}
							}else{
								$('#btnMinus_'+b_seq).click();
							}
						});
						
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				q_box('z_cngp_uj.aspx' + "?;;;noa='" + trim($('#txtNoa').val())+"';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
                if(t_para){
                    $('#txtDatea').datepicker('destroy');
                    $('#btnOrde').attr('disabled','disabled');
                }else{
                    $('#txtDatea').datepicker();
                    $('#btnOrde').removeAttr('disabled');
                }
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 800px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1200px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 1100px;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1500px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1250px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview"  >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewStore'> </a></td>
						<td align="center" style="width:20%"><a id='vewStorein'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='store'>~store</td>
						<td align="center" id='storein'>~storein</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblType" class="lbl" > </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStore" class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt" style="width:50%;"/>
							<input id="txtStore" type="text" class="txt" style="width:50%;"/>
						</td>
						<td><span> </span><a id="lblStorein" class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreinno" type="text" class="txt" style="width:50%;"/>
							<input id="txtStorein" type="text" class="txt" style="width:50%;"/>
						</td>
						<td><span> </span><a id="lblTrantype" class="lbl" > </a></td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td>
							<input id="txtTggno" type="text" class="txt" style="width:30%;"/>
							<input id="txtTgg" type="text" class="txt" style="width:70%;"/>
						</td>
						<td><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td>
						<input id="txtCardealno" type="text" class="txt c4" style="width:30%;"/>
						<input id="txtCardeal" type="text" class="txt c5" style="width:70%;"/>
						</td>
						<td><span> </span><a id="lblCarno" class="lbl" > </a></td>
						<td><input id="txtCarno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<!--<td><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num"/></td>-->
						<td><span> </span><a id="lblTranmoney" class="lbl" > </a></td>
						<td><input id="txtTranmoney" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblWorkkno_uj" class="lbl">訂單編號</a></td>
						<td><input id="txtWorkkno" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input id="btnOrde" type="button" value="訂單匯入" style="width:100%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSssno_uj" class="lbl btn">業務(交辦)</a></td>
						<td>
							<input id="txtSssno" type="text" class="txt c1" style="width:30%;"/>
							<input id="txtNamea" type="text" class="txt c1" style="width:70%;"/>
						</td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:white; background:#003366;' >
					<td style="width:40px;" align="center"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td style="width:25px;"> </td>
					<td align="center" style="width:180px;"><a id='lblProductno_uj_s'>料號(新成品名)</a></td>
					<td align="center" style="width:80px;"><a id='lblClass_uj_s'>類別</a></td>
					<td align="center" style="width:150px;"><a id='lblUno_uj_s'>批號(身分證號)</a></td>
					<td align="center" style="width:130px;"><a id='lblSpec_uj_s'>列管備註<BR>加工/製造備註</a></td>
					<td align="center" style="width:45px;"><a id='lblUnit_uj_s'>單位</a></td>
					<td align="center" style="width:80px;"><a id='lblMount_uj_s'>數量</a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_uj_s'>長度</a></td>
					<td align="center" style="width:50px;"><a id='lblStoreno_uj_s'>出倉</a></td>
					<td align="center" style="width:50px;"><a id='lblStoreinno_uj_s'>入倉</a></td>
					<td align="center"><a id='lblMemo_uj_s'>備註</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td ><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt c1" id="txtProductno.*" type="text"/></td>
					<td><input class="txt c1" id="txtClass.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtUno.*" type="text"/><!-- style="width:85%;"	-->
						<!--<input id="btnUno.*" type="button" value="." style="width: 1%;"/>-->
					</td>
					<td>
						<input class="txt c1" id="txtSpec.*" type="text" />
						<input class="txt c1" id="txtStyle.*" type="text" />
					</td>
					<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td><input class="txt num c1" id="txtWeight.*" type="text" /></td>
					<td><input class="txt c1" id="txtStoreno.*" type="text" /></td>
					<td><input class="txt c1" id="txtStoreinno.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>