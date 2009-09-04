function toggle(elm) {
 var newDisplay = "none";
 elm.style.background = 'url(css/folder-closed.gif)';

 var e = elm.nextSibling; 
 while (e != null) {
  if (e.tagName == "OL" || e.tagName == "ol") {
   if (e.style.display == "none") {
    newDisplay = "block";
    elm.style.background = 'url(css/folder-open.gif)';
   }
   break;
  }
  e = e.nextSibling;
 }

 while (e != null) {
  if (e.tagName == "OL" || e.tagName == "ol") e.style.display = newDisplay;
  e = e.nextSibling;
 }

}


function collapseAll() {
 var lists = document.getElementsByTagName("ol");
 for (var i = 0; i < lists.length; i++) 
  lists[i].style.display = "none";
 e = document.getElementById("root");
 e.style.display = "block";
}

function openBookMark() {
 var h = location.hash;
 if (h == "") h = "default";
 if (h == "#") h = "default";
 var ids = h.split(/[#.]/);
 for (i = 0; i < ids.length; i++) {
  if (ids[i] != "") toggle(document.getElementById(ids[i]));
 }
}
