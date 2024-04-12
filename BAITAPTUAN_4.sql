--Viết câu lệnh SQL để thực hiện các yêu cầu sau (mỗi yêu cầu chỉ được viết tối đa 1 câu lệnh SQL):
--Câu 1:Liệt kê MaDatPhong, MaDV, SoLuong của tất cả các dịch vụ có số
--lượng lớn hơn 1 và nhỏ hơn 10. (1 điểm)
SELECT *
    FROM CHI_TIET_SU_DUNG_DICH_VU 
WHERE (SoLuong > 1) AND (SoLuong < 10) 
--SoLuong BETWEN 4 AND 9
--Câu 2: Hiển thị TenKH của những khách hàng có tên bắt đầu là một trong
--các ký tự “H”, “N”, “M” và có độ dài tối đa là 20 ký tự. (1 điểm)
SELECT TenKH
    FROM KHACH_HANG 
WHERE TenKH LIKE '[HNM]%'
     AND LEN(TenKH) <= 20
--Câu 3: Hiển thị TenKH của tất cả các khách hàng có trong hệ thống, TenKH
--nào trùng nhau thì chỉ hiển thị một lần. Sinh viên sử dụng hai cách khác
--nhau để thực hiện yêu cầu trên, mỗi cách sẽ được 0,5 điểm. (1 điểm)
--C1
SELECT DISTINCT TenKH
   FROM  KHACH_HANG

--C2
SELECT  TenKH ,COUNT(MaKH) AS HIENTHI
   FROM KHACH_HANG 
GROUP BY TenKH

--Câu 4: Hiển thị MaDV, TenDV, DonViTinh, DonGia của những dịch vụ đi kèm
--có DonViTinh là “lon” và có DonGia lớn hơn 10,000 VNĐ hoặc những dịch vụ
--đi kèm có DonViTinh là “Cai” và có DonGia nhỏ hơn 5,000 VNĐ. (1 điểm)
SELECT *
  FROM DICH_VU_DI_KEM
WHERE DonViTinh  = 'lon' AND DonGia > 10000
    OR DonViTinh = 'cai' AND DonGia < 5000
--Câu 5: Hiển thị MaDatPhong, MaPhong, LoaiPhong, SoKhachToiDa,
--GiaPhong, MaKH, TenKH, SoDT, NgayDat, GioBatDau, GioKetThuc,
--MaDichVu, SoLuong, DonGia của những đơn đặt phòng có năm đặt phòng là
--“2016”, “2017” và đặt những phòng có giá phòng &gt; 50,000 VNĐ/ 1 giờ. (1
--điểm)
SELECT DISTINCT DP.MaDatPhong,P.MaPhong,P.LoaiPhong,P.SoKhachToiDa,P.[GiaPhong(1gio)],KH.MaKH,KH.TenKH,KH.DiaChi,DP.NgayDat,GioBatDau,GioKetThuc,DVDK.MaDV,CTSDDV.SoLuong,DVDK.DonGia
   FROM 
       KHACH_HANG AS KH
   INNER JOIN 
            DAT_PHONG AS DP
            ON KH.MaKH = DP.MaKH
   INNER JOIN 
            CHI_TIET_SU_DUNG_DICH_VU AS CTSDDV
            ON CTSDDV.MaDatPhong = DP.MaDatPhong
   INNER JOIN 
            PHONG AS P
            ON P.MaPhong = DP.MaPhong
   INNER JOIN 
            DICH_VU_DI_KEM AS DVDK
            ON DVDK.MaDV = CTSDDV.MaDV
WHERE YEAR(DP.NgayDat) = 2016 OR YEAR(DP.NgayDat) = 2017
      AND P.[GiaPhong(1gio)] = 50000
--Câu 6: Hiển thị MaDatPhong, MaPhong, LoaiPhong, GiaPhong, TenKH,
--NgayDat, TongTienHat, TongTienSuDungDichVu, TongTienThanhToan tương
--ứng với từng mã đặt phòng có trong bảng DAT_PHONG. Những đơn đặt
--phòng nào không sử dụng dịch vụ đi kèm thì cũng liệt kê thông tin
--của đơn đặt phòng đó ra. (1 điểm)
--TongTienHat = GiaPhong * (GioKetThuc – GioBatDau)
--TongTienSuDungDichVu = SoLuong * DonGia
SELECT DP.MaDatPhong,P.MaPhong,LoaiPhong,[GiaPhong(1gio)],KH.TenKH,DP.NgayDat,SUM (P.[GiaPhong(1gio)]) * (((DP.GioKetThuc) - (DP.GioBatDau))) AS TONG_TIEN_HAT,SUM( SoLuong * DonGia) AS TONG_TIEN_SU_DUNG_DICH_VU,SUM(SUM(P.[GiaPhong(1gio)]) * (((DP.GioKetThuc) - (DP.GioBatDau)))-SUM( SoLuong * DonGia)) AS TONG_TIEN_THANH_TOAN
     FROM 
       KHACH_HANG AS KH
   INNER JOIN 
            DAT_PHONG AS DP
            ON KH.MaKH = DP.MaKH
   INNER JOIN 
            CHI_TIET_SU_DUNG_DICH_VU AS CTSDDV
            ON CTSDDV.MaDatPhong = DP.MaDatPhong
   INNER JOIN 
            PHONG AS P
            ON P.MaPhong = DP.MaPhong
   LEFT JOIN 
            DICH_VU_DI_KEM AS DVDK
            ON DVDK.MaDV = CTSDDV.MaDV
GROUP BY DP.MaDatPhong,P.MaPhong,LoaiPhong,[GiaPhong(1gio)],KH.TenKH,DP.NgayDat
--Câu 7: Hiển thị MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, SoLanDat
--của những phòng được khách hàng đặt có số lần đặt lớn hơn 2 lần và trạng
--thái đặt là “Da dat”. (1 điểm)
SELECT P.MaPhong,KH.MaKH,P.LoaiPhong,SoKhachToiDa,[GiaPhong(1gio)],COUNT(DP.MaDatPhong) AS SOLANDAT
  FROM PHONG AS P
  INNER JOIN DAT_PHONG AS DP
      ON P.MaPhong = DP.MaPhong
  INNER JOIN KHACH_HANG AS KH
	      ON KH.MaKH = DP.MaKH
WHERE DP.TrangThaiDat = 'Da dat'
GROUP BY P.MaPhong,KH.MaKH,P.LoaiPhong,SoKhachToiDa,[GiaPhong(1gio)]
HAVING COUNT(DP.MaDatPhong) > 2
      

