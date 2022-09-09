function doLike(pid , uid){
    console.log(pid + "," +  uid );
    
    //now will create an object to send information through ajax \
    const d = {
        uid : uid ,
        pid : pid ,
        operation : 'like'
    };

    $.ajax({
        url: "LikedServlet" ,
        data : d  ,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            // jaise user Like Button Click karega parralley yha value update hojygi
            if( data.trim() === 'true'){
                let c = $('#'+pid).html();
                c++;
                $('#'+pid).html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}