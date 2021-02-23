%Constant coefficients
y = 0.7755;
w0 = 1.48169521e-6;
wr = 2.13636845e-7;
wg = 1.77746705e-7;
wb = 2.14348309e-7;
% 
% %Images loading and initial power estimation
% 
image_list_1.dir = dir(fullfile('./misc/', '*.tiff'));
image_list_2.dir = dir(fullfile('./BSR/BSDS500/data/images/train/', '*.jpg'));
image_list_3.dir = dir(fullfile('./screenshots/', '*.JPG'));
white = imread("./misc/white.png");
black = imread("./misc/black.png");



image_list_1.original_power = zeros(1, length(image_list_1.dir));
image_list_1.hungry_blue_consumption = zeros(1, 5);
image_list_1.name = strings(1, length(image_list_1.dir));

image_list_2.original_power = zeros(1, length(image_list_2.dir));
image_list_2.name = strings(1, length(image_list_2.dir));

image_list_3.original_power = zeros(1, length(image_list_3.dir));
image_list_3.name = strings(1, length(image_list_3.dir));

for k = 1:length(image_list_1.dir)
    image_path = strcat(image_list_1.dir(k).folder, '/', image_list_1.dir(k).name);
    image = imread(image_path);
    image_list_1_rgb{k} = image;
    image_list_1.original_power(1,k) =  power_consumption(y, w0, wr, wg, wb, image);
    image_list_1.name(1,k) = image_list_1.dir(k).name;
end
% 
% for k = 1:length(image_list_2.dir)
%     image_path = strcat(image_list_2.dir(k).folder, '/', image_list_2.dir(k).name);
%     image = imread(image_path);
%     image_list_2_rgb{k} = image;
%     image_list_2.original_power(1,k) =  power_consumption(y, w0, wr, wg, wb, image);
%     image_list_2.name(1,k) = image_list_2.dir(k).name;
% end
% 
% for k = 1:length(image_list_3.dir)
%     image_path = strcat(image_list_3.dir(k).folder, '/', image_list_3.dir(k).name);
%     image = imread(image_path);
%     image_list_3_rgb{k} = image;
%     image_list_3.original_power(1,k) =  power_consumption(y, w0, wr, wg, wb, image);
%     image_list_3.name(1,k) = image_list_3.dir(k).name;
% end
% 
% 
% 
% Conversion to L*a*b space
parfor k = 1:length(image_list_1.dir)
    image_list_1_lab{k} = rgb2lab(image_list_1_rgb{k});
