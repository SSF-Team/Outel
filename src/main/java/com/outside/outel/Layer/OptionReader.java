package com.outside.outel.Layer;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author Stapx Steve
 * @Description TODO 读取配置文件
 * @Date 下午 04:52 2020/12/25
**/


public class OptionReader {

    public static class OptVer {
        public String name;
        public String value;

        public OptVer(String name, String value) {
            this.name = name;
            this.value = value;
        }
    }

    public static List<OptVer> optList = new ArrayList<>();

    private static final File optFile = new File("Options.ini");

    public String GetOpt(String name) {
        for(OptVer opt: optList) {
            if(opt.name.equals(name)) {
                return opt.value;
            }
        }
        return "err";
    }

    public void ReadOpt() throws IOException {
        // 检查配置文件是否存在
        if (!optFile.exists()) {
            // 如果不存在尝试新建（会创建到 Tomcat 的 bin 目录里去）
            try {
                System.out.println("设置文件不存在，已经在 " + System.getProperty("user.dir") + " 创建。");
                System.out.println("请按要求编辑设置文件并重新启动容器。");
                optFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        // 开始读取
        FileInputStream inputStream = new FileInputStream(optFile);
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));

        String str = null;
        while((str = bufferedReader.readLine()) != null)
        {
            optList.add(new OptVer(str.split(":")[0], str.split(":")[1]));
            System.out.println("\t" + str.split(":")[0] + " --> " + str.split(":")[1]);
        }

        inputStream.close();
        bufferedReader.close();
    }

}
