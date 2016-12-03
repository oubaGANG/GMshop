$(function () {
    //为大预览图的图片地址赋值
    $('.bimg').attr('src',$('.simg').attr('src'))
    var big=$('.zoomDiv')//存放大图的盒子
    var bimg=$('.bimg')//大图片
    var small=$('.s_box')//存放小图的盒子
    var sw=small.width()//这也是小图片的宽度
    var float=$('.zoomMask')//放大镜

    small.hover(function (e) {
        float.show()
        big.show()

    },function () {
        float.hide()
        big.hide()
    })
    //移动事件
    small.mousemove(function (e) {
        //放大镜
        var left=e.pageX-small.offset().left-float.width()/2
        var top=e.pageY-small.offset().top-float.height()/2
        if(left<0)left=0

        if(left>small.width()-float.width()){
            left=small.width()-float.width()
        }
        if(top<0)top=0
        if(top>small.height()-float.height()){
            top=small.height()-float.height()
        }

        var bleft=(bimg.width()*3-big.width())/(sw-float.width())*left
        var btop= (bimg.height()*3-big.height())/($('.s_box img').height()-float.height())*top

        //alert(float.height())
        float.css({
            'left':left,
            'top':top
        })
        bimg.css({
            'left':-bleft,
            'top':-btop
        })


    })
})


















