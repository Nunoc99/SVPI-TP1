function NMec = tp1_95167()

%% TP1 - SVPI -------------------------------------------------------
% Name:       Nuno Cunha
% Num. Mec:   95167
% Date:       05/03/2024
% -------------------------------------------------------------------

addpath '..\tp1_lib\' % functions folder path
addpath '..\'
close all; clear all;
clc

% displaying the nr mec
NumMec = 95167;
% disp(NumMec) % nr mec display

%% --------------- GETTING THE IMAGES FROM THE FOLDER ---------------------
% reading the images names from inside the folder
% img_list = dir('..\images\svpi2018_TP1_img_*_*.png');
img_list = dir('..\*_TP1_img_330_01.png');

NumSeq = 0;
NumImg = 0;

if isempty(img_list)
    % Display placeholder image
    disp('There are no images')
else

    % save the variables value in a txt file
    txt_file = 'tp1_95167.txt';  
    % open the file
    file = fopen(txt_file, 'w');

    % printing the images names
    for i = 1:size(img_list,1)

        % get the image file name
        img_name = img_list(i).name;
        disp(img_name);

        img_name_parts = split(img_name, '_');
        if size(img_name_parts, 1) >= 4
            NumSeq = str2double(img_name_parts{4});
            Num_Img = img_name_parts{5};

            Num_Img_parts = split(Num_Img, '.');
            NumImg = str2double(Num_Img_parts{1});
        end

        % % read the actual image
        % A = imread(fullfile('..\images', img_name));
        % figure(1)
        % imshow(A)
        % title(['Image ', num2str(i)])
        % pause(0.2)

        %% ----------------- TRAINING FOR ONE IMAGE AT TIME ----------------------- 
        % do the process to one and only one image
        % ############### ORIGINAL IMAGE ###############
        % A = im2double(imread('..\images\svpi2024_TP1_img_330_08.png'));
        A = im2double(imread(img_name));
        
        
        % ############### REVERSED ORIGINAL IMG ###############
        B = ~A;
        
        
        % ############### EDGE DETECTION ###############
        % [C, thresh] = edge(B, 'sobel', 0.3787, 'both'); % 0.3787
        [C, thresh] = edge(B, 'roberts', 0.4850); % 0.4050 to be able to fill all the squares
        
        
        % ############### CLEANING THE NOISE ###############
        % D = bwareaopen(C, 200); % 226
        D = bwareaopen(C, 320); % 300 funciona melhor com o roberts para dps poder 
        
        
        % ############### FILL THE SQUARES ###############
        E = imfill(D, 'holes');
        
        % fill the squares with white pixels to after it eliminate the interior and
        % get THE CLEANEST the frames of the squares
        s = regionprops(E, 'Centroid', 'BoundingBox');
        centroids = cat(1,s.Centroid); % object's centroids
        % bboxs = cat(1,s.BoundingBox); % object's bounding box SEM EFEITO !!!!!
        
        % delete the repeated centroids coordinates, they're useless
        uniqueCentroids = unique(centroids, 'rows');
        
        
        % ############### FINAL IMAGE ###############
        F = E - A; % to get the clear objects in the original image

        % h1 = figure(1);
        % set(h1, 'Position', [22 288 749 637], 'OuterPosition', [16 280 760 730])
        % subplot(2,3,1)
        % imshow(A)
        % title('Original Image')
        % 
        % subplot(2,3,2)
        % imshow(B)
        % title('Not A')
        % 
        % subplot(2,3,3)
        % imshow(C)
        % title('Edge Detection')
        % 
        % subplot(2,3,4)
        % imshow(D)
        % title('Delete small area pixels')
        % 
        % subplot(2,3,5)
        % imshow(E)
        % title('Filling some objects')
        % 
        % subplot(2,3,6)
        % imshow(F)
        % title('Clear objects')
        % 
        
        [L, N] = bwlabel(E);
        
        %% ######### Create an image for each object in the global image ##########
        total_nr_objs = size(uniqueCentroids, 1);
        
        % initialize variables
        TotNM = 0; % CHECK CORRECT
        TotCB = 0; % CHECK CORRECT
        TotQR = 0; % CHECK CORRECT
        R0 = 0; % CHECK WRONG
        R90 = 0; % CHECK CORRECT
        R180 = 0; % CHECK WRONG
        R270 = 0; % CHECK CORRECT
        ReflCB = 0; % CHECK CORRECT
        BadCB = 0; % CHECK CORRECT
        TotDigCB = 0; % CHECK CORRECT
        CBL = 0; % CHECK CORRECT
        CBR = 0; % CHECK CORRECT
        CBG = 0; % CHECK CORRECT
        StringCB = ''; % CHECK CORRECT
        
        % auxiliary variables
        GoodCB = 0; % auxiliar variable to maths
        refle1 = 0;
        refle2 = 0;
        refle3 = 0;
        L_counter = 0;
        R_counter = 0;
        G_counter = 0;
        SS=ceil(sqrt(N)); % professor's code to visualize each object
        % Fcorner = [1 1 0; 1 1 0; 0 0 0];
        % ve = 10;
        QRCode_filter = [0 0 0 0 0 0 0
                         0 1 1 1 1 1 0
                         0 1 0 0 0 1 0
                         0 1 0 0 0 1 0
                         0 1 0 0 0 1 0
                         0 1 1 1 1 1 0
                         0 0 0 0 0 0 0];
        
        QRCode = logical(QRCode_filter);
        
        for k=1:N
        
            obj_img = L == k;
            iso_obj_img = obj_img & F;
        
            % Get object bounding box directly from object mask
            stats = regionprops(obj_img, 'BoundingBox', 'Centroid');
            boundingBox = stats.BoundingBox;
            cs = cat(1,stats.Centroid);
        
            % Adjust bounding box coordinates to integers
            x_min = floor(boundingBox(1));
            y_min = floor(boundingBox(2));
            x_max = x_min + ceil(boundingBox(3));
            y_max = y_min + ceil(boundingBox(4));
        
            % each_obj_img = imcrop(iso_obj_img, [x - w/2, y - h/2, w, h]);
            each_obj_img = iso_obj_img(y_min:y_max, x_min:x_max);
        
            % visualization of each obj original
            % h = figure(2);
            % subplot(1,2,1)
            % imshow(each_obj_img);
            % title(['Each image object, k = ', num2str(k)]);
        
            % [rows, cols] = size(each_obj_img);
        
            
        
            % ########################## ERASE THE FRAME ##########################
        
            % create the padding to erase all object's frame
            padding = padarray(each_obj_img, [5 5], 1, 'both'); % 1 because we want to erase white pixels
        
            % eliminate the pixels of padding
            frameless = imclearborder(padding);
        
            % put it back to white bg
            original = ~frameless;
        
            [rows, cols] = size(original);
        
            % Find the first row with a pixel value of 0
            first_row = find(any(original == 0, 2), 1, 'first');
        
            % Find the last row with a pixel value of 0
            last_row = find(any(original == 0, 2), 1, 'last');
        
            % Find the first column with a pixel value of 0
            first_col = find(any(original == 0, 1), 1, 'first');
        
            % Find the last column with a pixel value of 0
            last_col = find(any(original == 0, 1), 1, 'last');
        
            % If no 0 pixel found, keep the original image
            if isempty(first_row) || isempty(last_row) || isempty(first_col) || isempty(last_col)
                cleaned_obj_img = original;
            else
                % Crop the image to the desired region
                cleaned_obj_img = original(first_row:last_row, first_col:last_col);
            end
        
            % ###################### ERASE SOME SMALL PIXELS ######################
            [r, c] = size(cleaned_obj_img);
        
            vector_1_top = cleaned_obj_img(1,1:end);
            vector_2_bottom = cleaned_obj_img(end, 1:end);
            vector_3_left = cleaned_obj_img(1:end, 1);
            vector_4_right = cleaned_obj_img(1:end, end);
        
            total_top_pix = sum(vector_1_top);
            total_bottom_pix = sum(vector_2_bottom);
            total_left_pix = sum(vector_3_left);
            total_right_pix = sum(vector_4_right);
        
            threshold = 0.90; % 80% para eliminar aqueles 1/2 pixels a mais
        
            % Remove top rows
            for l = 1:r
                if total_top_pix >= size(cleaned_obj_img, 2) * threshold
                    cleaned_obj_img(1,:) = []; % remove the row
                    % Update total_top_pix after removal
                    total_top_pix = sum(cleaned_obj_img(1,:));
                    r = r - 1; % Update number of rows
                else
                    break
                end
            end
        
            % Remove bottom rows
            for l = r:-1:1
                if total_bottom_pix >= size(cleaned_obj_img, 2) * threshold
                    cleaned_obj_img(end,:) = []; % remove the row
                    % Update total_bottom_pix after removal
                    total_bottom_pix = sum(cleaned_obj_img(end,:));
                    r = r - 1; % Update number of rows
                else
                    break
                end
            end
        
            % Remove leftmost columns
            for j = 1:c
                if total_left_pix >= size(cleaned_obj_img, 1) * threshold
                    cleaned_obj_img(:,1) = []; % remove the column
                    % Update total_left_pix after removal
                    total_left_pix = sum(cleaned_obj_img(:,1));
                    c = c - 1; % Update number of columns
                else
                    break
                end
            end
        
            % Remove rightmost columns
            for j = c:-1:1
                if total_right_pix >= size(cleaned_obj_img, 1) * threshold
                    cleaned_obj_img(:,end) = []; % remove the column
                    % Update total_right_pix after removal
                    total_right_pix = sum(cleaned_obj_img(:,end));
                    c = c - 1; % Update number of columns
                else
                    break
                end
            end
        
            % figure;
            % imshow(cleaned_obj_img)
            % hold on
        
        
            % ######################## BAR CODE DETECTION ######################
            % 'L' codification
            zeroL = [1 1 1 0 0 1 0];
            oneL = [1 1 0 0 1 1 0];
            twoL = [1 1 0 1 1 0 0];
            threeL = [1 0 0 0 0 1 0];
            fourL = [1 0 1 1 1 0 0];
            fiveL = [1 0 0 1 1 1 0];
            sixL = [1 0 1 0 0 0 0];
            sevenL = [1 0 0 0 1 0 0];
            eightL = [1 0 0 1 0 0 0];
            nineL = [1 1 1 0 1 0 0];
        
            % 'R' codification
            zeroR = [0 0 0 1 1 0 1];
            oneR = [0 0 1 1 0 0 1];
            twoR = [0 0 1 0 0 1 1];
            threeR = [0 1 1 1 1 0 1];
            fourR = [0 1 0 0 0 1 1];
            fiveR = [0 1 1 0 0 0 1];
            sixR = [0 1 0 1 1 1 1];
            sevenR = [0 1 1 1 0 1 1];
            eightR = [0 1 1 0 1 1 1];
            nineR = [0 0 0 1 0 1 1];
        
            % 'G' codification
            zeroG = [1 0 1 1 0 0 0];
            oneG = [1 0 0 1 1 0 0];
            twoG = [1 1 0 0 1 0 0];
            threeG = [1 0 1 1 1 1 0];
            fourG = [1 1 0 0 0 1 0];
            fiveG = [1 0 0 0 1 1 0];
            sixG = [1 1 1 1 0 1 0];
            sevenG = [1 1 0 1 1 1 0];
            eightG = [1 1 1 0 1 1 0];
            nineG = [1 1 0 1 0 0 0];
           
            barcode_init_seq = [0 0 1 0 1 1 0 1 1 1 0];
            barcode_end_seq = [0 1 1 1 0 0 0 1 0 1 0 0];
        
            start_seq = logical(barcode_init_seq);
            end_seq = logical(barcode_end_seq);
        
            % h2 = figure(2);
            % subplot( SS, SS, k)
            % imshow(cleaned_obj_img)
            % title('Each Object')
            % set(h2, 'Position', [773 288 771 637], 'OuterPosition', [765 280 787 730])
        
            L_decode = [];
            R_decode = [];
            G_decode = [];
            same_sequence = false; % auxiliary variable to not read the same sequence 2x
        
            for reflection = 1:3 
              for zoom = 1:4 % pq quero 1/1, 1/2, 1/3 e 1/4
                  for orientation = [0 90 180 270] % three possible cases
                      temp_img = cleaned_obj_img; % copied image
                      if reflection == 1
                          % fliplr
                          % reflected = fliplr(temp_img);
                          % reflected = flipud(temp_img);
                          % disp('Reflect 1')
                          reflected = temp_img;
                      elseif reflection == 2
                          % flipud
                          reflected = flipud(temp_img);
                          % reflected = fliplr(temp_img);
                          % reflected = temp_img;
                          % disp('Reflect 2')
                      elseif reflection == 3 
                          % reflected = temp_img;
                          % reflected = flipud(temp_img);
                          reflected = fliplr(temp_img);
                          % disp('Reflect 3')
                      end
                      
                      % correct_img_size = imresize(reflected, 1/zoom); % zoom = 1, 2, 3, 4 e 5
                      rotate_img = imrotate(reflected, -orientation);
                      correct_img_size = imresize(rotate_img, 1/zoom); % zoom = 1, 2, 3, 4 e 5
                      % X = ['k = ', num2str(k), ' scale = ', num2str(zoom), ' orientation = ', num2str(orientation), ' reflection = ', num2str(reflection)];
                      % disp(X)
        
                      if size(correct_img_size, 2) < (size(barcode_init_seq, 2) + size(barcode_end_seq, 2))
                          continue
                      end
        
                      if same_sequence
                          break
                      end

                      if size(correct_img_size, 1) < 10
                          continue
                      end
                      
                      % make the median to pick the most common value 
                      seq_completa = median(correct_img_size(1:10, :)); % to not start in the first line due to bad obj isolating
                      if isequal(seq_completa(1, 1:size(barcode_init_seq, 2)), start_seq)
                          % disp('SEQ INICIAL CHECK')
        
                          TotCB = TotCB + 1; % nr total de barcodes
            
                          if isequal(seq_completa(1, end-size(barcode_end_seq, 2)+1:end), end_seq)
                              % disp('SEQ FINAL CHECK')
        
                              % count the nr of objects in each orientation
                              if orientation == 0
                                  R0 = R0 + 1;
                              elseif orientation == 90
                                  R90 = R90 + 1;
                              elseif orientation == 180
                                  R180 = R180 + 1;
                              elseif orientation == 270
                                  R270 = R270 + 1;
                              end
        
                              same_sequence = true;
        
                              % imshow(rotate_img)
                              % xlabel('Barcode');
        
                              center_nrs = seq_completa(1,size(barcode_init_seq, 2)+1:end-size(barcode_end_seq, 2));
        
                              valid_cb = false;
          
                              % starting 'L', 'R' and 'G' decoding
                              for decode = 1:size(zeroL, 2):size(center_nrs, 2) % zero = 1:7:49
                                  sequence_to_decode = center_nrs(decode:decode+6); % to decode 7 digits at time
        
                                  % 'L' decoding
                                  if isequal(sequence_to_decode, zeroL)
                                      % disp('ZeroL')
                                      Lnr0 = 0;
                                      L_decode = [L_decode, Lnr0];
                                  elseif isequal(sequence_to_decode, oneL)
                                      % disp('OneL')
                                      Lnr1 = 1;
                                      L_decode = [L_decode, Lnr1];
                                  elseif isequal(sequence_to_decode, twoL)
                                      % disp('TwoL')
                                      Lnr2 = 2;
                                      L_decode = [L_decode, Lnr2];
                                  elseif isequal(sequence_to_decode, threeL)
                                      % disp('ThreeL')
                                      Lnr3 = 3;
                                      L_decode = [L_decode, Lnr3];
                                  elseif isequal(sequence_to_decode, fourL)
                                      % disp('FourL')
                                      Lnr4 = 4;
                                      L_decode = [L_decode, Lnr4];
                                  elseif isequal(sequence_to_decode, fiveL)
                                      % disp('FiveL')
                                      Lnr5 = 5;
                                      L_decode = [L_decode, Lnr5];
                                  elseif isequal(sequence_to_decode, sixL)
                                      % disp('SixL')
                                      Lnr6 = 6;
                                      L_decode = [L_decode, Lnr6];
                                  elseif isequal(sequence_to_decode, sevenL)
                                      % disp('SevenL')
                                      Lnr7 = 7;
                                      L_decode = [L_decode, Lnr7];
                                  elseif isequal(sequence_to_decode, eightL)
                                      % disp('EightL')
                                      Lnr8 = 8;
                                      L_decode = [L_decode, Lnr8];
                                  elseif isequal(sequence_to_decode, nineL)
                                      % disp('NineL')
                                      Lnr9 = 9;
                                      L_decode = [L_decode, Lnr9];
                                  end
        
                                  % verify if the size of L_decode matches right quantity
                                  % of nrs to do decode
                                  if size(L_decode, 2) == size(center_nrs, 2)/7
                                      % disp('If novo 1')
                                      GoodCB = GoodCB + 1; % just to do the math for the BadCB
                                      LMid_X = L_decode(ceil(size(L_decode, 2)/2));
                                      StringCB = sort([StringCB, num2str(LMid_X)]);
                                      CBL = CBL + 1;
                                      TotDigCB_1 = size(center_nrs, 2)/7;
                                      TotDigCB = TotDigCB + TotDigCB_1;
                                      valid_cb = true;
                                  end
        
                                  % 'R' decoding
                                  if isequal(sequence_to_decode, zeroR)
                                      % disp('ZeroR')
                                      Rnr0 = 0;
                                      R_decode = [R_decode, Rnr0];
                                  elseif isequal(sequence_to_decode, oneR)
                                      % disp('OneR')
                                      Rnr1 = 1;
                                      R_decode = [R_decode, Rnr1];
                                  elseif isequal(sequence_to_decode, twoR)
                                      % disp('TwoR')
                                      Rnr2 = 2;
                                      R_decode = [R_decode, Rnr2];
                                  elseif isequal(sequence_to_decode, threeR)
                                      % disp('ThreeR')
                                      Rnr3 = 3;
                                      R_decode = [R_decode, Rnr3];
                                  elseif isequal(sequence_to_decode, fourR)
                                      % disp('FourR')
                                      Rnr4 = 4;
                                      R_decode = [R_decode, Rnr4];
                                  elseif isequal(sequence_to_decode, fiveR)
                                      % disp('FiveR')
                                      Rnr5 = 5;
                                      R_decode = [R_decode, Rnr5];
                                  elseif isequal(sequence_to_decode, sixR)
                                      % disp('SixR')
                                      Rnr6 = 6;
                                      R_decode = [R_decode, Rnr6];
                                  elseif isequal(sequence_to_decode, sevenR)
                                      % disp('SevenR')
                                      Rnr7 = 7;
                                      R_decode = [R_decode, Rnr7];
                                  elseif isequal(sequence_to_decode, eightR)
                                      % disp('EightR')
                                      Rnr8 = 8;
                                      R_decode = [R_decode, Rnr8];
                                  elseif isequal(sequence_to_decode, nineR)
                                      % disp('NineR')
                                      Rnr9 = 9;
                                      R_decode = [R_decode, Rnr9];
                                  end
        
                                  % verify if the size of L_decode matches right quantity
                                  % of nrs to do decode
                                  if size(R_decode, 2) == size(center_nrs, 2)/7
                                      % disp('If novo 2')
                                      GoodCB = GoodCB + 1; % just to do the math for the BadCB
                                      RMid_X = R_decode(ceil(size(R_decode, 2)/2));
                                      StringCB = sort([StringCB, num2str(RMid_X)]);
                                      CBR = CBR + 1;
                                      TotDigCB_2 = size(center_nrs, 2)/7;
                                      TotDigCB = TotDigCB + TotDigCB_2;
                                      valid_cb = true;
                                  end
                                  
        
                                  % 'G' decoding
                                  if isequal(sequence_to_decode, zeroG)
                                      % disp('ZeroG')
                                      Gnr0 = 0;
                                      G_decode = [G_decode, Gnr0];
                                  elseif isequal(sequence_to_decode, oneG)
                                      % disp('OneG')
                                      Gnr1 = 1;
                                      G_decode = [G_decode, Gnr1];
                                  elseif isequal(sequence_to_decode, twoG)
                                      % disp('TwoG')
                                      Gnr2 = 2;
                                      G_decode = [G_decode, Gnr2];
                                  elseif isequal(sequence_to_decode, threeG)
                                      % disp('ThreeG')
                                      Gnr3 = 3;
                                      G_decode = [G_decode, Gnr3];
                                  elseif isequal(sequence_to_decode, fourG)
                                      % disp('FourG')
                                      Gnr4 = 4;
                                      G_decode = [G_decode, Gnr4];
                                  elseif isequal(sequence_to_decode, fiveG)
                                      % disp('FiveG')
                                      Gnr5 = 5;
                                      G_decode = [G_decode, Gnr5];
                                  elseif isequal(sequence_to_decode, sixG)
                                      % disp('SixG')
                                      Gnr6 = 6;
                                      G_decode = [G_decode, Gnr6];
                                  elseif isequal(sequence_to_decode, sevenG)
                                      % disp('SevenG')
                                      Gnr7 = 7;
                                      G_decode = [G_decode, Gnr7];
                                  elseif isequal(sequence_to_decode, eightG)
                                      % disp('EightG')
                                      Gnr8 = 8;
                                      G_decode = [G_decode, Gnr8];
                                  elseif isequal(sequence_to_decode, nineG)
                                      % disp('NineG')
                                      Gnr9 = 9;
                                      G_decode = [G_decode, Gnr9];
                                  end
        
                                  % verify if the size of L_decode matches right quantity
                                  % of nrs to do decode
                                  if size(G_decode, 2) == size(center_nrs, 2)/7
                                      % disp('If novo 3')
                                      GoodCB = GoodCB + 1; % just to do the math for the BadCB
                                      GMid_X = G_decode(ceil(size(G_decode, 2)/2));
                                      StringCB = sort([StringCB, num2str(GMid_X)]);
                                      CBG = CBG + 1;
                                      TotDigCB_3 = size(center_nrs, 2)/7;
                                      TotDigCB = TotDigCB + TotDigCB_3;
                                      valid_cb = true;
                                  end
        
                              end
        
                              % count the nr of objects in each reflection
                              % if reflection == 1
                              %     % refle1 = refle1 + 1;
                              
                              if valid_cb && or(reflection == 2, reflection == 3)
                                  ReflCB = ReflCB + 1;
                              end
                           
                              pause(0.1)
                          end
                      end
                  end
        
              end
            end
        
            % ######################## QR CODE DETECTION ######################
            for zoom_qr = 1:4
                temp_img_2 = temp_img;
                correct_img_size_qr = imresize(temp_img_2, 1/zoom_qr); 
        
                if size(correct_img_size_qr, 1) < 21
                    continue
                end
        
                qr_aux_counter = 0;
        
                for orientation_qr = [0 90 180 270]
                    rotate_qr = imrotate(correct_img_size_qr, orientation_qr);

                     if size(rotate_qr, 1) >= size(QRCode_filter, 1) && size(rotate_qr, 2) >= size(QRCode_filter, 2)
                         
                         if isequal(rotate_qr(1:size(QRCode, 1), 1:size(QRCode, 2)), QRCode_filter)
                            qr_aux_counter = qr_aux_counter + 1;
                         end
                         
                         continue
                     end
        
                    % if isequal(rotate_qr(1:size(QRCode, 1), 1:size(QRCode, 2)), QRCode_filter)
                    %     qr_aux_counter = qr_aux_counter + 1;
                    % end
                 end
        
                 if qr_aux_counter == 3
                     % xlabel('QR-Code')
                     TotQR = TotQR + 1;
                 end
            end
           
        end

        % variable results
        TotCB; % Nr total de objetos com códigos de barras
        TotNM = k - TotCB - TotQR; % Nr total de objetos sem significado, PARA JÁ
        BadCB = TotCB - GoodCB;
        
        % write in it
        fprintf(file,'%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%s \n', ... 
            NumMec, NumSeq, NumImg, TotNM, TotCB, TotQR, R0, R90, R180, R270, ReflCB, BadCB, TotDigCB, CBL, CBR, CBG, StringCB);
    end
end
NMec = NumMec;
end


