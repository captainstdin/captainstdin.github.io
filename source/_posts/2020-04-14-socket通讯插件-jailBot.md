---
title: socket通讯插件-jailBot
date: 2020-04-14 22:22:14
tags: 机器人
---


阿里GIT开源webController
https://code.aliyun.com/admin1234566/jailbot.git


<!--more-->

![1.jpg][1]
![2.png][2]



    //私聊处理
    public function stringMsg(){
    
        $_img='http://www.mxact.com/static/img//logo2.png';
    
        $this->sendMsg('你好啊');
        $this->sendImg($_img); //发送图片
        $this->sendRecord('http://b.mxact.com/api.mp3'); //发送mp3语音
        $this->sendCardShare('272745091'); //分享名片
        $this->sendLocation('28.00','120.70','我在这里','点击看看啊 啊啊啊'); //分享坐标
        $this->sendUrlCard('http://www.baidu.com',$_img,'分享链接','有好东西');//分享卡片
        $this->sendShake();//抖屏
    }
    //群聊处理
     public function stringMsg()
        {
            $_img='http://www.mxact.com/static/img//logo2.png';
    
            $this->recall(); //撤回该发言人这个消息
            $this->ban(2); //禁言该发言人2分钟
            $this->unban(); //解除该发言人禁言
            $this->sendMsg('你好');//回复该发言人消息
            $this->reply('你好'); //at并且该发言人回复
            $this->kick();//踢出群
            $this->kickForEvery();//该发言人永久踢出群
    
            $this->sendImg($_img); //发送图片
            $this->sendRecord('http://b.mxact.com/api.mp3'); //发送mp3语音
            $this->sendCardShare('272745091'); //分享名片
            $this->sendLocation('28.00','120.70','我在这里','点击看看啊 啊啊啊'); //分享坐标
            $this->sendUrlCard('http://www.baidu.com',$_img,'分享链接','有好东西');//分享卡片
    
            $this->sendSign();//签到QQ群
            $this->setGroupSpecialTitle('设置头衔');//设置该发言人头衔，仅仅机器人群主使用
            $this->setGroupCard('设置名片');//设置该发言人的名片
    
    
            $this->setAllBanSpeak();//全体禁言
            $this->setUnAllBanSpeak(); //解除全体禁言
            $this->setAdmin(); //设置改发言用户管理员。仅仅机器人为群主可用
            $this->setUnAdmin();//取消改发言用户管理员。仅仅机器人为群主可用
    
        }



    ## 其他处理
    FriendAddRequest=>好友添加请求处理
    GroupAddRequest=>群他人申请/被邀请处理
    GroupMemberDecrease=>群成员离开/被踢处理
    GroupMemberIncrease=>群成员加入/被管理员邀请处理
    GroupUpload=>群成员上传文件处理

感谢朋友的底层技术支持:
![myfriends.png][3]

开发板 包含增强【撤回消息，发送语音，发送文件，发送图片，发送xml】
[socketEventpp.cpk][4]


**被动事件推送**


图片数据
好友已添加(FriendAdd)
好友添加请求(FriendAddRequest)
群添加请求(GroupAddRequest)
群禁言事件(GroupBan)
点击菜单事件(ClickMenu)
私聊消息(PrivateMsg)
群消息(GroupMsg)
收到匿名消息
讨论组消息(DiscussMsg)
群文件上传(GroupUpload)
群管理员变动(GroupAdminChange)
群成员减少(GroupMemberDecrease)
群成员增加(GroupMemberIncrease)


----------
**主动推送动作**

setGroupFileDelete「删除群文件」
sendDiscussMsg「发送讨论组消息」
sendFlower「送花」
sendGroupMsg「发送群消息」
sendLike「发送名片赞」
sendPrivateMsg「发送私聊消息」
setDiscussLeave「置讨论组退出」
setFriendAddRequest「置好友添加请求」
setGroupAddRequest「置群添加请求」
setGroupAdmin「置群管理员」
setGroupAnonymous「置群匿名设置」
setGroupAnonymousBan「置匿名群员禁言」
setGroupBan「置群成员禁言」
setGroupCard「置群成员名片」
setGroupFileDelete「删除群文件」
setGroupLeave「置群退出」
setGroupKick「置群成员移除」
setGroupSign「置群签到」
setGroupSpecialTitle「置群成员专属头衔」
setGroupWholeBan「置全群禁言」
setMsgDelete「撤回消息」
setSign「QQ打卡」
setStatus「置悬浮窗数据」
----------



