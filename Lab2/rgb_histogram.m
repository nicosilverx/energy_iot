%figure(1);
%rgb_histogram_f(image_base);
image_base = uint8(image_base);
P_image_base = power_consumption(image_base);
%figure(2);

%rgb_histogram_f(image_eq);



image_test = custom_man(image_base, 17);

(1 - ssim(image_base, image_test))*100

rgb_histogram_f(image_test);
P_test = power_consumption(image_test);

function image_transformed = custom_man(image, value)
    LOW_HIGH = stretchlim(image, [0.0001 0.9999]);
    image_transformed = imadjust(image, LOW_HIGH);
    image_transformed(:,:,3) = image_transformed(:,:,3) - value; 
end

function p = rgb_histogram_f(image)
    Red = image(:,:,1);
    Green = image(:,:,2);
    Blue = image(:,:,3);
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);
    p = plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
end

function P = power_consumption(image)
    y = 0.7755;
    w0 = 1.48169521e-6;
    wr = 2.13636845e-7;
    wg = 1.77746705e-7;
    wb = 2.14348309e-7;
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