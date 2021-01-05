package com.outside.outel.Service;

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
        List<User.SQLVer> list = User.selectByID("following", id);
        for(User.SQLVer info: list) {
            if(info.name.equals("following")) {
                following = info.value;
                if(following.equals("''")) {
                    following = "";
                }
            }
        }
         list = User.selectByID("follower", followId);
        for(User.SQLVer info: list) {
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

    public static String delete(String id, String followId) throws SQLException {
        // 获取 Following, Follower
        String following = "";
        String follower = "";
        List<User.SQLVer> list = User.selectByID("following", id);
        for (User.SQLVer info : list) {
            if (info.name.equals("following")) {
                following = info.value;
                if (following.equals("''")) {
                    following = "";
                }
            }
        }
        list = User.selectByID("follower", followId);
        for (User.SQLVer info : list) {
            if (info.name.equals("follower")) {
                follower = info.value;
                if (follower.equals("''")) {
                    follower = "";
                }
            }
        }
        // 写入数据
        String start = following.substring(0, following.indexOf(followId) - 1);
        String end = following.substring(following.indexOf(followId) + followId.length());
        following = start + end;
        System.out.println(following);
        String back = User.UpdateByID("following=" + following, id, true);
        if(!back.equals("OK")) {
            return back;
        }
        start = follower.substring(0, follower.indexOf(id) - 1);
        end = follower.substring((follower.indexOf(id) + id.length()));
        follower = start + end;
        back = User.UpdateByID("follower=" + follower, followId, true);
        if(!back.equals("OK")) {
            return back;
        }
        System.out.println(follower);
        return "OK";
    }

}
