/**
 * ファイル名：WorkRecordInputRegisterAction.java
 *
 * 変更履歴
 * 1.0  2010/11/02 Kazuya.Naraki
 */
package action.act;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import business.dto.LoginUserDto;
import business.dto.act.WorkRecordDto;
import business.logic.act.WorkRecordLogic;
import business.logic.utils.CheckUtils;
import business.logic.utils.ComboListUtilLogic;
import business.logic.utils.CommonUtils;
import constant.CommonConstant;
import constant.RequestSessionNameConstant;
import form.act.WorkRecordInputBean;
import form.act.WorkRecordInputForm;
import form.common.DateBean;

/**
 * 説明：勤務実績入力確認登録処理
 * @author naraki
 *
 */
public class WorkRecordInputRegisterAction extends Action {

    // ログ出力クラス
    private Log log = LogFactory.getLog(this.getClass());

    /**
     * 勤務実績入力確認登録処理のアクション
     *
     * @param mapping アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @return アクションフォワード
     * @author naraki
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest req, HttpServletResponse res) throws Exception {
        log.info(new Throwable().getStackTrace()[0].getMethodName());

        // セッション
        HttpSession session = req.getSession();

        // フォワードキー
        String forward = "";

        // ログインユーザ情報をセッションより取得
        LoginUserDto loginUserDto = (LoginUserDto) session.getAttribute(RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO);

        // 社員ID
        String employeeId = loginUserDto.getEmployeeId();

        // フォーム
        WorkRecordInputForm workRecordForm = (WorkRecordInputForm) form;

        // 対象年月
        String yearMonth = workRecordForm.getYearMonth();

        // 対象年月の月情報を取得する。
        List<DateBean> dateBeanList = CommonUtils.getDateBeanList(yearMonth);

        // 勤務実績ロジック
        WorkRecordLogic workRecordLogic = new WorkRecordLogic();

        // フォームデータをDtoに変換する
        List<WorkRecordDto> workRecordDtoList = this.formToDto(workRecordForm);

        // 時間計算を行う
        workRecordLogic.calculation(workRecordDtoList);

        // 勤務実績データの更新・登録を行う
        workRecordLogic.registerWorkRecord(workRecordDtoList, loginUserDto);

        // 勤務実績データの取得
        Map<String, WorkRecordDto> workRecordMap = workRecordLogic.getWorkRecordShiftData(employeeId, yearMonth);

        // セレクトボックスの取得
        ComboListUtilLogic comboListUtils = new ComboListUtilLogic();
        
        Map<String, String> yearMonthCmbMap = comboListUtils.getComboYearMonth(CommonUtils.getFisicalDay(CommonConstant.YEARMONTH_NOSL), 22, ComboListUtilLogic.KBN_YEARMONTH_PRE, false);

        // データを変換する
        List<WorkRecordInputBean> workRecordList = this.dtoToBean(dateBeanList, workRecordMap, loginUserDto);
        
        if (workRecordList == null || workRecordList.isEmpty()) {
            workRecordForm.setTotalActualWorkTime("00:00");
        } else {
            // 勤務実績の合計時間を計算
            String totalActualWorkTime = workRecordLogic.calculateTotalActualWorkTime(workRecordList);
            workRecordForm.setTotalActualWorkTime(totalActualWorkTime);
        }
        
        // フォームにデータをセットする
        workRecordForm.setDateBeanList(dateBeanList);
        workRecordForm.setWorkRecordInputList(workRecordList);
        workRecordForm.setYearMonthCmbMap(yearMonthCmbMap);

        forward = CommonConstant.SUCCESS;

        return mapping.findForward(forward);
    }


    /**
     * dtoデータをBeanのリストへ変換する
     * @param workRecordMap 勤務実績マップ key 稼働日, val 勤務実績Dto
     * @return
     * @author naraki
     * @throws ParseException
     */
    private List<WorkRecordInputBean> dtoToBean(
            List<DateBean> dateBeanList,
            Map<String, WorkRecordDto> workRecordMap,
            LoginUserDto loginUserDto) throws ParseException {

        // 戻り値
        List<WorkRecordInputBean> returnList = new  ArrayList<WorkRecordInputBean>();

        for (DateBean dateBean : dateBeanList) {

            // 勤務実績Bean
            WorkRecordInputBean workRecordInputBean = new WorkRecordInputBean();

            // 年月日
            String yearMonthDay = dateBean.getYearMonthDay();

            // 表示用の月日
            String monthDay = CommonUtils.changeFormat(
                    yearMonthDay,
                    CommonConstant.YEARMONTHDAY_NOSL,
                    CommonConstant.YEARMONTHDAY).substring(5, 10);

            // 月日をセットする
            workRecordInputBean.setWorkDay(yearMonthDay);
            workRecordInputBean.setWorkDayDisp(monthDay);
            // 曜日をセットする
            workRecordInputBean.setWeekDay(dateBean.getWeekDay());
            // 祝日フラグをセットする
            workRecordInputBean.setPublicHolidayFlg(dateBean.getPublicHolidayFlg());
            // 社員IDをセットする
            workRecordInputBean.setEmployeeId(loginUserDto.getEmployeeId());

            // Dtoを取得する
            WorkRecordDto workRecordDto = workRecordMap.get(yearMonthDay);

            if (CheckUtils.isEmpty(workRecordDto)) {

                // データが存在しなかった場合
                returnList.add(workRecordInputBean);
                // 次へ
                continue;
            }

            workRecordInputBean.setShiftId(workRecordDto.getShiftId());
            workRecordInputBean.setSymbol(workRecordDto.getSymbol());
            workRecordInputBean.setStartTimeShift(workRecordDto.getStartTimeShift());
            workRecordInputBean.setEndTimeShift(workRecordDto.getEndTimeShift());
            workRecordInputBean.setBreakTimeShift(workRecordDto.getBreakTimeShift());
            workRecordInputBean.setStartTime(workRecordDto.getStartTime());
            workRecordInputBean.setEndTime(workRecordDto.getEndTime());
            workRecordInputBean.setBreakTime(workRecordDto.getBreakTime());
            workRecordInputBean.setActualWorkTime(workRecordDto.getActualWorkTime());
            workRecordInputBean.setOverTime(workRecordDto.getOverTime());
            workRecordInputBean.setHolidayTime(workRecordDto.getHolidayTime());
            workRecordInputBean.setRemark(workRecordDto.getRemark());

            returnList.add(workRecordInputBean);
        }

        return returnList;
    }
    /**
     * formデータをDtoに変化する
     * @param
     * @return
     * @author naraki
     */
    private List<WorkRecordDto> formToDto(WorkRecordInputForm workRecordForm) {

        // 戻り値のリスト
        List<WorkRecordDto> dtoList = new ArrayList<WorkRecordDto>();
        // 画面の一覧
        List<WorkRecordInputBean> workRecordList = workRecordForm.getWorkRecordInputList();

        for (WorkRecordInputBean bean : workRecordList) {
            WorkRecordDto workRecordDto = new WorkRecordDto();

            // 計算以外の部分をセットする
            workRecordDto.setEmployeeId(bean.getEmployeeId());         // 社員ID
            workRecordDto.setWorkDay(bean.getWorkDay());               // 稼働日
            workRecordDto.setShiftId(bean.getShiftId());               // シフトID
            workRecordDto.setSymbol(bean.getSymbol());                 // シンボル
            workRecordDto.setStartTimeShift(bean.getStartTimeShift()); // 開始時間(シフト)
            workRecordDto.setEndTimeShift(bean.getEndTimeShift());     // 終了時間(シフト)
            workRecordDto.setBreakTimeShift(bean.getBreakTimeShift()); // 休憩時間(シフト)
            workRecordDto.setStartTime(bean.getStartTime());           // 開始時間
            workRecordDto.setEndTime(bean.getEndTime());               // 終了時間
            workRecordDto.setBreakTime(bean.getBreakTime());           // 休憩時間
            workRecordDto.setRemark(bean.getRemark());                 // 備考

            dtoList.add(workRecordDto);

        }

        return dtoList;

    }
}
