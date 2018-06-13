var setobj="";
var setstyletype="";
var settag="";
function HideShow(obj) { 
    var theobj=document.getElementById(obj);
    //alert(theobj.style.display);
    if(theobj.style.display=="none"){ 
        theobj.style.display="";
    } else{
        theobj.style.display="none";
    }    
}
function PreviewAll(obj) { 
    var theobj=document.getElementById(obj+'-aff-sys');
    var thelbl=document.getElementById(obj+'-aff-sys-lbl');
    //alert(theobj.style.height);
    if(theobj.style.height=="12px"){ 
        theobj.style.height="100%";
        thelbl.style.backgroundColor="#8BCBE0";
    } else{
        theobj.style.height="12px";
        thelbl.style.backgroundColor="#1797C0";
    }    
}
function colorPageBlock(pageblock, color) {
    if (pageblock != null) pageblock.firstChild.style.cssText = "background-color: " + color + ";";
}