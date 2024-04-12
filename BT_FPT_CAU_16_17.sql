--Câu 16: Tính tổng số lượng xe đã được đăng ký cho thuê tương ứng với từng dòng xe với 
--yêu cầu chỉ thực hiện tính đối với những lần đăng ký cho thuê có mức phí với đơn giá là 
--20.000 VNĐ trên 1 km (0.5 điểm)
SELECT DX.DongXe,MP.DonGia,SUM(DKCC.SoLuongXeDangKy) AS TONG_SO_XE_DA_DANG_KY
     FROM DANGKYCUNGCAP AS DKCC
	   INNER JOIN DONGXE AS DX
	          ON DKCC.DongXe = DX.DongXe
			  INNER JOIN MUCPHI AS MP
			     ON DKCC.MaMP = MP.MaMP
WHERE DonGia = 20.000
GROUP BY DX.DongXe,MP.DonGia


--Câu 17: Liệt kê MaNCC, SoLuongXeDangKy với yêu cầu chỉ liệt kê những nhà cung cấp 
--có địa chỉ là "Hai Chau" và chỉ mới thực hiện đăng ký cho thuê một lần duy nhất, kết quả
--được sắp xếp tăng dần theo số lượng xe đăng ký (0.5 điểm)SELECT                NCC.MaNhaCC,	           TenNhaCC,	           DKCC.SoLuongXeDangKy,	           diachi,	           COUNT(DKCC.MaNhaCC) AS SO_LAN_DANG_KY   FROM  	           DANGKYCUNGCAP AS DKCC   INNER JOIN 	           NHACUNGCAP AS NCC   ON 		       DKCC.MaNhaCC = NCC.MaNhaCCWHERE DiaChi = 'Hai Chau'GROUP BY                 NCC.MaNhaCC,	           TenNhaCC,	           DKCC.SoLuongXeDangKy,DiaChi
HAVING 
              COUNT(NCC.MANHACC) = 1
ORDER BY DKCC.SoLuongXeDangKy ASC