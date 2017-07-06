mkdir reald_me_src_nb_$$
cd reald_me_src_nb_$$
git svn init file:///srv/svn/auto_stereo --no-minimize-url --ignore-paths="20140630_DemoForLeoAsia|Brookes|OKAO|optics\/|hw\/|metrology\/|uom\/staticlib|NanoBoard|AutoCal|wxPython|PlusPlus_Software|faceapi\/|rdcv\/data\/faces\/|obu\/|^branches" --trunk="trunk/src"  --tags="tags/*/*/src"
git svn fetch --authors-file=../authors.txt 
#-r8000:HEAD

