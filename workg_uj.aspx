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
			q_tables = 't';
			var q_name = "workg";
			var q_readonly = ['txtNoa', 'txtDatea', 'txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtNoq','textA06','textB02','textC03','textJ02','textJ11','textJ17','textL05'
			,'textC01','textC04','textD01','textD02','textD05','textE01','textF02','textF03','textG02','textG03'
			,'textH01','textH02','textH03'
			,'textI02','textI06','textI07','textI09','textI10','textI12','textI13','textI18','textI19'
			,'textJ06','textJ07','textJ08','textJ09','textJ13','textJ14','textJ15','textJ16'
			,'textJ19','textJ20','textJ21'
			,'textK01','textK02','textK04','textK05','textK06','textK08','textK11','textK12','textK13'
			,'textL04','textL06','textL08','textM01','textM02','textM03','textM04','textN01','textN02','textN03'
			,'textP03','textP04','textP05','textQ03','textQ04','textQ05','textR06','textR07'
			];
			var q_readonlyt = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(
				['textA04_', '', 'uca', 'noa', '0textA04_,', 'uca_b.aspx']
				,['textF01_', '', 'uca', 'noa', '0textF01_,', 'uca_b.aspx']
				,['textG01_', '', 'uca', 'noa', '0textG01_,', 'uca_b.aspx']
				,['textI05_', '', 'ucc', 'noa', '0textI05_,', 'ucc_b.aspx']
				,['textI08_', '', 'ucc', 'noa', '0textI08_,', 'ucc_b.aspx']
				,['textI11_', '', 'ucc', 'noa', '0textI011_,', 'ucc_b.aspx']
				
				,['textK03_', '', 'uca', 'noa', '0textK03_,', 'uca_b.aspx']
				,['textP01_', '', 'ucc', 'noa', '0textP01_,', 'ucc_b.aspx']
				,['textP02_', '', 'ucc', 'noa', '0textP02_,', 'ucc_b.aspx']
				,['textQ01_', '', 'ucc', 'noa', '0textQ01_,', 'ucc_b.aspx']
				,['textQ02_', '', 'ucc', 'noa', '0textQ02_,', 'ucc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                bbsNum = [
					['textA08', 15, 4, 1],['textA09', 15, 4, 1],['textA10', 15, 4, 1]
					/*,['textB01', 15, 4, 1]*/,['textB02', 15, 4, 1]
					,['textC01', 15, 4, 1]/*,['textC02', 15, 4, 1]*/,['textC03', 15, 4, 1],['textC04', 15, 4, 1]
					,['textD01', 15, 4, 1],['textD02', 15, 4, 1],['textD03', 15, 4, 1]/*,['textD04', 15, 4, 1]*/,['textD05', 15, 4, 1]
					,['textF02', 15, 4, 1],['textF03', 15, 4, 1]
					,['textG02', 15, 4, 1],['textG03', 15, 4, 1]
					,['textH01', 15, 2, 1],['textH02', 15, 4, 1],['textH03', 15, 4, 1]
					/*,['textI01', 15, 4, 1]*/,['textI02', 15, 4, 1],['textI06', 15, 4, 1],['textI09', 15, 4, 1],['textI12', 15, 4, 1]
					,['textI16', 15, 0, 1],['textI19', 15, 4, 1],['textI20', 15, 0, 1]
					,['textJ05', 15, 2, 1],['textJ06', 15, 4, 1],['textJ07', 15, 4, 1],['textJ08', 15, 4, 1],['textJ09', 15, 4, 1]
					,['textJ12', 15, 2, 1],['textJ13', 15, 4, 1],['textJ14', 15, 4, 1],['textJ15', 15, 4, 1],['textJ16', 15, 4, 1]
					,['textJ19', 15, 4, 1],['textJ20', 15, 2, 1]
					,['textK06', 15, 4, 1]/*,['textK07', 15, 4, 1]*/,['textK08', 15, 4, 1],['textK12', 15, 2, 1],['textK13', 15, 2, 1]
					,['textM01', 15, 4, 1],['textM02', 15, 2, 1],['textM03', 15, 4, 1],['textM04', 15, 2, 1]
					,['textN01', 15, 4, 1],['textN02', 15, 2, 1]
					,['textP03', 15, 4, 1],['textP04', 15, 4, 1],['textP05', 15, 4, 1]
					,['textQ03', 15, 4, 1],['textQ04', 15, 4, 1],['textQ05', 15, 4, 1]
					,['textR01', 15, 4, 1],['textR02', 15, 4, 1],['textR03', 15, 4, 1],['textR04', 15, 4, 1],['textR05', 15, 4, 1]
					,['textR06', 15, 4, 1],['textR07', 15, 4, 1],['textL08', 15, 2, 1]
				];
				
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtSfbdate', r_picd], ['txtSfedate', r_picd], ['txtWadate', r_picd], ['txtWbdate', r_picd], ['txtWedate', r_picd]];
				bbsMask = [
					['textA05', r_picd],['textC07', r_picd],['textI07', r_picd],['textI10', r_picd],['textI13', r_picd],['textI15', r_picd],['textI17', r_picd] //A
					,['textJ01', r_picd],['textJ10', r_picd] //B
					,['textK01', r_picd],['textK14', r_picd],['textL03', r_picd] //製造
				];
				
				q_mask(bbmMask);
				q_cmbParse("cmbStype", '加工,製造');	
				q_cmbParse("combJ02", ',分1,分2,分3,分4','s');
				q_cmbParse("combJ11", ',覆1,覆2,覆3,其他','s');
				q_cmbParse("combJ17", ',急,做,可','s');
				q_cmbParse("combL05", ',A,B','s');
				
				document.title='加工/製造排程表';
				
				$('#btnCub_uj').click(function() {
					if(q_cur==1 || q_cur==2){
						if($('#cmbStype').val()=='加工'){
							var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
							var t_bdate=emp($('#txtBdate').val())?'#non':$('#txtBdate').val();
							var t_edate=emp($('#txtEdate').val())?'#non':$('#txtEdate').val();
							
							q_func('qtxt.query.cubimport_uj', 'orde_uj.txt,cubimport_uj,' + encodeURI(t_noa)+';'+encodeURI(t_bdate)+';'+encodeURI(t_edate)+';'+encodeURI('#non')+';'+encodeURI(q_date()),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							
							if (as[0] != undefined) {
								
								//q_gridAddRow(bbsHtm, 'tbbs', 'textA01,txtWorkhno,textA02,textA03,textA04,textA05,textA06,textA07,textA08,textA09,textA10,textA11'
								//, as.length, as, 'noa,cubno,product,ucolor,productno,edate,m1,btime,width,lengthb,mount,unit', 'textA01,txtWorkhno,textA02,textA03,textA04');
								
								//刪除已存在的表身的資料
								for (var i = 0; i < as.length; i++) {
									for (var j = 0; j < q_bbsCount; j++) {
										if(as[i].cubno==$('#txtWorkhno_'+j).val()){
											as.splice(i, 1);
		                                    i--;
		                                    break;
	                                   }
                                   	}
								}
								
								var t_j=0;
								for (var i = 0; i < as.length; i++) {
									var t_iswrite=false;
									for (var j = t_j; j < q_bbsCount; j++) {
										if(emp($('#textA01_'+j).val()) && emp($('#txtWorkhno_'+j).val()) && emp($('#textA02_'+j).val()) && emp($('#textA03_'+j).val()) && emp($('#textA04_'+j).val())){
											$('#textA01_'+j).val(as[i].noa);
											$('#txtWorkhno_'+j).val(as[i].cubno);
											$('#textA02_'+j).val(as[i].product);
											$('#textA03_'+j).val(as[i].ucolor);
											$('#textA04_'+j).val(as[i].productno);
											$('#textA05_'+j).val(as[i].edate);
											$('#textA06_'+j).val(as[i].m1);
											$('#textA07_'+j).val(as[i].btime);
											$('#textA08_'+j).val(as[i].width);
											$('#textA09_'+j).val(as[i].lengthb);
											$('#textA10_'+j).val(as[i].mount);
											$('#textA11_'+j).val(as[i].unit);
											
											$('#textB02_'+j).val(as[i].b02);
											$('#textC01_'+j).val(as[i].c01);
											$('#textC03_'+j).val(as[i].c03);
											$('#textD01_'+j).val(as[i].d01);
											$('#textD02_'+j).val(as[i].d02);
											$('#textF01_'+j).val(as[i].f01);
											$('#textF02_'+j).val(as[i].f02);
											$('#textG01_'+j).val(as[i].g01);
											$('#textG02_'+j).val(as[i].g02);
											$('#textI05_'+j).val(as[i].i05);
											$('#textI06_'+j).val(as[i].i06);
											$('#textI07_'+j).val(as[i].i07);
											$('#textI08_'+j).val(as[i].i08);
											$('#textI09_'+j).val(as[i].i09);
											$('#textI10_'+j).val(as[i].i10);
											$('#textI11_'+j).val(as[i].i11);
											$('#textI12_'+j).val(as[i].i12);
											$('#textI13_'+j).val(as[i].i13);
											$('#textI16_'+j).val(as[i].i16);
											
											FD05(j);
											FI17(j);
											
											//$('#textA03_'+i).change();
											//$('#textA10_'+i).change();
											
											//合併儲存
											var tstr='';
											for (var k = 0; k < fbbs.length; k++) {
												if(fbbs[k].substr(0,4)=='text'){
													tstr+="@,#"+$('#'+fbbs[k]+'_'+j).val();
												}
											}
											$('#txtMemo2_'+j).val(tstr);
											
											$('#txtProductno_'+j).val($('#textA04_'+j).val());
											$('#txtOdatea_'+j).val($('#textA05_'+j).val());
											$('#txtWidth_'+j).val($('#textA08_'+j).val());
											$('#txtLengthb_'+j).val($('#textA09_'+j).val());
											$('#txtMount_'+j).val($('#textD05_'+j).val());
											$('#txtUcano_'+j).val($('#textF01_'+j).val());
											$('#txtUcc3no_'+j).val($('#textG01_'+j).val());
											$('#txtUcc4no_'+j).val($('#textI05_'+j).val());
											$('#txtUcc5no_'+j).val($('#textI08_'+j).val());
											$('#txtUcc6no_'+j).val($('#textI11_'+j).val());
											$('#txtUcc2no_'+j).val($('#textP01_'+j).val());
											$('#txtUcc1no_'+j).val($('#textQ01_'+j).val());
											
											if($('#cmbStype').val()=='製造'){
												$('#txtProductno_'+j).val($('#textK03_'+j).val());
												$('#txtUcano_'+j).val($('#textK03_'+j).val());
												$('#txtMount_'+j).val($('#textK08_'+j).val());
											}
											
											t_iswrite=true;
											t_j=j;
											break;
										}
									}
									if(!t_iswrite){
										i--;
										//t_j--;
										$('#btnPlus').click();
									}
								}
								
								for (var j = 0; j < q_bbsCount; j++) {
									if($('#textA04_'+j).val().length>0)
										FB02(j);
								}
								nordeno();
							}else{
								alert('無資料!!');
							}
						}
					}
				});
				
				$('#btnWorkgsale_uj').click(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_bdate=emp($('#txtBdate').val())?'#non':$('#txtBdate').val();
					var t_edate=emp($('#txtEdate').val())?'#non':$('#txtEdate').val();
					var t_mon=emp($('#txtWadate').val())?q_date().substr(0,r_lenm):$('#txtWadate').val().substr(0,r_lenm);
					
					q_func('qtxt.query.workgsalef_uj', 'orde_uj.txt,workgsalef_uj,' + encodeURI(t_noa)+';'+encodeURI(t_bdate)+';'+encodeURI(t_edate)+';'+encodeURI(t_mon)+';'+encodeURI(q_date()),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
							
					if (as[0] != undefined) {
						
						//刪除已存在的表身的資料
						for (var i = 0; i < as.length; i++) {
							for (var j = 0; j < q_bbsCount; j++) {
								if(as[i].workhno==$('#txtWorkhno_'+j).val()){
									as.splice(i, 1);
									i--;
									break;
								}
							}
						}
						
						for (var i = 0; i < as.length; i++) {
							var t_iswrite=false;
							var t_j=0;
							for (var j = t_j; j < q_bbsCount; j++) {
								if(emp($('#textK03_'+j).val()) && emp($('#txtWorkhno_'+j).val())){
									$('#txtWorkhno_'+j).val(as[i].workhno);
									$('#textK01_'+j).val(as[i].k01);
									$('#textK02_'+j).val(as[i].k02);
									$('#textK03_'+j).val(as[i].k03);
									$('#textK04_'+j).val(as[i].k04);
									$('#textK05_'+j).val(as[i].k05);
									$('#textK06_'+j).val(as[i].k06);
									$('#textK08_'+j).val(as[i].k06);
									$('#textL01_'+j).val(as[i].l01);
									$('#textL02_'+j).val(as[i].l02);
									$('#textL03_'+j).val(as[i].l03);
									$('#textL06_'+j).val(as[i].l06);
									$('#textL08_'+j).val(as[i].l08);
									$('#textP01_'+j).val(as[i].p01);
									$('#textP03_'+j).val(as[i].p03);
									$('#textP04_'+j).val(as[i].p04);
									$('#textQ01_'+j).val(as[i].q01);
									$('#textQ03_'+j).val(as[i].q03);
									$('#textQ04_'+j).val(as[i].q04);
									$('#textR01_'+j).val(as[i].r01);
									$('#textR02_'+j).val(as[i].r02);
									$('#textR03_'+j).val(as[i].r03);
									$('#textR04_'+j).val(as[i].r04);
									$('#textR05_'+j).val(as[i].r05);
											
									//合併儲存
									var tstr='';
									for (var k = 0; k < fbbs.length; k++) {
										if(fbbs[k].substr(0,4)=='text'){
											tstr+="@,#"+$('#'+fbbs[k]+'_'+j).val();
										}
									}
									$('#txtMemo2_'+j).val(tstr);
										
									t_iswrite=true;
									t_j=j;
									break;
								}
							}
							if(!t_iswrite){
								i--;
								//t_j--;
								$('#btnPlus').click();
							}
						}
						FM01();
						FM02();
						FM03();
						FM04();
						nordeno();
						
					}else{
						alert('無資料!!');
					}

				});
				
				$('#cmbStype').change(function() {
					for (var i = 0; i < q_bbsCount; i++) {
						$('#btnMinus_'+i).click();
					}
					for (var i = 0; i < q_bbtCount; i++) {
						$('#btnMinut__'+i).click();
					}
					change_field();
				});
				
				//建議加工日
				$('#txtWadate').change(function() {
					FM01();
					FM02();
					FM03();
					FM04();
				});
				
				//決定分條
				$('#txtWbdate').change(function() {
					FJ06();
					FJ07();
					FJ08();
					FJ09();
				});
				
				//決定覆捲日
				$('#txtWedate').change(function() {
					FJ13();
					FJ14();
					FJ15();
					FJ16();
				});
				
				$('#btnClose_div_stk').click(function() {
					var n=$('#s_bbsnoq').val();
					var source=$('#s_bbssource').val();
					if(source=='1'){
						var t_smount=0;
						$('.setmount').each(function(index) {
							t_smount=q_add(t_smount,dec($(this).val()));
						});
						$('#textC04_'+n).val(t_smount);
					}else{
						var t_sweight=0;
						$('.setweight').each(function(index) {
							t_sweight=q_add(t_sweight,dec($(this).val()));
						});
						if(source=='2'){//中繼
							$('#textF03_'+n).val(t_sweight);
							FH01(n);
							FH02(n);
							FJ05(n);
							FI19(n);
						}
						if(source=='3'){//再製
							$('#textG03_'+n).val(t_sweight);
							FH01(n);
							FH02(n);
							FJ12(n);
							FI19(n);
						}
						if(source=='4'){//上紙
							$('#textP05_'+n).val(t_sweight);
							FK11(n);
							FK12(n);
							FN02(n);
						}
						if(source=='5'){//上皮
							$('#textQ05_'+n).val(t_sweight);
							FK11(n);
							FK13(n);
							FN02(n);
						}
					}
					
					//清除bbt
					for (var i = 0; i < q_bbtCount; i++) {
						if($('#txtNo2__'+i).val()==source && $('#txtOrdeno__'+i).val()==$('#txtOrdeno_'+n).val()){
							$('#btnMinut__'+i).click();
						}
					}
					//寫入bbt
					var stkCount=document.getElementById("table_stk").rows.length-4;
					var as=[];
					for (var i = 0; i < stkCount; i++) {
						if(dec($('#stk_txtMount_'+i).val())>0 || dec($('#stk_txtWeight_'+i).val())>0){
							as.push({
								'ordeno':$('#txtOrdeno_'+n).val(),
								'no2':source,
								'uno':$('#stk_tdUno_'+i).text(),
								'productno':$('#s_productno').text(),
								'spec':$('#stk_tdSpec_'+i).text(),
								'mount':$('#stk_txtMount_'+i).val(),
								'weight':$('#stk_txtWeight_'+i).val(),
								'memo':$('#stk_tdindate_'+i).text()+'#^#'+$('#stk_tdUnit_'+i).text(),
							});
						}
					}
					q_gridAddRow(bbtHtm, 'tbbt', 'txtOrdeno,txtNo2,txtUno,txtProductno,txtSpec,txtMount,txtWeight,txtMemo'
					, as.length, as, 'ordeno,no2,uno,productno,spec,mount,weight,memo', 'txtOrdeno,txtNo2,txtUno,txtProductno,txtSpec');
					
                	$('#div_stk').hide();
				});
				
				$('#btnClose_div_stk2').click(function() {
                	$('#div_stk').hide();
				});
				
				//上方插入空白行
		        $('#lblTop_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
		            }
		        });
		        //下方插入空白行
		        $('#lblDown_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
		            }
		        });
			}
			
			var ordedate=false;
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workg_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtBdate').val(q_cdn(q_date(),7));
				$('#txtBdate').focus();
				change_field();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProductno').focus();
				change_field();
			}

			function btnPrint() {
				q_box('z_workgp_uj.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr='';
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							tstr+="@,#"+$('#'+fbbs[j]+'_'+i).val();
						}
					}
					
					$('#txtMemo2_'+i).val(tstr);
					
					$('#txtProductno_'+i).val($('#textA04_'+i).val());
					$('#txtOdatea_'+i).val($('#textA05_'+i).val());
					$('#txtWidth_'+i).val($('#textA08_'+i).val());
					$('#txtLengthb_'+i).val($('#textA09_'+i).val());
					$('#txtMount_'+i).val($('#textD05_'+i).val());
					$('#txtUcano_'+i).val($('#textF01_'+i).val());
					$('#txtUcc3no_'+i).val($('#textG01_'+i).val());
					$('#txtUcc4no_'+i).val($('#textI05_'+i).val());
					$('#txtUcc5no_'+i).val($('#textI08_'+i).val());
					$('#txtUcc6no_'+i).val($('#textI11_'+i).val());
					$('#txtUcc2no_'+i).val($('#textP01_'+i).val());
					$('#txtUcc1no_'+i).val($('#textQ01_'+i).val());
					
					if($('#cmbStype').val()=='製造'){
						$('#txtProductno_'+i).val($('#textK03_'+i).val());
						$('#txtUcano_'+i).val($('#textK03_'+i).val());
						$('#txtMount_'+i).val($('#textK08_'+i).val());
					}
				}
				
				sum();
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}
			
			function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtMemo2_'+i).val().split('@,#');
					var tstc=1;
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							$('#'+fbbs[j]+'_'+i).val(tstr[tstc]);
							tstc++;
						}
					}
				}
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !dec(as['mount'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno'] && !as['productno'] && !as['ordeno']&& !as['no2']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				
				change_field();
			}
			
			function change_field () {
				if($('#cmbStype').val()=='製造'){
					$('.M1').hide();
					$('.M2').hide();
					$('.M3').show();
					$('#lblWadate_uj').text('指定排程日期');
					$('.dbbs').css('width','5000px');
					$('.dbbstop').css('width','5000px');
				}else{
					$('.M3').hide();
					$('.M1').show();
					$('.M2').show();
					$('#lblWadate_uj').text('建議加工日');
					$('.dbbs').css('width','8000px');
					$('.dbbstop').css('width','8000px');
				}
			}
			
			var mouse_div = true; //控制滑鼠消失div
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#div_row').hide();
					for (var i = 0; i < q_bbsCount; i++) {
						$('#combJ02_'+i).attr('disabled', 'disabled');
						$('#combJ11_'+i).attr('disabled', 'disabled');
						$('#combJ17_'+i).attr('disabled', 'disabled');
						$('#combL05_'+i).attr('disabled', 'disabled');
					}
				} else {
					for (var i = 0; i < q_bbsCount; i++) {
						$('#combJ02_'+i).removeAttr('disabled');
						$('#combJ11_'+i).removeAttr('disabled');
						$('#combJ17_'+i).removeAttr('disabled');
						$('#combL05_'+i).removeAttr('disabled');
					}
				}
				change_field();
			}

			function btnMinus(id) {
				_btnMinus(id);
				var n=id.split('_')[1];
				for (var i = 0; i < q_bbtCount; i++) {
					if($('#txtNo2__'+i).val()==n){
						$('#btnMinut__'+i).click();
					}
				}
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}
			
			var t_desc=0;
			function bbssort(tField) {
				if(q_cur==1 || q_cur==2){
					var t_bbs=new Array();
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProductno_'+i).val()) || !emp($('#txtOdatea_'+i).val())){
		               		var t_bbss=new Array();
		               		for (var j = 0; j < fbbs.length; j++) {
		               			t_bbss[fbbs[j]]=$('#'+fbbs[j]+'_'+i).val();
		               		}
		               		t_bbs.push(t_bbss);
		               	}
						$('#btnMinus_'+i).click();
					}
					
					if(t_bbs.length!=0){
						if(t_desc==0){
							t_bbs.sort(function compare(a,b) {
								if (eval('a.'+tField)< eval('b.'+tField)) return -1;
								if (eval('a.'+tField)> eval('b.'+tField)) return 1;
								return 0;
							});
							t_desc=1;
						}else{
							t_bbs.sort(function compare(a,b) {
								if (eval('a.'+tField)> eval('b.'+tField)) return -1;
								if (eval('a.'+tField)< eval('b.'+tField)) return 1;
								return 0;
							});
							t_desc=0;
						}
						for (var i = 0; i < t_bbs.length; i++) {
			              		for (var j = 0; j < fbbs.length; j++) {
			              			if(fbbs[j]!='txtNoq')
			              				$('#'+fbbs[j]+'_'+i).val(t_bbs[i][fbbs[j]]);
			              		}
						}
					}
					//清除NOQ 以避免重新排序
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtNoq_'+i).val('');
					}
				}
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#btnMinus_' + i).bind('contextmenu', function (e) {
		                    e.preventDefault();

		                    mouse_div = false;
		                    ////////////控制顯示位置
		                    $('#div_row').css('top', e.pageY);
		                    $('#div_row').css('left', e.pageX);
		                    ////////////
		                    t_IdSeq = -1;
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                    $('#div_row').show();
		                    row_b_seq = b_seq;
		                    row_bbsbbt = 'bbs';
		                });
						
						$('#textA03_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_engpro=$('#textA03_'+b_seq).val();
							if(t_engpro.length>0){//判斷舊編號
								q_gt('uca',"where=^^engpro='"+t_engpro+"'^^", 0, 0, 0, "getuca", r_accy,1);
								var tuca = _q_appendData("uca", "", true);
								if (tuca[0] != undefined) {
									if(tuca[0].typea=='2'){//成品
										$('#textA04_'+b_seq).val(tuca[0].noa);
										$('#textA07_'+b_seq).val(tuca[0].groupdno);//銷售政策
										$('#textA08_'+b_seq).val(tuca[0].mechs);//寬(mm)
										$('#textA09_'+b_seq).val(tuca[0].trans);//長(M)	
										$('#textA11_'+b_seq).val(tuca[0].unit);//單位
										
										$('#textF01_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
										$('#textG01_'+b_seq).val(tuca[0].groupcno)//再製品
										
										$('#textI05_'+b_seq).val(tuca[0].groupeno)//紙管
										$('#textI08_'+b_seq).val(tuca[0].groupfno)//紙箱
										$('#textI11_'+b_seq).val(tuca[0].groupgno)//塞頭
										
									}else{
										var t_unit1=t_engpro.substr(0,1).toLocaleUpperCase();
										if(t_unit1=='1' || t_unit1=='2' || t_unit1=='P' || t_unit1=='Z'|| t_unit1=='S'){
											$('#textA11_'+b_seq).val('支');//單位
										}else if(t_unit1=='C'){
											$('#textA11_'+b_seq).val('張');//單位
										}else if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
											$('#textA11_'+b_seq).val('M');//單位
										}else{
											$('#textA11_'+b_seq).val('');//單位
										}
										
										if(tuca[0].typea=='3'){//半成品
											$('#textF01_'+b_seq).val(t_engpro)//中繼產品料號
											$('#textI16_'+b_seq).val(tuca[0].preday);//熟成(天)
										}
									}
								}else{//判斷新編號
									$('#textA04_'+b_seq).val(t_engpro);
									q_gt('uca',"where=^^noa='"+t_engpro+"'^^", 0, 0, 0, "getuca", r_accy,1);
									var tuca = _q_appendData("uca", "", true);
									if (tuca[0] != undefined) {
										if(tuca[0].typea=='2'){//成品
											$('#textA04_'+b_seq).val(tuca[0].noa);
											$('#textA07_'+b_seq).val(tuca[0].groupdno);//銷售政策
											$('#textA08_'+b_seq).val(tuca[0].mechs);//寬(mm)
											$('#textA09_'+b_seq).val(tuca[0].trans);//長(M)	
											$('#textA11_'+b_seq).val(tuca[0].unit);//單位
											
											$('#textF01_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
											$('#textG01_'+b_seq).val(tuca[0].groupcno)//再製品
											
											$('#textI05_'+b_seq).val(tuca[0].groupeno)//紙管
											$('#textI08_'+b_seq).val(tuca[0].groupfno)//紙箱
											$('#textI11_'+b_seq).val(tuca[0].groupgno)//塞頭
										}else{
											var t_unit1=t_engpro.substr(0,1).toLocaleUpperCase();
											if(t_unit1=='1' || t_unit1=='2' || t_unit1=='P' || t_unit1=='Z'|| t_unit1=='S'){
												$('#textA11_'+b_seq).val('支');//單位
											}else if(t_unit1=='C'){
												$('#textA11_'+b_seq).val('張');//單位
											}else if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
												$('#textA11_'+b_seq).val('M');//單位
											}else{
												$('#textA11_'+b_seq).val('');//單位
											}
											
											if(tuca[0].typea=='3'){//半成品
												$('#textF01_'+b_seq).val(t_engpro)//中繼產品料號
												$('#textI16_'+b_seq).val(tuca[0].preday);//熟成(天)
											}
										}
									}else{
										alert('無此料號!!');
									}
								}
							}
							
							getstk(b_seq,'1');
							getstk(b_seq,'2');
							getstk(b_seq,'3');
							FI06(b_seq);
							FI07(b_seq);
							FI09(b_seq);
							FI10(b_seq);
							FI12(b_seq);
							FI13(b_seq);
						});
						
						//新成品
						$('#textA04_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						//原需求數量
						$('#textA10_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FB02(b_seq);
						});
						
						//手調
						$('#textB01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FB02(b_seq);
						});
						
						//數量
						$('#textB02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FB02(b_seq);
						});
						
						//Booking可動用
						$('#textC01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FC03(b_seq);
						});
						
						//Booking手調
						$('#textC02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FC03(b_seq);
						});
						
						//Booking
						$('#textC03_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FC03(b_seq);
						});
						
						//調撥單
						$('#btnC06_'+i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#textA07_'+b_seq).val()=='成-計' && dec($('#textB01_'+b_seq).val())>0){
								//轉調撥單
							}
						});
						
						//Booking到期日
						$('#textC07_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								FC03(b_seq);
							}
						});
						
						//指令流水號
						$('#textA01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FD01(b_seq);
						});
							
						
						//應生產量成品
						$('#textD01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FD01(b_seq);
						});
						
						//應生產(M)
						$('#textD02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FD02(b_seq);
						});
						
						//手調(M)
						$('#textD04_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FD05(b_seq);
						});
						
						//生產(M)
						$('#textD05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FD05(b_seq);
						});
						
						//場內可用庫存供貨
						$('#textE01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						//中繼產品料號
						$('#textF01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FD02(b_seq);
						});
						
						//中繼場內可用庫存
						$('#textF02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FE01(b_seq);
						});
						
						//再製品料號
						$('#textG01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						//再製品場內可用庫存
						$('#textG02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FE01(b_seq);
						});
						
						//指定(%)
						$('#textH01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FH01(b_seq);
						});
						
						//中繼指定(M)
						$('#textF03_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FH01(b_seq);
							FH02(b_seq);
							FJ05(b_seq);
							FI19(b_seq);
						});
						
						//再製指定(M)
						$('#textG03_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FH01(b_seq);
							FH02(b_seq);
							FJ12(b_seq);
							FI19(b_seq);
						});
						
						//物料需求(套)
						$('#textI02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FI02(b_seq);
						});
						
						//物料需求手調
						$('#textI01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FI02(b_seq);
						});
						
						//紙管
						$('#textI05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						//紙箱
						$('#textI08_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						//塞頭
						$('#textI11_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						
						//完工狀態(加工)
						$('#textI18_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FI02(b_seq);
						});
						
						//紙管貨齊日
						$('#textI07_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								FI17(b_seq);
							}
						});
						
						//紙箱貨齊日
						$('#textI10_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								FI17(b_seq);
							}
						});
						
						//塞頭貨齊日
						$('#textI13_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								FI17(b_seq);
							}
						});
						
						//上膠日
						$('#textI15_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								FI17(b_seq);
							}
						});
						
						//熟成(天)
						$('#textI16_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FI17(b_seq);
						});
						
						//料最快備齊日期
						$('#textI17_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								FI17(b_seq);
							}
						});
						
						//訂單總量
						$('#textI19_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FI19(b_seq);
						});
						
						//限定餘數
						$('#textI20_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FI20(b_seq);
						});
						
						//加工日
						$('#textJ01_'+i).focusout(function() {
							if(q_cur==1 || q_cur==2){
								FJ06();
								FJ07();
								FJ08();
								FJ09();
							}
						});
						
						//分條機台別
						$('#textJ02_'+i).change(function() {
							FJ06();
							FJ07();
							FJ08();
							FJ09();
						});
						
						//覆捲日
						$('#textJ10_'+i).focusout(function() {
							if(q_cur==1 || q_cur==2){
								FJ13();
								FJ14();
								FJ15();
								FJ16();
							}
						});
						
						//覆捲機台別
						$('#textJ11_'+i).change(function() {
							FJ13();
							FJ14();
							FJ15();
							FJ16();
						});
						
						$('#combJ02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#textJ02_'+b_seq).val($('#combJ02_'+b_seq).val());
								$('#textJ02_'+b_seq).change();
							}
						});
						
						$('#combJ11_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#textJ11_'+b_seq).val($('#combJ11_'+b_seq).val());
								$('#textJ11_'+b_seq).change();
							}
						});
						
						$('#combJ17_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#textJ17_'+b_seq).val($('#combJ17_'+b_seq).val());
							}
						});
						
						//製造----------------------
						$('#textK03_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#textK07_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FK08(b_seq);
						});
						
						$('#textL03_'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(q_cur==1 || q_cur==2){
								if(!emp($(this).val()))
									$('#textL04_'+b_seq).val(getweek($(this).val()));
								else
									$('#textL04_'+b_seq).val('');
								
								FM01();
								FM02();
								FM03();
								FM04();
								FR06(b_seq);
							}
						});
						
						$('#combL05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#textL05_'+b_seq).val($('#combL05_'+b_seq).val());
								FM01();
								FM02();
								FM03();
								FM04();
							}
						});
						
						$('#combL05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FR06(b_seq);
						});
						
						$('#textN01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FN02(b_seq)
						});
						
						$('#textP05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FK11(b_seq);
							FK12(b_seq);
							FN02(b_seq);
						});
						
						$('#textQ05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FK11(b_seq);
							FK13(b_seq);
							FN02(b_seq);
						});
						
						$('#textR01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FK06(b_seq);
						});
						$('#textR02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							FK06(b_seq);
						});
						
						//----------------------------------------------------------------
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
									
									$('#txtMemo2_'+b_seq).val(tstr);
									
									$('#txtProductno_'+b_seq).val($('#textA04_'+b_seq).val());
									$('#txtOdatea_'+b_seq).val($('#textA05_'+b_seq).val());
									$('#txtWidth_'+b_seq).val($('#textA08_'+b_seq).val());
									$('#txtLengthb_'+b_seq).val($('#textA09_'+b_seq).val());
									$('#txtMount_'+b_seq).val($('#textD05_'+b_seq).val());
									$('#txtUcano_'+b_seq).val($('#textF01_'+b_seq).val());
									$('#txtUcc3no_'+b_seq).val($('#textG01_'+b_seq).val());
									$('#txtUcc4no_'+b_seq).val($('#textI05_'+b_seq).val());
									$('#txtUcc5no_'+b_seq).val($('#textI08_'+b_seq).val());
									$('#txtUcc6no_'+b_seq).val($('#textI11_'+b_seq).val());
									$('#txtUcc2no_'+b_seq).val($('#textP01_'+b_seq).val());
									$('#txtUcc1no_'+b_seq).val($('#textQ01_'+b_seq).val());
									
									if($('#cmbStype').val()=='製造'){
										$('#txtProductno_'+b_seq).val($('#textK03_'+b_seq).val());
										$('#txtUcano_'+b_seq).val($('#textK03_'+b_seq).val());
										$('#txtMount_'+b_seq).val($('#textK08_'+b_seq).val());
									}
									
								});
							}
						}
						
					}
				}
				
				_bbsAssign();
				change_field();
				splitbbsf();
				
				//指定
				$('.btndivstk').unbind('click');
				$('.btndivstk').click(function(e) {
					var t_id=$(this).attr('id').split('_')[0];
					var t_n=$(this).attr('id').split('_')[1];
					nordeno();
					var t_productno='';
					var t_source='';
					//成品
					if(t_id=='btnC05'){
						t_productno= $('#textA04_' + t_n).val();
						t_source='1';
					}
					//中繼
					if(t_id=='btnF04'){
						t_productno= $('#textF01_' + t_n).val();
						t_source='2';
					}
					//再製
					if(t_id=='btnG04'){
						t_productno= $('#textG01_' + t_n).val();
						t_source='3';
					}
					//上紙
					if(t_id=='btnP06'){
						t_productno= $('#textP01_' + t_n).val();
						t_source='4';
					}
					//上皮
					if(t_id=='btnQ06'){
						t_productno= $('#textQ01_' + t_n).val();
						t_source='5';
					}
					
					//get庫存
					if(t_productno.length>0 && (q_cur==1 || q_cur==2)){
						$('#s_bbsnoq').val(t_n);
	                    $('#s_bbssource').val(t_source);
						$('#s_productno').text(t_productno);
						$('#s_cubno').text($('#textA01_' + t_n).val());
						$('#s_cubname').text($('#textA02_' + t_n).val());
						$('#s_product').text(getproduct(t_productno));
						if(t_source=='1'){
							$('#s_weight').text(q_mul(dec($('#textA10_' + t_n).val()),dec($('#textA09_' + t_n).val())));
						}else if (t_source=='2' || t_source=='3'){
							$('#s_weight').text(dec($('#textD05_' + t_n).val()));	
						}else{
							$('#s_weight').text(dec($('#textK08_' + t_n).val()));	
						}
						$('#s_isset').text('');
						$('#s_pisset').text('');
						$('#s_stk').text('');
						$('#s_ordc').text('');
						$('#s_ordcdate').text('');
	                        	
						$('#div_stk').css('top', e.pageY- $('#div_stk').height());
						$('#div_stk').css('left', e.pageX - $('#div_stk').width());
								
						//採購未交
						q_func('qtxt.query.ordcnotv_uj', 'orde_uj.txt,ordcnotv_uj,' + encodeURI(q_date())+';'+encodeURI(t_productno),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_weight=0,t_maxdate='';
								for (var i = 0; i < as.length; i++) {
									t_weight=q_add(t_weight,dec(as[i].weight));
									if(t_maxdate<as[i].indate){
										t_maxdate=as[i].indate;
									}
								}
									
								$('#s_ordc').text(t_weight);
		                        $('#s_ordcdate').text(t_maxdate);
						}
								
						var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
			            q_func('qtxt.query.div_stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_productno)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI(t_noa));
					}
				});
				
				if(q_cur==1 || q_cur==2){
					$('#btnOrderUcc1no').removeAttr('disabled');
					$('#btnOrderUcc2no').removeAttr('disabled');
				}else{
					$('#btnOrderUcc1no').attr('disabled', 'disabled');
					$('#btnOrderUcc2no').attr('disabled', 'disabled');
				}
				
				//面材排序
				$('#btnOrderUcc1no').unbind('click');
				$('#btnOrderUcc1no').click(function() {
					if(q_cur==1 || q_cur==2){
						bbssort('txtUcc1no');
					}
				});
				
				//底材排序
				$('#btnOrderUcc2no').unbind('click');
				$('#btnOrderUcc2no').click(function() {
					if(q_cur==1 || q_cur==2){
						bbssort('txtUcc2no');
					}
				});
				
			}
			
			//---------------------------------------------------------------
			//計算公式
			function FB02(i) { //A表 數量
				if($('#textB01_'+i).val().toUpperCase()=='X'){
					$('#textB02_'+i).val(0);
				}else if(dec($('#textB01_'+i).val())>0){
					$('#textB02_'+i).val(dec($('#textB01_'+i).val()));
				}else{
					$('#textB02_'+i).val(dec($('#textA10_'+i).val()));
				}
				
				FC03(i);
			}
			
			function FC03(i) { //A表 Booking
				if(dec($('#textC02_'+i).val())>0){ //Booking手調
					$('#textC03_'+i).val($('#textC02_'+i).val());
				}else{
					var t_ist2=false;//判斷是否成品
					var t_noa=$('#textA04_'+i).val();
					q_gt('uca',"where=^^noa='"+t_noa+"' and typea='2' ^^", 0, 0, 0, "getuca", r_accy,1);
					var tuca = _q_appendData("uca", "", true);
					if (tuca[0] != undefined) {
						t_ist2=true;
					}
					
					var t_groupdno=$('#textA07_'+i).val();
					if(t_groupdno=='特規' || t_groupdno=='成-計' || $('#textC02_'+i).val()=='X'
					|| !t_ist2 || (!emp($('#textC07_'+i).val()) && q_date()>$('#textC07_'+i).val())
					){
						$('#textC03_'+i).val(0);
					}else{
						if(dec($('#textC01_'+i).val())>dec($('#textB02_'+i).val()))
							$('#textC03_'+i).val(dec($('#textB02_'+i).val()));
						else
							$('#textC03_'+i).val(dec($('#textC01_'+i).val()));
					}
				}
				
				FD01(i);
			}
			
			function FD01(i) { //A表 應生產量成品
				var t_ist2=false;//判斷是否成品
				var t_noa=$('#textA04_'+i).val();
				q_gt('uca',"where=^^noa='"+t_noa+"' and typea='2' ^^", 0, 0, 0, "getuca", r_accy,1);
				var tuca = _q_appendData("uca", "", true);
				if (tuca[0] != undefined) {
					t_ist2=true;
				}
							
				if($('#textA01_'+i).val().substr(0,2)=='預留' || !t_ist2){
					$('#textD01_'+i).val(0);
				}else{
					if(dec($('#textC03_'+i).val())>=dec($('#textB02_'+i).val())){
						$('#textD01_'+i).val(0);
					}else{
						$('#textD01_'+i).val(q_sub(dec($('#textB02_'+i).val()),dec($('#textC03_'+i).val())));
					}
				}
				FD02(i);
			}
			
			function FD02(i) { //A表 應生產(M)
				if($('#textF01_'+i).val().length==0 || $('#textA01_'+i).val().substr(0,2)=='預留'){
					$('#textD02_'+i).val(0);
				}else{
					if($('#textA04_'+i).val().substr(0,1)=='1' || $('#textF01_'+i).val().substr(0,1)=='8'){
						$('#textD02_'+i).val(round(q_mul(dec($('#textA09_'+i).val()),dec($('#textD01_'+i).val())),0));
					}else{
						if($('#textA11_'+i).val()=='M'){
							$('#textD02_'+i).val(dec($('#textB02_'+i).val()));
						}else{
							var t_noa=$('#textA04_'+i).val(); //成品或再製品
							var t_uca3='';//半成品編號
							var t_badperc=1;//成品良率
							var t_molds=1;//成品裁切
							q_gt('uca',"where=^^noa='"+t_noa+"' ^^", 0, 0, 0, "getuca", r_accy,1);
							var tuca = _q_appendData("uca", "", true);
							if (tuca[0] != undefined) {
								t_uca3=tuca[0].groupbno;
								t_badperc=q_div(dec(tuca[0].badperc),100);
								t_molds=dec(tuca[0].molds);
							}
							
							var t_m=0;
							if(t_uca3.substr(0,1)=='5'){
								var t_len3=0;//半成品長度
								q_gt('uca',"where=^^noa='"+t_uca3+"' and typea='3' ^^", 0, 0, 0, "getuca", r_accy,1);
								var tuca2 = _q_appendData("uca", "", true);
								if (tuca2[0] != undefined) {
									t_len3=dec(tuca2[0].trans);
								}
								
								t_m=q_div(q_mul(q_div(dec($('#textD01_'+i).val()),Math.floor(q_div(q_mul(t_len3,t_badperc),dec($('#textA09_'+i).val())))),t_len3),t_molds);
							}
							$('#textD02_'+i).val(round(t_m,0));
						}
					}
				}
				FD05(i);
			}
			
			function FD05(i) { //A表 生產(M)
				if($('#textD04_'+i).val().toUpperCase()=='X'){
					$('#textD05_'+i).val(0);
				}else{
					if(dec($('#textD04_'+i).val())>0){
						$('#textD05_'+i).val(dec($('#textD04_'+i).val()));
					}else{
						$('#textD05_'+i).val(dec($('#textD02_'+i).val()));
					}
				}
				FH01(i);
				FE01(i);
				FH03(i);
			}
			
			function FE01(i) { //A表 場內可用庫存供貨
				$('#textE01_'+i).val('');
							
				if(dec($('#textH01_'+i).val())>=90){
					$('#textE01_'+i).val('轉指');
				}else{
					var t_ep=q_div(q_add(dec($('#textF02_'+i).val()),dec($('#textG02_'+i).val())),dec($('#textD05_'+i).val()));
					if(t_ep>1){
						$('#textE01_'+i).val('可指');
					}else{
						$('#textE01_'+i).val(round(q_mul(t_ep,100),2).toString()+'%');
					}
				}
				FI19(i);
			}
			
			function FH01(i) { //A表 指定(%)
				if(dec($('#textF03_'+i).val())==0 && dec($('#textG03_'+i).val())==0){
					$('#textH01_'+i).val(0);
				}else{
					$('#textH01_'+i).val(round(q_div(q_add(dec($('#textF03_'+i).val()),dec($('#textG03_'+i).val())),dec($('#textD05_'+i).val()))*100,2));
				}
				FE01(i);
			}
			
			function FH02(i) { //A表 指定可產出量
				if(dec($('#textA09_'+i).val())==0){
					$('#textH02_'+i).val(0);
				}else{
					$('#textH02_'+i).val(
						Math.floor(q_mul(Math.floor(q_mul(q_div(1000,dec($('#textA09_'+i).val())),0.95)),		
						q_div(q_add(dec($('#textF03_'+i).val()),dec($('#textG03_'+i).val())),1000)))
					);
				}
				FI20(i);
			}
			
			function FH03(i) { //A表 生產成品
				if(dec($('#textA09_'+i).val())==0){
					$('#textH03_'+i).val(0);
				}else{
					$('#textH03_'+i).val(
						Math.floor(q_mul(Math.floor(q_mul(q_div(1000,dec($('#textA09_'+i).val())),0.95)),		
						q_div(dec($('#textD05_'+i).val()),1000)))
					);
				}
				FI02(i);
			}
			
			function FI02(i) { //A表 物料需求(套)
				if($('#textI01_'+i).val().toUpperCase()=='X' || $('#textI18_'+i).val()=='完工' || $('#textJ21_'+i).val()=='完工'){
					$('#textI02_'+i).val(0);
				}else{
					if(dec($('#textI01_'+i).val())>0){
						$('#textI02_'+i).val(dec($('#textI01_'+i).val()));
					}else{
						$('#textI02_'+i).val(dec($('#textH03_'+i).val()));
					}
				}
			}
			
			function FI06(i) { //A表 紙管採購量  --*數量為負數公式有問題
				var t_g02=dec($('#textG02_'+i).val());//再製品場內可用庫存
				var t_i05=$('#textI05_'+i).val();//紙管
				var t_a09=dec($('#textA09_'+i).val());//成品長
				var t_leng=0;//紙管長度
				var t_mount=0; //可動用量
				var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
            	if(t_i05.length>0){
					q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_i05)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI(t_noa),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for (var j = 0; j < as.length; j++) {
						t_mount=q_add(t_mount,dec(as[j].mount));
					}
					
					q_gt('ucc',"where=^^noa='"+t_i05+"'^^", 0, 0, 0, "getucc", r_accy,1);
					var tucc = _q_appendData("ucc", "", true);
					if (tucc[0] != undefined) {
						t_leng=dec(tucc[0].reserve);
					}
				}
				
				if(t_g02==0 || t_mount>t_g02){
					if(t_a09!=0 && t_leng!=0){
						$('#textI06_'+i).val(Math.ceil(q_div(q_sub(t_g02,t_mount),q_div(t_leng,t_a09))));
					}else{
						$('#textI06_'+i).val(0);
					}
				}else{
					$('#textI06_'+i).val(0);
				}
			}
			
			function FI07(i) { //A表 紙管貨齊日
				var t_h02=dec($('#textH02_'+i).val());//指定可產出量
				var t_i05=$('#textI05_'+i).val();//紙管
				
				if(t_h02==0){
					$('#textI07_'+i).val(q_date());
				}else{
					var t_maxdate='';//已採未交到貨日
	            	if(t_i05.length>0){
						q_func('qtxt.query.ordcnotv_uj', 'orde_uj.txt,ordcnotv_uj,' + encodeURI(q_date())+';'+encodeURI(t_i05),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var j = 0; j < as.length; j++) {
								if(t_maxdate<as[j].indate){
									t_maxdate=as[j].indate;
								}
							}
						}
					}
					if(t_maxdate.length==0)
						$('#textI07_'+i).val(q_date());
					else
						$('#textI07_'+i).val(t_maxdate);
				}
				FI17(i);
			}
			
			function FI09(i) { //A表 紙箱採購量--*數量為負數公式有問題
				var t_g02=dec($('#textG02_'+i).val());//再製品場內可用庫存
				var t_i08=$('#textI08_'+i).val();//紙箱
				var t_lmount=0;//紙箱裝箱支數
				var t_mount=0; //可動用量
				var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
            	if(t_i08.length>0){
					q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_i08)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI(t_noa),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for (var j = 0; j < as.length; j++) {
						t_mount=q_add(t_mount,dec(as[j].mount));
					}
					
					q_gt('ucc',"where=^^noa='"+t_i08+"'^^", 0, 0, 0, "getucc", r_accy,1);
					var tucc = _q_appendData("ucc", "", true);
					if (tucc[0] != undefined) {
						t_lmount=dec(tucc[0].beginmoney);
					}
				}
				
				if(t_g02==0 || t_mount>t_g02){
					if(t_lmount!=0){
						$('#textI09_'+i).val(Math.ceil(q_div(q_sub(t_g02,t_mount),t_lmount)));
					}else{
						$('#textI09_'+i).val(0);
					}
				}else{
					$('#textI09_'+i).val(0);
				}
			}
			
			function FI10(i) { //A表 紙箱貨齊日
				var t_h02=dec($('#textH02_'+i).val());//指定可產出量
				var t_i08=$('#textI08_'+i).val();//紙箱
				
				if(t_h02==0){
					$('#textI10_'+i).val(q_date());
				}else{
					var t_maxdate='';//已採未交到貨日
	            	if(t_i08.length>0){
						q_func('qtxt.query.ordcnotv_uj', 'orde_uj.txt,ordcnotv_uj,' + encodeURI(q_date())+';'+encodeURI(t_i08),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var j = 0; j < as.length; j++) {
								if(t_maxdate<as[j].indate){
									t_maxdate=as[j].indate;
								}
							}
						}
					}
					if(t_maxdate.length==0)
						$('#textI10_'+i).val(q_date());
					else
						$('#textI10_'+i).val(t_maxdate);
				}
				FI17(i);
			}
			
			function FI12(i) { //A表 塞頭採購量--*數量為負數公式有問題
				var t_g02=dec($('#textG02_'+i).val());//再製品場內可用庫存
				var t_i11=$('#textI11_'+i).val();//紙箱
				var t_mount=0; //可動用量
				var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
            	if(t_i11.length>0){
					q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_i11)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI(t_noa),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for (var j = 0; j < as.length; j++) {
						t_mount=q_add(t_mount,dec(as[j].mount));
					}
				}
				
				if(t_g02==0 || t_mount>t_g02){
					$('#textI12_'+i).val(Math.ceil(q_mul(q_sub(t_g02,t_mount),2)));
				}else{
					$('#textI12_'+i).val(0);
				}
			}
			
			function FI13(i) { //A表 塞頭貨齊日
				var t_h02=dec($('#textH02_'+i).val());//指定可產出量
				var t_i11=$('#textI11_'+i).val();//紙箱
				
				if(t_h02==0){
					$('#textI13_'+i).val(q_date());
				}else{
					var t_maxdate='';//已採未交到貨日
	            	if(t_i11.length>0){
						q_func('qtxt.query.ordcnotv_uj', 'orde_uj.txt,ordcnotv_uj,' + encodeURI(q_date())+';'+encodeURI(t_i11),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var j = 0; j < as.length; j++) {
								if(t_maxdate<as[j].indate){
									t_maxdate=as[j].indate;
								}
							}
						}
					}
					if(t_maxdate.length==0)
						$('#textI13_'+i).val(q_date());
					else
						$('#textI13_'+i).val(t_maxdate);
				}
				FI17(i);
			}
			
			function FI17(i) { //A表 料最快備齊日期
				var t_date7=$('#textI07_'+i).val();//紙管
				var t_date10=$('#textI10_'+i).val();//紙箱
				var t_date13=$('#textI13_'+i).val();//塞頭
				var t_date15=$('#textI15_'+i).val();//上膠日
				var t_day16=dec($('#textI16_'+i).val());//熟成(天)
				var t_datea=t_date7;
				
				if(emp(t_date15)){
					if(t_date10>t_datea){t_datea=t_date10;}
					if(t_date13>t_datea){t_datea=t_date13;}
				}else{
					t_date15=q_cdn(t_date15,t_day16);
					if(t_date10>t_datea){t_datea=t_date10;}
					if(t_date13>t_datea){t_datea=t_date13;}
					if(t_date15>t_datea){t_datea=t_date15;}
				}
				$('#textI17_'+i).val(t_datea);
			}
			
			function FI19(i) { //A表 訂單總量
				if($('#textE01_'+i).val()=='轉指'){
					$('#textI19_'+i).val(q_add(dec($('#textF03_'+i).val()),dec($('#textG03_'+i).val())));
				}else{
					$('#textI19_'+i).val(q_mul(dec($('#textB02_'+i).val()),dec($('#textA09_'+i).val())));
				}
			}
			
			function FI20(i) { //A表 限定餘數
				if(dec($('#textH02_'+i).val())>dec($('#textA10_'+i).val()) && $('#textA06_'+i).val()=='限定'){
					$('#textI20_'+i).val(q_sub(dec($('#textH02_'+i).val()),dec($('#textA10_'+i).val())));
				}else{
					$('#textI20_'+i).val(0);
				}
			}
			
			function FJ05(i) { //B表 分條工時
				var t_f03=dec($('#textF03_'+i).val());//中繼指定(M)
				var t_sec=0;
				var t_noa=$('#textA04_'+i).val();
				q_gt('uca',"where=^^noa='"+t_noa+"'^^", 0, 0, 0, "getuca", r_accy,1);
				var tuca = _q_appendData("uca", "", true);
				if (tuca[0] != undefined) {
					t_sec=dec(tuca[0].sec);
				}
				
				$('#textJ05_'+i).val(q_div(q_mul(t_f03,t_sec),3600));
			}
			
			function FJ06() { //B表 分1
				var t_wbdate=$('#txtWbdate').val();//決定分條日
				var t_j06=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_f03=dec($('#textF03_'+i).val());//中繼指定(M)
					var t_j01=$('#textJ01_'+i).val();//加工日
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分1' && t_j01==t_wbdate){
						t_j06=q_add(t_j06,t_f03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分1'){ //不管加工日 只要是機台一樣就寫入
						$('#textJ06_'+i).val(t_j06);
					}else{
						$('#textJ06_'+i).val('');
					}
				}
			}
			
			function FJ07() { //B表 分2
				var t_wbdate=$('#txtWbdate').val();//決定分條日
				var t_j07=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_f03=dec($('#textF03_'+i).val());//中繼指定(M)
					var t_j01=$('#textJ01_'+i).val();//加工日
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分2' && t_j01==t_wbdate){
						t_j07=q_add(t_j07,t_f03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分2'){ //不管加工日 只要是機台一樣就寫入
						$('#textJ07_'+i).val(t_j07);
					}else{
						$('#textJ07_'+i).val('');
					}
				}
			}
			
			function FJ08() { //B表 分3
				var t_wbdate=$('#txtWbdate').val();//決定分條日
				var t_j08=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_f03=dec($('#textF03_'+i).val());//中繼指定(M)
					var t_j01=$('#textJ01_'+i).val();//加工日
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分3' && t_j01==t_wbdate){
						t_j08=q_add(t_j08,t_f03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分3'){ //不管加工日 只要是機台一樣就寫入
						$('#textJ08_'+i).val(t_j08);
					}else{
						$('#textJ08_'+i).val('');
					}
				}
			}
			
			function FJ09() { //B表 分4
				var t_wbdate=$('#txtWbdate').val();//決定分條日
				var t_j09=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_f03=dec($('#textF03_'+i).val());//中繼指定(M)
					var t_j01=$('#textJ01_'+i).val();//加工日
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分4' && t_j01==t_wbdate){
						t_j09=q_add(t_j09,t_f03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j02=$('#textJ02_'+i).val();//分條機台別
					if(t_j02=='分4'){ //不管加工日 只要是機台一樣就寫入
						$('#textJ09_'+i).val(t_j09);
					}else{
						$('#textJ09_'+i).val('');
					}
				}
			}
			
			function FJ12(i) { //B表 覆捲工時
				var t_g03=dec($('#textG03_'+i).val());//再製品指定(M)
				var t_minutes=0;
				var t_noa=$('#textA04_'+i).val();
				q_gt('uca',"where=^^noa='"+t_noa+"'^^", 0, 0, 0, "getuca", r_accy,1);
				var tuca = _q_appendData("uca", "", true);
				if (tuca[0] != undefined) {
					t_minutes=dec(tuca[0].minutes);
				}
				
				$('#textJ12_'+i).val(q_div(q_mul(t_g03,t_minutes),3600));
			}
			
			function FJ13() { //B表 覆1
				var t_wedate=$('#txtWedate').val();//決定覆捲日
				var t_j13=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_g03=dec($('#textG03_'+i).val());//再製品指定(M)
					var t_j10=$('#textJ10_'+i).val();//覆捲日
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='覆1' && t_j10==t_wedate){
						t_j13=q_add(t_j13,t_g03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='覆1'){ //不管覆捲日 只要是機台一樣就寫入
						$('#textJ13_'+i).val(t_j13);
					}else{
						$('#textJ13_'+i).val('');
					}
				}
			}
			
			function FJ14() { //B表 覆2
				var t_wedate=$('#txtWedate').val();//決定覆捲日
				var t_j14=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_g03=dec($('#textG03_'+i).val());//再製品指定(M)
					var t_j10=$('#textJ10_'+i).val();//覆捲日
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='覆2' && t_j10==t_wedate){
						t_j14=q_add(t_j14,t_g03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='覆2'){ //不管覆捲日 只要是機台一樣就寫入
						$('#textJ14_'+i).val(t_j14);
					}else{
						$('#textJ14_'+i).val('');
					}
				}
			}
			
			function FJ15() { //B表 覆3
				var t_wedate=$('#txtWedate').val();//決定覆捲日
				var t_j15=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_g03=dec($('#textG03_'+i).val());//再製品指定(M)
					var t_j10=$('#textJ10_'+i).val();//覆捲日
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='覆3' && t_j10==t_wedate){
						t_j15=q_add(t_j15,t_g03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='覆3'){ //不管覆捲日 只要是機台一樣就寫入
						$('#textJ15_'+i).val(t_j15);
					}else{
						$('#textJ15_'+i).val('');
					}
				}
			}
			
			function FJ16() { //B表 其他
				var t_wedate=$('#txtWedate').val();//決定覆捲日
				var t_j16=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_g03=dec($('#textG03_'+i).val());//再製品指定(M)
					var t_j10=$('#textJ10_'+i).val();//覆捲日
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='其他' && t_j10==t_wedate){
						t_j16=q_add(t_j16,t_g03);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_j11=$('#textJ11_'+i).val();//覆捲機台別
					if(t_j11=='其他'){ //不管覆捲日 只要是機台一樣就寫入
						$('#textJ16_'+i).val(t_j16);
					}else{
						$('#textJ16_'+i).val('');
					}
				}
			}
			
			function FK06(i) { //製造 原生產量(M)
				$('#textK06_'+i).val(q_add(dec($('#textR01_'+i).val()),dec($('#textR02_'+i).val())));
				FK08(i);
			}
			
			function FK08(i) { //製造 生產量
				if($('#textK07_'+i).val().toUpperCase()=='X'){
					$('#textK08_'+i).val(0);
				}else{
					if(dec($('#textK07_'+i).val())>0){
						$('#textK08_'+i).val(dec($('#textK07_'+i).val()));
					}else{
						$('#textK08_'+i).val(dec($('#textK06_'+i).val()));
					}
				}
				FK12(i);
				FK13(i);
				FL08(i);
				FM01();
				FM03();
			}
			
			function FK11(i) { //製造 指定進度
				var tk1='',tk2='';
				if(dec($('#textP05_'+i).val())>0){
					tk1='指';
				}else if (dec($('#textP03_'+i).val())>0){
					tk1='庫';
				}else{
					tk1='無';
				}
				if(dec($('#textQ05_'+i).val())>0){
					tk2='指';
				}else if (dec($('#textQ03_'+i).val())>0){
					tk2='庫';
				}else{
					tk2='無';
				}
				$('#textK11_'+i).val(tk1+'-'+tk2);
			}
			
			function FK12(i) { //製造 指定(紙)%
				if(dec($('#textK08_'+i).val())>0){
					if(dec($('#textP05_'+i).val())>0){
						$('#textK12_'+i).val(round(q_mul(q_div(dec($('#textP05_'+i).val()),dec($('#textK08_'+i).val())),100),2));
					}else{
						$('#textK12_'+i).val(round(q_mul(q_div(dec($('#textP03_'+i).val()),dec($('#textK08_'+i).val())),100),2));
					}
				}else{
					$('#textK12_'+i).val(0);
				}
			}
			
			function FK13(i) { //製造 指定(皮)%
				if(dec($('#textK08_'+i).val())>0){
					if(dec($('#textQ05_'+i).val())>0){
						$('#textK13_'+i).val(round(q_mul(q_div(dec($('#textQ05_'+i).val()),dec($('#textK08_'+i).val())),100),2));
					}else{
						$('#textK13_'+i).val(round(q_mul(q_div(dec($('#textQ03_'+i).val()),dec($('#textK08_'+i).val())),100),2));
					}
				}else{
					$('#textK13_'+i).val(0);
				}
			}
			
			function FM01() { //製造 A
				var t_wadate=$('#txtWadate').val();//指定排程日期
				var t_m01=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_k08=dec($('#textK08_'+i).val());//生產量
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='A' && t_l03==t_wadate){
						t_m01=q_add(t_m01,t_k08);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='A' && t_l03==t_wadate){
						$('#textM01_'+i).val(t_m01);
					}else{
						$('#textM01_'+i).val('');
					}
				}
			}
			
			function FM02() { //製造 A工時
				var t_wadate=$('#txtWadate').val();//指定排程日期
				var t_m02=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_l08=dec($('#textL08_'+i).val());//工時(Hr)
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='A' && t_l03==t_wadate){
						t_m02=q_add(t_m02,t_l08);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='A' && t_l03==t_wadate){
						$('#textM02_'+i).val(t_m02);
					}else{
						$('#textM02_'+i).val('');
					}
				}
			}
			
			function FM03() { //製造 B
				var t_wadate=$('#txtWadate').val();//指定排程日期
				var t_m03=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_k08=dec($('#textK08_'+i).val());//生產量
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='B' && t_l03==t_wadate){
						t_m03=q_add(t_m03,t_k08);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='B' && t_l03==t_wadate){
						$('#textM03_'+i).val(t_m03);
					}else{
						$('#textM03_'+i).val('');
					}
				}
			}
			
			function FM04() { //製造 B工時
				var t_wadate=$('#txtWadate').val();//指定排程日期
				var t_m04=0;
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_l08=dec($('#textL08_'+i).val());//工時(Hr)
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='B' && t_l03==t_wadate){
						t_m04=q_add(t_m04,t_l08);
					}
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					var t_l03=$('#textL03_'+i).val();//上膠日
					var t_l05=$('#textL05_'+i).val();//製造機台別
					if(t_l05=='B' && t_l03==t_wadate){
						$('#textM04_'+i).val(t_m04);
					}else{
						$('#textM04_'+i).val('');
					}
				}
			}
			
			function FN02(i) { //製造 產出率(%)
				var t_n1=dec($('#textN01_'+i).val());//產出(M)
				var t_p5=dec($('#textP05_'+i).val());//上紙指定(M)
				var t_q5=dec($('#textQ05_'+i).val());//上皮指定(M)
				if(t_p5<=t_q5){
					if(t_p5==0){
						$('#textN02_'+i).val(0);
					}else{					
						$('#textN02_'+i).val(round(q_mul(q_div(t_n1,t_p5),100),2));
					}
				}else{
					$('#textN02_'+i).val(round(q_mul(q_div(t_n1,t_q5),100),2));
				}
				
			}
			
			function FR06(i) { //製造 已排未產(M)
				if($('#textN03_'+i).val()=='完工' || emp($('#textL03_'+i).val())){
					$('#textR06_'+i).val(0);
				}else{
					var t_datea=$('#textL03_'+i).val();
					if(q_cdn(t_datea,-30)<q_date()){
						$('#textR06_'+i).val($('#textK08_'+i).val());
					}else{
						$('#textR06_'+i).val(0);
					}
				}
			}
			
			function FL08(i) { //製造 工時(Hr)
				var t_k08=dec($('#textK08_'+i).val());//生產量
				var t_sec=0;//生產速度(M/min)
				var t_noa=$('#textK03_'+b_seq).val();
				q_gt('uca',"where=^^noa='"+t_noa+"'^^", 0, 0, 0, "getuca", r_accy,1);
				var tuca = _q_appendData("uca", "", true);
				if (tuca[0] != undefined) {
					t_sec=dec(tuca[0].sec);
				}
				
				$('#textL08_'+i).val(round(q_div(q_div(t_k08,t_sec),60),1));
				FM02();
				FM04();
			}
			
			//---------------------------------------------------------------
			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
			}

			function sum() {
				for (var j = 0; j < q_bbsCount; j++) {

				}
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

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					case 'textA04_':
						var t_pno=$('#textA04_'+b_seq).val();
						q_gt('uca',"where=^^noa='"+t_pno+"'^^", 0, 0, 0, "getuca", r_accy,1);
						var tuca = _q_appendData("uca", "", true);
						if (tuca[0] != undefined) {
							if(tuca[0].typea=='2'){//成品
								$('#textA07_'+b_seq).val(tuca[0].groupdno);//銷售政策
								$('#textA08_'+b_seq).val(tuca[0].mechs);//寬(mm)
								$('#textA09_'+b_seq).val(tuca[0].trans);//長(M)	
								$('#textA11_'+b_seq).val(tuca[0].unit);//單位
												
								$('#textF01_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
								$('#textG01_'+b_seq).val(tuca[0].groupcno)//再製品
												
								$('#textI05_'+b_seq).val(tuca[0].groupeno)//紙管
								$('#textI08_'+b_seq).val(tuca[0].groupfno)//紙箱
								$('#textI11_'+b_seq).val(tuca[0].groupgno)//塞頭
							}else{
								var t_unit1=t_pno.substr(0,1).toLocaleUpperCase();
								if(t_unit1=='1' || t_unit1=='2' || t_unit1=='P' || t_unit1=='Z'|| t_unit1=='S'){
									$('#textA11_'+b_seq).val('支');//單位
								}else if(t_unit1=='C'){
									$('#textA11_'+b_seq).val('張');//單位
								}else if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
									$('#textA11_'+b_seq).val('M');//單位
								}else{
									$('#textA11_'+b_seq).val('');//單位
								}
								if(tuca[0].typea=='3'){//半成品
									$('#textF01_'+b_seq).val(t_pno);//中繼產品料號
									$('#textI16_'+b_seq).val(tuca[0].preday);//熟成(天)
								}
							}
						}else{
							alert('無此料號!!');
						}
						getstk(b_seq,'1');
						getstk(b_seq,'2');
						getstk(b_seq,'3');
						FI06(b_seq);
						FI07(b_seq);
						FI09(b_seq);
						FI10(b_seq);
						FI12(b_seq);
						FI13(b_seq);
						break;
					case 'textF01_':
						var t_pno=$('#textF01_'+b_seq).val();
						q_gt('uca',"where=^^noa='"+t_pno+"'^^", 0, 0, 0, "getuca", r_accy,1);
						var tuca = _q_appendData("uca", "", true);
						if (tuca[0] != undefined) {
							$('#textI16_'+b_seq).val(tuca[0].preday);//熟成(天)
						}
						getstk(b_seq,'2');
						break;
					case 'textG01_':
						getstk(b_seq,'3');
						break;
					case 'textI05_':
						FI06(b_seq);
						FI07(b_seq);
						break;
					case 'textI08_':
						FI09(b_seq);
						FI10(b_seq);
						break;
					case 'textI11_':
						FI12(b_seq);
						FI13(b_seq);
						break;
					case 'textK03_':
						var t_noa=$('#textK03_'+b_seq).val();
						q_gt('uca',"where=^^noa='"+t_noa+"' and typea='3' ^^", 0, 0, 0, "getuca", r_accy,1);
						var tuca = _q_appendData("uca", "", true);
						if (tuca[0] != undefined) {
							var t_style=tuca[0].style.split('#^#');
							
							$('#textL01_'+b_seq).val(t_style[1]); //換線屬性
							$('#textL02_'+b_seq).val(t_style[2]); //補水
							$('#textL06_'+b_seq).val(tuca[0].modelno); //限定機台別
							$('#textP01_'+b_seq).val(tuca[0].groupino); //上紙(投入)
							$('#textQ01_'+b_seq).val(tuca[0].grouphno); //上皮(投入)
						}else{
							alert('無此料號!!');
							$('#btnMinus_'+b_seq).click();
						}
						
						//判斷是否在計畫內
						if(emp($('#txtNoq_'+b_seq).val())){
							var t_mon=emp($('#txtWadate').val())?q_date().substr(0,r_lenm):$('#txtWadate').val().substr(0,r_lenm);
							q_gt('saleforecast',"where=^^mon='"+t_mon+"' and exists (select * from saleforecasts where noa=saleforecast.noa and productno='"+t_noa+"') ^^", 0, 0, 0, "getsaleforecasts", r_accy,1);
							var as = _q_appendData("saleforecasts", "", true);
							if (as[0] != undefined) {
								$('#textK04_'+b_seq).val('計');
								$('#textK05_'+b_seq).val(as[0].unit);
							}else{
								$('#textK04_'+b_seq).val('');
								$('#textK05_'+b_seq).val('');
							}
						}else{
							$('#textK04_'+b_seq).val('');
							$('#textK05_'+b_seq).val('');
						}
						
						break;
					default:
						break;
				}
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.div_stk_uj':
						var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			var rowslength=document.getElementById("table_stk").rows.length-4;
							for (var j = 0; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
							
							var bbtas=[];//bbt該筆資料已被指定的庫存
							var dbbtas=[];//bbt非該筆資料已被指定的庫存
							var t_n=$('#s_bbsnoq').val();
							var source=$('#s_bbssource').val();
							for (var i = 0; i < q_bbtCount; i++) {
								if($('#txtNo2__'+i).val()==source && $('#txtOrdeno__'+i).val()==$('#txtOrdeno_'+t_n).val()){
									bbtas.push({
										'ordeno':$('#txtOrdeno__'+i).val(),
										'no2':$('#txtNo2__'+i).val(),
										'uno':$('#txtUno__'+i).val(),
										'productno':$('#txtProductno__'+i).val(),
										'spec':$('#txtSpec__'+i).val(),
										'mount':$('#txtMount__'+i).val(),
										'weight':$('#txtWeight__'+i).val(),
										'indate':$('#txtMemo__'+i).val().split('#^#')[0]==undefined?'':$('#txtMemo__'+i).val().split('#^#')[0],
										'unit':$('#txtMemo__'+i).val().split('#^#')[1]==undefined?'':$('#txtMemo__'+i).val().split('#^#')[1],
									});
								}else{
									dbbtas.push({
										'ordeno':$('#txtOrdeno__'+i).val(),
										'no2':$('#txtNo2__'+i).val(),
										'uno':$('#txtUno__'+i).val(),
										'productno':$('#txtProductno__'+i).val(),
										'spec':$('#txtSpec__'+i).val(),
										'mount':$('#txtMount__'+i).val(),
										'weight':$('#txtWeight__'+i).val(),
										'indate':$('#txtMemo__'+i).val().split('#^#')[0]==undefined?'':$('#txtMemo__'+i).val().split('#^#')[0],
										'unit':$('#txtMemo__'+i).val().split('#^#')[1]==undefined?'':$('#txtMemo__'+i).val().split('#^#')[1],
									});
								}
							}
							
							//刪除本單已被其他項目指定的庫存
							for(var j=0;j<dbbtas.length;j++){
								for (var i = 0; i < as.length; i++) {
									if(dbbtas[j].uno==as[i].uno && dbbtas[j].productno==as[i].productno && dbbtas[j].spec==as[i].spec){
										as[i].bmount=q_add(dec(as[i].bmount),dec(dbbtas[j].mount));
										as[i].bweight=q_add(dec(as[i].bweight),dec(dbbtas[j].weight));
										break;
									}	
								}
							}
							
							//刪除已被本單和其他單號指定完的庫存 bmount,bweight
							for (var i = 0; i < as.length; i++) {
								if(q_sub(dec(as[i].mount),dec(as[i].bmount))<=0 && q_sub(dec(as[i].weight),dec(as[i].bweight))<=0){
									as.splice(i, 1);
                                    i--;
								}else{
									as[i].mount=q_sub(dec(as[i].mount),dec(as[i].bmount));
									as[i].weight=q_sub(dec(as[i].weight),dec(as[i].bweight));
								}
							}
							
							var t_stk=0;
							for (var i = 0; i < as.length; i++) {
								if(as[i].mount==1){
									as[i].lengthc=as[i].weight;
									as[i].lengthb='';
								}else{
									as[i].lengthc='';
								}
								
								t_stk=q_add(t_stk,dec(as[i].weight));
								var t_btmount=0,t_btweight=0;
								
								for (var j = 0; j < bbtas.length; j++) {
									if(bbtas[j].uno==as[i].uno && bbtas[j].spec==as[i].spec && bbtas[j].productno==as[i].productno){
										t_btmount=bbtas[j].mount;
										t_btweight=bbtas[j].weight;
										bbtas.splice(j, 1);
										break;
									}
								}
								
								var tr = document.createElement("tr");
								tr.id = "bbs_"+i;
								tr.innerHTML+="<td id='stk_tdUno_"+i+"'>"+as[i].uno+"</td>"; //身分證號
								tr.innerHTML+="<td id='stk_tdSpec_"+i+"'>"+as[i].spec+"</td>"; //列管品
								tr.innerHTML+="<td id='stk_tdindate_"+i+"' align='center'>"+as[i].indate+"</td>"; //進貨(生產)日
								tr.innerHTML+="<td id='stk_tdMount_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].mount)+"</td>"; //數量
								tr.innerHTML+="<td id='stk_tdUnit_"+i+"'>"+as[i].unit+"</td>"; //單位
								tr.innerHTML+="<td id='stk_tdLengthb_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].lengthb)+"</td>"; //標準長(M)同規格
								tr.innerHTML+="<td id='stk_tdLengthc_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].lengthc)+"</td>"; //原長(M)
								tr.innerHTML+="<td id='stk_tdWeight_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].weight)+"</td>"; //可用長
								tr.innerHTML+="<td id='stk_tdTmount_"+i+"'style='text-align: right;'><input id=stk_txtMount_"+i+" class='setmount' style='width:98%;text-align:right;' value='"+t_btmount+"'></td>"; //數量
								tr.innerHTML+="<td id='stk_tdTweight_"+i+"'style='text-align: right;'><input id=stk_txtWeight_"+i+" class='setweight' style='width:98%;text-align:right;' value='"+t_btweight+"'></td>"; //指定
								tr.innerHTML+="<td id='stk_tdNotv_"+i+"'style='text-align: right;' class='margin'>"+FormatNumber(as[i].weight)+"</td>"; //餘
								
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
								
								$('#stk_txtMount_'+i).change(function() {
									var tmp=$(this).val();
									tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
									$(this).val(tmp);
									
									var n=$(this).attr('id').split('_')[2];
									var x_mount=dec($(this).val());
									var t_mount=dec($('#stk_tdMount_'+n).text());
									var t_weight=dec($('#stk_tdWeight_'+n).text());
									
									if(x_mount>t_mount){
										alert('指定數量大於可用庫存數量!!');
										$(this).val(t_mount);
										x_mount=t_mount;
									}
									
									$('#stk_txtWeight_'+n).val(round(q_mul(t_weight,q_div(x_mount,t_mount)),0));
									$('#stk_txtWeight_'+n).change();
								});
								
								$('#stk_txtWeight_'+i).change(function() {
									var tmp=$(this).val();
									tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
									$(this).val(tmp);
									
									var n=$(this).attr('id').split('_')[2];
									var x_weight=dec($(this).val());
									var t_mount=dec($('#stk_tdMount_'+n).text());
									var t_weight=dec($('#stk_tdWeight_'+n).text());
									
									if(x_weight>t_weight){
										alert('指定長度大於可用庫存長度!!');
										$(this).val(t_weight);
										x_weight=t_weight;
									}
									
									$('#stk_txtMount_'+n).val(Math.ceil(q_mul(t_mount,q_div(x_weight,t_weight))));
									$('#stk_tdNotv_'+n).text(q_sub(t_weight,dec(x_weight)));
									
									var t_sweight=0;
									$('.setweight').each(function(index) {
										t_sweight=q_add(t_sweight,dec($(this).val()));
									});
									$('#s_isset').text(FormatNumber(t_sweight));
									var s_mount=dec($('#s_weight').text());
									if(s_mount!=0)
										$('#s_pisset').text(FormatNumber(Math.floor(q_mul(q_div(t_sweight,s_mount),100)))+'%');
									else
										$('#s_pisset').text('');
									
									var t_margin=0;
									$('.margin').each(function(index) {
										t_margin=q_add(t_margin,dec($(this).text()));
									});
									$('#s_stk').text(FormatNumber(t_margin));
								});
                			}
                			
                			//插入已使用的指定庫存
                			if(bbtas.length>0){
                				var trows=document.getElementById("table_stk").rows.length-4;
                				for (var j = 0; j < bbtas.length; j++) {
	                				var tr = document.createElement("tr");
									tr.id = "bbs_"+i;
									tr.innerHTML+="<td id='stk_tdUno_"+(trows+j)+"'>"+bbtas[j].uno+"</td>"; //身分證號
									tr.innerHTML+="<td id='stk_tdSpec_"+(trows+j)+"'>"+bbtas[j].spec+"</td>"; //列管品
									tr.innerHTML+="<td id='stk_tdindate_"+(trows+j)+"' align='center'>"+bbtas[j].indate+"</td>"; //進貨(生產)日
									tr.innerHTML+="<td id='stk_tdMount_"+(trows+j)+"'style='text-align: right;'></td>"; //數量
									tr.innerHTML+="<td id='stk_tdUnit_"+(trows+j)+"'>"+bbtas[j].unit+"</td>"; //單位
									tr.innerHTML+="<td id='stk_tdLengthb_"+(trows+j)+"'style='text-align: right;'></td>"; //標準長(M)同規格
									tr.innerHTML+="<td id='stk_tdLengthc_"+(trows+j)+"'style='text-align: right;'></td>"; //原長(M)
									tr.innerHTML+="<td id='stk_tdWeight_"+(trows+j)+"'style='text-align: right;'></td>"; //可用長
									tr.innerHTML+="<td id='stk_tdTmount_"+(trows+j)+"'style='text-align: right;'><input id=stk_txtMount_"+i+" class='setmount' style='width:98%;text-align:right;' value='"+bbtas[j].mount+"' disabled='disabled'></td>"; //數量
									tr.innerHTML+="<td id='stk_tdTweight_"+(trows+j)+"'style='text-align: right;'><input id=stk_txtWeight_"+i+" class='setweight' style='width:98%;text-align:right;' value='"+bbtas[j].weight+"' disabled='disabled'></td>"; //指定
									tr.innerHTML+="<td id='stk_tdNotv_"+i+"'style='text-align: right;' class='margin'>0</td>"; //餘
									
									var tmp = document.getElementById("stk_close");
									tmp.parentNode.insertBefore(tr,tmp);	
								}
                			}
                			
							$('#s_stk').text(FormatNumber(t_stk));
                			
                			if(as.length==0 && bbtas.length==0){
                				alert('無可動用庫存資料!!');
                			}else{
                				$('#div_stk').show();
                			}
                		}else{
                			alert('無可動用庫存資料!!');
                		}
						break;
				}
			}
			
			function getstk(n,source) {
				var t_productno='';
				if(source=='1'){
					t_productno=$('#textA04_' + n).val();
				}
				if(source=='2'){
					t_productno=$('#textF01_' + n).val();
				}
				if(source=='3'){
					t_productno=$('#textG01_' + n).val();
				}
				
				var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
            	if(t_productno.length>0){
					q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_productno)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI(t_noa),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					var t_weight=0,t_mount=0;
					for (var i = 0; i < as.length; i++) {
						t_mount=q_add(t_mount,dec(as[i].mount));
						t_weight=q_add(t_weight,dec(as[i].weight));
					}
					var t_unit1=t_productno.substr(0,1).toLocaleUpperCase();
					if(source=='1'){
						if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
							$('#textC01_' + n).val(t_weight);
						}else{
							$('#textC01_' + n).val(t_mount);
						}
					}
					if(source=='2'){
						$('#textF02_' + n).val(t_weight);
						FH01(n);
					}
					if(source=='3'){
						$('#textG02_' + n).val(t_weight);
						FH01(n);
					}
				}
			}
			
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
            
            function getproduct(t_pno) {
            	var t_product='';
            	
				if('1,2,3,P,C,S'.indexOf(t_pno.substr(0,1).toUpperCase())>-1){
					t_product='成品';
				}else if (t_pno.substr(0,1).toUpperCase()=='Z'){
					t_product='零碼';
				}else if (t_pno.substr(0,1).toUpperCase()=='6'){
					t_product='再製品(入帳)';
				}else if (t_pno.substr(0,1).toUpperCase()=='5'){
					t_product='半成品';
				}else if (t_pno.substr(0,1).toUpperCase()=='#'){
					t_product='再製品(中繼)';
				}else if ('7S,8S,8P'.indexOf(t_pno.substr(0,2).toUpperCase())>-1){
					t_product='皮料';
				}else if ('7L,8L'.indexOf(t_pno.substr(0,2).toUpperCase())>-1){
					t_product='離型紙';
				}else if (t_pno.substr(0,2).toUpperCase()=='9C'){
					t_product='紙箱';
				}else if (t_pno.substr(0,2).toUpperCase()=='9P'){
					t_product='管芯';
				}else if (t_pno.substr(0,2).toUpperCase()=='9B'){
					t_product='塞頭';
				}else if (t_pno.substr(0,2).toUpperCase()=='9W'){
					t_product='棧板';
				}else{
					t_product='';
				}
				return t_product;
			}
			
			function getweek(t_date) {
            	if(r_len==3){
            		t_date=dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2));
            	}
            	switch (new Date(t_date).getDay()) {
            		case 0:
            			return '日'; 
            			break;
            		case 1:
            			return '一';
            			break;
            		case 2:
            			return '二';
            			break;
            		case 3:
            			return '三';
            			break;
            		case 4:
            			return '四';
            			break;
            		case 5:
            			return '五';
            			break;
            		case 6:
            			return '六';
            			break;
            		default:
            			return '';
  						break;
            	}
            }
            
            //建立亂數項次號
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + s4() + s4();};
			})();
            function nordeno() {
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(emp($('#txtOrdeno_'+i).val())){
            			$('#txtOrdeno_'+i).val(guid()+Date.now());
            		}
            	}
            }
			
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 420px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
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
				width: 840px;
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
				/*width: 15%;*/
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
				width: 99%;
				float: left;
			}
			.txt.c2 {
				width: 46%;
				float: left;
			}
			.txt.c3 {
				width: 35%;
				float: left;
			}
			.txt.c4 {
				width: 63%;
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
			
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size:medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 3100px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
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
			#dbbt {
				width: 900px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1px;
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
			
			
			.dbbstop .tbbstop {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: lightgrey;
				width: 100%;
			}
			.dbbstop .tbbstop tr {
				height: 35px;
			}
			.dbbstop .tbbstop tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			
			#div_row{
				display:none;
				width:750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
                color: #000000;
                font-weight: bolder;
                font-size: medium;
                cursor: pointer;
            }
            .table_row tr td .lbl.btn:hover {
                color: #FF8F19;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<div id="div_stk" style="position:absolute; top:180px; left:20px; display:none; width:1120px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td align="center">訂單號
						<input id='s_bbsnoq' type="hidden">
						<input id='s_bbssource' type="hidden">
					</td>
					<td align="center">訂單名稱</td>
					<td colspan="2" align="center">指定料號</td>
					<td align="center">料名</td>
					<td align="center">需求(M)</td>
					<td align="center">指定</td>
					<td align="center">指定(%)</td>
					<td align="center">可動用</td>
					<td align="center">可用<BR>｢已採未交｣</td>
					<td align="center">｢已採未交｣<BR>到貨日</td>
				</tr>
				<tr>
					<td id='s_cubno'> </td>
					<td id='s_cubname'> </td>
					<td colspan="2" id='s_productno'> </td>
					<td id='s_product' align="center"> </td>
					<td id='s_weight' align="right"> </td>
					<td id='s_isset' align="right"> </td>
					<td id='s_pisset' align="right"> </td>
					<td id='s_stk' align="right"> </td>
					<td id='s_ordc' align="right"> </td>
					<td id='s_ordcdate' align="center"> </td>
				</tr>
				<tr>
					<td style="width:150px;" align="center">身分證號</td>
					<td style="width:100px;" align="center">列管品</td>
					<td style="width:100px;" align="center">進貨<BR>(生產)日</td>
					<td style="width:100px;" align="center">數量</td>
					<td style="width:70px;" align="center">單位</td>
					<td style="width:100px;" align="center">標準長(M)<BR>同規格</td>
					<td style="width:100px;" align="center">原長(M)</td>
					<td style="width:100px;" align="center">可用長</td>
					<td style="width:100px;" align="center">數量</td>
					<td style="width:100px;" align="center">指定</td>
					<td style="width:100px;" align="center">餘</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='11'>
						<input id="btnClose_div_stk" type="button" value="確定">
						<input id="btnClose_div_stk2" type="button" value="取消">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="width: 1270px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:24px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:110px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:50px; color:black;"><a id='vewStype'> </a></td>
						<td style="width:170px; color:black;"><a id='vewRang_uj'>訂單預交日</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td align="center" id='stype'>~stype</td>
						<td id='bdate edate' style="text-align: center;">~bdate - ~edate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td style="width: 140px;"> </td>
						<td style="width: 135px;"> </td>
						<td style="width: 140px;"> </td>
						<td style="width: 135px;"> </td>
						<td style="width: 140px;"> </td>
						<td style="width: 135px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input id="txtDatea" type="text" class="txt c1"/>
							<input id="txtSfbdate" type="hidden"/>
							<input id="txtSfedate" type="hidden"/>
						</td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c2"/>
						</td>
						<td>
							<input id="btnCub_uj" class="M1" type="button" value="生產指令匯入" style="display: none;"/>
							<input id="btnWorkgsale_uj" class="M3" type="button" value="計畫&生產匯入" style="display: none;"/>
						</td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" class="txt c3"/>
							<input id="txtComp" type="text" class="txt c4"/>
						</td>
					</tr>
					<tr class="M3">
						<td><span> </span><a id="lblUcc1_uj" class="lbl btn">製造"上皮"投入</a></td>
						<td><input id="txtUcc1no" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUcc2_uj" class="lbl btn">製造"上紙"投入</a></td>
						<td><input id="txtUcc2no" type="text" class="txt c1"/></td>
					</tr>
					<tr class="M1 M2 M3">
						<td><span> </span><a id="lblWadate_uj" class="lbl">建議加工日</a></td>
						<td><input id="txtWadate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMount_uj" class="lbl">排程量</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="M2">
						<td><span> </span><a id="lblWbdate_uj" class="lbl">決定分條日</a></td>
						<td><input id="txtWbdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWedate_uj" class="lbl">決定覆捲日</a></td>
						<td><input id="txtWedate" type="text" class="txt c1"/></td>
					</tr>
					<tr class="M2">
						<td><span> </span><a id="lblOrdano_uj" class="lbl">加工產出回報</a></td>
						<td><input id="txtOrdano" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo_uj" class="lbl" >備註</a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<!--bbs欄位區別-----------------------------暫不顯示容易跑掉-->
			<div class='dbbstop' style="float: left;display: none;">
				<table id="tbbstop" class='tbbstop'>
					<tr style='color:white; background:#003366;' >
						<td style="width:100px;"> </td>
						<!--原生產指令需求-->
						<td class="M1 M2" style="width:1400px;"><a>原生產指令需求</a></td>
						<!---->
						<td class="M1" style="width:200px;"> </td>
						<!--Booking或指定-->
						<td class="M1" style="width:625px;"><a>Booking或指定</a></td>
						<!--中繼產品"指定"前預估生產量-->
						<td class="M1 M2" style="width:500px;"><a>中繼產品"指定"前預估生產量</a></td>
						<!---->
						<td class="M1 M2" style="width:100px;"><a> </a></td>
						<!--中繼產品-->
						<td class="M1 M2" style="width:435px;"><a>中繼產品</a></td>
						<!--再製品-->
						<td class="M1 M2" style="width:435px;"><a>再製品</a></td>
						<!--指定後產出量-->
						<td class="M1" style="width:300px;"><a>指定後產出量</a></td>
						<!---->
						<td class="M1 M2" style="width:2300px;"><a> </a></td>
						<!--加工B-->
						<td class="M2" style="width:2100px;"><a> </a></td>
						<!--製造-->
						<td class="M3" style="width:1510px;"><a> </a></td> 
						<!--決定"上膠日"-->
						<td class="M3" style="width:725px;"><a>決定"上膠日"</a></td>
						<!--排程量-->
						<td class="M3" style="width:360px;"><a>排程量</a></td>
						<!--製造產出回報-->
						<td class="M3" style="width:280px;"><a>製造產出回報</a></td>
						<!---->
						<td class="M3" style="width:135px;"><a> </a></td>
						<!--上紙段(投入)-->
						<td class="M3" style="width:735px;"><a>上紙段(投入)</a></td>
						<!--上皮段(投入)-->
						<td class="M3" style="width:735px;"><a>上皮段(投入)</a></td>
						<!---->
						<td class="M3" style="width:700px;"><a> </a></td>
						<!---->
					</tr>
				</table>
			</div>
			<!-------------------------------------------->
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:40px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;display: none;"> </td>
						<td style="width:60px;"><a id='lblNoq_uj_s'>項次</a></td>
						<!--原生產指令需求-->
						<td class="M1 M2" style="width:150px;"><a id="lblA01_uj_s">指令流水號</a></td>
						<td class="M1 M2" style="width:150px;"><a id="lblA02_uj_s">指令名稱</a></td>
						<td class="M1 M2" style="width:200px;"><a id="lblA03_uj_s">料號<BR>(原成品名)</a></td>
						<td class="M1 M2" style="width:200px;"><a id="lblA04_uj_s">新成品<BR>編碼</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA05_uj_s">交期</a></td>
						<td class="M1" style="width:100px;"><a id="lblA06_uj_s">成品指令</a></td>
						<td class="M1" style="width:100px;"><a id="lblA07_uj_s">銷售政策</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA08_uj_s">寬(mm)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA09_uj_s">長(M)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA10_uj_s">原需求<BR>數量</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA11_uj_s">單位</a></td>
						<!---->
						<td class="M1" style="width:100px;"><a id="lblB01_uj_s">手調</a></td>
						<td class="M1" style="width:100px;"><a id="lblB02_uj_s">數量</a></td>
						<!--Booking或指定-->
						<td class="M1" style="width:100px;"><a id="lblC01_uj_s">可動用</a></td>
						<td class="M1" style="width:100px;"><a id="lblC02_uj_s">Booking<BR>手調</a></td>
						<td class="M1" style="width:100px;"><a id="lblC03_uj_s">Booking</a></td>
						<td class="M1" style="width:100px;"><a id="lblC04_uj_s">指定</a></td>
						<td class="M1" style="width:35px;"><a id="lblC05_uj_s">連接</a></td>
						<td class="M1" style="width:55px;"><a id="lblC06_uj_s">調撥單</a></td>
						<td class="M1" style="width:100px;"><a id="lblC07_uj_s">Booking<BR>到期日</a></td>
						<td class="M1" style="width:35px;"><a id="lblC08_uj_s">確定</a></td>
						<!--中繼產品"指定"前預估生產量-->
						<td class="M1" style="width:100px;"><a id="lblD01_uj_s">應生產量<BR>成品</a></td>
						<td class="M1" style="width:100px;"><a id="lblD02_uj_s">應生產(M)</a></td>
						<td class="M1" style="width:100px;"><a id="lblD03_uj_s">上膠(M)</a></td>
						<td class="M1" style="width:100px;"><a id="lblD04_uj_s">手調(M)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblD05_uj_s">生產(M)</a></td>
						<!---->
						<td class="M1 M2" style="width:100px;"><a id="lblE01_uj_s">場內可用<BR>庫存供貨</a></td>
						<!--中繼產品-->
						<td class="M1" style="width:200px;"><a id="lblF01_uj_s">中繼產品<BR>料號</a></td>
						<td class="M1" style="width:100px;"><a id="lblF02_uj_s">中繼場內<BR>可用庫存</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblF03_uj_s">中繼指定(M)</a></td>
						<td class="M1" style="width:35px;"><a id="lblF04_uj_s">連接</a></td>
						<!--再製品-->
						<td class="M1" style="width:200px;"><a id="lblG01_uj_s">再製品</a></td>
						<td class="M1" style="width:100px;"><a id="lblG02_uj_s">再製品場內<BR>可用庫存</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblG03_uj_s">再製品指定(M)</a></td>
						<td class="M1" style="width:35px;"><a id="lblG04_uj_s">連接</a></td>
						<!--指定後產出量-->
						<td class="M1" style="width:100px;"><a id="lblH01_uj_s">指定(%)</a></td>
						<td class="M1" style="width:100px;"><a id="lblH02_uj_s">指定<BR>可產出量</a></td>
						<td class="M1" style="width:100px;"><a id="lblH03_uj_s">生產成品</a></td>
						<!---->
						<td class="M1" style="width:100px;"><a id="lblI01_uj_s">物料需求<BR>手調</a></td>
						<td class="M1" style="width:100px;"><a id="lblI02_uj_s">物料需求(套)</a></td>
						<td class="M1" style="width:100px;"><a id="lblI03_uj_s">業務<BR>成品需求</a></td>
						<td class="M1" style="width:100px;"><a id="lblI04_uj_s">業務<BR>餘料需求</a></td>
						<td class="M1" style="width:200px;"><a id="lblI05_uj_s">紙管</a></td>
						<td class="M1" style="width:100px;"><a id="lblI06_uj_s">紙管<BR>採購量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI07_uj_s">紙管<BR>貨齊日</a></td>
						<td class="M1" style="width:200px;"><a id="lblI08_uj_s">紙箱</a></td>
						<td class="M1" style="width:100px;"><a id="lblI09_uj_s">紙箱<BR>採購量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI10_uj_s">紙箱<BR>貨齊日</a></td>
						<td class="M1" style="width:200px;"><a id="lblI11_uj_s">塞頭</a></td>
						<td class="M1" style="width:100px;"><a id="lblI12_uj_s">塞頭<BR>採購量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI13_uj_s">塞頭<BR>貨齊日</a></td>
						<td class="M1" style="width:100px;"><a id="lblI14_uj_s">物料<BR>指定確認</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblI15_uj_s">上膠日</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblI16_uj_s">熟成(天)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblI17_uj_s">料最快<BR>備齊日期</a></td>
						<td style="width:100px;display: none"><a id="lblI18_uj_s">完工狀態<BR>(加工)</a></td><!-- class="M1"-->
						<td class="M1" style="width:100px;"><a id="lblI19_uj_s">訂單總量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI20_uj_s">限定餘數</a></td>
						
						<!--加工B-->
						<td class="M2" style="width:100px;"><a id="lblJ01_uj_s">加工日</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ02_uj_s">分條機台別</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ03_uj_s">可分條機台</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ04_uj_s">不可<BR>分條機台</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ05_uj_s">分條工時<BR>(Hr)</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ06_uj_s">分1</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ07_uj_s">分2</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ08_uj_s">分3</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ09_uj_s">分4</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ10_uj_s">覆捲日</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ11_uj_s">覆捲<BR>機台別</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ12_uj_s">覆捲工時<BR>(Hr)</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ13_uj_s">覆1</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ14_uj_s">覆2</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ15_uj_s">覆3</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ16_uj_s">其他</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ17_uj_s">需求急別</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ18_uj_s">備註</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ19_uj_s">產出</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ20_uj_s">產出率(%)</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ21_uj_s">完工狀態</a></td>
						
						<!--製造-->
						<td class="M3" style="width:100px;"><a id="lblK01_uj_s">交期</a></td>   <!--107/01/09 調整-->
						<td class="M3" style="width:150px;"><a id="lblK02_uj_s">訂單名稱</a></td> <!--107/01/09 調整-->
						<td class="M3" style="width:200px;"><a id="lblK03_uj_s">半成品</a></td>
						<td class="M3" style="width:100px;"><a id="lblK04_uj_s">計畫性</a></td>
						<td class="M3" style="width:100px;"><a id="lblK05_uj_s">需求</a></td>
						<td class="M3" style="width:100px;"><a id="lblK06_uj_s">原生產量(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblK07_uj_s">手調</a></td>
						<td class="M3" style="width:100px;"><a id="lblK08_uj_s">生產量</a></td>
						<td class="M3" style="width:100px;"><a id="lblK09_uj_s">下料指令</a></td>
						<td class="M3" style="width:100px;"><a id="lblK10_uj_s">列管備註</a></td>
						<td class="M3" style="width:100px;"><a id="lblK11_uj_s">指定進度</a></td>
						<td class="M3" style="width:80px;"><a id="lblK12_uj_s">指定<BR>(紙)%</a></td>
						<td class="M3" style="width:80px;"><a id="lblK13_uj_s">指定<BR>(皮)%</a></td>
						<td class="M3" style="width:100px;"><a id="lblK14_uj_s">原料最快<BR>備齊日期</a></td>
						<!--決定"上膠日"-->
						<td class="M3" style="width:100px;"><a id="lblL01_uj_s">換線屬性</a></td>
						<td class="M3" style="width:100px;"><a id="lblL02_uj_s">補水</a></td>
						<td class="M3" style="width:125px;"><a id="lblL03_uj_s">上膠日</a></td>  <!--107/01/09 調整-->
						<td class="M3" style="width:100px;"><a id="lblL05_uj_s">製造機台別</a></td>
						<td class="M3" style="width:100px;"><a id="lblL06_uj_s">限定機台別</a></td>
						<td class="M3" style="width:100px;"><a id="lblL07_uj_s">備料板位</a></td>
						<td class="M3" style="width:100px;"><a id="lblL08_uj_s">工時(Hr)</a></td>  <!--107/01/09 調整-->
						<!--排程量-->
						<td class="M3" style="width:100px;"><a id="lblM01_uj_s">A</a></td>
						<td class="M3" style="width:80px;"><a id="lblM02_uj_s">A工時<BR>(小時)</a></td>
						<td class="M3" style="width:100px;"><a id="lblM03_uj_s">B</a></td>
						<td class="M3" style="width:80px;"><a id="lblM04_uj_s">B工時<BR>(小時)</a></td>
						<!--製造產出回報-->
						<td class="M3" style="width:100px;"><a id="lblN01_uj_s">產出(M)</a></td>
						<td class="M3" style="width:80px;"><a id="lblN02_uj_s">產出率<BR>(%)</a></td>
						<td class="M3" style="width:100px;"><a id="lblN03_uj_s">完工狀態</a></td>
						<!---->
						<td class="M3" style="width:35px;"><a id="lblO01_uj_s">完工<BR>確認</a></td>
						<td class="M3" style="width:100px;"><a id="lblO02_uj_s">備註</a></td>
						<!--上紙段(投入)-->
						<td class="M3" style="width:200px;"><a id="lblP01_uj_s">上紙(投入)</a></td>
						<td class="M3" style="width:200px;"><a id="lblP02_uj_s">上紙替代</a></td>
						<td class="M3" style="width:100px;"><a id="lblP03_uj_s">上紙場內<BR>可動用庫存</a></td>
						<td class="M3" style="width:100px;"><a id="lblP04_uj_s">上紙<BR>已採未交</a></td>
						<td class="M3" style="width:100px;"><a id="lblP05_uj_s">上紙<BR>指定(M)</a></td>
						<td class="M3" style="width:35px;"><a id="lblP06_uj_s">上紙<BR>連接</a></td>
						<!--上皮段(投入)-->
						<td class="M3" style="width:200px;"><a id="lblQ01_uj_s">上皮(投入)</a></td>
						<td class="M3" style="width:200px;"><a id="lblQ02_uj_s">上皮替代</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ03_uj_s">上皮場內<BR>可動用庫存</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ04_uj_s">上皮<BR>已採未交</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ05_uj_s">上皮<BR>指定(M)</a></td>
						<td class="M3" style="width:35px;"><a id="lblQ06_uj_s">上皮<BR>連接</a></td>
						<!---->
						<td class="M3" style="width:100px;"><a id="lblR01_uj_s">計畫性<BR>需求(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR02_uj_s">訂單性<BR>需求(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR03_uj_s">成品<BR>庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR04_uj_s">半成品<BR>庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR05_uj_s">再製品<BR>庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR06_uj_s">已排未產(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR07_uj_s">總庫存(M)</a></td>
						<!---->
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/></td>
						<td style="display: none;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td align="center">
							<input id="txtNoq.*" type="text" class="txt c1"/>
							<input id="txtOrdeno.*" type="hidden" class="txt c1"/>
						</td>
						<!--原生產指令需求-->
						<td class="M1 M2">
							<input id="textA01.*" type="text" class="txt c1"/>
							<input id="txtWorkhno.*" type="hidden"/> <!--用來儲存完整的cub.noa-cub.noq-->
						</td>
						<td class="M1 M2">
							<input id="textA02.*" type="text" class="txt c1"/>
							<input id="txtMemo2.*" type="hidden"/>
						</td>
						<td class="M1 M2"><input id="textA03.*" type="text" class="txt c1"/></td>
						<td class="M1 M2">
							<input id="textA04.*" type="text" class="txt c1"/>
							<input id="txtProductno.*" type="hidden"/>
						</td>
						<td class="M1 M2">
							<input id="textA05.*" type="text" class="txt c1"/>
							<input id="txtOdatea.*" type="hidden"/>
						</td>
						<td class="M1"><input id="textA06.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textA07.*" type="text" class="txt c1"/></td>
						<td class="M1 M2">
							<input id="textA08.*" type="text" class="txt num c1"/>
							<input id="txtWidth.*" type="hidden"/>
						</td>
						<td class="M1 M2">
							<input id="textA09.*" type="text" class="txt num c1"/>
							<input id="txtLengthb.*" type="hidden"/>
						</td>
						<td class="M1 M2"><input id="textA10.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textA11.*" type="text" class="txt c1"/></td>
						<!---->
						<td class="M1"><input id="textB01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textB02.*" type="text" class="txt num c1"/></td>
						<!--Booking或指定-->
						<td class="M1"><input id="textC01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textC02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textC03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textC04.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="btnC05.*" type="button" class="btndivstk" value="."/></td>
						<td class="M1"><input id="btnC06.*" type="button" value="."/></td>
						<td class="M1"><input id="textC07.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="chkIsprearranged.*" type="checkbox"/></td>
						<!--中繼產品"指定"前預估生產量-->
						<td class="M1"><input id="textD01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textD02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textD03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textD04.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2">
							<input id="textD05.*" type="text" class="txt num c1"/>
							<input id="txtMount.*" type="hidden"/>
						</td>
						<!---->
						<td class="M1 M2"><input id="textE01.*" type="text" class="txt num c1"/></td>
						<!--中繼產品-->
						<td class="M1">
							<input id="textF01.*" type="text" class="txt c1"/>
							<input id="txtUcano.*" type="hidden"/>
						</td>
						<td class="M1"><input id="textF02.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textF03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="btnF04.*" type="button" class="btndivstk" value="."/></td>
						<!--再製品-->
						<td class="M1">
							<input id="textG01.*" type="text" class="txt c1"/>
							<input id="txtUcc3no.*" type="hidden"/>
						</td>
						<td class="M1"><input id="textG02.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textG03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="btnG04.*" type="button" class="btndivstk" value="."/></td>
						<!--指定後產出量-->
						<td class="M1"><input id="textH01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textH02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textH03.*" type="text" class="txt num c1"/></td>
						<!---->
						<td class="M1"><input id="textI01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI03.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI04.*" type="text" class="txt c1"/></td>
						<td class="M1">
							<input id="textI05.*" type="text" class="txt c1"/>
							<input id="txtUcc4no.*" type="hidden"/>
						</td>
						<td class="M1"><input id="textI06.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI07.*" type="text" class="txt c1"/></td>
						<td class="M1">
							<input id="textI08.*" type="text" class="txt c1"/>
							<input id="txtUcc5no.*" type="hidden"/>
						</td>
						<td class="M1"><input id="textI09.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI10.*" type="text" class="txt c1"/></td>
						<td class="M1">
							<input id="textI11.*" type="text" class="txt c1"/>
							<input id="txtUcc6no.*" type="hidden"/>
						</td>
						<td class="M1"><input id="textI12.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI13.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI14.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textI15.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textI16.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textI17.*" type="text" class="txt c1"/></td>
						<td style="display: none;" ><input id="textI18.*" type="text" class="txt c1"/></td><!-- class="M1"-->
						<td class="M1"><input id="textI19.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI20.*" type="text" class="txt num c1"/></td>
						
						<!--加工B-->
						<td class="M2"><input id="textJ01.*" type="text" class="txt c1"/></td>
						<td class="M2">
							<input id="textJ02.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combJ02.*" style="width: 20px;"> </select>
						</td>
						<td class="M2"><input id="textJ03.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ04.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ05.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ06.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ07.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ08.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ09.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ10.*" type="text" class="txt c1"/></td>
						<td class="M2">
							<input id="textJ11.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combJ11.*" style="width: 20px;"> </select>
						</td>
						<td class="M2"><input id="textJ12.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ13.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ14.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ15.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ16.*" type="text" class="txt num c1"/></td>
						<td class="M2">
							<input id="textJ17.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combJ17.*" style="width: 20px;"> </select>
						</td>
						<td class="M2"><input id="textJ18.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ19.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ20.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ21.*" type="text" class="txt c1"/></td>
						
						<!--製造-->
						<td class="M3"><input id="textK01.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK03.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK04.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK05.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK06.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK07.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK08.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK09.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK10.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK11.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK12.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK13.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK14.*" type="text" class="txt c1"/></td>
						
						<!--決定"上膠日"-->
						<td class="M3"><input id="textL01.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL02.*" type="text" class="txt c1"/></td>
						<td class="M3">
							<input id="textL03.*" type="text" class="txt c1" style="width: 85px;"/>
							<input id="textL04.*" type="text" class="txt c1" style="width: 25px;"/>
						</td>
						<td class="M3">
							<input id="textL05.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combL05.*" style="width: 20px;"> </select>
						</td>
						<td class="M3"><input id="textL06.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL07.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL08.*" type="text" class="txt num c1"/></td>
						<!--排程量-->
						<td class="M3"><input id="textM01.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textM02.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textM03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textM04.*" type="text" class="txt num c1"/></td>
						<!--製造產出回報-->
						<td class="M3"><input id="textN01.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textN02.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textN03.*" type="text" class="txt c1"/></td>
						<!---->
						<td class="M3"><input id="btnO01.*" type="button" value="."/></td>
						<td class="M3"><input id="textO02.*" type="text" class="txt c1"/></td>
						<!--上紙段(投入)-->
						<td class="M3">
							<input id="textP01.*" type="text" class="txt c1"/>
							<input id="txtUcc2no.*" type="hidden"/>
						</td>
						<td class="M3"><input id="textP02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textP03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textP04.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textP05.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="btnP06.*" type="button" class="btndivstk" value="+"/></td>
						<!--上皮段(投入)-->
						<td class="M3">
							<input id="textQ01.*" type="text" class="txt c1"/>
							<input id="txtUcc1no.*" type="hidden"/>
						</td>
						<td class="M3"><input id="textQ02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textQ03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textQ04.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textQ05.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="btnQ06.*" type="button" class="btndivstk" value="+"/></td>
						
						<!---->
						<td class="M3"><input id="textR01.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR02.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR04.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR05.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR06.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR07.*" type="text" class="txt num c1"/></td>
						<!---->
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="display: none;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:300px; text-align: center;"><a id='lblOrdeno_uj_t'>亂數項次</a></td>
					<td style="width:40px; text-align: center;"><a id='lblNo2_uj_t'>類別指定</a></td>
					<td style="width:120px; text-align: center;"><a id='lblUno_uj_t'>批號</a></td>
					<td style="width:120px; text-align: center;"><a id='lblProductno_uj_t'>品名</a></td>
					<td style="width:95px; text-align: center;"><a id='lblSpec_uj_t'>列管品</a></td>
					<td style="width:100px; text-align: center;"><a id='lblMount_uj_t'>指定數量</a></td>
					<td style="width:100px; text-align: center;"><a id='lblWeight_uj_t'>指定長度</a></td>
					<td style="width:130px; text-align: center;"><a id='lblMemo_uj_t'>進貨日期/單位</a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtOrdeno..*" type="text" class="txt c1"/></td>
					<td><input id="txtNo2..*" type="text" class="txt c1"/></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec..*" type="text" class="txt c1"/></td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>