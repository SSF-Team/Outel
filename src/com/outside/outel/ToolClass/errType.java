package com.outside.outel.ToolClass;


import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2020/12/25 下午 02:18
 * @ClassName: errType
 * @Author: Stapxs
 * @Description TO DO
 **/
public class errType {

    // err 结构
    class errVer {
        public String code;
        public String msg;
        public String allmsg;

        public errVer(String code, String msg, String all) {
            this.code = code;
            this.msg = msg;
            this.allmsg = all;
        }
    }

    private List<errVer> errList = new ArrayList<>();

    // 构造函数
    public errType() {
        errList.add(new errVer("500", "服务器错误", "服务器遇到了一些问题，不要担心！我们将会引导你。"));
    }

    // 获取错误信息
    public String[] getErr(String code) {
        for (errVer err: errList) {
            if(err.code.equals(code))
                return new String[]{err.msg, err.allmsg};
        }
        return new String[]{"err", "err"};
    }
}
