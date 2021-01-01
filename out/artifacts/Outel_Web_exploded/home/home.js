function clearInput(nameInput) {
    const input = document.getElementById(nameInput);
    inp.value = "";
}

function showClear(nameInput, nameClear) {
    return;
    const input = document.getElementById(nameInput);
    const clear = document.getElementById(nameClear);
    if(input.value.length !== 0) {
        clear.style.visibility = "visible";
    } else {
        clear.style.visibility = "collapse";
    }

}

function inputChoice(nameBorder, nameInput, nameClear) {
    const border = document.getElementById(nameBorder);
    border.style.border = "1px solid #53A1FF";
    border.style.height = "43px";
    border.style.background = "#FFFFFF";
    const input = document.getElementById(nameInput);
    input.style.background = "#FFFFFF";
    if(input.value.length !== 0) {
        const clear = document.getElementById(nameClear);
        clear.style.visibility = "visible";
    }
}

function inputunChoice(nameBorder, nameInput, nameClear) {
    const border = document.getElementById(nameBorder);
    border.style.border = "0px";
    border.style.height = "45px";
    border.style.background = "#EBEEF0";
    const input = document.getElementById(nameInput);
    input.style.background = "#EBEEF0";
    const clear = document.getElementById(nameClear);
    clear.style.visibility = "collapse";
}

function RightBottomBarClick(name) {
    var t=document.getElementById(name);
    var tb=document.getElementById(name + 'Button');
    var s=window.getComputedStyle(t).marginBottom;
    var start = s.substring(0, s.length - 2);
    if(start >= 0) {
        // startTransform(name + 'Button', 0, 0);
        tb.style.transform = "rotate(0deg)";
        startMover(name, -403, 1);
    } else {
        // startTransform(name + 'Button', 180, 0);
        tb.style.transform = "rotate(180deg)";
        startMover(name, 0, 1);
    }
}

function startMover(name, to, speed){
    var t = document.getElementById(name);
    timer = setInterval(function(){
    var now = window.getComputedStyle(t).marginBottom.substring(0, window.getComputedStyle(t).marginBottom.length - 2);
    if(now == to){
     clearInterval(timer);
     return;
    }
    else{
        if(now > to) {
            now = Number(now) - 1;
        } else {
            now = Number(now) + 1;
        }
        t.style.marginBottom = now+'px';
     }
    },speed);
   }


   // 有 BUG 懒得修了
   function startTransform(name, to, speed){
    var t = document.getElementById(name);
    timer = setInterval(function(){
    var now = getmatrix(window.getComputedStyle(t).transform);
    if(now == to){
     clearInterval(timer);
     return;
    }
    else{
        if(now > to) {
            now = Number(now) - 1;
        } else {
            now = Number(now) + 1;
        }
        t.style.transform = "rotate(" + now + 'deg)';
     }
    },speed);
   }

   // 工具函数，将旋转坐标转换为deg角度
   function getmatrix(matrix){  
    var matrixList = (matrix.substring(7, matrix.length - 1)).split(',');
    var a = matrixList[0];
    var b = matrixList[1];
    var c = matrixList[2];
    var d = matrixList[3];
    var aa=Math.round(180*Math.asin(a)/ Math.PI);  
    var bb=Math.round(180*Math.acos(b)/ Math.PI);  
    var cc=Math.round(180*Math.asin(c)/ Math.PI);  
    var dd=Math.round(180*Math.acos(d)/ Math.PI);  
    var deg=0;  
    if(aa==bb||-aa==bb){  
        deg=dd;  
    }else if(-aa+bb==180){  
        deg=180+cc;  
    }else if(aa+bb==180){  
        deg=360-cc||360-dd;  
    }  
    return deg>=360?0:deg;  
    //return (aa+','+bb+','+cc+','+dd);  
}  