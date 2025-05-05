image_files = dir('Testing_Set/*.jpg');

optic_csv = fopen('optic_disc_coordinates.csv', 'w');
fovea_csv = fopen('fovea_coordinates.csv', 'w');

fprintf(optic_csv, 'Image No,X- Coordinate,Y - Coordinate');
fprintf(fovea_csv, 'Image No,X- Coordinate,Y - Coordinate');
for j = 1:33
    fprintf(optic_csv, ',');
    fprintf(fovea_csv, ',');
end
fprintf(optic_csv, '\n');
fprintf(fovea_csv, '\n');

for i = 1:length(image_files)
    filename = image_files(i).name;
    img_name = erase(filename, '.jpg');
    img = imread(fullfile('Testing_Set', filename));

    gray = rgb2gray(img);
    se = strel('disk', 10);
    opened = imopen(gray, se);
    closed = imclose(opened, se);
    processed = imadjust(closed);

    [height, width] = size(processed);
    roi_width = round(width * 0.3);
    roi_height = round(height * 0.3);
    x0 = round(width/2 - roi_width/2);
    y0 = round(height/2 - roi_height/2);
    roi = imcrop(processed, [x0, y0, roi_width, roi_height]);

    min_val = min(roi(:));
    [y_f, x_f] = find(roi == min_val);
    x_f_center = round(median(x_f));
    y_f_center = round(median(y_f));
    xFovea = x0 + x_f_center;
    yFovea = y0 + y_f_center;

    red = img(:,:,1);
    red_eq = adapthisteq(red, 'ClipLimit', 0.01, 'Distribution', 'rayleigh');
    blurred = imgaussfilt(red_eq, 8);
    binary_img = blurred > 220;
    binary_cleaned = bwareaopen(binary_img, 200);
    stats = regionprops(binary_cleaned, 'Area', 'Centroid', 'Eccentricity');

    max_area = 0;
    optic_center = [];
    for k = 1:length(stats)
        if stats(k).Area > max_area && stats(k).Eccentricity < 0.8
            max_area = stats(k).Area;
            optic_center = stats(k).Centroid;
        end
    end

    fprintf(fovea_csv, '%s,%.2f,%.2f', img_name, xFovea, yFovea);
    for j = 1:33
        fprintf(fovea_csv, ',');
    end
    fprintf(fovea_csv, '\n');
    
    if ~isempty(optic_center)
        fprintf(optic_csv, '%s,%.2f,%.2f', img_name, optic_center(1), optic_center(2));
    else
        fprintf(optic_csv, '%s,,', img_name);
    end
    for j = 1:33
        fprintf(optic_csv, ',');
    end
    fprintf(optic_csv, '\n');
end

fclose(optic_csv);
fclose(fovea_csv);

disp('tamamlandı');
