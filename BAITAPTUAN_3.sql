--Bài tập tuần 3
--Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ (0.5 điểm)
SELECT DongXe,HangXe,SoChoNgoi
   FROM DONGXE
WHERE SoChoNgoi > 5
--Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
--thuộc hãng xe "Toyota" với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
--thuộc hãng xe "KIA" với mức phí có đơn giá là 20.000 VNĐ/km (0.5 điểm)
SELECT DISTINCT NCC.*,DX.HangXe,MP.DonGia
   FROM NHACUNGCAP AS NCC
     INNER JOIN DANGKYCUNGCAP AS DKCC 
	        ON NCC.MaNhaCC = DKCC.MaNhaCC
     INNER JOIN DONGXE AS DX
            ON DKCC.DongXe = DX.DongXe
     INNER JOIN MUCPHI AS MP
	        ON DKCC.MaMP = MP.MaMP
WHERE (DX.HangXe = 'Toyota' and MP.DonGia = 15.000)
      OR (DX.HangXe = 'KIA' AND MP.DonGia = 20.000)
--Câu 5: Liệt kê thông tin của các dòng xe thuộc hãng xe có tên bắt đầu là ký tự "T" và có độ
--dài là 5 ký tự (0.5 điểm)
   SELECT  DongXe,HangXe
      FROM DONGXE
WHERE HangXe LIKE 'T%' 
     AND LEN(DongXe)= 5
--Câu 8: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
--chỉ được liệt kê một lần (0.5 điểm)     
SELECT DISTINCT HangXe
   FROM DONGXE
--Câu 9: Liệt kê MaDKCC, TenLoaiDV, TenNhaCC, DonGia, DongXe, HangXe,
--NgayBatDauCC, NgayKetThucCC, SoLuongXeDangKy của tất cả các lần đăng ký cung cấp
--phương tiện (0.5 điểm)
SELECT DISTINCT DKCC.MaDKCC,LDV.TenLoaiDV,NCC.TenNhaCC,MP.DonGia,DX.DongXe,HangXe,DKCC.NgayBatDauCungCap,NgayKetThucCungCap,SoLuongXeDangKy
   FROM DANGKYCUNGCAP AS DKCC
     INNER JOIN NHACUNGCAP AS NCC
	        ON DKCC.MaNhaCC = NCC.MaNhaCC
     INNER JOIN DONGXE AS DX
	        ON  DKCC.DongXe = DX.DongXe
     INNER JOIN MUCPHI AS MP
	        ON DKCC.MaMP = MP.MaMP
	INNER JOIN LOAIDICHVU AS LDV
	        ON DKCC.MaLoaiDV = LDV.MaLoaiDV

--Câu 6: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp 
--và giảm dần theo mã số thuế (0.5 điểm)
SELECT 
        NHACUNGCAP. *
     FROM 
	    NHACUNGCAP
ORDER BY 
        TenNhaCC ASC,
        MaSoThue DESC
      