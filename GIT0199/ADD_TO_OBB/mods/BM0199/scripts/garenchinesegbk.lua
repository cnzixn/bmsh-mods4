local char = "garen"
if string.find(string.upper(STRINGS.NAMES.GRASS), "草") then
    local STRINGS = GLOBAL.STRINGS
    _G.STRINGS.CHARACTER_TITLES[char] = "盖伦"
    _G.STRINGS.CHARACTER_NAMES[char] = "盖伦"
    _G.STRINGS.CHARACTER_DESCRIPTIONS[char] = "*4技能\n*1被动\n*德玛西亚......"
    _G.STRINGS.CHARACTER_QUOTES[char] = "\"接受制裁吧正义必胜\""
    STRINGS.NAMES.GAREN = '盖伦'
    STRINGS.NAMES.GARENDUCK = "鸭子"
    STRINGS.RECIPE_DESC.GARENDUCK = "一只很老很丑可以当船的鸭子"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENDUCK = "一只很老很丑可以当船的鸭子"
    STRINGS.NAMES.GARENMAXWELLLIGHT = STRINGS.NAMES.MAXWELLLIGHT
    STRINGS.RECIPE_DESC.GARENMAXWELLLIGHT = "永恒不灭的火炬"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMAXWELLLIGHT = STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAXWELLLIGHT
    STRINGS.NAMES.GARENMAXWELLPHONOGRAPH = STRINGS.NAMES.MAXWELLPHONOGRAPH
    STRINGS.RECIPE_DESC.GARENMAXWELLPHONOGRAPH = "听听歌快速恢复精神"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMAXWELLPHONOGRAPH = STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAXWELLPHONOGRAPH
    STRINGS.NAMES.GARENACCOMPLISHMENT_SHRINE = STRINGS.NAMES.ACCOMPLISHMENT_SHRINE
    STRINGS.RECIPE_DESC.GARENACCOMPLISHMENT_SHRINE = "想作死尽管来吧"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENACCOMPLISHMENT_SHRINE = STRINGS.CHARACTERS.GENERIC.DESCRIBE.ACCOMPLISHMENT_SHRINE
    STRINGS.NAMES.GARENGARBAGEHEAP = "垃圾堆"
    STRINGS.RECIPE_DESC.GARENGARBAGEHEAP = "处理垃圾回收材料"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENGARBAGEHEAP = "比你家干净多了"
    STRINGS.NAMES.GARENSKULLCHEST = STRINGS.NAMES.SKULLCHEST
    STRINGS.RECIPE_DESC.GARENSKULLCHEST = "更大的箱子"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSKULLCHEST = STRINGS.CHARACTERS.GENERIC.DESCRIBE.SKULLCHEST
    STRINGS.NAMES.GARENPANDORAS_CHEST = STRINGS.NAMES.PANDORASCHEST
    STRINGS.RECIPE_DESC.GARENPANDORAS_CHEST = "更大的箱子"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENPANDORAS_CHEST = STRINGS.CHARACTERS.GENERIC.DESCRIBE.PANDORASCHEST
    STRINGS.NAMES.GARENPORO = "破罗"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENPORO = "迷之生物"
    STRINGS.RECIPE_DESC.GARENPORO = "似乎可以烤着吃"
    STRINGS.NAMES.GARENWORMHOLE_SHIPWRECKED_FX = "司南珠"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENWORMHOLE_SHIPWRECKED_FX = "司南珠"
    STRINGS.NAMES.GARENTENT1 = "德玛西亚帐篷"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENTENT1 = "德玛西亚帐篷"
    STRINGS.NAMES.GARENTENT2 = "诺克萨斯帐篷"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENTENT2 = "诺克萨斯帐篷"
    STRINGS.NAMES.GARENPACKAGED = "打包"
    STRINGS.NAMES.DORAN = "多兰剑"
    STRINGS.NAMES.GARENSOULBALL = "精灵球"
    STRINGS.RECIPE_DESC.GARENSOULBALL = "抓宠物用的"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSOULBALL = "去吧皮卡丘"
    STRINGS.NAMES.GARENSOULBALLADVANCE = "高级精灵球"
    STRINGS.RECIPE_DESC.GARENSOULBALLADVANCE = "宠物死亡不会消失不掉等级"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSOULBALLADVANCE = "去吧皮卡丘"
    STRINGS.NAMES.GARENSOULBALLWHITE = "建筑打包球"
    STRINGS.RECIPE_DESC.GARENSOULBALLWHITE = "里面塞着建筑"
    STRINGS.RECIPE_DESC.DORAN = "最基本的武器"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.DORAN = "最基本的武器"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSOULBALLWHITE = "把网吧打包走好了"
    STRINGS.TABS.GARENTABS = "盖伦"
    STRINGS.NAMES.GAREN = "盖伦"
    for i = 1, TUNING.GARENWEAPONNUM do
        STRINGS.NAMES["GARENWEAPON" .. i] = "盖伦武器"
        STRINGS.CHARACTERS.GENERIC.DESCRIBE["GARENWEAPON" .. i] = "盖伦武器"
        STRINGS.RECIPE_DESC["GARENWEAPON" .. i] = "盖伦武器"
    end
    GLOBAL.LOLMEMBERTALK = {
        "哥可最强王者",
        "嘿,小学生",
        "让哥带你超神带你飞",
        "劳资对线就没输过",
        "你也就个青铜渣水平吧",
        "和你当队友真是难为我了",
        "谁不服有种solo",
        "哥向来都是一挑五",
        "父子局劳资就没输过",
        "劳资是一区王者",
        "劳资一个人痛打你们五个",
        "在劳资眼里你们都是小学生",
        "劳资打的你全家都不认识你",
        "对面见到我都吓得挂机",
    }
    TUNING.LOLMEMBER.TALK = "我需要%s,如果能找到我会给你一些报酬"
    TUNING.LOLMEMBER.TALK2 = "既然你在外面挨揍了,就让哥帮你摆平吧"
    TUNING.LOLMEMBER.TALK3 = "装备可以有"
    TUNING.LOLMEMBER.TALK4 = "正好饿成狗,不用点外卖了"
    TUNING.LOLMEMBER.TALK5 = "谢谢,虽然它并没啥卵用"
    TUNING.LOLMEMBER.TALK6 = "哥有船"
    TUNING.LOLMEMBER.TALK7 = "经验宝宝来了"
    TUNING.LOLMEMBER.TALK8 = "摔死劳资了"
    TUNING.LOLMEMBER.TALK9 = "我是老王,我喂自己袋盐"
    TUNING.LOLMEMBER.TALK10 = "我的丧帝"
    TUNING.LOLMEMBER.TALK11 = "去屎吧"
    TUNING.LOLMEMBER.TALK12 = "敌军还有30秒到达战场"
    TUNING.LOLMEMBER.TALK13 = "全军出击"
    TUNING.LOLMEMBER.TALK14 = "主播从动物园里逃出来啦"
    TUNING.LOLMEMBER.TALK15 = "把我的大baojian拿来"
    TUNING.LOLMEMBER.TALK16 = "色情主播我报警啦"
    TUNING.LOLMEMBER.TALK17 = "666666"
    TUNING.LOLMEMBER.TALK18 = "我要日墙"
    TUNING.LOLMEMBER.TALK19 = "抓捕成功"
    TUNING.LOLMEMBER.TALK20 = "不作死就不会死"
    TUNING.LOLMEMBER.TALK21 = "草丛才是我的家"
    TUNING.LOLMEMBER.TALK22 = "我Q死你"
    TUNING.LOLMEMBER.TALK23 = "来打我呀,来打我呀"
    TUNING.LOLMEMBER.TALK24 = "请选择目标"
    TUNING.LOLMEMBER.TALK25 = "吃我大baojian"
    TUNING.LOLMEMBER.TALK26 = "吾乃小彩旗"
    TUNING.LOLMEMBER.TALK27 = "船上转想弄死我啊"
    TUNING.LOLMEMBER.TALK28 = "吓屎你!"
    TUNING.LOLMEMBER.TALK29 = "小兄弟"
    TUNING.LOLMEMBER.TALK30 = "我看你骨骼惊奇"
    TUNING.LOLMEMBER.TALK31 = "要不要冲个币"
    TUNING.LOLMEMBER.TALK32 = "或者冲个钻啥的"
    TUNING.LOLMEMBER.TALK33 = "或者办个会员"
    TUNING.LOLMEMBER.TALK34 = "......"
    TUNING.LOLMEMBER.TALK35 = "别忘了充钱哦"
    TUNING.LOLMEMBER.TALK36 = "等级"
    TUNING.LOLMEMBER.TALK37 = "战绩"
    TUNING.LOLMEMBER.TALK38 = "生命"
    TUNING.LOLMEMBER.TALK39 = "饥饿"
    TUNING.LOLMEMBER.TALK40 = "精神"
    TUNING.LOLMEMBER.TALK41 = "杀"
    TUNING.LOLMEMBER.TALK42 = "死"
    TUNING.LOLMEMBER.TALK43 = "力量"
    TUNING.LOLMEMBER.TALK44 = "智力"
    TUNING.LOLMEMBER.TALK45 = "敏捷"
    TUNING.LOLMEMBER.TALK46 = "体质"
    TUNING.LOLMEMBER.TALK47 = "技能点"
    TUNING.LOLMEMBER.TALK48 = "换人"
    TUNING.LOLMEMBER.TALK49 = "切换角色"
    TUNING.LOLMEMBER.TALK50 = "想用谁坑队友？"
    TUNING.LOLMEMBER.TALK51 = "不换了"
    TUNING.LOLMEMBER.TALK52 = "咋加点"
    TUNING.LOLMEMBER.TALK53 = "帮助"
    TUNING.LOLMEMBER.TALK54 = "不用BB了"
    TUNING.LOLMEMBER.TALK55 = "经验"
    TUNING.LOLMEMBER.TALK56 = "伤害"
    TUNING.LOLMEMBER.TALK57 = "法伤"
    TUNING.LOLMEMBER.TALK58 = "穿透"
    TUNING.LOLMEMBER.TALK59 = "防御"
    TUNING.LOLMEMBER.TALK60 = "暴击"
    TUNING.LOLMEMBER.TALK61 = "攻速"
    TUNING.LOLMEMBER.TALK62 = "移速"
    TUNING.LOLMEMBER.TALK63 = "回血"
    TUNING.LOLMEMBER.TALK64 = "硬直"
    TUNING.LOLMEMBER.TALK65 = "金钱"
    TUNING.LOLMEMBER.TALK66 = "分钟"
    TUNING.LOLMEMBER.TALK67 = "加点说明"
    TUNING.LOLMEMBER.TALK68 = "力量:基础伤害百分比，技能杀伤范围，饥饿上限(技能有30%普攻伤害加成)\n智力:技能固定伤害，普攻和技能真实伤害百分比(无视生物护甲)，精神上限，获得更多经验\n敏捷:普攻暴击率，技能暴击率，攻速，移速\n体质:生命上限，生命恢复速度，硬直时间，伤害吸收，技能释放CD\n洗点喝曼德拉汤，空间有限，详细说明看创意工坊"
    TUNING.LOLMEMBER.TALK69 = '攻(%d)防(%d)速(%d)治疗(%d)cd(%d)暴击(%d)\n\n\n\n'
    TUNING.LOLMEMBER.TALK70 = '首先我得有个基地吧'
    STRINGS.NAMES.GARENSOULBALLBLUE = "重铸器"
    STRINGS.RECIPE_DESC.GARENSOULBALLBLUE = "随机变更武器品质"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSOULBALLBLUE = "随机武器资质"
    STRINGS.NAMES.GARENHEARTHSTONE = "司南珠"
    STRINGS.RECIPE_DESC.GARENHEARTHSTONE = "出门要做的第一件事是回家"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENHEARTHSTONE = "出门要做的第一件事是回家"
    STRINGS.NAMES.GARENSOULBALLYELLOW = "附魔石"
    STRINGS.RECIPE_DESC.GARENSOULBALLYELLOW = "武器随机获得七种特性之一"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSOULBALLYELLOW = "幸亏不是网游，不然又是坑钱的"
    GLOBAL.LOLSYM = {
        "金",
        "木",
        "水",
        "火",
        "土",
        "风",
        "雷",
    }
    GLOBAL.LOLSYMDESC = {
        "武器变为万用工具;打怪掉金币金子小概率宝石",
        "攻击概率召唤藤蔓;释放收集周围所有作物",
        "攻击概率冰冻;释放范围冰冻",
        "攻击有火焰伤害;击杀单位吸收生命和精神",
        "武器永久获得少量溅射伤害;释放范围地震",
        "攻击概率击飞单位;释放直线释放破坏型旋风",
        "武器拥有瞬移能力;释放范围雷击",
    }
    TUNING.LOLMEMBER.noxusmem = '诺克萨斯'
    TUNING.LOLMEMBER.demaciamem = '德玛西亚'
    if (GLOBAL.GetPlayer and GLOBAL.GetPlayer() and GLOBAL.GetPlayer().prefab == "garen") or GLOBAL.TUNING.LOLCHAR then
        if not STRINGS.BORE_TALK_ATTEMPT_TRADE then
            STRINGS.BORE_TALK_ATTEMPT_TRADE = {}
        end
        if not STRINGS.BORE_TALK_EAT_MEAT then
            STRINGS.BORE_TALK_EAT_MEAT = {}
        end
        if not STRINGS.BORE_TALK_FIGHT then
            STRINGS.BORE_TALK_FIGHT = {}
        end
        if not STRINGS.BORE_TALK_FIND_LIGHT then
            STRINGS.BORE_TALK_FIND_LIGHT = {}
        end
        if not STRINGS.BORE_TALK_FIND_MEAT then
            STRINGS.BORE_TALK_FIND_MEAT = {}
        end
        if not STRINGS.BORE_TALK_FOLLOWWILSON then
            STRINGS.BORE_TALK_FOLLOWWILSON = {}
        end
        if not STRINGS.BORE_TALK_GO_HOME then
            STRINGS.BORE_TALK_GO_HOME = {}
        end
        if not STRINGS.BORE_TALK_HELP_CHOP_WOOD then
            STRINGS.BORE_TALK_HELP_CHOP_WOOD = {}
        end
        if not STRINGS.BORE_TALK_LOOKATWILSON then
            STRINGS.BORE_TALK_LOOKATWILSON = {}
        end
        if not STRINGS.BORE_TALK_PANIC then
            STRINGS.BORE_TALK_PANIC = {}
        end
        if not STRINGS.BORE_TALK_PANICFIRE then
            STRINGS.BORE_TALK_PANICFIRE = {}
        end
        if not STRINGS.BORE_TALK_RUN_FROM_SPIDER then
            STRINGS.BORE_TALK_RUN_FROM_SPIDER = {}
        end
        if not STRINGS.BORE_TALK_RUNAWAY_WILSON then
            STRINGS.BORE_TALK_RUNAWAY_WILSON = {}
        end
        if not STRINGS.BORE_TALK_HELP_HACK then
            STRINGS.BORE_TALK_HELP_HACK = {}
        end
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.PIGMAN.GENERIC = '长得和你真像'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.PIGMAN.FOLLOWER = '带你装逼带你飞'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.PIGMAN.WEREPIG = '能杀我喊你爸爸'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.PIGMAN.GUARD = '有种别猥琐塔下'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.PIGMAN.DEAD = '红烧还是清蒸呢'
        STRINGS.CHARACTERS.GENERIC.BATTLECRY.PREY = '跟我卖萌是没用滴'
        STRINGS.CHARACTERS.GENERIC.BATTLECRY.PIG = '叫你不清真'
        STRINGS.CHARACTERS.GENERIC.BATTLECRY.SPIDER_WARRIOR = '听说你挺跳啊'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_ACCOMPLISHMENT = '还有谁'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_ACCOMPLISHMENT_DONE = '不服还有谁'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_ADVENTUREFAIL = '装逼又失败了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_BEES = '让我静静的装bee'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_BOOMERANG = '德莱文你给我出来'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_CANFIX = '别被偷家了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_CHARLIE = '有种别隐身'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_CHARLIE_ATTACK = '被gank了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_COLD = '有暖气么'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_CRAFTING_FAIL = '真菜'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_DEERCLOPS = '嘴强王者要来了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_DUSK = '应该快放学了吧'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_EAT.GENERIC = '外卖到了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_EAT.PAINFUL = '这不清真'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_EAT.SPOILED = '这不清真'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_EAT.STALE = '比大学食堂的还难吃'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_ENTER_DARK = '又停电了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_ENTER_LIGHT = '来电了继续开lu'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_FREEDOM = '快去网吧占个座'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_HIGHRESEARCH = '炸了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_HOUNDS = '听起来像是内瑟斯'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_HUNGRY = '我要喝地沟油'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_HUNT_BEAST_NEARBY = '要gank了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_HUNT_LOST_TRAIL = '估计它回城了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_KNOCKEDOUT = '要炸了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_LOWRESEARCH = '然并卵'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_MOSQUITOS = '我真想把风油精喝了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_NO_TRAP = '这位置适合插眼'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_NODANGERSLEEP = '睡你麻痹起来嗨'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_NODAYSLEEP = '睡你麻痹起来嗨'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_NODAYSLEEP_CAVE = '睡你麻痹起来嗨'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_NOHUNGERSLEEP = '先来点宵夜吧'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_PECKED = '放学你等着'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_QUAKE = '就算地震也要坚守网吧'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_RESEARCH = '猜猜里面会有啥'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_THORNS = '你敢用针扎我'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_TORCH_OUT = '我的充电宝呢'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_TRAP_WENT_OFF = '被反眼了'
        STRINGS.CHARACTERS.GENERIC.ANNOUNCE_WORMHOLE = '回城不是按B键么'
        STRINGS.CHARACTERS.GENERIC.BATTLECRY.GENERIC = '来啊互相伤害啊'
        STRINGS.CHARACTERS.GENERIC.BATTLECRY.SPIDER = '管你是不是伊莉丝'
        STRINGS.CHARACTERS.GENERIC.COMBAT_QUIT.GENERIC = '怂货'
        STRINGS.CHARACTERS.GENERIC.COMBAT_QUIT.PIG = '你个菜逼'
        STRINGS.CHARACTERS.GENERIC.COMBAT_QUIT.PREY = '走位挺风骚啊'
        STRINGS.CHARACTERS.GENERIC.COMBAT_QUIT.SPIDER = '认怂了吧'
        STRINGS.CHARACTERS.GENERIC.COMBAT_QUIT.SPIDER_WARRIOR = '让你装逼'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.EVERGREEN_SPARSE.CHOPPED = '茂凯滚出来'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE_GENERIC = '这是啥'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE_TOODARK = '楼管又拉电闸了'
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.RATATOUILLE = '还是煮方便面方便些'
        STRINGS.BORE_TALK_ATTEMPT_TRADE[1] = '来一发py交易'
        STRINGS.BORE_TALK_ATTEMPT_TRADE[2] = '色情主播我报警了'
        STRINGS.BORE_TALK_ATTEMPT_TRADE[3] = '今年过节不收礼呀'
        STRINGS.BORE_TALK_EAT_MEAT[1] = '外卖送的及时给个好评'
        STRINGS.BORE_TALK_EAT_MEAT[2] = '没放地沟油吧'
        STRINGS.BORE_TALK_FIGHT[1] = '来啊互相伤害啊'
        STRINGS.BORE_TALK_FIGHT[2] = '我将带头装逼'
        STRINGS.BORE_TALK_FIGHT[3] = '专注打野二十年'
        STRINGS.BORE_TALK_FIGHT[4] = '看我咸猪手'
        STRINGS.BORE_TALK_FIGHT[5] = '我看到提莫了'
        STRINGS.BORE_TALK_FIGHT[6] = '让哥教你怎么无伤打野'
        STRINGS.BORE_TALK_FIND_LIGHT[1] = '我的24K钛合金猪眼'
        STRINGS.BORE_TALK_FIND_LIGHT[2] = '强力围观主播装逼'
        STRINGS.BORE_TALK_FIND_LIGHT[3] = '谁在那里装逼如此耀眼'
        STRINGS.BORE_TALK_FIND_LIGHT[4] = '吓死本宝宝了'
        STRINGS.BORE_TALK_FIND_LIGHT[5] = '电费又省下了'
        STRINGS.BORE_TALK_FIND_MEAT[1] = '哥喜欢地沟油'
        STRINGS.BORE_TALK_FIND_MEAT[2] = '一定是小草莓味的'
        STRINGS.BORE_TALK_FIND_MEAT[3] = '听说你很清真'
        STRINGS.BORE_TALK_FIND_MEAT[4] = '啊好想吃猪肉'
        STRINGS.BORE_TALK_FOLLOWWILSON[1] = '咋了又在外面受欺负了'
        STRINGS.BORE_TALK_FOLLOWWILSON[2] = '你不就是想把我喂疯么'
        STRINGS.BORE_TALK_FOLLOWWILSON[3] = '听说你智商比我还低'
        STRINGS.BORE_TALK_FOLLOWWILSON[4] = '想要py交易么'
        STRINGS.BORE_TALK_GO_HOME[1] = '等我回家出中亚的'
        STRINGS.BORE_TALK_GO_HOME[2] = '导员查寝了'
        STRINGS.BORE_TALK_HELP_CHOP_WOOD[1] = '树人有种给我出来'
        STRINGS.BORE_TALK_HELP_CHOP_WOOD[2] = '看我咸猪手'
        STRINGS.BORE_TALK_HELP_CHOP_WOOD[3] = '手打残了算工伤不'
        STRINGS.BORE_TALK_HELP_HACK[1] = '我又不是熊猫'
        STRINGS.BORE_TALK_HELP_HACK[2] = '打的手生疼'
        STRINGS.BORE_TALK_HELP_HACK[3] = '手打残了算工伤不'
        STRINGS.BORE_TALK_LOOKATWILSON[1] = '哪儿来的小学生'
        STRINGS.BORE_TALK_LOOKATWILSON[2] = '发现野生青铜渣'
        STRINGS.BORE_TALK_LOOKATWILSON[3] = '就你这水平洗洗睡吧'
        STRINGS.BORE_TALK_LOOKATWILSON[4] = '咋的想solo啊'
        STRINGS.BORE_TALK_PANIC[1] = '丑八怪能否别把灯打开'
        STRINGS.BORE_TALK_PANIC[2] = '我看到提莫了'
        STRINGS.BORE_TALK_PANIC[3] = '妹子我要妹子'
        STRINGS.BORE_TALK_PANICFIRE[1] = '快成烤乳猪了'
        STRINGS.BORE_TALK_PANICFIRE[2] = '已经五分熟了'
        STRINGS.BORE_TALK_PANICFIRE[3] = '已经八分熟了'
        STRINGS.BORE_TALK_RUN_FROM_SPIDER[1] = '伊莉丝就是个渣渣'
        STRINGS.BORE_TALK_RUN_FROM_SPIDER[2] = '让哥教你怎么无伤打野'
        STRINGS.BORE_TALK_RUN_FROM_SPIDER[3] = '虐蜘蛛就跟虐菜一样'
        STRINGS.BORE_TALK_RUNAWAY_WILSON[1] = '救命非礼啦'
        STRINGS.BORE_TALK_RUNAWAY_WILSON[2] = '这人连猪都不放过'
        STRINGS.BORE_TALK_RUNAWAY_WILSON[3] = '不要这样我还是个孩子'
        STRINGS.BORE_TALK_RUNAWAY_WILSON[4] = '我跟你什么仇什么怨'
        STRINGS.PIG_GUARD_TALK_FIGHT[1] = '来啊互相伤害啊'
        STRINGS.PIG_GUARD_TALK_FIGHT[2] = '我将带头装逼'
        STRINGS.PIG_GUARD_TALK_FIGHT[3] = '专注打野二十年'
        STRINGS.PIG_GUARD_TALK_GOHOME[1] = '等我回家出中亚的'
        STRINGS.PIG_GUARD_TALK_GOHOME[2] = '导员查寝了'
        STRINGS.PIG_GUARD_TALK_GOHOME[3] = '宿舍要停电了'
        STRINGS.PIG_GUARD_TALK_LOOKATWILSON[1] = '想偷塔没门'
        STRINGS.PIG_GUARD_TALK_LOOKATWILSON[2] = '来啊互相伤害啊'
        STRINGS.PIG_GUARD_TALK_LOOKATWILSON[3] = '我将带头装逼'
        STRINGS.PIG_GUARD_TALK_TORCH[1] = '想偷塔没门'
        STRINGS.PIG_GUARD_TALK_TORCH[2] = '来啊互相伤害啊'
        STRINGS.PIG_GUARD_TALK_TORCH[3] = '我将带头装逼'
        STRINGS.PIG_TALK_ATTEMPT_TRADE[1] = '来一发py交易'
        STRINGS.PIG_TALK_ATTEMPT_TRADE[2] = '色情主播我报警了'
        STRINGS.PIG_TALK_EAT_MEAT[1] = '外卖送的及时给个好评'
        STRINGS.PIG_TALK_EAT_MEAT[2] = '没放地沟油吧'
        STRINGS.PIG_TALK_FIGHT[1] = '来啊互相伤害啊'
        STRINGS.PIG_TALK_FIGHT[2] = '我将带头装逼'
        STRINGS.PIG_TALK_FIGHT[3] = '专注打野二十年'
        STRINGS.PIG_TALK_FIND_LIGHT[1] = '我的24K钛合金猪眼'
        STRINGS.PIG_TALK_FIND_LIGHT[2] = '强力围观主播装逼'
        STRINGS.PIG_TALK_FIND_LIGHT[3] = '谁在那里装逼如此耀眼'
        STRINGS.PIG_TALK_FIND_LIGHT[4] = '吓死本宝宝了'
        STRINGS.PIG_TALK_FIND_LIGHT[5] = '电费又省下了'
        STRINGS.PIG_TALK_FIND_MEAT[1] = '哥喜欢地沟油'
        STRINGS.PIG_TALK_FIND_MEAT[2] = '一定是小草莓味的'
        STRINGS.PIG_TALK_FIND_MEAT[3] = '听说你很清真'
        STRINGS.PIG_TALK_FIND_MEAT[4] = '啊好想吃猪肉'
        STRINGS.PIG_TALK_FOLLOWWILSON[1] = '咋了又在外面受欺负了'
        STRINGS.PIG_TALK_FOLLOWWILSON[2] = '你不就是想把我喂疯么'
        STRINGS.PIG_TALK_FOLLOWWILSON[3] = '听说你智商比我还低'
        STRINGS.PIG_TALK_FOLLOWWILSON[4] = '想要py交易么'
        STRINGS.PIG_TALK_GO_HOME[1] = '等我回家出中亚的'
        STRINGS.PIG_TALK_GO_HOME[2] = '导员查寝了'
        STRINGS.PIG_TALK_HELP_CHOP_WOOD[1] = '树人有种给我出来'
        STRINGS.PIG_TALK_HELP_CHOP_WOOD[2] = '看我咸猪手'
        STRINGS.PIG_TALK_HELP_CHOP_WOOD[3] = '猪蹄儿大的拳头'
        STRINGS.PIG_TALK_LOOKATWILSON[1] = '哪儿来的小学生'
        STRINGS.PIG_TALK_LOOKATWILSON[2] = '发现野生青铜渣'
        STRINGS.PIG_TALK_LOOKATWILSON[3] = '就你这水平洗洗睡吧'
        STRINGS.PIG_TALK_LOOKATWILSON[4] = '咋的想solo啊'
        STRINGS.PIG_TALK_PANIC[1] = '丑八怪能否别把灯打开'
        STRINGS.PIG_TALK_PANIC[2] = '我看到提莫了'
        STRINGS.PIG_TALK_PANIC[3] = '妹子我要妹子'
        STRINGS.PIG_TALK_PANICFIRE[1] = '快成烤乳猪了'
        STRINGS.PIG_TALK_PANICFIRE[2] = '已经五分熟了'
        STRINGS.PIG_TALK_PANICFIRE[3] = '已经八分熟了'
        STRINGS.PIG_TALK_RUN_FROM_SPIDER[1] = '伊莉丝就是个渣渣'
        STRINGS.PIG_TALK_RUN_FROM_SPIDER[2] = '让哥教你怎么无伤打野'
        STRINGS.PIG_TALK_RUN_FROM_SPIDER[3] = '虐蜘蛛就跟虐菜一样'
        STRINGS.PIG_TALK_RUNAWAY_WILSON[1] = '救命非礼啦'
        STRINGS.PIG_TALK_RUNAWAY_WILSON[2] = '这人连猪都不放过'
        STRINGS.PIG_TALK_RUNAWAY_WILSON[3] = '不要这样我还是个孩子'
        STRINGS.PIG_TALK_RUNAWAY_WILSON[4] = '我跟你什么仇什么怨'
        local charNames = {
            "霜月",
            "翼语",
            "MdCoco99",
            "老崔",
            "幻影",
            "丰艺",
            "天地",
            "红猪",
            "豪猪",
            "龙肥",
            "DDK",
            "故事",
            "碧可",
            "老苗",
            "董者里",
            "陡壁",
            "深辰",
            "老宁",
            "司徒",
            "小川",
            "安猫",
            "呆萌",
            "煎蛋",
            "顾顾",
            "小热",
            "叶小吉",
        }
        if not STRINGS.PIGNAMES then
            STRINGS.PIGNAMES = {}
        end
        if not STRINGS.BUNNYMANNAMES then
            STRINGS.BUNNYMANNAMES = {}
        end
        if not STRINGS.MERMNAMES then
            STRINGS.MERMNAMES = {}
        end
        if not STRINGS.PARROTNAMES then
            STRINGS.PARROTNAMES = {}
        end
        if not STRINGS.SHIPNAMES then
            STRINGS.SHIPNAMES = {}
        end
        for i = 1, 200 do
            STRINGS.PIGNAMES[i] = charNames[(i - 1) % #charNames + 1]
            STRINGS.BUNNYMANNAMES[i] = charNames[(i - 1) % #charNames + 1]
            STRINGS.MERMNAMES[i] = charNames[(i - 1) % #charNames + 1]
            STRINGS.PARROTNAMES[i] = charNames[(i - 1) % #charNames + 1]
            STRINGS.SHIPNAMES[i] = charNames[(i - 1) % #charNames + 1] .. "号"
        end
    end
    STRINGS.NAMES.GARENWILTON = "学委"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENWILTON = "好贱的东西"
    STRINGS.NAMES.GARENMEMBERRIDER = "恐怖骑兵"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMEMBERRIDER = "真挫"
    STRINGS.LOLCRIT = "暴击"
    STRINGS.LOLTAUNT = "嘲讽"
    GLOBAL.LOLMEMBERBUSINESSTALK = {
        "要来发清爽的py交易么",
        "花生瓜子饮niao矿泉水",
        "出售脑残片脑残片",
        "订阅mod时给个好评哈",
        "出售苍老师全集要的mmmmm",
        "节操包月套餐，买就送主播内裤一条",
        "我看你骨骼惊奇，要来包辣条么",
        "哎我当NPC我容易么",
        "老酸奶三氯奶粉地沟油有售",
        "想定制mod可以找天地哦"
    }
    STRINGS.NAMES.GARENMENGXIN = "萌新"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMENGXIN = "我有萌新恐惧症"
    GLOBAL.LOLMENGXIN = {
        "主播今年多大",
        "主播这游戏哪里下载",
        "主播哪儿的人",
        "主播我不会玩怎么办",
        "主播在哪儿订阅的mod",
        "主播怎么订阅mod",
        "主播这是什么人物",
        "主播海难出联机版了吗",
        "主播这是联机吗",
        "主播为什么我老死",
        "主播为什么我箱子不能写字",
        "再不理我你会失去本宝宝的",
        "主播这是什么游戏",
        "主播这是mod么",
        "主播小切怎么升级",
        "主播能开摄像头么",
        "主播为什么我活不过10天",
        "主播不理人",
        "主播那个胖蜜蜂怎么得的",
        "主播春季BOSS怎么打",
        "主播夏季BOSS怎么打",
        "主播秋季BOSS怎么打",
        "主播冬季BOSS怎么打",
        "主播这个游戏好难",
        "主播有群么",
        "主播你结婚了么",
        "主播你有女朋友么",
        "主播你有网盘么",
        "主播你玩联机吗",
        "主播网盘地址是多少",
        "主播破解版哪里下载",
        "主播为什么我一玩就崩溃",
        "主播为什么我一进去就崩溃",
        "主播春天怎么过",
        "主播夏天怎么过",
        "主播秋天怎么过",
        "主播冬天怎么过",
        "主播打海妖啊",
        "主播打虎鲨啊",
        "主播章鱼哥在哪儿",
        "主播你不看弹幕啊",
        "主播我找不到猪王怎么办",
        "主播怎么汉化",
        "主播怎么才能不被饿死",
        "主播你一个月工资多少",
        "主播你一个月赚多少",
        "点歌$大悲咒",
        "点歌$威风堂堂",
        "主播能给我个房管么",
        "主播你胖不胖",
        "主播你多少斤",
        "主播你为什么不玩联机",
        "主播你就玩这一个游戏？",
        "主播每天玩这个不腻么",
        "主播能不能换个游戏",
        "主播怎么点歌",
        "主播为什么不理我",
        "主播为什么不回答我问题",
        "主播你玩到几点啊",
        "主播几点下播",
        "主播通宵么",
        "主播几点睡",
        "我去看其他主播玩了",
        "主播真会玩",
        "2333",
        "6666666",
        "主播你开心就好",
        "主播你是不是傻",
        "主播这个mod不好玩",
        "主播我想看玩莎莉",
        "主播我想看玩翼语",
        "主播我来了想没想我",
        "主播你爱我么",
        "主播这个游戏怎么玩",
        "主播为什么我看不到我弹幕",
        "主播为什么我这黑屏",
        "主播为什么我看你直播老卡",
        "主播你游戏哪儿买的",
        "主播请珍惜自己的直播间",
        "色情主播我报警啦",
        "主播再不理我我就取消关注了",
        "主播我是不是很烦啊",
        "有本事你打死我啊",
        "我从单机穿越来就是为了烦死你们",
        "我要烦死你!烦死你!",
        "求主播心理阴影部分面积",
        "主播猪王能杀吗",
        "主播mod怎么解压",
        "主播你真菜B",
        "主播这个BGM叫什么",
    }
    GLOBAL.LOLPIGKING = {
        "劳资有的是钱",
        "有钱任性",
        "人丑没关系有钱就行了",
        "我不想说我是头猪",
        "我的全名叫做比尔盖茨·猪王",
        "能不能别老怼俺",
        "跟哥混保你吃香喝辣",
        "饥荒里就数俺最有钱",
        "俺其实是世界首富",
        "中国大妈都去哪儿了",
        "俺钱多的银行都存不下来",
        "拿去吧不用找了",
        "年轻银好好工作别没事老怼俺",
        "俺今年打算竞选国民干爹",
        "你这肉不是注水肉吧",
        "俺钱多的都走不动道了",
        "要不是太胖俺早就站起来走两步了"
    }
    STRINGS.NAMES.GARENMEMBERBUSINESSMAN = "商人"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMEMBERBUSINESSMAN = "一看就不是个好东西"
    TUNING.LOLMEMBER.TALK71 = "友谊的小船说翻就翻"
    STRINGS.NAMES.GARENSMALLBOSS = "小动物"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSMALLBOSS = "好想抓一只玩玩"
    STRINGS.NAMES.GARENTREASURECHEST = "卖"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENTREASURECHEST = "节操满满"
    STRINGS.GARENMEMBERBUSINESSMANTITLE = '卖东西扔我旁边箱子里'
    STRINGS.GARENDESTORY = '销毁'
    STRINGS.GARENSELL = '卖掉'
    STRINGS.LOLENOMOUS = '巨型'
    STRINGS.LOLDL1 = '劣质'
    STRINGS.LOLDL2 = '普通'
    STRINGS.LOLDL3 = '精良'
    STRINGS.LOLDL4 = '稀有'
    STRINGS.LOLDL5 = '卓越'
    STRINGS.LOLDL6 = '完美'
    STRINGS.LOLDL7 = '史诗'
    STRINGS.LOLDL8 = '传说'
    STRINGS.LOLDL9 = '远古'
    STRINGS.LOLDL10 = '不朽'
    STRINGS.LOLDL11 = '圣物'
    STRINGS.LOLDL12 = '神赐'
    STRINGS.NAMES.GARENSLOT_MACHINE = "奸商赌博机"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENSLOT_MACHINE = "又是个坑钱的设定"
    STRINGS.GARENMEMBERBUSINESSMANSLOT = '赌一次花%s$'
    STRINGS.GARENMEMBERBUSINESSMANSLOTYES = '赌呗'
    STRINGS.GARENMEMBERBUSINESSMANSLOTNO = '拉倒'
    STRINGS.LOLPROFICIENCY = '武器熟练度%s'
    STRINGS.NAMES.GARENHAMMER = "韧化器"
    STRINGS.RECIPE_DESC.GARENHAMMER = "永久提升装备30点耐久"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENHAMMER = "信不信我打死你"
    TUNING.LOLMEMBER.TALK72 = '这附近放不下'
    TUNING.LOLMEMBER.TALK73 = '基地附近没空地方'
    TUNING.LOLMEMBER.TALK74 = '甩技能'
    TUNING.LOLMEMBER.TALK75 = '取消'
    STRINGS.TD1MADAO_GRASS_CHECK = "草"
    STRINGS.NAMES.GARENWIZARD = "法师"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENWIZARD = "切后排啊SB"
    STRINGS.NAMES.GARENMEMBERAMBASSADOR = "使者"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMEMBERAMBASSADOR = "我不太想和这货谈判"
    STRINGS.NAMES.GARENRANDOMCREATURE = "杀马特"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENRANDOMCREATURE = "现在的年轻银咋都这样捏"
    STRINGS.TD1MADAOAMBASSADOR_AGREE = "给钱"
    STRINGS.TD1MADAOAMBASSADOR_WAIT = "等等"
    STRINGS.TD1MADAOAMBASSADOR_NEGOTIATION = "谈判"
    STRINGS.TD1MADAOAMBASSADOR_NEGOTIATION_CONTENT = "%s军队将对你发动全面进攻.\n如果你给出5000$,\n我们可以签一个和平协议\n保证20天内你不会受到任何%s成员的主动攻击\n除了亡灵,%s的骑兵步兵法师和ADC以及雇佣的杀马特军团都都不会主动攻击你\n\n但是,如果期间你主动攻击了%s成员,协议将会废弃"
    TUNING.LOLMEMBER.TALK76 = '符文'
    TUNING.LOLMEMBER.TALK77 = '定制mod'
    STRINGS.NAMES.GARENRUNEITEM = "符文"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENRUNEITEM = "我喜欢这个表情"
    STRINGS.NAMES.GARENMEMBERN = TUNING.LOLMEMBER.noxusmem
    STRINGS.NAMES.GARENMEMBERD = TUNING.LOLMEMBER.demaciamem
    TUNING.LOLMEMBER.TALK78 = '介绍'
    TUNING.LOLMEMBER.TALK79 = '\n\n\n作者：td1madao(天地一madao)\nQQ：360810498\t\t\temail：td1madao@163.com\n接受单/联机模组订单\n支付宝:18506823312\t\t\tpaypal:wo4li2wang@gmail.com'
    TUNING.LOLMEMBER.TALK80 = '定制'
    TUNING.LOLMEMBER.TALK81 = '皮肤'
    TUNING.LOLMEMBER.TALK82 = '开启mod人物购买更多皮肤'
    TUNING.LOLMEMBER.TALK83 = '购买'
    TUNING.LOLMEMBER.TALK84 = '使用'
    TUNING.LOLMEMBER.TALK85 = '你个屎胖纸'
    TUNING.LOLMEMBER.TALK86 = '你个萝莉控'
    TUNING.LOLMEMBER.TALK87 = '你还敢趁火打劫'
    TUNING.LOLMEMBER.TALK88 = '给老娘站住'
    STRINGS.NAMES.GARENMODCHAR = "路人???"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMODCHAR = "两个活宝"
    GLOBAL.LOLXIAORETALK = {
        "都是洗衣粉的锅",
        "呜呜呜呜我不开心",
        "被热死是bug!是bug!"
    }
    STRINGS.NAMES.GARENXIAORE = "被热死的小热"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENXIAORE = "我...啥也没看见\n啥也没看见"
    STRINGS.NAMES.GAREN_SY = "霜猪猪"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GAREN_SY = "这发型多少钱弄的"
    GLOBAL.LOLSYTALK = {
        "无敌是多么多么寂寞",
        "无敌是多么多么空虚",
    }
    TUNING.LOLMEMBER.TALK89 = "倍化术"
    TUNING.LOLMEMBER.TALK90 = "影分身之术"
    TUNING.LOLMEMBER.TALK91 = "螺旋丸"
    TUNING.LOLMEMBER.TALK92 = "替身术"
    GLOBAL.LOLPIGKINGATTACK = {
        "敢打月关的子民",
        "小东西真是不要命了",
        "你以为我是摆设啊",
        "猪猪这么萌你也忍心打",
        "你以为月关猪王是白当的么",
        "你个畜生连猪都不放过",
    }
    TUNING.LOLMEMBER.TALK95 = "不约"
    TUNING.LOLMEMBER.TALK93 = "看什么看\n一边凉快去"
    TUNING.LOLMEMBER.TALK94 = "看什么看\n没见过这么帅的猪吗"
    STRINGS.NAMES.GARENGUNPOWDER = "火药"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENGUNPOWDER = "这也行?"

    TUNING.LOLPIGKINGSTOMACHACHE = {
        "这肉是注水肉",
        "啊肚子好疼",
        "不行我憋不住了",
        "这屁好臭"
    }
    STRINGS.NAMES.X_MARKS_SPOT_GAREN = "隐藏的宝藏"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.X_MARKS_SPOT_GAREN = "作者想要搞什么鬼"
    TUNING.TD1MADAOGAMESKILL = {
        "装备可以塞宝石强化\n六种宝石强化属性各不相同",
        "不要和一群敌人站撸，否则会死的很惨",
        "敌人法师很脆但也很危险\n他懂得召唤亡灵",
        "骑兵用于保护ADC和法师\n他懂得嘲讽敌人",
        "奸商卖东西价格会有波动",
        "建议开启莎莉或者翼语mod",
        "可以和使者谈判结盟\n腾出时间建家防敌",
        "可以买其他mod人物皮肤\n需要开启对应的人物mod",
        "可以使用莎莉和翼语的专属\n开启这两个mod即可",
        "人物玩腻了可以切换其他人物玩\n目前只支持天地制作的人物",
        "玩玩黑暗英雄和幻幻的龙骑士\n挑战一下游戏难度嘛",
        "人物可以跳墙\n右键围墙试试",
        "魄罗越吃越大\n可以慢慢喂它",
        "后期生物都有一定护甲\n穿透伤害很重要",
        "怎么赚钱？做任务",
        "小心敌人拆家",
        "可以制作司南石传送回基地",
        "可以买些漂亮的人物皮肤",
        "有位移技能的人物其实很难玩哦",
        "玩玩天堂黑暗英雄龙骑士很有意思的",
        "这个mod削弱了护甲",
        "锅和冰箱容易生虫子",
        "对敌人帐篷不要手软",
        "可以烧掉敌人帐篷哦",
        "耗蓝角色注意猪村打蓝buff哈",
        "浆果地树上和箱子里有时会有埋伏",
        "可以打包友军帐篷作为防御措施",
        "敌人多时尽量引开或雇佣帮手",
        "签署合约争取建家时间",
        "地图上有随机宝藏哦",
        "建筑打包球可以打包建筑",
        "建议利用好队友打怪",
        "装备可以附魔\n让装备有自己的必杀技",
        "垃圾装备可以用科学仪器分解\n会出一些材料",
        "及时强化武器免得后面打不动怪",
        "灵活使用技能可以无伤打怪哦",
        "友军是很好的御敌手段\n善用友军",
        "黄金雇佣友军可以帮忙干活",
        "宝石添加燃料就是强化",
        "作者一直为自己mod坑不到人而感到苦恼",
        "物品品级颜色:白青绿粉金暗金",
        "武器除了打怪掉可以自制哦",
        "ALT点武器可以查看武器属性",
        "腾出格子雇佣的友军才能给你东西",
        "狗牙陷阱是个不错的御敌措施",
        "各种石头都可以修复武器",
        "武器附魔要谨慎\n只能附魔一次",
        "加点根据自己习惯\n每个属性都是有用的",
        "打死巨型怪物是有奖励的",
        "亡灵是没有护甲的生物，不过比较烦人",
        "猪王有时会失踪，你要地图上好好找找",
        "有的人物技能可以破坏建筑",
        "宝石可以给建筑染色哦",
        "工坊有mod的盗版下载地址",
        "制作附魔石可以给武器附魔",
        "麦斯威尔留声机可以恢复脑残",
        "人物专属箱子容量大一些",
        "定制人物mod找天地",
        "暗夜照明灯也可以生成友军\n和友军帐篷一样",
        "暗夜灯也可以生成友军\n速度比帐篷慢",
    }
    TUNING.LOLMEMBER.TALK96 = "需要%s$才能继续强化"
    TUNING.LOLMEMBER.TALK97 = '染色'
    TUNING.LOLMEMBER.TALK98 = '好多钱'
    TUNING.TD1MADAO_KRAMPUS = {
        "耍猴咯",
        "耍猴快来看",
        "看的客观赏点钱哈",
        "走过路过不要错过",
        "看官赏小的500$哈",
    }
    STRINGS.NAMES.GARENKRAMPUS = "耍猴卖艺的坎普斯"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENKRAMPUS = "看好你家的猴子"
    STRINGS.NAMES.GARENMONKEY = "猴子"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMONKEY = "看好你家的猴子"
    STRINGS.TD1MADAOKRAMPUS_NEGOTIATION = "耍猴卖艺的坎普斯"
    STRINGS.TD1MADAOKRAMPUS_NEGOTIATION_CONTENT = "大兄弟，我在你这耍猴这么久了\n你好歹赏点钱呗\n给我500$吧\n没钱俺和俺家猴子可就要发动本能了"
    STRINGS.TD1MADAOAMBASSADOR_REFUSE = "不给"
    STRINGS.NAMES.GARENMOSQUITOCOILS = "蚊香"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMOSQUITOCOILS = "我从未见过如此厚颜无耻之徒"
    STRINGS.RECIPE_DESC.GARENMOSQUITOCOILS = "天地牌蚊香"
    TUNING.LOLMEMBER.TALK99 = '我日你哥'
    TUNING.LOLMEMBER.TALK100 = "普通"
    TUNING.LOLMEMBER.TALK101 = "噩梦"
    TUNING.LOLMEMBER.TALK102 = "较难"
    TUNING.LOLMEMBER.TALK103 = "任务"
    TUNING.LOLMEMBER.TALK104 = "完成"
    TUNING.LOLMEMBER.TALK105 = "关闭"
end