<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
            var q_name = 'cugt', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = [], bbsKey = ['noa,noq'], as, brwCount2 = 10;
            var t_sqlname = 'cugt_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = ['textF01','textF02','textF03','textF04','textF05','textF06','textF07'
            ,'textF08','textF09','textF10','textF11','textF12','textF13','textF14','textF15','textF16'
            ,'textF17','textF18','textF19','textF20','textF21','textF22','textF23','textF24','textF25'
            ,'textF26','textF27','textF28','textF29','textF30','textF31','textF32','textF33','textF35'
            ,'textF36','textF37','textF38','textF39','textF40'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

            aPop = new Array();

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='0015'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                q_mask(bbmMask);
                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch

            }
            var tmpdate='';
            function bbsAssign() {
            	var t_stationno=q_getHref()[3];
            	var t_noa=q_getHref()[1];
            	for(var i = 0; i < q_bbsCount; i++) {
            		$('#txtDatea_' + i).focusin(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
				    });
            		
				    $('#txtMemo_' + i).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
				    });
            	}
                _bbsAssign();
                if(t_stationno=='2'){
                	$('.S3').hide();
                	$('.S4').hide();
                	$('.S5').hide();
                	$('.S6').hide();
                	$('.S2').show();
                	$('#btnModi').hide();
                }
                if(t_stationno=='3'){
                	$('.S2').hide();
                	$('.S4').hide();
                	$('.S5').hide();
                	$('.S6').hide();
                	$('.S3').show();
                	$('#btnModi').hide();
                }
                if(t_stationno=='4'){
                	$('.S2').hide();
                	$('.S3').hide();
                	$('.S5').hide();
                	$('.S6').hide();
                	$('.S4').show();
                }
                if(t_stationno=='5'){
                	$('.S2').hide();
                	$('.S3').hide();
                	$('.S4').hide();
                	$('.S6').hide();
                	$('.S5').show();
                }
                if(t_stationno=='6'){
                	$('.S2').hide();
                	$('.S3').hide();
                	$('.S4').hide();
                	$('.S5').hide();
                	$('.S6').show();
                	$('#btnModi').hide();
                }
                splitbbsf();
            }

            function btnOk() {
            	if(q_getHref()[0] == 'noa' && q_getHref()[1] != '' ){
	            	for(var i = 0 ;i < q_bbsCount;i++){
	            		//合併儲存
						var tstr='';
						for (var j = 0; j < fbbs.length; j++) {
							if(fbbs[j].substr(0,4)=='text'){
								tstr+="@,#"+$('#'+fbbs[j]+'_'+i).val();
							}
						}
						
						$('#txtMemo_'+i).val(tstr);
	            	}
            	}else{
            		alert("read error!");
            		return;
            	}
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                
            }

            function bbsSave(as) {
                if(!as['memo']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
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
                if(q_tables == 's')
                    bbsAssign();
            }
            
            function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtMemo_'+i).val().split('@,#');
					var tstc=1;
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							$('#'+fbbs[j]+'_'+i).val(tstr[tstc]);
							tstc++;
						}
					}
				}
			}

		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="display: none;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:5%;"><a id='lblF01_uj'>排序</a></td>
					<!--半成品,再製品--->
					<td align="center" style="width:170px;display: none;" class="S2 S3"><a id='lblF02_uj'>指令名稱</a></td>
					<td align="center" style="width:150px;display: none;" class="S2 S3"><a id='lblF03_uj'>身分證號<BR>(生產日期)</a></td>
					<td align="center" style="width:200px;display: none;" class="S2 S3"><a id='lblF04_uj'>中繼產品料號</a></td>
					<td align="center" style="width:50px;display: none;" class="S2 S3"><a id='lblF05_uj'>數量</a></td>
					<td align="center" style="width:100px;display: none;" class="S2 S3"><a id='lblF06_uj'>長(M)</a></td>
					<td align="center" style="width:100px;display: none;" class="S2 S3"><a id='lblF07_uj'>總量</a></td>
					<td align="center" style="width:120px;display: none;" class="S2 S3"><a id='lblF08_uj'>總長(M)</a></td>
					<td align="center" style="width:120px;display: none;" class="S2 S3"><a id='lblF09_uj'>需求級別</a></td>
					<td align="center" style="width:200px;display: none;" class="S2 S3"><a id='lblF10_uj'>備註</a></td>
					<td align="center" style="width:150px;display: none;" class="S2 S3"><a id='lblF11_uj'>列管備註</a></td>
					<!---物料-------->
					<td align="center" style="width:170px;display: none;" class="S6"><a id='lblF12_uj'>指令名稱</a></td>
					<td align="center" style="width:170px;display: none;" class="S6"><a id='lblF13_uj'>料號(原成品名)</a></td>
					<td align="center" style="width:170px;display: none;" class="S6"><a id='lblF14_uj'>新成品編碼</a></td>
					<td align="center" style="width:80px;display: none;" class="S6"><a id='lblF15_uj'>數量</a></td>
					<td align="center" style="width:50px;display: none;" class="S6"><a id='lblF16_uj'>餘數</a></td>
					<td align="center" style="width:150px;display: none;" class="S6"><a id='lblF17_uj'>紙管</a></td>
					<td align="center" style="width:100px;display: none;" class="S6"><a id='lblF18_uj'>備料量</a></td>
					<td align="center" style="width:150px;display: none;" class="S6"><a id='lblF19_uj'>紙箱</a></td>
					<td align="center" style="width:100px;display: none;" class="S6"><a id='lblF20_uj'>備料量</a></td>
					<td align="center" style="width:150px;display: none;" class="S6"><a id='lblF21_uj'>塞頭</a></td>
					<td align="center" style="width:100px;display: none;" class="S6"><a id='lblF22_uj'>備料量</a></td>
					<td align="center" style="width:150px;display: none;" class="S6"><a id='lblF23_uj'>備註</a></td>
					<!--------------->
					<td align="center" style="width:5%;display: none;" class="S4 S5"><a id='lblWorker_uj'>生產<BR>順位</a></td>
					<!---上皮-------->
					<td align="center" style="width:150px;display: none;" class="S5"><a id='lblF24_uj'>皮料號</a></td>
					<td align="center" style="width:100px;display: none;" class="S5"><a id='lblF25_uj'>上紙製程段</a></td>
					<td align="center" style="width:100px;display: none;" class="S5"><a id='lblF26_uj'>儲位</a></td>
					<td align="center" style="width:80px;display: none;" class="S5"><a id='lblF27_uj'>支數</a></td>
					<td align="center" style="width:80px;display: none;" class="S5"><a id='lblF28_uj'>長(M)</a></td>
					<td align="center" style="width:100px;display: none;" class="S5"><a id='lblF29_uj'>小計(M)</a></td>
					<td align="center" style="width:100px;display: none;" class="S5"><a id='lblF30_uj'>總支數</a></td>
					<td align="center" style="width:120px;display: none;" class="S5"><a id='lblF31_uj'>總長(M)</a></td>
					<td align="center" style="width:150px;;display: none;" class="S5"><a id='lblF32_uj'>批號</a></td>
					<td align="center" style="width:170px;;display: none;" class="S5"><a id='lblF34_uj'>備註</a></td>
					<!---上紙-------->
					<td align="center" style="width:180px;display: none;" class="S4"><a id='lblF35_uj'>下紙段(投入)</a></td>
					<td align="center" style="width:100px;display: none;" class="S4"><a id='lblF36_uj'>代碼</a></td>
					<td align="center" style="width:100px;display: none;" class="S4"><a id='lblF37_uj'>長(M)</a></td>
					<td align="center" style="width:100px;display: none;" class="S4"><a id='lblF38_uj'>總顆數</a></td>
					<td align="center" style="width:100px;display: none;" class="S4"><a id='lblF39_uj'>總長(M)</a></td>
					<td align="center" style="width:150px;display: none;" class="S4"><a id='lblF40_uj'>身分證號碼</a></td>
					<td align="center" style="width:200px;display: none;" class="S4"><a id='lblF42_uj'>備註</a></td>
					<!--對應workg-->
					<td style="display: none;"><a id='lblF43_uj'>排程單號</a></td>
					<td style="display: none;"><a id='lblF44_uj'>項次</a></td>
					<!--對應workgt-->
					<td style="display: none;"><a id='lblF45_uj'>指定項次</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" style="display: none;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
	                    <input id="txtNoq.*" type="hidden" />
	                    <input id="txtStationno.*" type="hidden" /><!--放備料單類別-->
	                    <input id="txtMemo.*" type="hidden" /><!--內容-->
					</td>
					<td><input id="textF01.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!--半成品,再製品--->
					<td class="S2 S3" style="display: none;"><input id="textF02.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF03.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF04.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF05.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF06.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF07.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF08.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF09.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF10.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S2 S3" style="display: none;"><input id="textF11.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!---物料-------->
					<td class="S6" style="display: none;"><input id="textF12.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF13.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF14.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF15.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S6" style="display: none;"><input id="textF16.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF17.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF18.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S6" style="display: none;"><input id="textF19.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF20.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S6" style="display: none;"><input id="textF21.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S6" style="display: none;"><input id="textF22.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S6" style="display: none;"><input id="textF23.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!--------------->
					<td class="S4 S5" style="display: none;"><input id="txtWorker.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!---上皮-------->
					<td class="S5" style="display: none;"><input id="textF24.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S5" style="display: none;"><input id="textF25.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S5" style="display: none;"><input id="textF26.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S5" style="display: none;"><input id="textF27.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S5" style="display: none;"><input id="textF28.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S5" style="display: none;"><input id="textF29.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S5" style="display: none;"><input id="textF30.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S5" style="display: none;"><input id="textF31.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S5" style="display: none;"><input id="textF32.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td style="display: none;"><input id="textF33.*" type="text" class="txt c1" style="width:95%;"/></td><!--列管品-->
					<td class="S5" style="display: none;"><input id="textF34.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!---上紙-------->
					<td class="S4" style="display: none;"><input id="textF35.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S4" style="display: none;"><input id="textF36.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="S4" style="display: none;"><input id="textF37.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S4" style="display: none;"><input id="textF38.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S4" style="display: none;"><input id="textF39.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="S4" style="display: none;"><input id="textF40.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td style="display: none;"><input id="textF41.*" type="text" class="txt c1" style="width:95%;"/></td><!--列管品-->
					<td class="S4" style="display: none;"><input id="textF42.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!--對應workgs-->
					<td style="display: none;"><input id="textF43.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td style="display: none;"><input id="textF44.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!--對應workgt-->
					<td style="display: none;"><input id="textF45.*" type="text" class="txt c1" style="width:95%;"/></td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
