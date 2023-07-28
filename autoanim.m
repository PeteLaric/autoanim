% autoanim.m
% (cc) BY 2023-07-28 Pete Laric / www.PeteLaric.com
% An automated tool to create animated GIFs from a directory full of images.
% Currently set to look for .PNG images, but this can be easily altered.
% The core of this code was shamelessly stolen from:
%
%      https://electroagenda.com/en/create-gif-files-in-octave-and-matlab/
%
% However, I modified it to 1) work from image files rather than mathematical
% plots, and 2) scour a local directory for all such images, so you don't have
% to list them individually.  Combined with my autocrop tool, these two tools
% can be used to create animations from webcam screenshots with minimal effort.

clear all
clc

anim_filename = 'my_anim.gif'
DelayTime = 0.25 %Time in seconds for each plot in the GIF

system('ls *.png > list.txt')

fp = fopen('list.txt')

n = 1;

while (!feof(fp))
      
      image_number = n
      
      % load source image
      image_filename = fgets(fp);
      image_filename = strtrim(image_filename)
      im = imread(image_filename);
      
      % Transform RGB samples to 1 dimension with a color map "cm". 
      %%%%%[imind,cm] = rgb2ind(im); %crashes!
      if n == 1;
          % Create GIF file
          %%%%imwrite(imind,cm,anim_filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw'); %crashes!
          imwrite(im,anim_filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw');
      else
          % Add each new plot to GIF
          %%%%%imwrite(imind,cm,anim_filename,'gif','WriteMode','append','DelayTime', DelayTime , 'Compression' , 'lzw'); %crashes!
          imwrite(im,anim_filename,'gif','WriteMode','append','DelayTime', DelayTime , 'Compression' , 'lzw');
      end
      
      n = n + 1;
end

fclose(fp)

