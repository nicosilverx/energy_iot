image1 = imread('misc/immagine1.png');
image2 = imread('misc/immagine2.png');
image3 = imread('misc/immagine3.png');
image4 = imread('misc/immagine4.png');

% colored_image = imread('misc/4.1.01.tiff');

y = 0.7755;
w0 = 1.48169521e-6;
wr = 2.13636845e-7;
wg = 1.77746705e-7;
wb = 2.14348309e-7;

% image1_lab = rgb2lab(image1);
% image2_lab = rgb2lab(image2);
% image3_lab = rgb2lab(image3);
% image4_lab = rgb2lab(image4);
% 
% P1 = power_consumption(y, w0, wr, wg, wb, image1);
% P2 = power_consumption(y, w0, wr, wg, wb, image2);
% P3 = power_consumption(y, w0, wr, wg, wb, image3);
% P4 = power_consumption(y, w0, wr, wg, wb, image4);

% D1_2 = image_diff(image1_lab, image2_lab);
% D1_3 = image_diff(image1_lab, image3_lab);
% D1_4 = image_diff(image1_lab, image4_lab);
% D2_2 = image_diff(image2_lab, image2_lab);
% 
% D1_2_perc = (D1_2 / (256 * 256 * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
% D1_3_perc = (D1_3 / (256 * 256 * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
% D1_4_perc = (D1_4 / (256 * 256 * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
% D2_2_perc = (D2_2 / (256 * 256 * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;

%SSIM gives better results for monochromatic images (b&w)
% D1_2_ssim = ssim(image1, image2) * 100
% D1_3_ssim = ssim(image1, image3) * 100
% D1_4_ssim = ssim(image1, image4) * 100

% return_image = hungry_blue(colored_image, 10);
% %imshow(return_image)
% %ssim(colored_image, return_image)*100
% Y = histeq(colored_image);
% figure(1);
% imshow(colored_image);
% figure(2);
% imshow(Y);

% images_list = dir(fullfile(uigetdir(), '*.tiff'));
% for k = 1:length(images_list)
%    image_path = strcat(images_list(k).folder, '/', images_list(k).name);
%    image = imread(image_path);
%    initial_power = power_consumption(y, w0, wr, wg, wb, image);
%    
%    reduced_blue_image = hungry_blue(image, 100);
%    hist_image = histeq(image);
%    
%    reduced_blue_image_power = power_consumption(y, w0, wr, wg, wb, reduced_blue_image);
%    hist_image_power = power_consumption(y, w0, wr, wg, wb, hist_image);
%    
%    reduced_blue_diff = ssim(image, reduced_blue_image)*100;
%    hist_diff = ssim(image, hist_image)*100;
%    
%    fprintf(1,"Image: %s Power: %f | Hungry blue  Power: %f Distortion: %f | Hist  Power: %f Distortion: %f\n", images_list(k).name, initial_power, reduced_blue_image_power, reduced_blue_diff, hist_image_power, hist_diff);
%    
% end
% 

hungry_blue_values = 0:20:100;
%powers = zeros(1,100);
qualities = zeros(1,100);
quality_constrain = 1.0;
for k = hungry_blue_values
    image = imread('misc/4.1.01.tiff');
    initial_power = power_consumption(y, w0, wr, wg, wb, image);
    reduced_blue_image = hungry_blue(image, k);
    reduced_blue_image_power = power_consumption(y, w0, wr, wg, wb, reduced_blue_image);
    reduced_blue_diff = (1 - ssim(image, reduced_blue_image))*100;
    
    powers(1,mod(k/20,6)+1) = reduced_blue_image_power;
    qualities(1,mod(k/20,6)+1) = reduced_blue_diff;
    
end


% test_blue = ssim(colored_image, return_image)*100
% test_hist = ssim(colored_image, Y)*100

function P = power_consumption(y, w0, wr, wg, wb, image)
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    P = zeros(65536,1);
    for i = 1 : (length(image(:,1,1)))
        for j = 1 : (length(image(1,:,1)))
            R_component = double(R(i,j));
            G_component = double(G(i,j));
            B_component = double(B(i,j));
            index = i.*255 + j;
            P(index) = (wr * (R_component .^ y)) + (wg * (G_component .^ y)) + (wb * (B_component .^ y));
        end
    end 

    P = sum(P) + w0;
end

function D = image_diff(image1, image2)
    L_1 = image1(:,:,1);
    a_1 = image1(:,:,2);
    b_1 = image1(:,:,3);
    
    L_2 = image2(:,:,1);
    a_2 = image2(:,:,2);
    b_2 = image2(:,:,3);
    
    D = 0;
    for index = 1 : ((length(image1(:,1,1))) * (length(image2(:,1,1))))
        %i = mod(index, 256) + 1;
        %j = round(index / 256);
        L_diff = (L_1(index) - L_2(index)).^2;
        a_diff = (a_1(index) - a_2(index)).^2;
        b_diff = (b_1(index) - b_2(index)).^2;
        
        D = D + sqrt(L_diff + a_diff + b_diff);
    end
end

function transformed_image = hungry_blue(image, const)
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    for pixel = 1 : ((length(image(:,1,1))) * (length(image(:,1,1))))
       B(pixel) = B(pixel) - const; 
       if(B(pixel)<0)
           B(pixel)=0; 
       end
    end
    transformed_image = cat(3, R, G, B);
end