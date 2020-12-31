package com.outside.outel.Util;

import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2020/12/28 上午 09:12
 * @ClassName: Errs
 * @Author: Stapx Steve
 * @Description TODO 错误信息
 **/
public class Errs {

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
    public Errs() {
        errList.add(new errVer("500", "服务器错误", "服务器遇到了一些问题，不要担心！我们将会引导你。"));
        errList.add(new errVer("403", "拒绝访问", "很抱歉你不能这么干，离开这里吧。"));
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
