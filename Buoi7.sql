--Buổi 7
--Ví dụ: Cho biết những nhà cung cấp đã từng đăng kí cung cấp
--IN/NOT IN
SELECT *
    FROM 
	       NHACUNGCAP
WHERE 
           MaNhaCC IN (
					     SELECT DISTINCT MaNhaCC
						    FROM DANGKYCUNGCAP )

--Câu 12: Liệt kê thông tin của  các nhà cung cấp 
--chưa từng thực hiện đăng kí cung cấP phương tiện lần nào(0.5 điểm)
--NOT IN
SELECT *
    FROM 
	       NHACUNGCAP 
WHERE 
           MaNhaCC NOT IN(
					       SELECT DISTINCT MaNhaCC
						      FROM DANGKYCUNGCAP )
      

--Câu 11:Liệt kê thông tin 
--các nhà cung cấp đã từng đăng ký cung cấp phương tiện 
--thuộc dòng xe 'Hiace' 
--hoặc từng đăng kí cung cấp phương tiện thuộc dòng xe "Cerato"
--IN ĐÃ TỪNG
SELECT *
   FROM NHACUNGCAP 
WHERE MaNhaCC IN (
        SELECT DISTINCT MaNhaCC
		  FROM DANGKYCUNGCAP
		  WHERE DongXe = 'Hiace') OR MANHACC IN(  SELECT DISTINCT MaNhaCC
											  FROM DANGKYCUNGCAP
											  WHERE DongXe = 'Cerato')

--Liệt kê thông tin của các nhà cc đã từng đăng kí cung cấp những dòng xe thuộc hãng xe "Toyota"
--với mức phí có đơn giá là 15.000 VNĐ/KM 
--hoặc những dòng xe thuộc hãng xe "KIA" vơi mức phí có đơn giá là 20.000 VNĐ/KM
--(0.5 điểm)
SELECT DISTINCT NCC.*
  FROM 
        NHACUNGCAP AS NCC
  INNER JOIN DANGKYCUNGCAP AS DKCC
         ON DKCC.MaNhaCC = NCC.MaNhaCC
  INNER JOIN DONGXE AS DX
		 ON DX.DongXe = DKCC.DongXe
  INNER JOIN MUCPHI AS MP
		 ON MP.MaMP = DKCC.MaMP
WHERE NCC.MaNhaCC IN (
					SELECT DISTINCT MaNhaCC
					   FROM DANGKYCUNGCAP AS DKCC
					INNER JOIN DONGXE AS DX
						   ON DX.DongXe = DKCC.DongXe
				    INNER JOIN MUCPHI AS MP
						   ON MP.MaMP = DKCC.MaMP
					WHERE (DX.HangXe = 'Toyota' AND MP.DonGia = 15000)
						OR(DX.HangXe = 'KIA' AND MP.DonGia = 20000))



--Câu 13: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện thuộc 
--dòng xe "Hiace" và chưa từng đăng ký cung cấp phương tiện thuộc dòng xe "Cerato" (0.5 
--điểm)
SELECT *
   FROM NHACUNGCAP 
WHERE MaNhaCC IN (
                    SELECT  DISTINCT MaNhaCC
					     FROM DANGKYCUNGCAP
					WHERE DongXe = 'Hiace'
				     ) AND MaNhaCC NOT IN ( SELECT  DISTINCT MaNhaCC
													 FROM DANGKYCUNGCAP
												WHERE DongXe = 'Cerato')

--Câu 14: Liệt kê thông tin của những dòng xe chưa được nhà cung cấp nào đăng ký cho thuê 
--vào năm "2015" nhưng đã từng được đăng ký cho thuê vào năm "2016" (0.5 điểm	 
SELECT *
 FROM DONGXE
  WHERE DongXe NOT IN (SELECT DISTINCT DongXe
                           FROM DANGKYCUNGCAP
						WHERE YEAR(NgayBatDauCungCap) = 2015)
		AND	 DongXe IN (SELECT DISTINCT DongXe
							   FROM DANGKYCUNGCAP
							WHERE YEAR(NgayBatDauCungCap) = 2016)
--Nhân viên nào của công ty bán được số lượng hàng nhiều nhất 
--và số lượng hàng bán được của nhân viên này là bao nhiêu
SELECT NV.MANHANVIEN,HO,TEN,SUM(CTDH.SOLUONG) AS TONG_NGOAI
    FROM NHANVIEN AS NV
	INNER JOIN DONDATHANG AS DDH
	       ON NV.MANHANVIEN = DDH.MANHANVIEN
    INNER JOIN CHITIETDATHANG AS CTDH
	       ON CTDH.SOHOADON = DDH.SOHOADON
GROUP BY NV.MANHANVIEN,HO,TEN
HAVING SUM(CTDH.SOLUONG) >= ALL (SELECT SUM(CTDH.SOLUONG) AS TONG_TRONG
									FROM NHANVIEN AS NV
									INNER JOIN DONDATHANG AS DDH
										   ON NV.MANHANVIEN = DDH.MANHANVIEN
									INNER JOIN CHITIETDATHANG AS CTDH
										   ON CTDH.SOHOADON = DDH.SOHOADON
								GROUP BY NV.MANHANVIEN,HO,TEN)









    