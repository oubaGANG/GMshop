$(function () {
    $('.pmenu').hover(function () {
        $(this).find('span').show()
    },function () {
        $(this).find('span').hide()
    })
    $('.pmenu').click(function () {
       var url=$(this).attr('data-url');//用于获取地址
        var title=$(this).find('b').text();//用于写title
       if ($('#tabs').tabs('exists',title)) {
            $('#tabs').tabs('select',title);
        }else {
            $('#tabs').tabs('add', {
                title: title,
                iconCls: 'icon-'+url,
                closable: true,
                href: "manager/"+url + '.jsp',
            })
        }
    })

    $('#tabs').tabs({
        fit : true,
        border : false,
    });

});















































