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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "cug";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtHours','txtSmount','txtKdate'];
            var q_readonlys = ['txtOrdeno','textF01','txtProductno','txtThours','txtDhours','textF02','txtMount'
            				,'textF03','textF04','textF05','textF06','textF07','textF08','textF09','textF10'
            				,'textF11','textF12','textF13','textF14'];
            var bbmNum = [['txtSmount', 15, 0, 1],['txtHours', 10, 2, 1]];
            var bbsNum = [['txtMount', 10, 0, 1],['txtHours', 10, 2, 1],['txtThours', 10, 0, 1],['txtDhours', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';            
            
            aPop = new Array(
            	
            );
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
			
            function mainPost() {
            	if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                bbmMask = [['txtDatea', r_picd],['txtKdate', r_picd]];
                bbsMask = [];
                q_getFormat();
                q_mask(bbmMask);
                
                q_cmbParse("cmbBdate", '加工,製造');	
                
                $('#cmbBdate').change(function() {
                	$('#combProcessno').text('');
                	if($(this).val()=='加工'){
                		q_cmbParse("combProcessno", '分1,分2,分3,分4,覆1,覆2,覆3,其他');	
                	}else{
                		q_cmbParse("combProcessno", 'A,B');	
                	}
                	$('#txtProcessno').val('');
                	change_field();
				});
				
				$('#combProcessno').change(function() {
					$('#txtProcessno').val($(this).val());
				});
				
				$('#btnWorkg_uj').click(function() {
					if(q_cur==1 || q_cur==2){
						
					}
				});
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
			
            function q_gtPost(t_name) {
                switch (t_name) {
                	
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
			
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtProcessno', '機台'],['txtDatea', '日期']]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                sum();
                
                for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr='';
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							tstr+="@,#"+$('#'+fbbs[j]+'_'+i).val();
						}
					}
					$('#txtMemo_'+i).val(tstr);
				}
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
								
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtKdate').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cug') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
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

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cug_uj_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtKdate').val(q_date());
                $('#cmbBdate').change();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#cmbBdate').change();
            }

            function btnPrint() {
                q_box('z_cugp_uj.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }
			
            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
		                $('#txtNos_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                	//if(q_cur==1 || q_cur==2){}
						});
						
					}
                }
                _bbsAssign();
                splitbbsf();
            }

            function bbsSave(as) {
                if (!as['productno']) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }
				
				as['processno'] = abbm2['processno'];
                q_nowf();

                return true;
            }

            function sum() {
                var t1 = 0,t2=0;
                for (var j = 0; j < q_bbsCount; j++) {
					t1=q_add(t1,q_float('txtHours_'+j));
					t2=q_add(t2,q_float('txtMount_'+j));
                } // j
                $('#txtHours').val(t1);
                $('#txtSmount').val(t2);
            }

            function refresh(recno) {
                _refresh(recno);
                change_field();
            }
            
            function change_field () {
				if($('#cmbBdate').val()=='製造'){
					$('.M1').hide();
					$('.M2').show();
					$('.dbbs').css('width','1750px');
				}else{
					$('.M2').hide();
					$('.M1').show();
					$('.dbbs').css('width','1650px');
				}
			}

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(t_para){
                	
	            }else{
	            	
	            }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
            
		   function q_funcPost(t_func, result) {
                switch(t_func) {
                	
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
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
                width: 1260px;
            }
            .dview {
                float: left;
                width: 30%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 685px;
                margin: -1px;
                border: 1px black solid;
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
                /*width: 9%;*/
            }
            .tbbm .tdZ {
                width: 2%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 48%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 100%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select {
                font-size: medium;
            }
            .dbbs {
                width: 1700px;
                background:#cad3ff;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs tr.chkIssel { background:bisque;} 
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewDatea_uj'>日期</a></td>
						<td align="center" style="width:30%"><a id='vewBdate_uj'>類別</a></td>
						<td align="center" style="width:30%"><a id='vewProcessno_uj'>機台</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='bdate'>~bdate</td>
						<td align="center" id='processno'>~processno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td style="width: 105px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td style="width: 175px;"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td style="width: 105px;"><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td style="width: 175px;"><input id="txtKdate" type="text" class="txt c1"/></td>
						<td style="width: 105px;"> </td>
						<td style="width: 20px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea_uj' class="lbl">日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate_uj' class="lbl">類別</a></td>
						<td><select id="cmbBdate" class="txt c1"> </select></td>
						<td><span> </span><a id='lblProcessno_uj' class="lbl">機台</a></td>
						<td>
							<input id="txtProcessno" type="text" class="txt c1" style="width: 50%;"/>
							<select id="combProcessno" style="widows: 20px;"> </select>
						</td>
						<td><input id="btnWorkg_uj" type="button" value="排程匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSmount_uj' class="lbl">總產出</a></td>
						<td><input id="txtSmount" type="text" class="txt num c1"/></td>
						<td ><span> </span><a id='lblHours_uj' class="lbl">總工時</a></td>
						<td><input id="txtHours" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c5"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<!--匯入做排序不提供刪除和新增-->
					<td align="center" style="width:85px;display: none;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:75px;"><a id='lblNos_uj_s'>排序</a></td>
					<td align="center" style="width:150px;" class="M1"><a id='lblOrdeno_uj_s'>訂單名稱</a></td>
					<td align="center" style="width:200px;" class="M1"><a id='lblF01_s'>料號(原成品名)</a></td>
					<td align="center" style="width:200px;">
						<a id='lblProductno1_uj_s' class="M1">新成品編碼</a>
						<a id='lblProductno2_uj_s' class="M2">生產料號</a>
					</td>
					<td align="center" style="width:100px;">
						<a id='lblThours1_uj_s' class="M1">寬(mm)</a>
						<a id='lblThours2_uj_s' class="M2">有效寬(mm)</a>
					</td>
					<td align="center" style="width:100px;" class="M1"><a id='lblDhours_uj_s'>長(M)</a></td>
					<td align="center" style="width:100px;" class="M1"><a id='lblF02_s'>長度備註</a></td>
					<td align="center" style="width:100px;">
						<a id='lblMount1_uj_s' class="M1">數量</a>
						<a id='lblMount2_uj_s' class="M2">產出(M)</a>
					</td>
					
					<td align="center" style="width:100px;" class="M1"><a id='lblF03_uj_s'>成品指令</a></td>
					<td align="center" style="width:100px;" class="M1"><a id='lblF04_uj_s'>限定餘數</a></td>
					<td align="center" style="width:100px;" class="M1"><a id='lblF05_uj_s'>需求級別</a></td>
					
					<td align="center" style="width:175px;" class="M2"><a id='lblF06_uj_s'>上皮投入</a></td>
					<td align="center" style="width:100px;" class="M2"><a id='lblF07_uj_s'>指定(M)</a></td>
					<td align="center" style="width:100px;" class="M2"><a id='lblF08_uj_s'>上膠面</a></td>
					<td align="center" style="width:175px;" class="M2"><a id='lblF09_uj_s'>上紙投入</a></td>
					<td align="center" style="width:100px;" class="M2"><a id='lblF10_uj_s'>指定(M)</a></td>
					<td align="center" style="width:130px;" class="M2"><a id='lblF11_uj_s'>下料指令</a></td>
					<td align="center" style="width:130px;" class="M2"><a id='lblF12_uj_s'>列管備註</a></td>
					<td align="center" style="width:130px;" class="M2"><a id='lblF13_uj_s'>注意事項</a></td>
					
					<td align="center" style="width:200px;"><a id='lblF14_uj_s'>備註</a></td>
				</tr>
				<tr id="trSel.*">
					<td align="center" style="display: none;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold; display: none;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtNos.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
						<input id="txtMemo.*" type="hidden" class="txt c1"/>
						<input id="txtWorkgno.*" type="hidden" class="txt c1"/>
						<input id="txtHours.*" type="hidden" class="txt c1"/>
					</td>
					<td class="M1"><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
					<td class="M1"><input id="textF01.*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td><input id="txtThours.*" type="text" class="txt num c1"/></td>
					<td class="M1"><input id="txtDhours.*" type="text" class="txt num c1"/></td>
					<td class="M1"><input id="textF02.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td class="M1"><input id="textF03.*" type="text" class="txt c1"/></td>
					<td class="M1"><input id="textF04.*" type="text" class="txt c1"/></td>
					<td class="M1"><input id="textF05.*" type="text" class="txt c1"/></td>
					<td class="M2"><input id="textF06.*" type="text" class="txt c1"/></td>
					<td class="M2"><input id="textF07.*" type="text" class="txt num c1"/></td>
					<td class="M2"><input id="textF08.*" type="text" class="txt c1"/></td>
					<td class="M2"><input id="textF09.*" type="text" class="txt c1"/></td>
					<td class="M2"><input id="textF10.*" type="text" class="txt num c1"/></td>
					<td class="M2"><input id="textF11.*" type="text" class="txt c1"/></td>
					<td class="M2"><input id="textF12.*" type="text" class="txt c1"/></td>
					<td class="M2"><input id="textF13.*" type="text" class="txt c1"/></td>
					<td><input id="textF14.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
