% Constant Parameters
p1 = +4.251e-5;
p2 = -3.029e-4;
p3 = +3.024e-5;
Vdd= 15;
Vdd_interval = Vdd:-0.3:Vdd/1.5;

% Images path
images.list_1.dir = dir(fullfile('./misc/', '*.tiff'));

% Initialize some values
images.list_1.original_power = zeros(1, length(images.list_1.dir));

% Image set 1
for index = 1:length(images.list_1.dir)
    % Load images
    image_path = strcat(images.list_1.dir(index).folder, '/', images.list_1.dir(index).name);
    images.list_1.rgb_image{index} = imread(image_path);
    images.list_1.name = images.list_1.dir(index).name;
    % Compute original power consumption
    images.list_1.original_power(index) = P_panel(p1, p2, p3, Vdd, images.list_1.rgb_image{index});
end

distortion = zeros(3,length(Vdd_interval));
P_reduction = zeros(3,length(Vdd_interval));


for k = 1:length(images.list_1.dir)
    image_base = images.list_1.rgb_image{k};
    I_image_base = I_panel(p1, p2, p3, Vdd, image_base);
    P_image_base = P_panel(p1, p2, p3, Vdd, image_base);

    image_base_rgb = uint8(displayed_image(I_image_base, Vdd, 1));

    index = 1;
    
    %Brightness compensation
    for Vdd_new = Vdd_interval
        b = (Vdd/Vdd_new - 1)/2;
        % Image transformed
        image_transformed = brightness_compensation(image_base_rgb, b);
        % Panel current and power of image transformed
        I_image_transformed = I_panel(p1, p2, p3, Vdd_new, image_transformed);
        P_image_transformed(index) = P_panel(p1, p2, p3, Vdd_new, image_transformed);
        % Actual displayed image transformed
        image_transformed_displayed = uint8(displayed_image(I_image_transformed, Vdd_new, 1));
        % Power reduction between original and transformed
        P_reduction(1,index) =  P_reduction(1,index) + ((P_image_base - P_image_transformed(index))/P_image_base)*100;
        % Distortion between original and transformed displayed images
        distortion(1,index) = distortion(1,index) + (1 - ssim(image_base_rgb, image_transformed_displayed)) *100;
        %disp("Vdd_new: " + Vdd_new +" b: " + b + " P: " + P_image_transformed(index) + "P_reduction: " + P_reduction(1,index) + " distortion: " + distortion(1,index));        

        index = index + 1;
    end
    
    % Contrast enhanchement
    index = 1;
    for Vdd_new = Vdd_interval
        b = Vdd/Vdd_new;
        % Image transformed
        image_transformed = contrast_enhanchement(image_base_rgb, b);
        % Panel current and power of image transformed
        I_image_transformed = I_panel(p1, p2, p3, Vdd_new, image_transformed);
        P_image_transformed(index) = P_panel(p1, p2, p3, Vdd_new, image_transformed);
        % Actual displayed image transformed
        image_transformed_displayed = uint8(displayed_image(I_image_transformed, Vdd_new, 1));
        % Power reduction between original and transformed
        P_reduction(2,index) = P_reduction(2,index) + ((P_image_base - P_image_transformed(index))/P_image_base)*100;
        % Distortion between original and transformed displayed images
        distortion(2,index) = distortion(2,index) + (1 - ssim(image_base_rgb, image_transformed_displayed))*100;
        %disp("Vdd_new: " + Vdd_new +" b: " + b + " P: " + P_image_transformed(index) + "P_reduction: " + P_reduction(2,index) + " distortion: " + distortion(2,index));        

        index = index + 1;
    end
    
    % Combined
    index = 1;
    for Vdd_new = Vdd_interval
        b = Vdd_new/Vdd;
        % Image transformed
        image_transformed = combined_transformation(image_base_rgb, b, Vdd, Vdd_new);
        % Panel current and power of image transformed
        I_image_transformed = I_panel(p1, p2, p3, Vdd_new, image_transformed);
        P_image_transformed(index) = P_panel(p1, p2, p3, Vdd_new, image_transformed);
        % Actual displayed image transformed
        image_transformed_displayed = uint8(displayed_image(I_image_transformed, Vdd_new, 1));
        % Power reduction between original and transformed
        P_reduction(3,index) = P_reduction(3,index) + ((P_image_base - P_image_transformed(index))/P_image_base)*100;
        % Distortion between original and transformed displayed images
        distortion(3,index) = distortion(3,index) + (1 - ssim(image_base_rgb, image_transformed_displayed))*100;
        %disp("Vdd_new: " + Vdd_new +" b: " + b + " P: " + P_image_transformed(index) + "P_reduction: " + P_reduction(3,index) + " distortion: " + distortion(3,index));        
        %figure(index);
        %imshow(uint8(displayed_image(I_image_transformed, Vdd_new, 1)));

        index = index + 1;
    end
end

