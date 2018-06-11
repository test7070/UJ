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
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
 
			q_tables = 's';
			var q_name = "vcc";
			var q_readonly = ['txtNoa', 'txtAccno', 'txtComp','txtCardeal','txtSales', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtWorker', 'txtWorker2','txtTranstart','txtCartrips'];
			var q_readonlys = ['textF01','txtWcost','txtUnit','textF03','textF04','textF05','textF06','txtWidth','txtWidth3','txtTotal', 'txtOrdeno','txtNo2','txtNoq'
			,'txtUno','txtSpec','txtStyle','txtWidth2','txtWeight'];
			var bbmNum = [
				['txtPrice', 10, 3, 1], ['txtTranmoney', 11, 0, 1], ['txtMoney', 15, 0, 1], ['txtTax', 15, 0, 1],
				['txtTotal', 15, 0, 1], ['txtTotalus', 15, 2, 1], ['txtTranadd', 15, 2, 1], ['txtFloata', 11, 5, 1],
				['txtCartrips', 15, 2, 1]
			];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 12;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'datea';

			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,nick,tel,fax,zip_comp,addr_comp,paytype,trantype,salesno,sales', 'txtCustno,txtComp,txtTel,txtFax,txtPost,txtAddr,txtPaytype,cmbTrantype,txtSalesno,txtSales', 'cust_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtRackno_', 'btnRackno_', 'rack', 'noa,rack,storeno,store', 'txtRackno_', 'rack_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtSalesno2', 'lblSales2_uj', 'cust', 'noa,nick,zip_comp,addr_comp', 'txtSalesno2,txtSales2,txtPost2,txtAddr2', 'cust_b.aspx'],
				['txtCustno2', 'lblCust2', 'cust', 'noa,comp', 'txtCustno2,txtComp2', 'cust_b.aspx'],
				//['txtPost', 'lblAddr', 'addr', 'post,addr', 'txtPost,txtAddr', 'addr_b.aspx'],
				//['txtPost2', 'lblAddr2', 'addr', 'post,addr', 'txtPost2,txtAddr2', 'addr_b.aspx'],
				['txtPost', 'lblAddr', 'addr2', 'noa,post', 'txtPost', 'addr2_b.aspx'],
				['txtPost2', 'lblAddr2', 'addr2', 'noa,post', 'txtPost2', 'addr2_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
				['txtTranstartno', 'lblTranstart', 'addr2', 'noa,post','txtTranstartno,txtTranstart', 'addr2_b.aspx']
			);

			$(document).ready(function() {
				q_desc = 1;
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0,t_money=0, t_tax = 0, t_total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $('#txtUnit_' + j).val();
					t_mount = q_float('txtMount_' + j);
					t_weight=+q_float('txtMount_' + j);
					$('#txtTotal_' + j).val(round(q_mul(q_float('txtPrice_' + j), dec(t_mount)), 0));
					
					$('#txtWidth3_'+j).val(q_mul(dec($('#txtTotal_' + j).val()),dec($('#txtFloata').val())));
					
					t_money = q_add(t_money, dec(q_float('txtTotal_' + j)));
				}
				if($('#chkAtax').prop('checked')){
					var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
					t_tax = round(q_mul(t_money, t_taxrate), 0);
					t_total = q_add(t_money, t_tax);
				}else{
					t_tax = q_float('txtTax');
					t_total = q_add(t_money, t_tax);
				}
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				
				/*var price = dec($('#txtPrice').val());
				var addMoney = dec(q_getPara('sys.tranadd'));
				var addMul = dec($('#txtTranadd').val());
				var transtyle = $.trim($('#cmbTranstyle').val());
				total = 0
				if(transtyle=='4' || transtyle=='9'){
					price = 0;
				}
				total = q_add(q_mul(addMoney,addMul),price);
				q_tr('txtTranmoney', total);*/
				q_tr('txtTotalus', round(q_mul(q_float('txtMoney'), q_float('txtFloata')),2));
				//cufttotal();
			}
			function cufttotal() {
				var t_cuft=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_cuft=q_add(t_cuft,dec($('#txtTranmoney2_'+j).val()));	
				}
				$('#txtCartrips').val(t_cuft);
			}
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [['txtTranmoney', 11, 0, 1], ['txtMoney', 15, 0, 1], ['txtTax', 15, 0, 1],['txtTotal', 15, 0, 1], ['txtTotalus', 15, 2, 1], ['txtFloata', 11, 5, 1]];
				//['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1], ['txtTranadd', 11, 2, 1]
				bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 15, 0, 1]];
				//q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				q_cmbParse("cmbStype", q_getPara('vcc.stype'));
				//q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPay", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				
				q_cmbParse("cmbKind", ',追加,指送,指寄,第1趟,第2趟');
				
				var t_where = "where=^^ 1=0  ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入					
				$('#txtMemo').change(function(){
					if ($('#txtMemo').val().substr(0,1)=='*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				$('#txtMon').click(function(){
					if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
						q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
				});
				
				$('#chkAtax').click(function() {
					refreshBbm();
					sum();
				});
				
				$('#txtTax').change(function() {
					sum();
				});
				
				$('#txtPost').change(function(){
					//GetTranPrice();
				});
				$('#txtPost2').change(function(){
					//GetTranPrice();
				});
				$('#txtTranstartno').change(function(){
					//GetTranPrice();
				});
				$('#txtCardealno').change(function(){
					//GetTranPrice();
					//取得車號下拉式選單
					var thisVal = $(this).val();
					var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
					q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				});
				
				$('#cmbTranstyle').change(function(){
					//GetTranPrice();
				});
				
				$('#btnOrdes').click(function() {
					var t_custno = trim($('#txtCustno').val());
					var t_where = '';
					if (t_custno.length > 0) {
						t_where = "isnull(notv,0)>0  && isnull(enda,0)!=1 && isnull(cancel,0)!=1 &&" + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");
						if (!emp($('#txtOrdeno').val()))
							t_where += " && charindex(noa,'" + $('#txtOrdeno').val() + "')>0";
						t_where = t_where;
					} else {
						alert(q_getMsg('msgCustEmp'));
						return;
					}
					q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
				});
				
				$('#btnCubs').click(function() {
					var t_custno = trim($('#txtCustno').val());
					var t_product = trim($('#txtTimea').val());
					var t_where = '';
					
					if(!(q_cur==1 || q_cur==2)){
						return;
					}
					if(t_custno.length==0 && t_product.length==0){
						alert('請先輸入【客戶】編號!!')
						return;
					}
					
					if(t_product.length>0){
						q_gt('view_cub',"where=^^ product='"+t_product+"'^^", 0, 0, 0, "getcub", r_accy,1);
					}else{
						//107/06/07 改成匯入已完工
						//(原未完工 ref:"0.業務生產指令 2017.8.25-1.xlsx"生產指令說明 參照25 完成【出貨單】作業,才按下"完工"此筆"生產指令"完成任務)
						//q_gt('view_cub',"where=^^ custno='"+t_custno+"' and isnull(enda,0)=0 ^^", 0, 0, 0, "getcub", r_accy,1);
						q_gt('view_cub',"where=^^ custno='"+t_custno+"' and isnull(enda,0)=1 ^^", 0, 0, 0, "getcub", r_accy,1);
					}
					var as = _q_appendData("view_cub", "", true);
					var t_noa='',t_storeno='',t_store='';
					if(as[0] != undefined){
						if(t_product.length>0){
							/*if(as[0].enda=='true'){
								alert('生產指令【'+t_product+'】已完工!!');
								return;	
							}*/
							if(as[0].enda=='false'){
								alert('生產指令【'+t_product+'】未完工!!');
								return;	
							}else{
								$('#txtCustno').val(as[0].custno);
								$('#txtComp').val(as[0].comp);
								t_storeno=as[0].processno;
								t_store=as[0].process;
							}
						}
						t_noa=as[0].noa;
					}else{
						if(t_product.length>0){
							alert('找不到【'+t_product+'】生產指令!!');
						}else{
							alert('客戶已無需出貨的生產指令!!');
						}
						return;	
					}
					
					//q_gt('view_cubs',"where=^^ noa='"+t_noa+"' ^^", 0, 0, 0, "getcubs", r_accy,1);
					//var as = _q_appendData("view_cubs", "", true);
					
					q_func('qtxt.query.getcubs', 'orde_uj.txt,getcubs,' + encodeURI(t_noa)+';'+encodeURI('#non'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for (var i = 0; i < as.length; i++) {
						for (var j = 0; j < q_bbsCount; j++) {
							if(as[i].noa==$('#textF03_'+j).val() && as[i].no2==$('#textF04_'+j).val()){
								as.splice(i, 1);
								i--;
								break;
							}
						}
					}
					if(as.length>0){
						var t_i=-1;
						for (var i = 0; i < q_bbsCount; i++) {
							if(!emp($('#txtUcolor_'+i).val()) || !emp($('#txtProductno_'+i).val())){
								t_i=i;
							}
						}
						Lock(1, {
							opacity : 0
						});
						for (var i = 0; i < as.length; i++) {
							if(t_i+1>=q_bbsCount){
								$('#btnPlus').click();
							}
							t_i++;
							//$('#txtUcolor_'+t_i).val(as[i].ucolor);
							$('#txtProductno_'+t_i).val(as[i].productno);
							$('#textF01_'+t_i).val(as[i].btime);
							$('#txtStoreno_'+t_i).val(t_storeno);
							$('#txtMount_'+t_i).val(as[i].mount);
							$('#txtUnit_'+t_i).val(as[i].unit);
							$('#textF03_'+t_i).val(as[i].noa)
							$('#textF04_'+t_i).val(as[i].noq)
							$('#txtOrdeno_'+t_i).val(as[i].ordeno)
							$('#txtNo2_'+t_i).val(as[i].no2)
							if(as[i].cudsmemo.length>0)
								$('#textF02_'+t_i).val(as[i].cudsmemo.split('_')[7]);
							//$('#txtUno_'+t_i).val(as[i].cudsuno);
							
							$('#txtProductno_'+t_i).change();
						}
						Unlock(1);
					}else{
						alert('資料已存在表身，不重覆匯入!!');
					}
				});
				
				$('#cmbCubnouj').change(function() {
					$('#txtTimea').val($.trim($('#cmbCubnouj').val()));
				});

				$('#lblOrdeno').click(function() {
					q_pop('txtOrdeno', "orde_uj.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $('#txtOrdeno').val() + "')>0;" + r_accy + '_' + r_cno, 'orde', 'noa', '', "92%", "1024px", q_getMsg('lblOrdeno'), true);
				});
				
				$('#lblTimea_uj').click(function() {
					var t_where = "product='"+ $('#txtTimea').val() + "'";
					q_box("cub_uj.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cub', "95%", "95%", '生產指令');
				});
				
				$('#lblAccc').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});

				$('#lblInvono').click(function() {
					t_where = '';
					t_invo = $('#txtInvono').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcca', "95%", "95%", $('#lblInvono').val());
					}
				});
				
				$('#lblInvo').click(function() {
					t_where = '';
					t_invo = $('#txtInvo').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("invo.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", $('#lblInvo').val());
					}
				});
				
				$('#cmbStype').change(function() {
					stype_chang();
				});
				
				$('#txtFloata').change(function() {
					sum();
				});
				
				$('#txtPrice').change(function() {
					sum();
				});
				
				$('#txtTranadd').change(function() {
					sum();
				});
				
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				
				$('#btnClose_div_stk').click(function() {
					$('#div_stk').hide();
				});
				
				$('#btnClose_div_stkuj').click(function() {
					var t_n=dec($('#Stkuj_Seq').val());
					var t_on=dec($('#Stkuj_Seq').val());
					$("#table_stkuj [type=checkbox]").each(function(index) {
						if($(this).prop('checked')){
							var td_id=$(this).attr('id');
							var td_n=dec($(this).attr('id').split('_')[2]);
							
							if(t_n!=t_on){
								q_bbs_addrow('bbs', t_n, 0);
								//$('#txtUcolor_'+t_n).val($('#txtUcolor_'+t_on).val());
								$('#txtProductno_'+t_n).val($('#txtProductno_'+t_on).val());
								$('#txtProduct_'+t_n).val($('#txtProduct_'+t_on).val());
								$('#textF01_'+t_n).val($('#textF01_'+t_on).val());
								$('#txtStoreno_'+t_n).val($('#txtStoreno_'+t_on).val());
								$('#txtStore_'+t_n).val($('#txtStore_'+t_on).val());
								$('#txtWcost_'+t_n).val($('#txtWcost_'+t_on).val());
								$('#txtPrice_'+t_n).val($('#txtPrice_'+t_on).val());
								$('#textF02_'+t_n).val($('#textF02_'+t_on).val());
								$('#txtMemo_'+t_n).val($('#txtMemo_'+t_on).val());
								$('#textF03_'+t_n).val($('#textF03_'+t_on).val());
								$('#textF04_'+t_n).val($('#textF04_'+t_on).val());
								$('#txtOrdeno_'+t_n).val($('#txtOrdeno_'+t_on).val());
								$('#txtNo2_'+t_n).val($('#txtNo2_'+t_on).val());
								$('#txtWidth2_'+t_n).val($('#txtWidth2_'+t_on).val());
								$('#textF05_'+t_n).val($('#textF05_'+t_on).val());
								$('#textF06_'+t_n).val($('#textF06_'+t_on).val());
								$('#txtWidth_'+t_n).val($('#txtWidth_'+t_on).val());
								$('#txtSize_'+t_n).val($('#txtSize_'+t_on).val());
							}
							$('#txtUno_'+t_n).val($('#stk_tdUno_'+td_n).text());
							$('#txtSpec_'+t_n).val($('#stk_tdSpec_'+td_n).text());
							$('#txtStyle_'+t_n).val($('#stk_tdStyle_'+td_n).text());
							$('#txtWcost_'+t_n).val($('#stk_tdMount_'+td_n).text());
							$('#txtMount_'+t_n).val($('#stk_tdMount_'+td_n).text());
							$('#txtUnit_'+t_n).val($('#stk_tdUnit_'+td_n).text());
							$('#txtWeight_'+t_n).val($('#stk_tdWeight_'+td_n).text());
							$('#txtLengthc_'+t_n).val($('#stk_tdLengthc_'+td_n).text());
							$('#txtLengthb_'+t_n).val($('#stk_tdLengthb_'+td_n).text());
							t_n++;
						}
					});
					
					
					$('#div_stkuj').hide();
				});
				$('#btnClose_div_stkuj2').click(function() {
					$('#div_stkuj').hide();
				});
				
				$('#txtDatea').focusout(function() {
					for (var j = 0; j < q_bbsCount; j++) {
						//if(!emp($('#txtUcolor_'+ j).val()))
						//	$('#txtUcolor_'+ j).change();
						if(!emp($('#txtProductno_'+ j).val()))
							$('#txtProductno_'+ j).change();
					}
				});
			}
			
			function refreshBbm() {
                if (q_cur == 1 || q_cur==2) {
					if($('#chkAtax').prop('checked'))
						$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					else
						$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
                }else{
                	$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }

			function bbsGetOrdeList(){
				var t_custno = $.trim($('#txtCustno').val());
				if(t_custno.length > 0){
					var PnoArray = [];
					for(var j=0;j<q_bbsCount;j++){
						var t_productno = $.trim($('#txtProductno_'+j).val());
						var t_ordeno = $.trim($('#txtOrdeno_'+j).val());
						var t_no2 = $.trim($('#txtNo2_'+j).val());
						if((t_productno.length > 0) && (t_ordeno.length==0) && (t_no2.length==0)){
							PnoArray.push("'"+t_productno+"'");
						}
					}
					if(PnoArray.length > 0){
						var t_where = 'where=^^ 1=1 ';
						t_where += "and ((select isnull(enda,0) from view_orde where noa=a.noa)!=1) ";//BBM未結案
						t_where += "and (isnull(enda,0)!=1) ";//BBS未結案
						t_where += "and (custno=N'"+t_custno+"')";
						t_where += "and (productno in (" +PnoArray.toString()+ "))";
						q_gt('view_ordes', t_where, 0, 0, 0, "GetOrdeList");
					}
				}
			}
			
			function GetTranPrice(){
				var Post2 = $.trim($('#txtPost2').val());
				var Post = $.trim($('#txtPost').val()); 
				var Transtartno = $.trim($('#txtTranstartno').val()); 
				var Cardealno = $.trim($('#txtCardealno').val()); 
				var TranStyle = $.trim($('#cmbTranstyle').val());
				var Carspecno = $.trim(thisCarSpecno);
				var t_where = 'where=^^ 1=1 ';
				t_where += " and post=N'" + (Post2.length>0?Post2:Post) + "' ";
				t_where += " and transtartno=N'" + Transtartno + "' ";
				t_where += " and cardealno=N'" + Cardealno + "' ";
				t_where += " and transtyle=N'" + TranStyle + "' ";
				if(Carspecno.length > 0){
					t_where += " and carspecno=N'" + Carspecno + "' ";
				}
				t_where += ' ^^';
				q_gt('addr', t_where, 0, 0, 0, "GetTranPrice");
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					
                }
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							
							
							//ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtPrice,txtMount,txtMemo', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price,mount,memo', 'txtProductno,txtProduct,txtSpec');
							
							//寫入訂單號碼
							var t_oredeno = '';
							for (var i = 0; i < b_ret.length; i++) {
								if (t_oredeno.indexOf(b_ret[i].noa) == -1)
									t_oredeno = t_oredeno + (t_oredeno.length > 0 ? (',' + b_ret[i].noa) : b_ret[i].noa);
							}
							//取得訂單備註 + 指定地址
							if (t_oredeno.length > 0) {
								var t_where = "where=^^ charindex(noa,'" + t_oredeno + "')>0 ^^";
								q_gt('orde', t_where, 0, 0, 0, "", r_accy);
							}

							$('#txtOrdeno').val(t_oredeno);
							sum();
						}
					case 'pack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#txtItemno_'+b_seq).val(ret[0].packway);
							$('#txtItem_'+b_seq).val(ret[0].pack);
						}
						if(!emp($('#txtProductno_'+b_seq).val()) && !emp($('#txtItemno_'+b_seq).val())){
							var t_where="where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' and packway='"+$('#txtItemno_'+b_seq).val()+"' ^^";
		                	q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
		                	var as = _q_appendData("pack2s", "", true);
							if (as[0] != undefined) {
								var t_gweight=0; //毛重
								var t_nweight=0; //淨重
								var t_mount=dec($('#txtMount_'+b_seq).val());
								var t_uweight=dec(as[0].uweight);
								var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
								var t_inweight=dec(as[0].inweight);
								var t_outweight=dec(as[0].outweight);
								var t_cuft=dec(as[0].cuft);
								t_nweight=q_mul(t_mount,t_uweight);
								var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
								var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
								var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
								t_gweight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
								t_gweight=q_mul(t_pfmount,t_gweight); //整箱毛重
								if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
									var tt_weight=q_mul(t_emount,t_uweight);
									tt_weight=q_add(tt_weight,t_outweight);
									tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
									t_gweight=q_add(t_gweight,tt_weight);
								}
								//$('#txtWeight_'+b_seq).val(t_nweight);
								//$('#txtGweight_'+b_seq).val(t_gweight);
								$('#txtTranmoney2_'+b_seq).val(q_mul(t_cuft,t_pcmount));
		                	}
	                	}
						break;
					
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var t_msg = '';
			var focus_addr = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			var carnoList = [];
			var thisCarSpecno = '';
			function q_gtPost(t_name) {
				var as;
				switch (t_name) {
					case 'GetOrdeList':
						var as = _q_appendData("view_ordes", "", true);
						for(var k=0;k<q_bbsCount;k++){
							var thisPno = $.trim($('#txtProductno_'+k).val());
							if(thisPno.length > 0){
								$('#combOrdelist_'+k+' option').remove();
								$('#combOrdelist_'+k).append($("<option></option>").attr("value",'').text('')); 
								for(var j=0;j<as.length;j++){
									if(as[j].productno==thisPno){
										var FullOrdeno = $.trim(as[j].noa) + '-' + $.trim(as[j].no2);
										$('#combOrdelist_'+k).append($("<option></option>").attr("value",FullOrdeno).text(FullOrdeno)); 
									}
								}
							}
						}
						break;
					case 'getCardealCarno' :
						var as = _q_appendData("cardeals", "", true);
						carnoList = as;
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].carno + '@' + as[i].carno;
							}
						}
						for(var k=0;k<carnoList.length;k++){
							if(carnoList[k].carno==$('#txtCarno').val()){
								thisCarSpecno = carnoList[k].carspecno;
								break;
							}
						}
						document.all.combCarno.options.length = 0;
						q_cmbParse("combCarno", t_item);
						$('#combCarno').unbind('change').change(function(){
							if (q_cur == 1 || q_cur == 2) {
								$('#txtCarno').val($('#combCarno').find("option:selected").text());
							}
							for(var k=0;k<carnoList.length;k++){
								if(carnoList[k].carno==$('#txtCarno').val()){
									thisCarSpecno = carnoList[k].carspecno;
									break;
								}
							}
							GetTranPrice();
						});
						break;
					case 'GetTranPrice' :
						var as = _q_appendData("addr", "", true);
						if (as[0] != undefined) {
							$('#txtPrice').val(as[0].driverprice2);
						}else{
							$('#txtPrice').val(0);
						}
						sum();
						break;
					case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength=document.getElementById("table_stk").rows.length-3;
							for (var j = 1; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
						var stk_row=0;
						
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if(dec(as[i].mount)!=0){
								var tr = document.createElement("tr");
								tr.id = "bbs_"+j;
								tr.innerHTML = "<td id='assm_tdStoreno_"+stk_row+"'><input id='assm_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
								tr.innerHTML+="<td id='assm_tdStore_"+stk_row+"'><input id='assm_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
								tr.innerHTML+="<td id='assm_tdMount_"+stk_row+"'><input id='assm_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
								stk_row++;
							}
							//庫存總計
							stkmount = stkmount + dec(as[i].mount);
						}
						var tr = document.createElement("tr");
						tr.id = "bbs_"+j;
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >倉庫總計：</span></td>";
						tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						
						$('#div_stk').css('top',mouse_point.pageY-parseInt($('#div_stk').css('height')));
						$('#div_stk').css('left',mouse_point.pageX-parseInt($('#div_stk').css('width')));
						$('#div_stk').toggle();
						break;
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'msg_ucc':
						var as = _q_appendData("ucc", "", true);
						t_msg = '';
						if (as[0] != undefined) {
							t_msg = "銷售單價：" + dec(as[0].saleprice) + "<BR>";
						}
						//客戶售價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and datea<'" + q_date() + "' ^^ stop=1";
						q_gt('quat', t_where, 0, 0, 0, "msg_quat", r_accy);
						break;
					case 'msg_quat':
						var as = _q_appendData("quats", "", true);
						var quat_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									quat_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近報價單價：" + quat_price + "<BR>";
						//最新出貨單價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and noa in (select noa from vccs" + r_accy + " where productno='" + $('#txtProductno_' + b_seq).val() + "' and price>0 ) ^^ stop=1";
						q_gt('vcc', t_where, 0, 0, 0, "msg_vcc", r_accy);
						break;
					case 'msg_vcc':
						var as = _q_appendData("vccs", "", true);
						var vcc_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									vcc_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近出貨單價：" + vcc_price;
						q_msg($('#txtPrice_' + b_seq), t_msg);
						break;
					case 'acomp_stk':
						var as = _q_appendData("acomp", "", true);
						var storeno = '';
						for (var i = 0; i < as.length; i++) {
							storeno = storeno + ',' + as[i].noa;
						}
						storeno = storeno.substr(1, storeno.length);
						var t_where = "where=^^ ['" + q_date() + "','" + storeno + "','') where productno='" + $('#txtProductno_' + b_seq).val() + "' ^^";
						q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
						break;
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = stkmount + dec(as[i].mount);
						}
						t_msg = "庫存量：" + stkmount;
						//平均成本
						var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by datea desc ^^ stop=1";
						q_gt('wcost', t_where, 0, 0, 0, "msg_wcost", r_accy);
						break;
					case 'msg_wcost':
						var as = _q_appendData("wcost", "", true);
						var wcost_price;
						if (as[0] != undefined) {
							if (dec(as[0].mount) == 0) {
								wcost_price = 0;
							} else {
								wcost_price = round(q_div(q_add(q_add(q_add(dec(as[0].costa), dec(as[0].costb)), dec(as[0].costc)), dec(as[0].costd)), dec(as[0].mount)), 0);
								//wcost_price=round((dec(as[0].costa)+dec(as[0].costb)+dec(as[0].costc)+dec(as[0].costd))/dec(as[0].mount),0);
							}
						}
						if (wcost_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + wcost_price;
							q_msg($('#txtMount_' + b_seq), t_msg);
						} else {
							//原料成本
							var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by mon desc ^^ stop=1";
							q_gt('costs', t_where, 0, 0, 0, "msg_costs", r_accy);
						}
						break;
					case 'msg_costs':
						var as = _q_appendData("costs", "", true);
						var costs_price;
						if (as[0] != undefined) {
							costs_price = as[0].price;
						}
						if (costs_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + costs_price;
						}
						q_msg($('#txtMount_' + b_seq), t_msg);
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'orde':
						var as = _q_appendData("orde", "", true);
						var t_memo = $('#txtMemo').val();
						var t_post = '';
						var t_addr = '';
						var t_post2 = '';
						var t_addr2 = '';
						for ( i = 0; i < as.length; i++) {
							t_memo = t_memo + (t_memo.length > 0 ? '\n' : '') + as[i].noa + ':' + as[i].memo;
							t_post = t_post+(t_post.length>0?';':'')+as[i].post;
							t_addr = t_addr+(t_addr.length>0?';':'')+as[i].addr;
							t_post2 = t_post2+(t_post2.length>0?';':'')+as[i].post2;
							t_addr2 = t_addr2+(t_addr2.length>0?';':'')+as[i].addr2;
						}
						$('#txtMemo').val(t_memo);
						$('#txtPost').val(t_post);
						$('#txtAddr').val(t_addr);
						$('#txtPost2').val(t_post2);
						$('#txtAddr2').val(t_addr2);
						if (as[0] != undefined){
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							//$('#cmbTaxtype').val(as[0].taxtype);
							$('#cmbCoin').val(as[0].coin);
							$('#txtFloata').val(as[0].floata);
						}
						sum();
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'btnDele':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnDele();
						Unlock(1);
						break;
					case 'btnModi':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnModi();
						Unlock(1);
						$('#txtCustno').focus();
						
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						//取得車號下拉式選單
						var thisVal = $('#txtCardealno').val();
						var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
						q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
						bbsGetOrdeList();
						getcubno();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					case 'sss':
						as = _q_appendData('sss', '', true);
						break;
					case 'startdate':
						var as = _q_appendData('cust', '', true);
						var t_startdate='';
						if (as[0] != undefined) {
							t_startdate=as[0].startdate;
						}
						if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(7, 2)<('00'+t_startdate).slice(-2)){
							$('#txtMon').val($('#txtDatea').val().substr(0, r_lenm));
						}else{
							var t_date=$('#txtDatea').val();
							if(r_len==4){
								var nextdate=new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,1);
					    		nextdate.setMonth(nextdate.getMonth() +1)
					    		t_date=''+(nextdate.getFullYear())+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
							}else{
								var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
					    		nextdate.setMonth(nextdate.getMonth() +1)
					    		t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
					    	}
							$('#txtMon').val(t_date);
						}
						check_startdate=true;
						btnOk();
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
						}
						sum();
						break;
				}
			}
			
			var check_startdate=false;
			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtCustno', q_getMsg('lblCust')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//判斷起算日,寫入帳款月份
				//104/09/30 如果備註沒有*字就重算帳款月份
				//if(!check_startdate && emp($('#txtMon').val())){
				if(!check_startdate && $('#txtMemo').val().substr(0,1)!='*'){	
					var t_where = "where=^^ noa='"+$('#txtCustno').val()+"' ^^";
					q_gt('cust', t_where, 0, 0, 0, "startdate", r_accy);
					return;
				}
				
				check_startdate=false;
				t_err='';
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr='';
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							tstr+="@,#"+$('#'+fbbs[j]+'_'+i).val();
						}
					}
					$('#txtSize_'+i).val(tstr);
					
					if(dec($('#txtMount_'+i).val())>dec($('#txtWcost_'+i).val())){
						t_err+='第'+(i+1)+'項出貨數量【'+dec($('#txtMount_'+i).val())+'】大於可用庫存數量【'+dec($('#txtWcost_'+i).val())+'】';
					}
				}
				
				if(t_err.length>0){
					alert(t_err);
					return;
				}
					
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}
			
			function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtSize_'+i).val().split('@,#');
					var tstc=1;
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							$('#'+fbbs[j]+'_'+i).val(tstr[tstc]);
							tstc++;
						}
					}
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('vcc_s.aspx', q_name + '_s', "500px", "630px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPay");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}
			
			var mouse_point;
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						/*$('#txtUcolor_'+ i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var t_engpro=$.trim($('#txtUcolor_'+ b_seq).val());
							if(t_engpro.length>0){
								var t_where = "where=^^ engpro='" + t_engpro + "' ^^ stop=1";
								q_gt('uca', t_where, 0, 0, 0, "getuca", r_accy,1);
								var as = _q_appendData("uca", "", true);
								if (as[0] != undefined) {
									$('#txtProductno_'+b_seq).val(as[0].noa);//新料號
									$('#textF01_'+b_seq).val(as[0].groupdno);//銷售政策
									$('#txtUnit_'+b_seq).val(as[0].unit);//單位
									$('#textF05_'+b_seq).val(as[0].style.split('#^#')[8]);//長度備註
									$('#textF06_'+b_seq).val(as[0].rev);//產品系列
									$('#txtWidth_'+b_seq).val(as[0].mechs);//寬幅
									$('#txtLengthb_'+b_seq).val(as[0].trans);//標準長
								}else{
									$('#txtProductno_'+b_seq).val(t_engpro);
									var t_where = "where=^^ noa='" + t_engpro + "' ^^ stop=1";
									q_gt('uca', t_where, 0, 0, 0, "getuca", r_accy,1);
									var as = _q_appendData("uca", "", true);
									if (as[0] != undefined) {
										$('#textF01_'+b_seq).val(as[0].groupdno);//銷售政策
										$('#txtUnit_'+b_seq).val(as[0].unit);//單位
										$('#textF05_'+b_seq).val(as[0].style.split('#^#')[8]);//長度備註
										$('#textF06_'+b_seq).val(as[0].rev);//產品系列
										$('#txtWidth_'+b_seq).val(as[0].mechs);//寬幅
										$('#txtLengthb_'+b_seq).val(as[0].trans);//標準長
									}
								}
								
								//庫存
								var t_pno=$('#txtProductno_'+b_seq).val();
								var t_sno=$('#txtStoreno_'+b_seq).val();
								var t_uno=$('#txtUno_'+b_seq).val();
								if(t_sno.length==0){
									t_sno='#non';
								}
								if(t_uno.length==0){
									t_uno='#non';
								}
								if(t_pno.length>0){
									var t_mount=0;
									var tdatea=emp($('#txtDatea').val())?q_date():$('#txtDatea').val();
									q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(tdatea)+';'+encodeURI(t_uno)+';'+encodeURI(t_pno)+';'+encodeURI(t_sno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
									var as = _q_appendData("tmp0", "", true, true);
									for(var j=0;j<as.length;j++){
										if(as[j].storeno==$('#txtStoreno_'+b_seq).val())
											t_mount=q_add(t_mount,dec(as[j].mount));
									}
									
									$('#txtWcost_'+b_seq).val(t_mount);//庫存
								}
							}else{
								$('#txtProductno_'+b_seq).val('');//新料號
								$('#textF01_'+b_seq).val('');//銷售政策
								$('#txtUnit_'+b_seq).val('');//單位
								$('#textF05_'+b_seq).val('');//長度備註
								$('#textF06_'+b_seq).val('');//產品系列
								$('#txtWidth_'+b_seq).val('');//寬幅
								$('#txtWcost_'+b_seq).val('');//庫存
								$('#txtLengthb_'+b_seq).val('');//標準長
								$('#txtLengthc_'+b_seq).val('');//原長度
							}
							
							$('#textF01_'+b_seq).change();
						});*/
						
						$('#txtStoreno_'+ i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#btnUno_'+i).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var tpno=$('#txtProductno_'+b_seq).val();
							var tsno=$('#txtStoreno_'+b_seq).val();
							var trno=emp($('#txtRackno_'+b_seq).val())?'#non':$('#txtRackno_'+b_seq).val();
							var tuno=emp($('#txtUno_'+b_seq).val())?'#non':$('#txtUno_'+b_seq).val();
							var tnoa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
							var tdatea=emp($('#txtDatea').val())?q_date():$('#txtDatea').val();
							
							if(!(q_cur==1 || q_cur==2)){
								return;
							}
							if(tpno.length>0 && tsno.length>0){
								$('#Stkuj_Seq').val(b_seq);
								q_func('qtxt.query.div_stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(tdatea)+';'+encodeURI('#non')+';'+encodeURI(tpno)+';'+encodeURI(tsno)+';'+encodeURI(trno)+';'+encodeURI(tnoa)+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								//扣除表身已存在的庫存
								for (var k = 0; k < q_bbsCount; k++) {
									for(var j=0;j<as.length;j++){
										if($('#txtUno_'+k).val()==as[j].uno && $('#txtSpec_'+k).val()==as[j].spec && $('#txtStyle_'+k).val()==as[j].style && b_seq!=k){
											as[j].mount=q_sub(as[j].mount,dec($('#txtMount_'+k).val()));
											as[j].weight=q_sub(as[j].weight,dec($('#txtWeight_'+k).val()));
											
											if(as[j].mount<=0 || as[j].weight<=0){
												as.splice(j, 1);
												j--;
											}
											
											break;
										}
									}
								}
								
								
								//刪除之前的內容
								var rowslength=document.getElementById("table_stkuj").rows.length-2;
								for (var j = 0; j < rowslength; j++) {
									document.getElementById("table_stkuj").deleteRow(1);
								}
								
								for(var j=0;j<as.length;j++){
									if(as[j].mount==1){
										as[j].lengthc=as[j].weight;
										as[j].lengthb='';
									}else{
										as[j].lengthc='';
									}
									
									var tr = document.createElement("tr");
									tr.id = "bbs_"+j;
									tr.innerHTML+="<td><input id='stk_tdSel_"+j+"' type='checkbox'></td>"; //chk
									tr.innerHTML+="<td id='stk_tdUno_"+j+"'>"+as[j].uno+"</td>"; //身分證號
									tr.innerHTML+="<td id='stk_tdSpec_"+j+"'>"+as[j].spec+"</td>"; //列管品
									tr.innerHTML+="<td id='stk_tdStyle_"+j+"' style='display:none;'>"+as[j].style+"</td>"; //加工製造備註
									tr.innerHTML+="<td id='stk_tdIndate_"+j+"' style='text-align:center;'>"+as[j].indate+"</td>"; //進貨(生產)日
									tr.innerHTML+="<td id='stk_tdMount_"+j+"' style='text-align:right;'>"+FormatNumber(as[j].mount)+"</td>"; //庫存數量
									tr.innerHTML+="<td id='stk_tdUnit_"+j+"' style='text-align:center;'>"+as[j].unit+"</td>"; //單位
									tr.innerHTML+="<td id='stk_tdLengthb_"+j+"' style='text-align:right;'>"+FormatNumber(as[j].lengthb)+"</td>"; //標準長(M)同規格
									tr.innerHTML+="<td id='stk_tdLengthc_"+j+"' style='text-align:right;'>"+FormatNumber(as[j].lengthc)+"</td>"; //原長(M)
									tr.innerHTML+="<td id='stk_tdWeight_"+j+"' style='text-align:right;'>"+FormatNumber(as[j].weight)+"</td>"; //可用長
									
									var tmp = document.getElementById("stkuj_close");
									tmp.parentNode.insertBefore(tr,tmp);
								}
								if(as.length>0){
									$('#div_stkuj').css('top', e.pageY- $('#div_stkuj').height());
									$('#div_stkuj').css('left', e.pageX+10);
									$('#div_stkuj').show();
								}else
									alert('無庫存資料!!');
							}else{
								if(tpno.length==0){
									alert('請輸入料號!!');
								}else{
									alert('請輸入倉庫!!');	
								}
							}
						});
						
						$('#txtWidth3_'+i).change(function() {
							sum();
						});
						
						//--------------------------------------------------------------
						$('#combOrdelist_'+i).change(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var thisVal = $.trim($(this).val());
							var ValArray = thisVal.split('-');
							if(ValArray[0] && ValArray[1]){
								$('#txtOrdeno_' + n).val(ValArray[0]);
								$('#txtNo2_' + n).val(ValArray[1]);
							}
							$(this).val('');
						});
						
						$('#txtPrice_' + i).focusout(function() {
							sum();
						});
						
						$('#txtMount_' + i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
								
							if (q_cur == 1 || q_cur == 2){
								if($('#txtWcost_'+b_seq).val()>1){
									$('#txtWeight_'+b_seq).val(q_mul(dec($('#txtMount_'+b_seq).val()),dec($('#txtLengthb_'+b_seq).val())));
								}else{
									$('#txtWeight_'+b_seq).val(dec($('#txtLengthc_'+b_seq).val()));
								}
								
								sum();
								
							}
							//$('#btnClose_div_stk').click();
						});
						
						$('#txtMount_' + i).focusin(function(e) {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								/*if (!emp($('#txtProductno_' + b_seq).val())) {
									//庫存
									//var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "')  ^^";
									//q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
									//顯示DIV 104/03/21
									mouse_point=e;
									mouse_point.pageY=$('#txtMount_'+b_seq).offset().top;
									mouse_point.pageX=$('#txtMount_'+b_seq).offset().left;
									document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
									document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
									//庫存
									var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
									q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
								}*/
							}
						});
						$('#txtPrice_' + i).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								/*if (!emp($('#txtProductno_' + b_seq).val())) {
									var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
									q_gt('ucc', t_where, 0, 0, 0, "msg_ucc", r_accy);
								}*/
							}
						});

						$('#btnRecord_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
							t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
						
						$('#btnStk_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
								mouse_point=e;
								document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
								document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
								//庫存
								var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
								q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
							}
						});
						
						$('#btnPackway_'+i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							t_where = "noa='" + $('#txtProductno_'+b_seq).val() +"' and packway='" + $('#txtCustno').val() + "'";
							q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", '包裝方式');
						});
						
						//每個欄位變動都去變動合併儲存格
						for (var j = 0; j < fbbs.length; j++) {
							if(fbbs[j].substr(0,4)=='text'){
								$('#'+fbbs[j]+'_'+i).change(function() {
									t_IdSeq = -1;
				                    q_bodyId($(this).attr('id'));
				                    b_seq = t_IdSeq;
				                    
				                    var tstr='';
									for (var k = 0; k < fbbs.length; k++) {
										if(fbbs[k].substr(0,4)=='text'){
											tstr+="@,#"+$('#'+fbbs[k]+'_'+b_seq).val();
										}
									}
									
									$('#txtSize_'+b_seq).val(tstr);
								});
							}
						}
					}
				}
				_bbsAssign();
				HiddenTreat();
				refreshBbm();
				stype_chang();
				splitbbsf();
				
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtDatea').val(q_date());
				$('#cmbTypea').val('1');
				$('#txtDatea').focus();
				//$('#cmbTaxtype').val('1');
				stype_chang();
				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				Lock(1, {
					opacity : 0
				});
				var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnModi', r_accy);
			}

			function btnPrint() {
				q_box('z_vccp_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total']) && !as['ordeno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['typea'] = abbm2['typea'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['custno'] = abbm2['custno'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];

				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}
				return true;
			}

			function q_stPost() {
				if (q_cur == 1 || q_cur == 2) {
					var s2 = xmlString.split(';');
					abbm[q_recno]['accno'] = s2[0];
				}
			}

			function refresh(recno) {
				_refresh(recno);
				HiddenTreat();
				stype_chang();
				refreshBbm();
				getinvomemo();
			}

			function HiddenTreat(returnType){
				returnType = $.trim(returnType).toLowerCase();
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				var hasRackComp = q_getPara('sys.rack');
				var isRack = (hasRackComp.toString()=='1'?$('.isRack').show():$('.isRack').hide());
				if(returnType=='style'){
					return (hasStyle.toString()=='1');
				}else if(returnType=='spec'){
					return (hasSpec.toString()=='1');
				}else if(returnType=='rack'){
					return (hasRackComp.toString()=='1');
				}
			}
			
			function stype_chang(){
				if($('#cmbStype').val()=='3'){
					$('.invo').show();
					$('.vcca').hide();
				}else{
					$('.invo').hide();
					$('.vcca').show();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
				HiddenTreat();
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				if ($('#txtMemo').val().substr(0,1)=='*')
					$('#txtMon').removeAttr('readonly');
				else
					$('#txtMon').attr('readonly', 'readonly');
				refreshBbm();
			}

			function btnMinus(id) {
				_btnMinus(id);
				var n=id.split('_')[id.split('_').length-1];
				$('#combOrdelist_'+n+' option').remove();
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
				if (q_chkClose())
					return;
				Lock(1, {
					opacity : 0
				});
				
				var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnDele', r_accy);
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						var t_pno=$.trim($('#txtProductno_'+ b_seq).val());
						if(t_pno.length>0){
							var t_where = "where=^^ noa='" + t_pno + "' ^^ stop=1";
							q_gt('uca', t_where, 0, 0, 0, "getuca", r_accy,1);
							var as = _q_appendData("uca", "", true);
							if (as[0] != undefined) {
								$('#txtProduct_'+b_seq).val(as[0].product);//物品名稱
								$('#textF01_'+b_seq).val(as[0].groupdno);//銷售政策
								$('#txtUnit_'+b_seq).val(as[0].unit);//單位
								$('#textF05_'+b_seq).val(as[0].style.split('#^#')[8]);//長度備註
								$('#textF06_'+b_seq).val(as[0].rev);//產品系列
								$('#txtWidth_'+b_seq).val(as[0].mechs);//寬幅
								$('#txtLengthb_'+b_seq).val(as[0].trans);//標準長
							}
							
							//庫存
							var t_sno=$('#txtStoreno_'+b_seq).val();
							var t_rno=$('#txtRackno_'+b_seq).val();
							var t_uno=$('#txtUno_'+b_seq).val();
							if(t_sno.length==0){
								t_sno='#non';
							}
							if(t_rno.length==0){
								t_rno='#non';
							}
							if(t_uno.length==0){
								t_uno='#non';
							}
							if(t_pno.length>0){
								var t_mount=0;
								var tdatea=emp($('#txtDatea').val())?q_date():$('#txtDatea').val();
								q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(tdatea)+';'+encodeURI(t_uno)+';'+encodeURI(t_pno)+';'+encodeURI(t_sno)+';'+encodeURI(t_rno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								for(var j=0;j<as.length;j++){
									if(as[j].storeno==$('#txtStoreno_'+b_seq).val())
										t_mount=q_add(t_mount,dec(as[j].mount));
								}
								
								$('#txtWcost_'+b_seq).val(t_mount);//庫存
							}
							
							var t_custno=emp($('#txtCustno').val())?'#non':$('#txtCustno').val();
							var t_datea=emp($('#txtDatea').val())?q_date():$('#txtDatea').val();
							
							q_func('qtxt.query.getcustprices', 'orde_uj.txt,getcustprices,' + encodeURI(t_pno)+';'+encodeURI(t_custno)+';'
							+';'+encodeURI(t_datea),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								$('#txtPrice_'+b_seq).val(as[0].price);
								sum();
							}
							
						}else{
							$('#txtProductno_'+b_seq).val('');//新料號
							$('#txtProduct_'+b_seq).val('');//物品名稱
							$('#textF01_'+b_seq).val('');//銷售政策
							$('#txtUnit_'+b_seq).val('');//單位
							$('#textF05_'+b_seq).val('');//長度備註
							$('#textF06_'+b_seq).val('');//產品系列
							$('#txtWidth_'+b_seq).val('');//寬幅
							$('#txtWcost_'+b_seq).val('');//庫存
							$('#txtLengthb_'+b_seq).val('');//標準長
							$('#txtLengthc_'+b_seq).val('');//原長度
						}
							
						$('#textF01_'+b_seq).change();
						break;
					//---------------------------------------------
					case 'txtStoreno_':
						var t_pno=$('#txtProductno_'+b_seq).val();
						var t_sno=$('#txtStoreno_'+b_seq).val();
						var t_rno=$('#txtRackno_'+b_seq).val();
						var t_uno=$('#txtUno_'+b_seq).val();
						if(t_sno.length==0){
							t_sno='#non';
						}
						if(t_rno.length==0){
							t_rno='#non';
						}
						if(t_uno.length==0){
							t_uno='#non';
						}
						if(t_pno.length>0){
							var t_mount=0;
							var tdatea=emp($('#txtDatea').val())?q_date():$('#txtDatea').val();
							q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(tdatea)+';'+encodeURI(t_uno)+';'+encodeURI(t_pno)+';'+encodeURI(t_sno)+';'+encodeURI(t_rno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							for(var j=0;j<as.length;j++){
								if(as[j].storeno==$('#txtStoreno_'+b_seq).val())
									t_mount=q_add(t_mount,dec(as[j].mount));
							}
							
							$('#txtWcost_'+b_seq).val(t_mount);//庫存
						}
						break;
					//-----------------------------------------------
					case 'txtCardealno':
						//取得車號下拉式選單
						var thisVal = $('#txtCardealno').val();
						var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
						q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
						//GetTranPrice();
						break;
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						getinvomemo();
						getcubno();
						//bbsGetOrdeList();
						break;
					/*case 'txtPost2':
						GetTranPrice();
						break;
					case 'txtPost':
						GetTranPrice();
						break;
					case 'txtTranstartno':
						GetTranPrice();
						break;
					case 'txtProductno_':
						bbsGetOrdeList();
						break;*/	
				}
			}
			
			function getinvomemo() {
				if(emp($('#txtCustno').val())){
					$('#lblInvomemo').text('');
				}else{
					q_gt('custm',"where=^^ noa='"+$('#txtCustno').val()+"'^^", 0, 0, 0, "getinvomemo", r_accy,1);
					var as = _q_appendData("custm", "", true);
					if(as[0] != undefined){
						$('#lblInvomemo').text(as[0].invomemo);
					}else{
						$('#lblInvomemo').text('');
					}
				}
			}
			
			function getcubno() {
				$('#cmbCubnouj').text('');
				if(!emp($('#txtCustno').val())){
					var t_custno=$('#txtCustno').val();
					q_gt('view_cub',"where=^^ custno='"+t_custno+"' and isnull(enda,0)=1 ^^", 0, 0, 0, "getcub", r_accy,1);
					var as = _q_appendData("view_cub", "", true);
					var t_item = " @ ";
					if (as[0] != undefined) {
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].product + '@' + as[i].product;
						}
					}
					q_cmbParse("cmbCubnouj", t_item);
				}
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
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
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
				width: 70%;
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
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 30%;
				float: left;
			}
			.txt.c3 {
				width: 68%;
				float: left;
			}
			.txt.c4 {
				width: 49%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
				</tr>
				<tr id='stk_top'>
					<td align="center" style="width: 30%;">倉庫編號</td>
					<td align="center" style="width: 45%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">倉庫數量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		
		<div id="div_stkuj" style="position:absolute; top:180px; left:20px; display:none; width:850px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stkuj" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="width:20px;" align="center">選擇</td>
					<td style="width:150px;" align="center">身分證號</td>
					<td style="width:100px;" align="center">列管品</td>
					<td style="width:100px;" align="center">進貨<BR>(生產)日</td>
					<td style="width:100px;" align="center">數量</td>
					<td style="width:70px;" align="center">單位</td>
					<td style="width:100px;" align="center">標準長(M)<BR>同規格</td>
					<td style="width:100px;" align="center">原長(M)</td>
					<td style="width:100px;" align="center">可用長</td>
				</tr>
				<tr id='stkuj_close'>
					<td align="center" colspan='11'>
						<input id="btnClose_div_stkuj" type="button" value="確定">
						<input id="btnClose_div_stkuj2" type="button" value="取消">
						<input id="Stkuj_Seq" type="hidden">
					</td>
				</tr>
			</table>
		</div>
		
		<div id="dmain" style="width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:5%"><a id='vewType'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%;display: none;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewTimea_uj'>指令名稱</a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa' style="display: none;">~noa</td>
						<td align="center" id='timea'>~timea</td>
						<td align="center" id='comp,4'>~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr>
						<td style="width: 108px;"><span> </span><a id='lblType' class="lbl"> </a></td>
						<td style="width: 108px;"><select id="cmbTypea"> </select></td>
						<td style="width: 108px;">
							<a id='lblStype' class="lbl" style="float: left;"> </a>
							<span style="float: left;"> </span>
							<select id="cmbStype"> </select>
						</td>
						<td style="width: 108px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td style="width: 108px;"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td style="width: 108px;"><input id="txtNoa" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td> </td>
						<td>
							<span> </span>
							<a id='lblInvono' class="lbl btn vcca"> </a>
							<a id='lblInvo' class="lbl btn invo"> </a>
						</td>
						<td>
							<input id="txtInvono" type="text" class="txt c1 vcca"/>
							<input id="txtInvo" type="text" class="txt c1 invo"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPay' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPay" style="width: 100%;" onchange='combPay_chg()'> </select></td>
						<td><span> </span><a id="lblTimea_uj" class="lbl btn">生產指令名稱</a></td>
						<td><input id="txtTimea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td colspan='2'><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td colspan='2'><input id="txtFax" type="text" class="txt c1"/></td>
						<td colspan='2' align="center">	
							<!--<input id="btnOrdes" type="button"/>-->
							<input id="btnCubs" type="button" value="匯入生產指令"/>
							<select id="cmbCubnouj" style="width: 20px;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr" class="lbl btn"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" style="width: 100%;"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl btn"> </a></td>
						<td><input id="txtPost2"  type="text" class="txt c1"/></td>
						<td colspan='4'>
							<input id="txtAddr2"  type="text" class="txt c1" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td><span> </span><a id='lblOrdeno' class="lbl btn"> </a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td><input id="txtSalesno" type="text" class="txt c1"/></td>
						<td><input id="txtSales" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td><input id="txtCardealno" type="text" class="txt c1"/></td>
						<td><input id="txtCardeal" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td>
							<input id="txtCarno"  type="text" class="txt" style="width:75%;"/>
							<select id="combCarno" style="width: 20%;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales2_uj' class="lbl btn">指送客戶</a></td>
						<td><input id="txtSalesno2" type="text" class="txt c1"/></td>
						<td><input id="txtSales2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblKind_uj' class="lbl">原單追加</a></td>
						<td><select id="cmbKind" style="width: 100%;"> </select></td>
						<td> </td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1"/></td>
					</tr>
					<!--<tr>
						<td><select id="cmbTranstyle" style="width: 100%;"> </select></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblTranstart' class="lbl btn"> </a></td>
						<td><input id="txtTranstartno" type="text" class="txt c1"/></td>
						<td><input id="txtTranstart" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTranadd' class="lbl"> </a></td>
						<td><input id="txtTranadd" type="text" class="txt num c1"/></td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td colspan='2'><input id="txtMoney" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtTax" type="text" class="txt num c1 istax"  style="width: 49%;"/>
							<!--<select id="cmbTaxtype" style="width: 49%;" onchange="calTax();"> </select>-->
							<input id="chkAtax" type="checkbox" />
						</td>
						<td><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 istax"/></td>
					</tr>
					<tr>
						<td class="cust2" style="display: none;"><span> </span><a id="lblCust2" class="lbl btn"> </a></td>
						<td class="cust2" style="display: none;"><input id="txtCustno2" type="text" class="txt c1"/></td>
						<td class="cust2" style="display: none;"><input id="txtComp2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" style="width: 100%;" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblTotalus" class="lbl"> </a></td>
						<td colspan='2'><input id="txtTotalus" type="text" class="txt num c1"/></td>
						<!--<td><span> </span><a id='lblCuft_r' class="lbl">Total Cuft</a></td>
						<td colspan="2"><input id="txtCartrips" type="text" class="txt num c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td colspan='2'><input id="txtAccno" type="text" class="txt c1"/></td>
						<td> </td>
						<td><a id='lblInvomemo' class="lbl" style="color: red;float: left;"> </a></td>
						<!--<td align="right"><input id="btnst4rc2vcc" type="button" value="轉回典盈" style="display: none;"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='7'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 2030px;">
			<table id="tbbs" class='tbbs'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;width:" /></td>
					<td align="center" style="width:55px;"><a id='lblNoq_uj_s'>項次</a></td>
					<td align="center" style="width:170px;display: none;"><a id='lblUcolor_uj_s'>料號(需求)</a></td>
					<td align="center" style="width:170px;"><a id='lblProductno_uj_s'>料號</a></td>
					<td align="center" style="width:170px;"><a id='lblProduct_uj_s'>出貨名稱</a></td>
					<td align="center" style="width:55px;"><a id='lblF01_uj_s'>銷售<BR>政策</a></td>
					<td align="center" style="width:60px;"><a id='lblStoreno_uj_s'>出貨<BR>倉別</a></td>
					<td align="center" style="width:60px;"><a id='lblRackno_uj_s'>儲位</a></td>
					<td align="center" style="width:75px;"><a id='lblWcost_uj_s'>庫存</a></td>
					<td align="center" style="width:140px;"><a id='lblUno_uj_s'>批號</a></td>
					<td align="center" style="width:110px;"><a id='lblSpec_uj_s'>列管備註<BR>加工/製造備註</a></td>
					<td align="center" style="width:80px;"><a id='lblMount_uj_s'>出貨數量</a></td>
					<td align="center" style="width:55px;"><a id='lblUnit_uj_s'>單位</a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_uj_s'>單價</a></td>
					<td align="center" style="width:100px;"><a id='lblTotal_uj_s'>小計</a></td>
					<td align="center" style="width:120px;"><a id='lblF02_uj_s'>板號</a></td>
					<td align="center" style="width:180px;"><a id='lblMemo_uj_s'>備註</a></td>
					<td align="center" style="width:80px;"><a id='lblWidth2_uj_s'>Booking</a></td>
					<td align="center" style="width:120px;"><a id='lblF05_uj_s'>長度備註</a></td>
					<td align="center" style="width:90px;"><a id='lblWidth3_uj_s'>台幣</a></td>
					<td align="center" style="width:55px;"><a id='lblF06_uj_s'>產品<BR>系列</a></td>
					<td align="center" style="width:80px;"><a id='lblWidth_uj_s'>寬幅</a></td>
					<td align="center" style="width:90px;"><a id='lblWeight_uj_s'>指定長</a></td>
					<!--<td align="center" style="width:80px;"><a id='lblPack_s'>包裝方式</a></td>
					<td align="center" style="width:85px;"><a id='lblCuft_s'>材積</a></td>-->
					<!--<td align="center" style="width:100px;" class="isRack"><a id='lblRackno_s'> </a></td>-->
					<!--<td align="center" style="width:40px;"><a id='lblRecord_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblStk_s'> </a></td>-->
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td align="center">
						<input class="txt c1" id="txtNoq.*" type="text"/>
						<input class="txt c1" id="txtSize.*" type="hidden"/>
					</td>
					<td style="display: none;"><input class="txt c1" id="txtUcolor.*" type="text" /></td>
					<td><input class="txt c1" id="txtProductno.*" type="text" /></td>
					<td><input class="txt c1" id="txtProduct.*" type="text"/></td>
					<td><input class="txt c1" id="textF01.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtStoreno.*" type="text"/>
						<!--<input class="btn" id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />-->
						<input class="txt c1" id="txtStore.*" type="text" style="display: none;"/>
					</td>
					<td><input class="txt c1" id="txtRackno.*" type="text" /></td>
					<td><input class="txt num c1" id="txtWcost.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtUno.*" type="text" style="width: 115px;" />
						<input class="btn" id="btnUno.*" type="button" value='.' style=" font-weight: bold;width: 20px;" />
					</td>
					<td>
						<input class="txt c1" id="txtSpec.*" type="text" />
						<input class="txt c1" id="txtStyle.*" type="text" />
					</td>
					<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td><input class="txt num c1" id="txtPrice.*" type="text"/></td>
					<td><input class="txt num c1" id="txtTotal.*" type="text"/></td>
					<td><input class="txt c1" id="textF02.*" type="text" /></td>
					<td align="center">
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<!--<select id="combOrdelist.*" style="width: 10%;"> </select>-->
						<input class="txt c1" id="textF03.*" type="text" style="width:69%;"/><!--生產指令號-->
						<input class="txt c1" id="textF04.*" type="text" style="width:25%;"/><!--生產指令序-->
						<input class="txt c1" id="txtOrdeno.*" type="text" style="width:64%;display: none;"/><!--訂單號-->
						<input class="txt c1" id="txtNo2.*" type="text" style="width:30%;display: none;"/><!--訂單序-->
					</td>
					<td><input class="txt num c1" id="txtWidth2.*" type="text" /></td>
					<td><input class="txt c1" id="textF05.*" type="text" /></td>
					<td><input class="txt num c1" id="txtWidth3.*" type="text" /></td>
					<td><input class="txt c1" id="textF06.*" type="text" /></td>
					<td><input class="txt num c1" id="txtWidth.*" type="text" /></td>
					<td>
						<input class="txt num c1" id="txtWeight.*" type="text" />
						<input class="txt num c1" id="txtLengthb.*" type="hidden" /><!--存放標準長-->
						<input class="txt num c1" id="txtLengthc.*" type="hidden" /><!--存放原長度-->
					</td>
					<!--
					<td>
						<input id="txtItemno.*" type="text" class="txt c1" style="width: 60%;"/>
						<input class="btn" id="btnPackway.*" type="button" value='.' style=" font-weight: bold;"/>
						<input id="txtItem.*" type="text" class="txt c1"/>
					</td>
					<td><input  id="txtTranmoney2.*" type="text" class="txt num c7"/></td>
					-->
					<!--
					<td class="isRack">
						<input class="btn" id="btnRackno.*" type="button" value='.' style="float:left;" />
						<input id="txtRackno.*" type="text" class="txt c1" style="width: 70%"/>
					</td>
					-->
					<!--<td align="center"><input class="btn" id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnStk.*" type="button" value='.' style="width:1%;"/></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>