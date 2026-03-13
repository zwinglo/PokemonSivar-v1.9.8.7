if $MKXP
  
 class Bitmap
   alias mkxp_draw_text draw_text

   def draw_text(x, y, width, height, text, align = 0)
     height = text_size(text).height
     mkxp_draw_text(x, y+4, width, height, text, align)
   end
 end
end

def pbSetSystemFont(bitmap)
  fontname=MessageConfig.pbGetSystemFontName()
  bitmap.font.name=fontname
  if fontname=="Pokemon FireLeaf" || fontname=="Power Red and Green"
    bitmap.font.size=29
  elsif fontname=="Pokemon Emerald Small" || fontname=="Power Green Small"
    bitmap.font.size=25
  else
    if $MKXP
      bitmap.font.size=29
    else
      bitmap.font.size=31
    end
  end
end