for index = 1 : length(Vdd_interval)
    distortion(1,index) = distortion(1,index) / (length(Vdd_interval)-1);
    distortion(2,index) = distortion(2,index) / (length(Vdd_interval)-1);
    distortion(3,index) = distortion(3,index) / (length(Vdd_interval)-1);

    P_reduction(1,index) = P_reduction(1,index) / (length(Vdd_interval)-1);
    P_reduction(2,index) = P_reduction(2,index) / (length(Vdd_interval)-1);
    P_reduction(3,index) = P_reduction(3,index) / (length(Vdd_interval)-1);
end

figure(1)
plot(Vdd_interval, P_reduction(1,:), 'b')
hold on 
plot(Vdd_interval, distortion(1,:), 'g')
legend("Power reduction %", "Distortion %");
xlabel("Vdd [V]");
title("Brightness compensation");

figure(2)
plot(Vdd_interval, P_reduction(2,:), 'b')
hold on 
plot(Vdd_interval, distortion(2,:), 'g')
legend("Power reduction %", "Distortion %");
xlabel("Vdd [V]");
title("Contrast Enhanchement");

figure(3)
plot(Vdd_interval, P_reduction(3,:), 'b')
hold on 
plot(Vdd_interval, distortion(3,:), 'g')
legend("Power reduction %", "Distortion %");
xlabel("Vdd [V]");
title("Combined");

% Compute the total power consumption of the panel
function P_panel = P_panel(p1, p2, p3, Vdd, rgb_image)
    P_panel = sum(Vdd * sum(sum(I_panel(p1, p2, p3, Vdd, rgb_image))));
end

% Compute the single current components of each cell
function I_cell = I_cell(p1, p2, p3, Vdd, D_rgb)
    I_cell = ((p1 * Vdd * D_rgb) / 255) + ((p2 * D_rgb) / 255) + p3;
end

% Compute the total current of the panel
function I_panel = I_panel(p1, p2 ,p3, Vdd, rgb_image)
    I_panel = zeros(length(rgb_image(:,1,1)), length(rgb_image(:,1,1)), 3);
    for i = 1 : (length(rgb_image(:,1,1)))
        for j = 1 : (length(rgb_image(1,:,1)))
            I_panel(i,j,:) = (I_cell(p1, p2, p3, Vdd, double(rgb_image(i,j,:))));
        end       
    end
end

% ----------------------------------------
function out = displayed_image(I_cell, Vdd, mode)

SATURATED = 1;
DISTORTED = 2;

p1 =   4.251e-05;
p2 =  -3.029e-04;
p3 =   3.024e-05;
Vdd_org = 15;

I_cell_max = (p1 * Vdd * 1) + (p2 * 1) + p3;
image_RGB_max = (I_cell_max - p3)/(p1*Vdd_org+p2) * 255;

out = round((I_cell - p3)/(p1*Vdd_org+p2) * 255);

if (mode == SATURATED)
    out(find(I_cell > I_cell_max)) = image_RGB_max;

else if (mode == DISTORTED)
        out(find(I_cell > I_cell_max)) ...
        = round(255 - out(find(I_cell > I_cell_max)));
        
    end
end

end

% Brightness compensation routine
function out = brightness_compensation(image, b)
    hsv_image = rgb2hsv(image);
    for i = 1:(length(image(:,1,1)))
        for j = 1:(length(image(1,:,1)))
            hsv_image(i,j,3) = hsv_image(i,j,3) + b;
            if hsv_image(i,j,3) > 1.0 
                hsv_image(i,j,3) = 1.0;
            elseif hsv_image(i,j,3) < 0
                hsv_image(i,j,3) = 0.0;
            end
        end
    end
    out = im2uint8(hsv2rgb(hsv_image));
end

% COntrast enhanchement routine
function out = contrast_enhanchement(image, b)
    hsv_image = rgb2hsv(image);
    for i = 1:(length(image(:,1,1)))
        for j = 1:(length(image(1,:,1)))
            hsv_image(i,j,3) = hsv_image(i,j,3) / b;
            if hsv_image(i,j,3) > 1.0 
                hsv_image(i,j,3) = 1.0;
            elseif hsv_image(i,j,3) < 0
                hsv_image(i,j,3) = 0.0;
            end
        end
    end
    
    out = im2uint8(hsv2rgb(hsv_image));
end

% Combined transformations
function out = combined_transformation(image, b, Vdd, Vdd_new)
    gl = -((1 - Vdd/Vdd_new)/2 * (Vdd_new/Vdd));
    gu = (b) + gl;
    
    if ( gl > 1 ) 
        gl=1; 
    elseif(gl < 0) 
        gl=0; 
    end
    if (gu > 1) 
        gu=1; 
    elseif(gu < 0) 
        gu=0; 
    end
    
    c = 1/(gu - gl);
    d = -(gl/(gu-gl));
    
    hsv_image = rgb2hsv(image);
    
    for i = 1:(length(image(:,1,1)))
        for j = 1:(length(image(1,:,1)))
            if hsv_image(i,j,3)<=gl
                hsv_image(i,j,3) = 0;
            elseif hsv_image(i,j,3)>=gu
                hsv_image(i,j,3) = 1;
            else
                hsv_image(i,j,3) = c*hsv_image(i,j,3) + d;
            end
        end
    end
    
    out = im2uint8(hsv2rgb(hsv_image));
end
