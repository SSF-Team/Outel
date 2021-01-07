package com.outside.outel.Service;

/**
 * @Version: 1.0
 * @Date: 2021/1/7 下午 08:07
 * @ClassName: PrintOut
 * @Author: Stapx Steve
 * @Description TODO 获取 Out 的 HTML 文本
 **/
public class PrintHTML {

    public static String SmallOut(String name, String at, String time, String things, String pic, String huDong, String head, String back, String id, String userid, String artid, boolean isAccept, boolean isZhuan, boolean isLike, boolean isHome) {
        String[] huDongs = huDong.split(",");

        String out = "";
        out +=  "<div class=\"newspull\">\n" +
                "        <div style=\"width: 569px; padding-top: 10px\"></div>\n";
        out +=  "        <div class=\"personalPhoto\"><img src=\"" + head + "\" height=\"49\"></div>\n";
        out +=  "        <div class=\"rightContent\">\n" +
                "            <div class=\"mainInfo\">\n";
        // ---------------------------------------------------
        if(isHome)
        out +=  "                <a href=\"personalInfo.jsp?id=" + id + "&userid=" + userid + "\">"+ name + "</a>\n";
        else
        out +=  "                <a target=_parent href=\"personalInfo.jsp?id=" + id + "&userid=" + userid + "\">"+ name + "</a>\n";
        // ---------------------------------------------------
        if(isAccept)
        out +=  "                <img src=\"../svg/official.svg\">\n";
        else
        out +=  "                <img>\n";
        // ---------------------------------------------------
        out +=  "                <a href=\"personalInfo.jsp?id=3&amp;userid=2\">@" + at + "</a>\n";
        out +=  "                <span>&nbsp;·&nbsp;" + time + "</span>\n";
        out +=  "            </div>\n" +
                "            <div class=\"content\">\n";
        out +=  "                <span>" + things + "</span>\n";
        out +=  "            </div>\n" +
                "            <div class=\"huDong\">\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/pinglun.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">";
        out +=  "                        " + huDongs[0] + "\n";
        out +=  "                    </span>\n" +
                "                </button>\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/zhuantui.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n";
        out +=  "                        " + huDongs[1] + "\n";
        out +=  "                    </span>\n" +
                "                </button>\n";
        // ---------------------------------------------------
        if(isLike)
        out +=  "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;cursor: pointer;\" onclick=\"window.location.href='/Like?type=unlike&artid=" + artid + "&backto=" + back + "'\">\n" +
                "                    <img src=\"../svg/xihuan_checked.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n";
        else
        out +=  "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;cursor: pointer;\" onclick=\"window.location.href='/Like?type=like&artid=" + artid + "&backto=" + back + "'\">\n" +
                "                    <img src=\"../svg/xihuan.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n";
        // ---------------------------------------------------
        out +=  "                        " + huDongs[2] + "\n";
        out +=  "                    </span>\n" +
                "                </button>\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/fenxiang.svg\" height=\"18\">\n" +
                "                </button>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "    </div>\n";
        return out;
    }

    public static String UserCard(String name, String at, String hand, String followWho, String back, String width, boolean isFollowed) {
        String out = "";
        String follow = isFollowed?"uf":"fl";
        String followText = isFollowed?"已关注":"关注";
        String buttonBackground = isFollowed?"#1DA1F2":"transparent";

        out +=  "<div class=\"Tuijian\" style=\"width: " + width + "px;\">\n" +
                "    <div>\n" +
                "       <div class=\"TJCard-Head\"><img src=\"" + hand + "\" height=\"49\" width=\"49\"></div>\n";
        out +=  "       <div class=\"TJCard-NamePad\">\n" +
                "           <span class=\"TJCard-Name\">" + name + "</span>\n" +
                "           <br>\n" +
                "           <span class=\"TJCard-At\">@" + at + "</span>\n" +
                "       </div>\n";
        out +=  "       <div style=\"float: right\">\n" +
                "            <button class=\"TJCard-But\" style=\"cursor:pointer;outline:none;background: " + buttonBackground + ";\" onclick=\"window.location.href='/Follow?type=" + follow + "&follow=" + followWho + "&backto=" + back + "'\">" + followText + "</button>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</div>";
        return out;
    }

}
