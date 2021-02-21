bbg1 = double(imread("data4/BackgroundImg01.jpg"));
bbg2 = double(imread("data4/BackgroundImg02.jpg"));
cp1 =  double(imread("data4/CompositeImg01.jpg"));
cp2 =  double(imread("data4/CompositeImg02.jpg"));

%%extract rgb each photo.
%%Backgroundimg1
br1 = (bbg1(:,:,1));
bg1 = (bbg1(:,:,2));
bb1 = (bbg1(:,:,3));

%%Backgroundimg2
br2 = (bbg2(:,:,1));
bg2 = (bbg2(:,:,2));
bb2 = (bbg2(:,:,3));

%%Compositeimg1
cr1 = (cp1(:,:,1));
cg1 = (cp1(:,:,2));
cb1 = (cp1(:,:,3));

%%Compositeimg2
cr2 = (cp2(:,:,1));
cg2 = (cp2(:,:,2));
cb2 = (cp2(:,:,3));

%%calculate alpha
p1 = (cr1 - cr2) .* (br1-br2);
p2 = (cg1 - cg2) .* (bg1-bg2);
p3 = (cb1 - cb2) .* (bb1-bb2);
o1 = (br1 - br2).^2;
o2 = (bg1 - bg2).^2;
o3 = (bb1 - bb2).^2;
x = p1 + p2 + p3;
y = o1 + o2 + o3;
z = x ./ y;
alpha = 1 - z;

%%calculate foreground
fr = ((cr1 - ((1-alpha).*br1))./alpha); 
fg = ((cg1 - ((1-alpha).*bg1))./alpha);
fb = ((cb1 - ((1-alpha).*bb1))./alpha);


%%create white background
mask = ones(size(bbg1));
mask(:,:) = 255;

%%composte 
cir = alpha .* fr + (1-alpha) .* mask(:,:,1);
cig = alpha .* fg + (1-alpha) .* mask(:,:,2);
cib = alpha .* fb + (1-alpha) .* mask(:,:,3);

%%creat new image with white brackground
img_new2 = cat(3,uint8(cir),uint8(cig),uint8(cib));
imwrite(img_new2, "result_white_background.jpg","jpg");
figure;
imshow(img_new2);

%%composte with new backgroud
%%import background
nb = double(imread("data4/NewBackground01.jpg"));

%%extract rgb
nbr = nb(:,:,1);
nbg = nb(:,:,2);
nbb = nb(:,:,3);

%%composte 
cir = alpha .* fr + (1-alpha) .* nbr;
cig = alpha .* fg + (1-alpha) .* nbg;
cib = alpha .* fb + (1-alpha) .* nbb;

%%creat new image with new brackground
img_new3 = cat(3,uint8(cir),uint8(cig),uint8(cib));
imwrite(img_new3, "result_new_background.jpg","jpg");
figure;
imshow(img_new3);
