var xx,yy,col;

col = false //if a collision has occurred
xx = argument0//x translation
yy = argument1//y translation

if yy > 0 
    {
    repeat(yy)
        {
        if place_free(x,y+1) {y+=1}
        else {col=true}
        }
    }
else if yy < 0
    {
    repeat(-yy)
        {
        if place_free(x,y-1) {y-=1}
        else {col=true}
        }
    }



if xx > 0 
    {
    repeat(xx)
        {
        if place_free(x+1,y) {x+=1}
        else {col=true}
        }
    }
else if xx < 0
    {
    repeat(-xx)
        {
        if place_free(x-1,y) {x-=1}
        else {col=true}
        }
    }
    
return col;
    
