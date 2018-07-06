var current=0;

$('#prev').on('click',function(){
    current-=1;
    if(current<0){current=6}
    $('#sushiList li').eq(current).fadeIn();
    $('#sushiList li').eq(current).siblings().fadeOut();
    
})

$('#next').on('click',function(){
    current+=1;
    if(current>6){current=0}
   sushi();
})


function sushi(){
   $('#sushiList li').eq(current).fadeIn();
    $('#sushiList li').eq(current).siblings().fadeOut();
 
    
}