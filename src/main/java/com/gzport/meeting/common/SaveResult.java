package com.gzport.meeting.common;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/29.
 */
public class SaveResult {
    private boolean success;//true时视为保存成功
    private String messageCode;//与message一一对应，为便于识别
    private String message;//null时认为识别
    public static final String SUCCESS = "success";
    public static final String FAILE = "fail";
    public static final String WAIT_CHANGE = "fail";

    private SaveResult() {
        this.success = true;
        this.messageCode = SUCCESS;
        this.message = null;
    }


    private SaveResult(boolean success, String messageCode, String message) {
        this.success = success;
        this.messageCode = messageCode;
        this.message = message;
    }

    private static final SaveResult OBJ_SUCCESS = new SaveResult();
    private static final SaveResult OBJ_DATACHANGE_FILE = new SaveResult(false, FAILE, "修改失败");
    private static final SaveResult OBJ_WAIT_CHANGE = new SaveResult(false, WAIT_CHANGE, "超过修改时间，请等待结果");
    private static final Map<String, SaveResult> msg = new HashMap<>();

    public static final SaveResult getInstance(String messageCode) {
        return msg.get(messageCode);
    }

    static {
        msg.put(SUCCESS, OBJ_SUCCESS);
        msg.put(FAILE, OBJ_DATACHANGE_FILE);
        msg.put(WAIT_CHANGE, OBJ_WAIT_CHANGE);
    }
}
