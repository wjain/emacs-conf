;;日历基本配置
;;设置我所在地方的经纬度，calendar里有个功能是日月食的预测，和你的经纬度相联系的。
(setq calendar-latitude +39.9)
(setq calendar-longitude +116.4)
;;我的所在地北京，欢迎大家来找北京请我吃饭
(setq calendar-location-name "Xi-an")
;;这个做什么的？忘了，有谁能告诉我，谢谢。
;;我的配置文件里很多东西忘了，欢迎大家来指正下
(setq calendar-remove-frame-by-deleting t)
;;设定一周的开始为周一
(setq calendar-week-start-day 1)
;;节日和生日提醒设置
;;我不过基督徒的节日、希伯来人的节日和伊斯兰教的节日。
;;我是无神论者，不过我喜欢神话，大家有兴趣也可以探讨一下，发email给我吧
(setq christian-holidays nil)
(setq hebrew-holidays nil)
(setq islamic-holidays nil)
;;设定一些自定义的生日和节日
;;隐私需要，删掉朋友的生日
;;后面那些农历节日需要每年根据日历修改
;;有些可惜，没有中国传统农历，谁能写个扩展elisp包弄一下
(setq general-holidays '((holiday-fixed 1 1 "元旦")
(holiday-fixed 3 8 "妇女节")
(holiday-fixed 4 1 "愚人节")
(holiday-fixed 4 11 "谁的生日")
(holiday-fixed 5 1 "劳动节")
(holiday-fixed 10 1 "国庆节")
(holiday-fixed 12 25 "圣诞节")
(holiday-fixed 2 5 "元宵节")
(holiday-fixed 4 4 "清明节")
(holiday-fixed 4 21 "鬼节")
(holiday-fixed 6 22 "端午节")
(holiday-fixed 9 28 "中秋节")
(holiday-float 5 0 2 "母亲节")
(holiday-float 6 0 3 "父亲节")
))
;;其他的一些设置
;;日历不和日记相连，我不用Calendar自带的diary记日记
(setq mark-diary-entries-in-calendar nil)
;;这个又忘了，我真是忘性好！
(setq appt-issue-message nil)
;;在日历中突出标记节日和生日
(setq mark-holidays-in-calendar t)
;;打开calendar自动打开节日和生日列表
(setq view-calendar-holidays-initially t)

;;下面两个是设置年份为中国年，好像默认的是用英文写的，由王垠修改的。
;;这个设置在节日列表的春节那天能看到，如今年的春节他就写着
;;Thursday, January 22, 2004: Chinese New Year (甲-申)
(setq chinese-calendar-celestial-stem
["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
["子" "丑" "寅" "卯" "辰" "巳" "戊" "未" "申" "酉" "戌" "亥"])


(provid jain-calendar)