end
% 
% parfor k = 1:length(image_list_2.dir)
%     image_list_2_lab{k} = rgb2lab(image_list_2_rgb{k});
% end
% 
% parfor k = 1:length(image_list_3.dir)
%     image_list_3_lab{k} = rgb2lab(image_list_3_rgb{k});
% end
% 
% % Hungry-blue analysis
% 
% hungry_blue_values = 20:20:100;
% 
% for k = 1:length(image_list_1.dir)
%     for const = hungry_blue_values
%         transformed_image = hungry_blue(image_list_1_rgb{k}, const);
%         transformed_power_consumption(k,mod(const/20,6)) = power_consumption(y,w0,wr,wg,wb,transformed_image);
%         transformed_image_distortion(k,mod(const/20,6)) = (1 - ssim(image_list_1_rgb{k}, transformed_image))*100;
%         transformed_image_difference(k,mod(const/20,6)) = ((image_diff(image_list_1_lab{k}, rgb2lab(transformed_image)))/ (length(image_list_1_rgb{k}(:,1,1)) * length(image_list_1_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
%     end
%     image_list_1.hungry_blue_consumption(k,:) = transformed_power_consumption(k,:);
%     image_list_1.hungry_blue_distortion(k,:) = transformed_image_distortion(k,:);
%     image_list_1.hungry_blue_difference(k,:) = transformed_image_difference(k,:);
% end
% 
% for k = 1:length(image_list_2.dir)
%     for const = hungry_blue_values
%         transformed_image = hungry_blue(image_list_2_rgb{k}, const);
%         transformed_power_consumption(k,mod(const/20,6)) = power_consumption(y,w0,wr,wg,wb,transformed_image);
%         transformed_image_distortion(k,mod(const/20,6)) = (1 - ssim(image_list_2_rgb{k}, transformed_image))*100;
%         transformed_image_difference(k,mod(const/20,6)) = ((image_diff(image_list_2_lab{k}, rgb2lab(transformed_image)))/ (length(image_list_2_rgb{k}(:,1,1)) * length(image_list_2_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
%     end
%     image_list_2.hungry_blue_consumption(k,:) = transformed_power_consumption(k,:);
%     image_list_2.hungry_blue_distortion(k,:) = transformed_image_distortion(k,:);
%     image_list_2.hungry_blue_difference(k,:) = transformed_image_difference(k,:);
% end
% 
% for k = 1:length(image_list_3.dir)
%     for const = hungry_blue_values
%         transformed_image = hungry_blue(image_list_3_rgb{k}, const);
%         transformed_power_consumption(k,mod(const/20,6)) = power_consumption(y,w0,wr,wg,wb,transformed_image);
%         transformed_image_distortion(k,mod(const/20,6)) = (1 - ssim(image_list_3_rgb{k}, transformed_image))*100;
%         transformed_image_difference(k,mod(const/20,6)) = ((image_diff(image_list_3_lab{k}, rgb2lab(transformed_image)))/ (length(image_list_3_rgb{k}(:,1,1)) * length(image_list_3_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
%     end
%     image_list_3.hungry_blue_consumption(k,:) = transformed_power_consumption(k,:);
%     image_list_3.hungry_blue_distortion(k,:) = transformed_image_distortion(k,:);
%     image_list_3.hungry_blue_difference(k,:) = transformed_image_difference(k,:);
% end
% 
% figure(1)
% subplot(3,1,1)
% title("Image list 1 power consumptions");
% power_bar.image_list_1 = bar(categorical(image_list_1.name), [ image_list_1.original_power;image_list_1.hungry_blue_consumption.'] );
% legend("Original power consumption", "Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% subplot(3,1,2)
% title("Image list 2 power consumptions");
% power_bar.image_list_2 = bar(categorical(image_list_2.name),[ image_list_2.original_power;image_list_2.hungry_blue_consumption.'] );
% legend("Original power consumption", "Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% subplot(3,1,3)
% title("Image list 3 power consumptions");
% power_bar.image_list_3 = bar(categorical(image_list_3.name), [ image_list_3.original_power;image_list_3.hungry_blue_consumption.'] );
% legend("Original power consumption", "Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% 
% figure(2)
% subplot(3,1,1)
% title("Image list 1 distortion")
% quality_bar.image_list_1 = bar(categorical(image_list_1.name), [image_list_1.hungry_blue_distortion.'] );
% legend("Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% subplot(3,1,2)
% title("Image list 2 distortion")
% quality_bar.image_list_2 = bar(categorical(image_list_2.name), [image_list_2.hungry_blue_distortion.'] );
% legend("Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% subplot(3,1,3)
% title("Image list 3 distortion")
% quality_bar.image_list_3 = bar(categorical(image_list_3.name), [image_list_3.hungry_blue_distortion.'] );
% legend("Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% 
% figure(3)
% subplot(3,1,1)
% title("Image list 1 differences %")
% quality_bar.image_list_1 = bar(categorical(image_list_1.name), [image_list_1.hungry_blue_difference.'] );
% legend("Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% subplot(3,1,2)
% title("Image list 2 differences %")
% quality_bar.image_list_2 = bar(categorical(image_list_2.name), [image_list_2.hungry_blue_difference.'] );
% legend("Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% subplot(3,1,3)
% title("Image list 3 differences %")
% quality_bar.image_list_3 = bar(categorical(image_list_3.name), [image_list_3.hungry_blue_difference.'] );
% legend("Hungry blue - 20", "Hungry blue - 40", "Hungry blue - 60", "Hungry blue - 80", "Hungry blue - 100")
% 
% 
% for k = 1:length(image_list_1.dir)
%     original_power = image_list_1.original_power(1,k);
%     hungry_blue_powers = image_list_1.hungry_blue_consumption(k,:);
%     for i = 1:length(hungry_blue_powers)
%         image_list_1.reduced_power{k,i} = ((original_power - hungry_blue_powers(1,i)) / original_power)*100;
%     end
%     %image_list_1.mean_reduced_power{k,1} = mean(cell2mat(image_list_1.mean_reduced_power)) ;
% end
% %image_list_1.mean_total_reduced_power = mean(cell2mat(image_list_1.mean_reduced_power));
% 
% for k = 1:length(image_list_2.dir)
%     original_power = image_list_2.original_power(1,k);
%     hungry_blue_powers = image_list_2.hungry_blue_consumption(k,:);
%     for i = 1:length(hungry_blue_powers)
%         image_list_2.reduced_power{k,i} = ((original_power - hungry_blue_powers(1,i)) / original_power)*100;
%     end
%     %image_list_2.mean_reduced_power{k,1} = mean(cell2mat(image_list_2.reduced_power(k,:))) ;
% end
% %image_list_2.mean_total_reduced_power = mean(cell2mat(image_list_2.mean_reduced_power));
% 
% for k = 1:length(image_list_3.dir)
%     original_power = image_list_3.original_power(1,k);
%     hungry_blue_powers = image_list_3.hungry_blue_consumption(k,:);
%     for i = 1:length(hungry_blue_powers)
%         image_list_3.reduced_power{k,i} = ((original_power - hungry_blue_powers(1,i)) / original_power)*100;
%     end
%    % image_list_3.mean_reduced_power{k,1} = mean(cell2mat(image_list_3.reduced_power(k,:))) ;
% end
% %image_list_3.mean_total_reduced_power = mean(cell2mat(image_list_3.mean_reduced_power));
% 
% 
% image_list_1.mean_hungry_blue_20 = mean(cell2mat(image_list_1.reduced_power(:,1)));
% image_list_1.mean_hungry_blue_40 = mean(cell2mat(image_list_1.reduced_power(:,2)));
% image_list_1.mean_hungry_blue_60 = mean(cell2mat(image_list_1.reduced_power(:,3)));
% image_list_1.mean_hungry_blue_80 = mean(cell2mat(image_list_1.reduced_power(:,4)));
% image_list_1.mean_hungry_blue_100 = mean(cell2mat(image_list_1.reduced_power(:,5)));
% 
% image_list_2.mean_hungry_blue_20 = mean(cell2mat(image_list_2.reduced_power(:,1)));
% image_list_2.mean_hungry_blue_40 = mean(cell2mat(image_list_2.reduced_power(:,2)));
% image_list_2.mean_hungry_blue_60 = mean(cell2mat(image_list_2.reduced_power(:,3)));
% image_list_2.mean_hungry_blue_80 = mean(cell2mat(image_list_2.reduced_power(:,4)));
% image_list_2.mean_hungry_blue_100 = mean(cell2mat(image_list_2.reduced_power(:,5)));
% 
% image_list_3.mean_hungry_blue_20 = mean(cell2mat(image_list_3.reduced_power(:,1)));
% image_list_3.mean_hungry_blue_40 = mean(cell2mat(image_list_3.reduced_power(:,2)));
% image_list_3.mean_hungry_blue_60 = mean(cell2mat(image_list_3.reduced_power(:,3)));
% image_list_3.mean_hungry_blue_80 = mean(cell2mat(image_list_3.reduced_power(:,4)));
% image_list_3.mean_hungry_blue_100 = mean(cell2mat(image_list_3.reduced_power(:,5)));
% 
% 
% figure(4)
% subplot(3,1,1)
% title("Image list 1 Hungry Blue mean percentage power reduction")
% bar([20 40 60 80 100], [image_list_1.mean_hungry_blue_20 image_list_1.mean_hungry_blue_40 image_list_1.mean_hungry_blue_60 image_list_1.mean_hungry_blue_80 image_list_1.mean_hungry_blue_100] );
% yline(mean([image_list_1.mean_hungry_blue_20 image_list_1.mean_hungry_blue_40 image_list_1.mean_hungry_blue_60 image_list_1.mean_hungry_blue_80 image_list_1.mean_hungry_blue_100]), "-.b","Mean value");
% ylabel("Power reduction %");
% xlabel("Hungry blue value");
% 
% subplot(3,1,2)
% title("Image list 2 Hungry Blue mean percentage power reduction")
% bar([20 40 60 80 100], [image_list_2.mean_hungry_blue_20 image_list_2.mean_hungry_blue_40 image_list_2.mean_hungry_blue_60 image_list_2.mean_hungry_blue_80 image_list_2.mean_hungry_blue_100] );
% yline(mean([image_list_2.mean_hungry_blue_20 image_list_2.mean_hungry_blue_40 image_list_2.mean_hungry_blue_60 image_list_2.mean_hungry_blue_80 image_list_2.mean_hungry_blue_100]), "-.b","Mean value");
% ylabel("Power reduction %");
% xlabel("Hungry blue value");
% 
% subplot(3,1,3)
% title("Image list 3 Hungry Blue mean percentage power reduction")
% bar([20 40 60 80 100], [image_list_3.mean_hungry_blue_20 image_list_3.mean_hungry_blue_40 image_list_3.mean_hungry_blue_60 image_list_3.mean_hungry_blue_80 image_list_3.mean_hungry_blue_100] );
% yline(mean([image_list_3.mean_hungry_blue_20 image_list_3.mean_hungry_blue_40 image_list_3.mean_hungry_blue_60 image_list_3.mean_hungry_blue_80 image_list_3.mean_hungry_blue_100]), "-.b","Mean value");
% ylabel("Power reduction %");
% xlabel("Hungry blue value");


% Histogram equalization
% for k = 1:length(image_list_1.dir)
%     image_list_1_eq{k} = histeq(image_list_1_rgb{k});
%     image_list_1.im_eq_power_consumption(1,k) = power_consumption(y,w0,wr,wg,wb,image_list_1_eq{k});
%     image_list_1.im_eq_power_reduction(1,k) = ((image_list_1.original_power(1,k) - image_list_1.im_eq_power_consumption(1,k)) / image_list_1.original_power(1,k))*100;
%     image_list_1.im_eq_distortion(1,k) = (1 - ssim(image_list_1_rgb{k}, image_list_1_eq{k}))*100;
%     image_list_1.im_eq_difference(1,k) = ((image_diff(image_list_1_lab{k}, rgb2lab(image_list_1_eq{k}))) / (length(image_list_1_rgb{k}(:,1,1)) * length(image_list_1_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2)) )*100;
% end
% 
% for k = 1:length(image_list_2.dir)
%     image_list_2_eq{k} = histeq(image_list_2_rgb{k});
%     image_list_2.im_eq_power_consumption(1,k) = power_consumption(y,w0,wr,wg,wb,image_list_2_eq{k});
%     image_list_2.im_eq_power_reduction(1,k) = ((image_list_2.original_power(1,k) - image_list_2.im_eq_power_consumption(1,k)) / image_list_2.original_power(1,k))*100;
%     image_list_2.im_eq_distortion(1,k) = (1 - ssim(image_list_2_rgb{k}, image_list_2_eq{k}))*100;
%     image_list_2.im_eq_difference(1,k) = ((image_diff(image_list_2_lab{k}, rgb2lab(image_list_2_eq{k}))) / (length(image_list_2_rgb{k}(:,1,1)) * length(image_list_2_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2)) )*100;
% end
% 
% for k = 1:length(image_list_3.dir)
%     image_list_3_eq{k} = histeq(image_list_3_rgb{k});
%     image_list_3.im_eq_power_consumption(1,k) = power_consumption(y,w0,wr,wg,wb,image_list_3_eq{k});
%     image_list_3.im_eq_power_reduction(1,k) = ((image_list_3.original_power(1,k) - image_list_3.im_eq_power_consumption(1,k)) / image_list_3.original_power(1,k))*100;
%     image_list_3.im_eq_distortion(1,k) = (1 - ssim(image_list_3_rgb{k}, image_list_3_eq{k}))*100;
%     image_list_3.im_eq_difference(1,k) = ((image_diff(image_list_3_lab{k}, rgb2lab(image_list_3_eq{k}))) / (length(image_list_3_rgb{k}(:,1,1)) * length(image_list_3_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2)) )*100;
% end
% 
% figure(5)
% subplot(3,1,1)
% bar(categorical(image_list_1.name), image_list_1.im_eq_power_reduction);
% title("Image list 1 Histogram equalization percentage power reduction")
% yline(mean(image_list_1.im_eq_power_reduction),"-.b","Mean value");
% 
% subplot(3,1,2)
% bar(categorical(image_list_2.name), image_list_2.im_eq_power_reduction);
% title("Image list 2 Histogram equalization percentage power reduction")
% yline(mean(image_list_2.im_eq_power_reduction),"-.b","Mean value");
% 
% subplot(3,1,3)
% bar(categorical(image_list_3.name), image_list_3.im_eq_power_reduction);
% title("Image list 3 Histogram equalization percentage power reduction")
% yline(mean(image_list_3.im_eq_power_reduction),"-.b","Mean value");
% 
% 
% figure(6)
% subplot(3,1,1)
% bar(categorical(image_list_1.name), image_list_1.im_eq_distortion);
% title("Image list 1 Histogram equalization percentage distortion")
% yline(mean(image_list_1.im_eq_distortion),"-.b","Mean value");
% 
% subplot(3,1,2)
% bar(categorical(image_list_2.name), image_list_2.im_eq_distortion);
% title("Image list 2 Histogram equalization percentage distortion")
% yline(mean(image_list_2.im_eq_distortion),"-.b","Mean value");
% 
% subplot(3,1,3)
% bar(categorical(image_list_3.name), image_list_3.im_eq_distortion);
% title("Image list 3 Histogram equalization percentage distortion")
% yline(mean(image_list_3.im_eq_distortion),"-.b","Mean value");
% 
% 
% 
% figure(7)
% subplot(3,1,1)
% bar(categorical(image_list_1.name), image_list_1.im_eq_difference);
% title("Image list 1 Histogram equalization percentage difference")
% yline(mean(image_list_1.im_eq_difference),"-.b","Mean value");
% 
% subplot(3,1,2)
% bar(categorical(image_list_2.name), image_list_2.im_eq_difference);
% title("Image list 2 Histogram equalization percentage difference")
% yline(mean(image_list_2.im_eq_difference),"-.b","Mean value");
% 
% subplot(3,1,3)
% bar(categorical(image_list_3.name), image_list_3.im_eq_difference);
% title("Image list 3 Histogram equalization percentage difference")
% yline(mean(image_list_3.im_eq_difference),"-.b","Mean value");

% Best image manipulation given some constrains
avg_distortion = [0.01 0.5 0.10];

test_image_rgb = image_list_1_rgb{1};
test_image_lab = image_list_1_lab{1};
test_image_orginal_power = image_list_1.original_power(1);
test_image_min_power = inf;
test_image_eucl_diff_min = inf;
hungry_blue_value = -1;

% Euclidian difference
%   -Hungry blue
for k = 1:255
    transformed_image = hungry_blue(test_image_rgb, k);
    transformed_power_consumption(k) = power_consumption(y,w0,wr,wg,wb,transformed_image);
    transformed_image_difference(k) = image_diff(test_image_lab, rgb2lab(transformed_image));
    transformed_image_relative_difference(k) = (transformed_image_difference(k) / image_diff(rgb2lab(white),rgb2lab(black)));
    
    
    if(transformed_image_relative_difference(k) < avg_distortion(1))
        if(transformed_power_consumption(k) < test_image_orginal_power)
            disp(k)
            hungry_blue_value = k;
        end
    end
end


% for k = 1:length(image_list_1.dir)
%     for const = hungry_blue_values
%         transformed_image = hungry_blue(image_list_1_rgb{k}, const);
%         transformed_power_consumption(k,mod(const/20,6)) = power_consumption(y,w0,wr,wg,wb,transformed_image);
%         transformed_image_distortion(k,mod(const/20,6)) = (1 - ssim(image_list_1_rgb{k}, transformed_image))*100;
%         transformed_image_difference(k,mod(const/20,6)) = ((image_diff(image_list_1_lab{k}, rgb2lab(transformed_image)))/ (length(image_list_1_rgb{k}(:,1,1)) * length(image_list_1_rgb{k}(1,:,1)) * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;
%     end
%     image_list_1.hungry_blue_consumption(k,:) = transformed_power_consumption(k,:);
%     image_list_1.hungry_blue_distortion(k,:) = transformed_image_distortion(k,:);
%     image_list_1.hungry_blue_difference(k,:) = transformed_image_difference(k,:);
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%   Estimate the power consumption of an RGB, 8-bit image
%
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

%
%   Euclidian difference between two images
%
function D = image_diff(image1, image2)
    L_1 = image1(:,:,1);
    a_1 = image1(:,:,2);
    b_1 = image1(:,:,3);
    
    L_2 = image2(:,:,1);
    a_2 = image2(:,:,2);
    b_2 = image2(:,:,3);
    
    D = 0;
    for index = 1 : ((length(image1(:,1,1))) * (length(image2(1,:,1))))
        %i = mod(index, 256) + 1;
        %j = round(index / 256);
        L_diff = (L_1(index) - L_2(index)).^2;
        a_diff = (a_1(index) - a_2(index)).^2;
        b_diff = (b_1(index) - b_2(index)).^2;
        
        D = D + sqrt(L_diff + a_diff + b_diff);
    end
end

%
%   Hungry blue: subtract a constant value from each pixel
%
function transformed_image = hungry_blue(image, const)
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    for pixel = 1 : ((length(image(:,1,1))) * (length(image(1,:,1))))
        B(pixel) = B(pixel) - const; 
        if(B(pixel)<0)
           B(pixel)=0; 
        end
    end
    transformed_image = cat(3, R, G, B);
end