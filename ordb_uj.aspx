<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			q_tables = 's';
			var q_name = "ordb";
			var q_readonly = ['txtOrdcno','txtWorkgno', 'txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtTotal', 'txtTotalus','txtApv'];
			var q_readonlys = ['txtNo3','txtStdmount', 'txtNo2', 'txtTotal', 'txtC1', 'txtNotv', 'txtOmount','chkEnda','txtOrdeno','txtNo2'];
			var bbmNum = [
				['txtFloata', 10, 5, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],
				['txtTotal', 10, 0, 1], ['txtTotalus', 10, 0, 1]
			];
			//chkIsnotdeal 功能未知 先隱藏
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			//q_xchg = 1;
			brwCount2 = 10;
			aPop = new Array(
				['txtProductno1_', 'btnProduct1_', 'ucaucc2', 'noa,product,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtProduct_', 'ucaucc2_b.aspx'],
				['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtProduct_', 'bcc_b.aspx'],
				['txtProductno3_', 'btnProduct3_', 'fixucc', 'noa,namea,unit', 'txtProductno3_,txtProduct_,txtUnit_,txtProduct_', 'fixucc_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype', 'txtTggno,txtTgg,txtNick,txtPaytype', 'tgg_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']
			);

			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				var t_db=q_db.toLocaleUpperCase();
				q_gt('acomp', "where=^^(dbname='"+t_db+"' or not exists (select * from acomp where dbname='"+t_db+"')) ^^ stop=1", 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_float = q_float('txtFloata');

				for (var j = 0; j < q_bbsCount; j++) {
					t_weights = q_float('txtWeight_' + j);
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					t_moneys = round(q_mul(t_prices, t_mounts), 0);

					t_weight = q_add(t_weight, t_weights);
					t_mount = q_add(t_mount, t_mounts);
					t_money = q_add(t_money, t_moneys);

					$('#txtTotal_' + j).val(q_trv(t_moneys, 0, 1));
				}
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						t_tax = round(q_mul(t_money, t_taxrate), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '3':
						// 內含
						t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
						t_total = t_money;
						t_money = q_sub(t_total, t_tax);
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(q_trv(round(q_mul(t_weight, t_price), 0), 0, 1));
				}
				$('#txtWeight').val(q_trv(t_weight, 0, 1));

				$('#txtMoney').val(q_trv(t_money, 0, 1));
				$('#txtTax').val(q_trv(t_tax, 0, 1));
				$('#txtTotal').val(q_trv(t_total, 0, 1));
				$('#txtTotalus').val(q_trv(round(q_mul(q_float('txtTotal'), q_float('txtFloata')), 2), 0, 1));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				bbsNum = [['txtMount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtOmount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1],
										['txtTotal', 10, 0, 1], ['txtC1', 10, q_getPara('rc2.mountPrecision'), 1], ['txtNotv', 10, q_getPara('rc2.mountPrecision'), 1], ['txtStdmount', 10, q_getPara('rc2.mountPrecision'), 1]];
				
				bbsMask = [['txtLdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('ordb.kind'));
				q_cmbParse("cmbKind2",'一般@一般,希得@希得');
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#combAddr").change(function(e) {
					if (q_cur == 1 || q_cur == 2) {
						$('#txtAddr').val($('#combAddr').find("option:selected").text());
						$('#txtPost').val($('#combAddr').find("option:selected").val());
					}
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				});
				
				$('#btnOrde').hide();
				//變動按鈕
				$('#txtAddr').change(function() {
					var t_where = "where=^^ noa='" + trim($(this).val()) + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "", r_accy);
				});

				$('#txtFloata').change(function() {
					sum();
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtTggno').change(function() {
					loadCustAddr($.trim($(this).val()));
				});
				$('#btnOrdc').click(function(e) {
					$('#exportordc').toggle();
					$('#textBno_a').val($('#txtNoa').val());
					$('#textEno_a').val($('#txtNoa').val());
				});
				$('#btnExport_a').click(function(e) {
					var t_tggno = $('#textTggno_a').val();
					var t_datea = $('#textDatea_a').val();
					var t_bedate = $('#textBedate_a').val();
					var t_eedate = $('#textEedate_a').val();
					var t_bfdate = $('#textBfdate_a').val();
					var t_efdate = $('#textEfdate_a').val();
					var t_bodate = $('#textBodate_a').val();
                    var t_eodate = $('#textEodate_a').val();
                    var t_bldate = $('#textBldate_a').val();
                    var t_eldate = $('#textEldate_a').val();
					var t_bproductno = $('#textBproductno_a').val();
                    var t_eproductno = $('#textEproductno_a').val();
					var t_workgno = $('#textWorkgno_a').val();
					var t_bno = $('#textBno_a').val();
					var t_eno = $('#textEno_a').val();
					if (t_datea.length > 0) {
						Lock(1, {
							opacity : 0
						});
						q_func('qtxt.query.ordb', 'ordb.txt,ordc,' + encodeURI(r_userno) + ';' + encodeURI(r_name) + ';' + encodeURI(q_getPara('key_ordc')) + ';' + encodeURI(t_datea) + ';' + encodeURI(t_tggno)
						+ ';' + encodeURI(t_bedate) + ';' + encodeURI(t_eedate) + ';' + encodeURI(t_bfdate) + ';' + encodeURI(t_efdate) + ';' + encodeURI(t_workgno) + ';' + encodeURI(t_bno) + ';' + encodeURI(t_eno)
						+ ';' + encodeURI(t_bodate) + ';' + encodeURI(t_eodate)
                        + ';' + encodeURI(t_bldate) + ';' + encodeURI(t_eldate)
                        + ';' + encodeURI(t_bproductno) + ';' + encodeURI(t_eproductno));
					} else
						alert('請輸入採購日期。');
				});
				$('#btnClose_a').click(function(e) {
					$('#exportordc').toggle();
				});
				//--------------------------------------------------------
				
				$('#lblOrdcno').click(function(e){
                    var t_where = "1!=1";
                    var t_ordcno = $('#txtOrdcno').val().split(',');
                    for(var i in t_ordcno){
                        if(t_ordcno[i].length>0)
                            t_where += " or noa='"+t_ordcno[i]+"'";
                    }
                    q_box("ordc.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
                });
                
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				//判斷核准(手動)是否顯示
				$('.apv').hide();
				
				$("#cmbKind2").change(function(e) {
                    refreshBbs();
                });
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.ordb':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_msg = '';
							for (var i = 0; i < as.length; i++) {
								t_msg += (t_msg.length > 0 ? '\r\n' : '') + as[i].memo;
							}
							alert(t_msg);
							if (as.length > 1)
							    window.open("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";action=z_ordbp06;" + r_accy);
							location.replace("ordb.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";;" + r_accy);
						} else {
							alert('無資料!');
						}
						Unlock(1);
						break;
					default:
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ucctgg':
						var as = _q_appendData("ucctgg", "", true);
						var ass = _q_appendData("ucctggs", "", true);
						var mount=dec($('#txtMount_'+b_seq).val())==0?1:dec($('#txtMount_'+b_seq).val());
						if (as[0] != undefined) {
							for ( var i = 0; i < ass.length; i++) {
								ass[i].dmoumt=q_sub(mount,dec(ass[i].mount));
								if(ass[i].dmoumt<0){
									ass.splice(i, 1);
	                                i--;
								}
							}
							ass.sort(function(a,b){return a.dmoumt-b.dmoumt;})
							if (ass[0] != undefined) {
								q_tr('txtPrice_'+b_seq,ass[0].price);
							}
						}
						break;
					case 'check_accu':
						var bbs_total=0,accu_total=0,ordb_total=0;
						var as = _q_appendData("accu", "", true);
						if (as[0] != undefined) {
							accu_total=dec(as[0].accu_total);
							ordb_total=dec(as[0].ordb_total);
						}
						if(!$('#chkCancel').prop('checked')){
							for(var i=0;i<q_bbsCount;i++){
								if(!$('#chkCancel_'+i).prop('checked')){
									bbs_total=q_add(bbs_total,dec($('#txtTotal_'+i).val()));
								}
							}
						}
						
						if(accu_total>=q_add(bbs_total,ordb_total)){
							chack_accu=true;
							btnOk();
						}else{
							alert(' 請購預算額度='+q_trv(accu_total)+' \r 已請購金額='+q_trv(ordb_total)+' \r 本次請購金額='+q_trv(bbs_total)+' \r ----------------------------------------- \r可用額度='+q_trv(Math.abs(q_sub(accu_total,q_add(bbs_total,ordb_total)))));
						}
						
						break;
					case 'GetTggt':
						var as = _q_appendData("ordb", "", true);
						if (as[0] != undefined) {
							$('#vttggt2_'+q_recno).text((as[0].tggt).substr(0,2));
							$('#vtfinish_'+q_recno).text((as[0].finish));
						}
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
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case 'combAddr':
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
					case 'cust' :
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							var CustAddr = trim(as[0].addr_fact);
							if (CustAddr.length > 0) {
								$('#txtAddr').val(CustAddr);
								$('#txtPost').val(as[0].zip_fact);
							}
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.substring(0,11)=='ordesucctgg'){
					var n = parseInt(t_name.split('_')[1]);
                    var as = _q_appendData("ucctgg", "", true);
					var ass = _q_appendData("ucctggs", "", true);
					var mount=dec($('#txtMount_'+n).val())==0?1:dec($('#txtMount_'+n).val());
					if (as[0] != undefined) {
						for ( var i = 0; i < ass.length; i++) {
							ass[i].dmoumt=q_sub(mount,dec(ass[i].mount));
							if(ass[i].dmoumt<0){
								ass.splice(i, 1);
	                               i--;
							}
						}
						ass.sort(function(a,b){return a.dmoumt-b.dmoumt;})
						if (ass[0] != undefined) {
							q_tr('txtPrice_'+n,ass[0].price);
						}
					}
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordbt':
						setTimeout(function(){
							var t_noa = $.trim($('#txtNoa').val());
							q_gt('ordb', "where=^^ noa='" + t_noa + "' ^^", 0, 0, 0, "GetTggt",r_accy);
						},800)
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
					q_box('ordb_s.aspx', q_name + '_s', "490px", "420px", q_getMsg("popSeek"));
			}

			function btnIns() {
				//106/12/26 重新抓取
				var t_db=q_db.toLocaleUpperCase();
				q_gt('acomp', "where=^^(dbname='"+t_db+"' or not exists (select * from acomp where dbname='"+t_db+"')) ^^ stop=1", 0, 0, 0, "cno_acomp",r_accy,1);
				var as = _q_appendData("acomp", "", true);
				if (as[0] != undefined) {
					z_cno = as[0].noa;
					z_acomp = as[0].acomp;
					z_nick = as[0].nick;
				}
				_btnIns();
				refreshBbs();
				$('#chkIsproj').attr('checked', true);
				$('#txtNoa').val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();
				$('#txtDatea').val(q_cdn(q_date(),10));
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				if (abbm[q_recno] != undefined)
					loadCustAddr(abbm[q_recno].tggno);	
				
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				var t_where = "where=^^ordbno='"+$('#txtNoa').val()+"' and isnull(mount,0)>0 ^^";
				q_gt('view_ordcs', t_where, 0, 0, 0, "",r_accy,1);
				var as = _q_appendData("view_ordcs", "", true);
				if (as[0] != undefined) {
					alert('【'+$('#txtNoa').val() + '】請購單已採購，禁止修改!!');
					return;
				}
				
				_btnModi();
				$('#txtOdate').focus();
				if (abbm[q_recno] != undefined)
					loadCustAddr(abbm[q_recno].tggno);
				sum();
				refreshBbs();
			}

			function btnPrint() {
				q_box("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'z_ordbp', "95%", "95%", q_getMsg('popPrint'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			
			//103/08/29根據ordb.accu判斷預估作業
			var chack_accu=false;
			function btnOk() {
				if ($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())) {
					alert(q_getMsg('lblOdate') + '錯誤。');
					return;
				}

				//105/04/20
				if(q_cur==2){
					var t_where = "where=^^ordbno='"+$('#txtNoa').val()+"' and isnull(mount,0)>0 ^^";
					q_gt('view_ordcs', t_where, 0, 0, 0, "",r_accy,1);
					var as = _q_appendData("view_ordcs", "", true);
					if (as[0] != undefined) {
						alert('【'+$('#txtNoa').val() + '】請購單已採購，禁止修改!!');
						return;
					}
				}
				
				Lock(1, {
					opacity : 0
				});

				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}

				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true')
					}
				}

				for (var i = 0; i < q_bbsCount; i++) {
					if (q_cur == 1 || (q_cur != 1 && q_float('txtOmount_' + i) == 0))
						$('#txtOmount_' + i).val($('#txtMount_' + i).val());
				}
				
				sum();
	
				//106/10/25 品號有KEY數量!=0
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_' + i).val()) && dec($('#txtMount_'+i).val())==0){
						alert($('#txtProduct_' + i).val()+' '+q_getMsg('lblMount_st') + '不可為零。');
						Unlock(1);
						return;
					}
				}
				
				if (q_cur == 1) {
					$('#txtWorker').val(r_name);
				} else if (q_cur == 2) {
					$('#txtWorker2').val(r_name);
				} else {
					alert("error: btnok!");
				}
							
				//清除是否判斷預估
				chack_accu=false;
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr').val($('#combAddr').find("option:selected").text());
					$('#txtPost').val($('#combAddr').find("option:selected").val());
				}
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				as['odate'] = abbm2['odate'];
				as['noa'] = abbm2['noa'];
				as['apv'] = abbm2['apv'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				HiddenTreat();
				refreshBbs();
			}

			function loadCustAddr(t_tggno) {
				$('#combAddr').children().remove();
				if ((q_cur == 1 || q_cur == 2)) {
					if (t_tggno.length > 0) {
						q_gt('custaddr', "where=^^ noa='" + t_tggno + "' ^^ stop=100", 0, 0, 0, "combAddr");
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
					$('#tmp').find("input[type='text']").attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
					$('#tmp').find("input[type='text']").removeAttr('disabled');
				}
				HiddenTreat();	
			}
			
			function HiddenTreat() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				$('.isCust').hide();
			}

			function btnMinus(id) {
				_btnMinus(id);
				refreshBbs();
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#btnRc2record_' + j).click(function() {
							var n = replaceAll($(this).attr('id'), 'btnRc2record_', '');
							q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";ordbno=" + $('#txtNoa').val() + "&no3=" + $('#txtNo3_' + n).val() + ";" + r_accy, 'z_rc2record', "95%", "95%", q_getMsg('popPrint'));
						});
						$('#btnOrdc_' + j).click(function(e) {
							var n = replaceAll($(this).attr('id'), 'btnOrdc_', '');
							t_where = "productno='" + $('#txtProductno_' + n).val() + "'";
							if ($('#txtProductno_' + n).val().length > 0)
								q_box("ucctgg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctgg', "95%", "95%", '採購建議量');
						});
						$('#btnOrdc2_' + j).click(function(e) {
							var n = replaceAll($(this).attr('id'), 'btnOrdc2_', '');
							t_where = "productno='" + $('#txtProductno_' + n).val() + "' and product='" + $('#txtProduct_' + n).val() + "'";
							if ($('#txtProductno_' + n).val().length > 0)
								q_box("z_ordbordc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbordc', "95%", "95%", '採購統計');
						});
						$('#btnRecord_' + j).click(function(e) {
							var n = replaceAll($(this).attr('id'), 'btnRecord_', '');
							t_where = "b.noa is not null" + " and c.noa is not null" + " and isnull(a.rprice,0)!=0" + " and c.productno='" + $('#txtProductno_' + n).val() + "'";
							if ($('#txtProductno_' + n).val().length > 0)
								q_box("ordbt_view_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbt_view', "95%", "95%", '歷史詢價記錄');
						});
						$('#btnTmprecord_' + j).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var t_pno = $.trim($('#txtProductno_'+n).val());
							var t_no3 = $.trim($('#txtNo3_'+n).val());
							var t_noa = $.trim($('#txtNoa').val());
							if((t_pno.length>0) && (t_no3.length>0) && (t_noa.length>0) && (t_noa != 'AUTO')){
								var t_where = "noa='" + t_noa + "' and no3='" + t_no3 + "' ";
								q_box("ordbt_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbt', "95%", "95%", '詢價紀錄');
							}
						});
						
						$('#txtOrdeno_'+j).bind('contextmenu',function(e) {
	                    	/*滑鼠右鍵*/
	                    	e.preventDefault();
	                    	t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
	                    	q_box("orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + r_accy, 'orde', "95%", "95%", '訂單作業');
	                    	
	                   });
					}
				}
				_bbsAssign();
				HiddenTreat();
				refreshBbs();
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
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
				var t_where = "where=^^ordbno='"+$('#txtNoa').val()+"' ^^";
				q_gt('view_ordcs', t_where, 0, 0, 0, "",r_accy,1);
				var as = _q_appendData("view_ordcs", "", true);
				if (as[0] != undefined) {
					alert('【'+$('#txtNoa').val() + '】請購單已採購，禁止修改!!');
					return;
				}
				
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					case 'txtTggno':
						loadCustAddr($.trim($('#txtTggno').val()));
						break;
					default:
						break;
				}
				id='';
			}
			function refreshBbs(){
                if($('#cmbKind2').val()=='希得'){
                    $('.isUJCD').show();
                }else{
                    $('.isUJCD').hide();
                }
            }
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 400px;
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
				width: 850px;
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
			.c1 {
				width: 100%;
				float: left;
			}
			.c2 {
				width: 95%;
				float: left;
			}
			.num {
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
			input[type="text"], input[type="button"],select {
				font-size: medium;
			}
			.dbbs {
				width: 2000px;
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
				width: 100%;
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
				width: 800px;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="exportordc" style="background:pink;display:none; position: absolute;top:200px;left:400px;width:600px;height:400px;">
			<table style="width:100%;height:100%;border: 2px white double;">
				<tr style="height:1px;">
					<td style="width:40%;"> </td>
					<td style="width:60%;"> </td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center; color:darkblue;"><a>已匯出至採購單的,須先刪除採購單才可重新匯出</a></td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>採購日期</a></td>
					<td><input id="textDatea_a" type="text" style="width:40%;"/></td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>廠商</a></td>
					<td>
						<input id="textTggno_a" type="text" style="width:45%;float:left;"/>
						<input id="textTgg_a" type="text" style="width:45%;float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>請購單號</a></td>
					<td>
						<input id="textBno_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEno_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
                    <td style="text-align: center;"><a>請購日期</a></td>
                    <td>
                        <input id="textBodate_a" type="text" style="width:40%; float:left;"/>
                        <a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
                        <input id="textEodate_a" type="text" style="width:40%; float:left;"/>
                    </td>
                </tr>
				<tr>
                    <td style="text-align: center;"><a>最慢需求日</a></td>
                    <td>
                        <input id="textBldate_a" type="text" style="width:40%; float:left;"/>
                        <a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
                        <input id="textEldate_a" type="text" style="width:40%; float:left;"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;"><a>物品編號</a></td>
                    <td>
                        <input id="textBproductno_a" type="text" style="width:40%; float:left;"/>
                        <a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
                        <input id="textEproductno_a" type="text" style="width:40%; float:left;"/>
                    </td>
                </tr>
				<tr>
					<td style="text-align: center;"><a>合約有效日期</a></td>
					<td>
						<input id="textBedate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEedate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>成交日期</a></td>
					<td>
						<input id="textBfdate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEfdate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>轉來</a></td>
					<td><input id="textWorkgno_a" type="text" style="width:80%;"/></td>
				</tr>
				<tr>
					<td align="center">
						<input id="btnExport_a" type="button" style="width:100px;" value="匯出採購"/>
					</td>
					<td align="center">
						<input id="btnClose_a" type="button" style="width:100px;" value="關閉"/>
					</td>
				</tr>
			</table>
		</div>

		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:25px"><a id='vewChk'> </a></td>
						<td align="center" style="width:70px"><a id='vewOdate'> </a></td>
						<td align="center" style="width:150px"><a id='vewTgg'> </a></td>
						<td align="center" style="width:150px"><a id='vewTggt'> </a></td>
						<td align="center" style="width:100px"><a id='vewFinish'>成交日期</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='nick'>~nick</td>
						<td align="center" id='tggt,2'>~tggt,2</td>
						<td align="center" id='finish'>~finish</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td><input type="text" style="display:none;" id="txtFinish"></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
					    <td class="td1"><span> </span><a id='lblKind2' class="lbl">類別</a></td>
                        <td class="td2"><select id="cmbKind2" class="txt c1"> </select></td>
						<td class="td1" style="display: none;"><span> </span><a id='lblKind_uj' class="lbl"></a></td>
						<td class="td2" style="display: none;"><select id="cmbKind" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td4"><input id="txtOdate" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td8" align="right">
							<input id="chkIsproj" type="checkbox"/>
							<a id='lblIsproj' style="width: 50%;"> </a><span> </span>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtCno" type="text" style="float:left;width:30%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:70%;"/>
						</td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td8" align="right">
							<input id="chkEnda" type="checkbox"/>
							<a id='lblEnd' style="width: 50%;"> </a><span> </span>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
							<input id="txtTggno" type="text" style="float:left;width:30%;"/>
							<input id="txtTgg" type="text" style="float:left;width:70%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
							<input id="txtTggtno" type="text" style="display:none;"/>
							<input id="txtTggt" type="text" style="display:none;"/>
						</td>
						<td class="td5"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td6" colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:90%;"/>
							<select id="combPaytype" style="float:left; width:10%;"> </select>
						</td>
						<td class="td8" align="right">
                            <input id="chkCancel" type="checkbox"/>
                            <a id='lblCancel' style="width: 50%;"> </a><span> </span>
                        </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtFax" type="text" class="txt c1"/></td>
						<td class="td8" align="center"><input id="btnOrde" type="button" style="text-align: center;"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td class="td2" colspan="7">
						<input id="txtPost" type="text" style="float:left; width:95px;"/>
						<input id="txtAddr" type="text" style="float:left; width:520px;"/>
						<select id="combAddr" style="float:left;width: 20px;"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td class="td3"><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td class="td4" colspan="2">
							<input id="txtContract" type="text" class="txt c1"/>
						</td>
						<td class="td6"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td7" colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1" /></td>
						<td><select id="cmbTaxtype" class="txt c1" style="float:left;" > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1" style="display: none;"><span> </span><a id="lblOrde" class="lbl"> </a></td>
						<td class="td2" style="display: none;"><input id="txtOrdeno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTotalus" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblOrdcno" class="lbl btn"> </a></td>
						<td class="td2" colspan="4"><input id="txtOrdcno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblApv' class="lbl apv"> </a></td>
						<td><input id="txtApv" type="text" class="txt c1 apv" /></td>
						<td><input id="btnOrdc" type="button" value="批次轉採購單" style="display:none;" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>

						<td><span> </span><a id='lblWorkgno' class="lbl"> </a></td>
                        <td colspan="3"><input id="txtWorkgno" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width:2000px">
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
                        <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"> </td>
					<td id="tdpno" align="center" style="width:140px;"><a id='lblProductno_uj'>貨品編號</a></td>
					<td id="tdspec" align="center" style="width:200px;"><a id='lblProduct_uj'>貨品名稱</a></td>
					<td class='isUJCD' align="center" style="width:30px;display: none;"><a id='lblIsnotdeal_uj'>1色</a></td>
					<td align="center" style="width:80px;"><a id='lblScolor_uj'> </a>採購優惠</td>
					<td align="center" style="width:70px;"><a id='lblTheory_uj'>距離必採倒數(天)</a></td>
					<td align="center" style="width:50px;"><a id='lblApv_uj'>採購</a></td>
					<td class='isUJCD' align="center" style="width:90px;display: none;"><a id='lblUcolor_uj'>採購條件</a></td>
					<td align="center" style="width:80px;"><a id='lblWidth_uj'>原採購量(M)</a></td>
					<td align="center" style="width:80px;"><a id='lblLengthb_uj'>原採購量(Kg)</a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_uj'>採購單位</a></td>
					<td align="center" style="width:80px;"><a id='lblDime_uj'>採購量(Kg)</a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_uj'>採購量(M)</a></td>
					<td align="center" style="width:80px;"><a id='lblMount_uj'>採購量(支)</a></td>
					<td align="center" style="width:80px;"><a id='lblRadius_uj'>各廠商採購量(M)</a></td>
					<td align="center" style="width:80px;"><a id='lblOmount_uj'>採購限定MOQ(Kg)</a></td>
					<td align="center" style="width:60px;"><a id='lblSize_uj'>庫存水位(%)</a></td>
					<td class='isUJCD' align="center" style="width:80px;display: none;"><a id='lblStdmount_uj'>整合月均(M)</a></td>
					<td align="center" style="width:80px;"><a id='lblWmount_uj'>月均(Kg)</a></td>
					<td align="center" style="width:80px;"><a id='lblUnit2_uj'>寬幅(mm)</a></td>
					<td class='isUJCD' align="center" style="width:80px;display: none;"><a id='lblSizea_uj'>希德簡碼</a></td>
					<td align="center" style="width:80px;"><a id='lblEmount_uj'>原月均(M)</a></td>
					<td class='isUJCD' align="center" style="width:70px;display: none;"><a id='lblSlit_uj'>同色短尺寸採購</a></td>
					<td align="center" style="width:80px;"><a id='lblMemo_uj'>注意事項</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td align="center">
						<input id="txtProductno.*" type="text" class="txt c1" style="width:97%;float:left;"/>
						<input id="txtNo3.*" type="text" style="width:80px;float:left;"/>
						<input id="btnProduct.*" type="button" value='.' style="font-weight: bold;float:left;" />
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c2"/></td>
					<td class='isUJCD' style="display: none;"><input id="chkIsnotdeal.*" type="checkbox"/></td>
					<td><input id="txtScolor.*" type="text" class="txt c2"/></td>
					<td><input id="txtTheory.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtApv.*" type="text" class="txt c2"/></td>
					<td class='isUJCD' style="display: none;"><input id="txtUcolor.*" type="text" class="txt c2"/></td>
					<td><input id="txtWidth.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c2"/></td>
					<td><input id="txtDime.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtMount.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtRadius.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtOmount.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtSize.*" type="text" class="txt c2"/></td>
					<td class='isUJCD' style="display: none;"><input id="txtStdmount.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtWmount.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtUnit2.*" type="text" class="txt c2"/></td>
					<td><input id="txtSizea.*" type="text" class="txt c2"/></td>
					<td class='isUJCD' style="display: none;"><input id="txtEmount.*" type="text" class="txt c2 num"/></td>
					<td class='isUJCD' style="display: none;"><input id="txtSlit.*" type="text" class="txt c2"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c2 num"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>