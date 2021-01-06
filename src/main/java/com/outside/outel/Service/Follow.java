package com.outside.outel.Service;

import com.outside.outel.Dao.Dao;
import com.outside.outel.Dao.User;

import java.sql.SQLException;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2021/1/4 上午 10:14
 * @ClassName: AddFollowing
 * @Author: Stapx Steve
 * @Description TODO 关注相关操作
 **/
public class Follow {

    /**
     * @Author Stapx Steve
     * @Description TODO 关注用户
     * @Date 上午 10:18 2021/1/4
     * @Param [id, followId]
     * @return boolean
    **/
    public static String set(String id, String followId) throws SQLException {
        // 获取 Following, Follower
        String following = "";
        String follower = "";
        List<Dao.SQLVer> list = User.selectByID("following", id);
        for(Dao.SQLVer info: list) {
            if(info.name.equals("following")) {
                following = info.value;
                if(following.equals("''")) {
                    following = "";
                }
            }
        }
         list = User.selectByID("follower", followId);
        for(Dao.SQLVer info: list) {
            if(info.name.equals("follower")) {
                follower = info.value;
                if(follower.equals("''")) {
                    follower = "";
                }
            }
        }
        // 写入数据
        following = following + "," + followId;
        String back = User.UpdateByID("following=" + following, id, true);
        if(!back.equals("OK")) {
            return back;
        }
        follower = follower + "," + id;
        back = User.UpdateByID("follower=" + follower, followId, true);
        if(!back.equals("OK")) {
            return back;
        }
        return "OK";
    }

    /**
     * @Author Stapx Steve
     * @Description TODO 取关用户
     * @Date 上午 12:06 2021/1/7
     * @Param [id, followId]
     * @return java.lang.String
    **/
    public static String delete(String id, String followId) throws SQLException {
        // 获取 Following, Follower
        String following = "";
        String follower = "";
        List<Dao.SQLVer> list = User.selectByID("following", id);
        for (Dao.SQLVer info : list) {
            if (info.name.equals("following")) {
                following = info.value;
                if (following.equals("''")) {
                    following = "";
                }
            }
        }
        list = User.selectByID("follower", followId);
        for (Dao.SQLVer info : list) {
            if (info.name.equals("follower")) {
                follower = info.value;
                if (follower.equals("''")) {
                    follower = "";
                }
            }
        }
        // 写入数据
        String[] followingList = following.split(",");
        StringBuilder out = new StringBuilder();
        for(String info: followingList) {
            if(!info.equals(followId) && !info.equals("")) {
                out.append(",").append(info);
            }
        }
        following = out.toString();
        System.out.println(following);
        String back = User.UpdateByID("following=" + following, id, true);
        if(!back.equals("OK")) {
            return back;
        }
        String[] followerList = follower.split(",");
        out = new StringBuilder();
        for(String info: followerList) {
            if(!info.equals(id) && !info.equals("")) {
                out.append(",").append(info);
            }
        }
        follower = out.toString();
        back = User.UpdateByID("follower=" + follower, followId, true);
        if(!back.equals("OK")) {
            return back;
        }
        System.out.println(follower);
        return "OK";
    }

}
