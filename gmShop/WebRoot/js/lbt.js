$(function () {
	  //全局变量，用于记录当前index
    var nowIndex=1;
    var imgWidth=$('#img img').width()//图片的宽度
 
    //把第一个克隆放在最后，用于无缝滚动
    var lastImg=$('#img img').eq(0).clone()
    $('#img').append(lastImg)
    var imgLength=$('#img img').length

    //移动方法
    function move(num) {
            $('#img').animate({
                left:-num*imgWidth
            })
             $('#adv a').eq(num).addClass('active').siblings().removeClass('active')
    }
    //定义定时器，开始向做移动
    var timer=setInterval(leftMove,3000)
//自动向左移动
    function leftMove() {
        if(nowIndex==imgLength-1){
            $('#adv a').eq(0).addClass('active').siblings().removeClass('active')
        }
      //如果到最后一个,
        if(nowIndex==imgLength){
        
            //立马改变left，用css肉眼看不到变化，解决无缝链接,
            $('#img').css('left','0px')
            nowIndex=1
        }
        //调用move()移动
        move(nowIndex)
        nowIndex++
    }

    //手动点击移动
    $('#adv a').click(function () {

        var num=$(this).index()//当前点击的下标
        nowIndex=num
        move(nowIndex)

    })

    $('.content_top').hover(function () {
        //鼠标移入，清除定时器
        clearInterval(timer)
    },function () {
        //移出，恢复定时器
        timer=setInterval(leftMove,3000)
    }) 
})


