C**CQ码动作**

    <?php
    /**
     * Created by PhpStorm.
     * User: admin
     * Date: 2020/4/13
     * Time: 18:05
     */
    
    namespace app\index\service;
    
    
    class cqCodeBuilder
    {
    
        /**
         * 说明
         * 此class只用于获取特定CQ码，并没有真正的调用API！！！
         */
    
        /**
         * @某人(at)
         * @param number $qq 要艾特的QQ号，-1 为全体
         * @param bool $needSpace  At后不加空格，默认为 True，可使At更规范美观。如果不需要添加空格，请置本参数为 False。
         * @return string CQ码_At
         */
        public function cqAt($qq, $needSpace = true)
        {
            if($qq == -1) $qq = 'all';
            return $needSpace ? "[CQ:at,qq=$qq] " : "[CQ:at,qq=$qq]";
        }
    
        /**
         * 禁言
         * 只能在群消息中使用，
         * @param int $qq 禁言操作，-1为全体
         * @param int $time 禁言时间，0为解除禁言
         * @return string CQ码_At
         */
        public function cqBan($qq = -1, $time = 0)
        {
            return "[CQ:ban,qq=$qq,time=$time]";
        }
    
        /**
         * 发送emoji表情(emoji)
         * @param int $id 表情ID，emoji的unicode编号
         * @return string CQ码_emoji
         */
        public function cqEmoji($id)
        {
            return "[CQ:emoji,id=$id]";
        }
    
        /**
         * 发送表情(face)
         * @param int $id 表情ID，0 ~ 200+
         * @return string CQ码_表情
         */
        public function cqFace($id)
        {
            return "[CQ:face,id=$id]";
        }
    
        /**
         * 发送窗口抖动(shake) - 仅支持好友，腾讯已将其改名为戳一戳
         * @return string CQ码_窗口抖动
         */
        public function cqShake()
        {
            return '[CQ:shake]';
        }
    
        /**
         * 反转义
         * @param string $msg 原消息，要反转义的字符串
         * @return string 反转义后的字符串
         */
        public function antiEscape($msg)
        {
            $msg = str_replace('&#91;', '[', $msg);
            $msg = str_replace('&#93;', ']', $msg);
            $msg = str_replace('&#44;', ',', $msg);
            $msg = str_replace('&amp;', '&', $msg);
            return $msg;
        }
    
        /**
         * 发送链接分享(share)
         * @param string $url 分享链接，点击卡片后跳转的网页地址
         * @param string $title 标题，可空，分享的标题，建议12字以内
         * @param string $content 内容，可空，分享的简介，建议30字以内
         * @param string $picUrl 图片链接，可空，分享的图片链接，留空则为默认图片
         * @return string CQ码_链接分享
         */
        public function cqShare($url, $title = '', $content = '', $picUrl = '') //发送链接分享
        {
            $msg = '[CQ:share,url='.$this->escape($url, true);
            if($title) $msg .= ',title='.$this->escape($title, true);
            if($content) $msg .= ',content='.$this->escape($content, true);
            if($picUrl) $msg .= ',image='.$this->escape($picUrl, true);
            $msg .= ']';
            return $msg;
        }
    
        /**
         * 发送名片分享(contact)
         * @param string $type 分享类型，目前支持 qq/好友分享 group/群分享
         * @param number $id 分享帐号，类型为qq，则为QQ号；类型为group，则为群号
         * @return string CQ码_名片分享
         */
        public function cqCardShare($type = 'qq', $id)
        {
            $type = $this->escape($type, true);
            return "[CQ:contact,type=$type,id=$id]";
        }
    
        /**
         * 匿名发消息（anonymous），仅支持群
         * @param boolean $ignore 是否不强制，默认为 False。如果希望匿名失败时，将消息转为普通消息发送（而不是取消发送），请置本参数为 True
         * @return string CQ码_匿名
         */
        public function cqAnonymous($ignore = false)
        {
            return $ignore ? '[CQ:anonymous,ignore=true]' : '[CQ:anonymous]';
        }
    
        /**
         * CQ码_图片(image)
         * @param string $path 图片路径，可使用网络图片和本地图片．使用本地图片时需在路径前加入 file://
         * @return string CQ码_图片
         */
        public function cqImage ($path)
        {
            $path = $this->escape($path, true);
            return "[CQ:image,file=$path]";
        }
    
        /**
         * 取CQ码_位置分享(location)
         * @param double $lat 纬度
         * @param double $lon 经度
         * @param int $zoom 放大倍数，可空，默认为 15
         * @param string $title 地点名称，建议12字以内
         * @param string $content 地址，建议20字以内
         * @return string CQ码_位置分享
         */
        public function cqLocation ($lat, $lon, $zoom = 15, $title, $content)
        {
            $title = $this->escape($title, true);
            $content = $this->escape($content, true);
            return "[CQ:location,lat=$lat,lon=$lon,zoom=$zoom,title=$title,content=$content]";
        }
    
        /**
         * 取CQ码_音乐(music)
         * @param number $songID 音乐的歌曲数字ID
         * @param string $type 音乐网站类型，目前支持 qq/QQ音乐 163/网易云音乐 xiami/虾米音乐，默认为qq
         * @param bool $newStyle 是否启用新版样式，目前仅 QQ音乐 支持
         * @return string CQ码_音乐
         */
        public function cqMusic ($songID, $type = 'qq', $newStyle = false) //发送音乐
        {
            $type = $this->escape($type, true);
            $newStyle = $newStyle ? 1 : 0;
            return "[CQ:music,id=$songID,type=$type,style=$newStyle]";
        }
    
        /**
         * 取CQ码_音乐自定义分享(music)
         * @param string $url 分享链接，点击分享后进入的音乐页面（如歌曲介绍页）
         * @param string $audio 音频链接，音乐的音频链接（如mp3链接）
         * @param string $title 标题，可空，音乐的标题，建议12字以内
         * @param string $content 内容，可空，音乐的简介，建议30字以内
         * @param string $image 封面图片链接，可空，音乐的封面图片链接，留空则为默认图片
         * @return string CQ码_音乐自定义分享
         */
        public function cqCustomMusic($url, $audio, $title = '', $content = '', $image = '') //发送自定义音乐分享
        {
            $url = $this->escape($url, true);
            $audio = $this->escape($audio, true);
            $para = "[CQ:music,type=custom,url=$url,audio=$audio";
            if($title) $para .= ',title='.$this->escape($title, true);
            if($content) $para .= ',content='.$this->escape($content, true);
            if($image) $para .= ',image='.$this->escape($image, true);
            $para .= ']';
            return $para;
        }
    
        /**
         * 取CQ码_语音(record)
         * @param string $path 语音路径，可使用网络和本地语音文件．使用本地语音文件时需在路径前加入 file://
         * @return string CQ码_语音
         */
        public function cqRecord($path)
        {
            $path = $this->escape($path, true);
            return "[CQ:record,file=$path]";
        }
    
        /**
         * 转义
         * @param string $msg 要转义的字符串
         * @param boolean $escapeComma 转义逗号，默认不转义
         * @return string 转义后的字符串
         */
        public function escape ($msg, $escapeComma=false)
        {
            $msg = str_replace('[', '&#91;', $msg);
            $msg = str_replace(']', '&#93;', $msg);
            $msg = str_replace('&', '&amp;', $msg);
            if($escapeComma) $msg = str_replace(',', '&#44;', $msg);
            return $msg;
        }
    
        /**
         * 取CQ码_大表情(bface)
         * @param int $pID 大表情所属系列的标识
         * @param int $id 大表情的唯一标识
         * @return string CQ码_大表情
         */
        public function cqBigFace($pID, $id)
        {
            return "[CQ:bface,p=$pID,id=$id]";
        }
    
        /**
         * 取CQ码_小表情(sface)
         * @param int $id 小表情代码
         * @return string CQ码_小表情
         */
        public function cqSmallFace($id)
        {
            return "[CQ:sface,id=$id]";
        }
    
        /**
         * 取CQ码_厘米秀(show)
         * @param int $id 动作代码
         * @param number $qq 动作对象，可空，仅在双人动作时有效
         * @param string $content 消息内容，建议8个字以内
         * @return string CQ码_厘米秀
         */
        public function cqShow ($id, $qq = null, $content = '')
        {
            $msg = '[CQ:show,id='.$id;
            if($qq) $msg .= ',qq='.$qq;
            if($content) $msg .= ',content='.$this->escape($content, true);
            $msg .= ']';
            return $msg;
        }
    
    }


[1]: typecho/uploads/2020/04/3028545767.jpg
[2]: typecho/uploads/2020/04/2726954109.png
[3]: typecho/uploads/2020/04/731715100.png
[4]: typecho/uploads/2020/04/3827829048.cpk
