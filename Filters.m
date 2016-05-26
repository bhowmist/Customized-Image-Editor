function Filters (ImgIn, ImgOut)

    [m, n, d] = size(ImgIn);
    %G = uint8( zeros( m, n, 3));

    for x = 1 : m
        for y = 1 : n
            ImgOut(x, y, 1) = 50;%(ImgIn(x, y, 1) * 0.393) + (ImgIn(x, y, 2) * 0.769) + (ImgIn(x, y, 3) * 0.189);
            ImgOut(x, y, 2) = 100;%(ImgIn(x, y, 1) * 0.349) + (ImgIn(x, y, 2) * 0.686) + (ImgIn(x, y, 3) * 0.168);
            ImgOut(x, y, 3) = 200;%(ImgIn(x, y, 1) * 0.272) + (ImgIn(x, y, 2) * 0.534) + (ImgIn(x, y, 3) * 0.131);
        end
    end
    