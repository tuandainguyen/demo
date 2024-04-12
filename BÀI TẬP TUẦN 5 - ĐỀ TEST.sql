--Câu 3. Cho biết thông tin học sinh có tên là Hoc Sinh B
SELECT *
    FROM HOCSINH
WHERE TenHocSinh LIKE '%B'
--Câu 4. Cho biết thông tin học sinh giới tính Nam và sinh năm 2012 hoặc học sinh Nữ sinh năm 2013
SELECT *
   FROM HOCSINH
WHERE GioiTinh = 'Nam' AND YEAR(NamSinh) = 2012
   OR  GioiTinh = 'Nu'  AND YEAR(NamSinh) = 2013
--Câu 5. Liệt kê thông tin các mã đề thi có mã đề kết thúc là "001"
SELECT *
    FROM DETHI
WHERE MaDeThi  LIKE '%001'
--Câu 6. Liệt kê thông tin toàn bộ các câu hỏi được sắp xếp giảm dần theo mã khối và tãng dần theo
--mã câu hỏi
SELECT *
   FROM CAUHOI
ORDER BY MaKhoi DESC ,MaCauHoi ASC
--Câu 7. Liệt kê thông tin các đề thi đã phát hành vào tháng 12 nãm 2017
SELECT *
    FROM DETHI
WHERE TrangThai = 'Da phat hanh' 
  AND YEAR(ThoiGianThi)= 2017
  AND MONTH(ThoiGianThi) = 12
 --Câu 8. Liệt kê tên của tất cả học sinh với yêu cầu mỗi học sinh được liệt kê một lần.
SELECT TenHocSinh,COUNT(MaHocSinh) AS SOLAN
    FROM HOCSINH
GROUP BY TenHocSinh
HAVING COUNT(MaHocSinh) = 1

SELECT DISTINCT TenHocSinh
    FROM HOCSINH

--Câu 9. Liệt kê thông tin các mã đề thi,
--tên đề thi, thời gian thi, số câu hỏi, trạng thái, mã câu hỏi, mã
--khối đối với các dề thi chua phát hành
SELECT DT.*,CH.MaCauHoi,CH.MaKhoi
  FROM DETHI AS DT
  INNER JOIN DETHI_CAUHOI AS DTCH
         ON DT.MaDeThi = DTCH.MaDeThi
  INNER JOIN CAUHOI AS CH
         ON DTCH.MaCauHoi = CH.MaCauHoi
WHERE DT.TrangThai = 'Chua phat hanh'
--Câu 10. Liệt kê thông tin Mã đề thi, 
--tên đề thi, thời gian thi, số câu hỏi, trạng thái, mã câu hỏi, mã
--khối với yêu cầu những đề thi không có câu hỏi nào cũng liệt kê thông tin của đề thi đó ra.
SELECT DISTINCT DT.*,K.Makhoi
   FROM DETHI AS DT
   INNER JOIN KETQUA AS KQ
          ON DT.MaDeThi = KQ.MaDeThi
   INNER JOIN CAUHOI AS CH
          ON KQ.MaCauHoi = CH.MaCauHoi
    LEFT JOIN KHOI AS K
	      ON K.Makhoi = CH.MaKhoi
          
--Câu 11. Liệt kê thông tin những học sinh chưa từng thi một đề thi nào cả.
SELECT *
   FROM HOCSINH AS HS    
WHERE MaHocSinh NOT IN (
                           SELECT DISTINCT MaHocSinh
						      FROM KETQUA AS KQ
							  
					     )
--Câu 12. Liệt kê thông tin của những học sinh đã từng thi của khối lớp 1 và những học sinh chưa từng
--thi của khối lớp 3.
SELECT DISTINCT *
   FROM HOCSINH 

WHERE MaHocSinh IN ( SELECT DISTINCT MaHocSinh
						   FROM KETQUA AS KQ
						   INNER JOIN CAUHOI AS CH
								  ON CH.MaCauHoi = KQ.MaCauHoi
						   INNER JOIN KHOI AS K
								  ON K.Makhoi = CH.MaKhoi 
                          WHERE K.TenKhoi = 'Khoi lop 1'
								  )
  AND 
  MaHocSinh NOT IN ( SELECT  DISTINCT MaHocSinh
						   FROM  KETQUA AS KQ
						   INNER JOIN CAUHOI AS CH
								  ON CH.MaCauHoi = KQ.MaCauHoi
						   INNER JOIN KHOI AS K
								  ON K.Makhoi = CH.MaKhoi 
                          WHERE K.TenKhoi = 'Khoi lop 3'
								  )
--Câu 13. Liệt kê thông tin của những học sinh đã từng thi vào nãm 2016 nhưng chưa từng thi vào
--năm 2017
SELECT HS.*
   FROM HOCSINH AS HS
   INNER JOIN KETQUA AS KQ
          ON HS.MaHocSinh = KQ.MaHocSinh
   INNER JOIN DETHI AS DT
          ON DT.MaDeThi = KQ.MaDeThi
WHERE HS.MaHocSinh IN (SELECT HS.MaHocSinh
						   FROM HOCSINH AS HS
						   INNER JOIN KETQUA AS KQ
								  ON HS.MaHocSinh = KQ.MaHocSinh
						   INNER JOIN DETHI AS DT
								  ON DT.MaDeThi = KQ.MaDeThi
                         WHERE YEAR(DT.ThoiGianThi) = 2016
								  )
AND 
HS.MaHocSinh NOT IN (SELECT HS.MaHocSinh
						   FROM HOCSINH AS HS
						   INNER JOIN KETQUA AS KQ
								  ON HS.MaHocSinh = KQ.MaHocSinh
						   INNER JOIN DETHI AS DT
								  ON DT.MaDeThi = KQ.MaDeThi
                         WHERE YEAR(DT.ThoiGianThi) = 2017)
--Câu 14. Hiển thị thông tin học sinh có số đáp án nhiều nhất.
SELECT HS.MaHocSinh,HS.TenHocSinh,HS.TenLop,HS.GioiTinh,HS.NamSinh,COUNT(KQ.DapAn) AS SODAPAN
  FROM HOCSINH AS HS
  INNER JOIN KETQUA AS KQ
         ON HS.MaHocSinh = KQ.MaHocSinh
GROUP BY HS.MaHocSinh,HS.TenHocSinh,HS.TenLop,HS.GioiTinh,HS.NamSinh
HAVING COUNT(KQ.DapAn) >= ALL(SELECT COUNT(KQ.DapAn)
							     FROM HOCSINH AS HS
							  INNER JOIN KETQUA AS KQ
									 ON HS.MaHocSinh = KQ.MaHocSinh
                              GROUP BY HS.MaHocSinh,HS.TenHocSinh,HS.TenLop,HS.GioiTinh,HS.NamSinh
									 )
--Câu 15. Hiển thị thông tin học sinh có số đáp án nhiều hơn 2.
SELECT HS.MaHocSinh,HS.TenHocSinh,HS.TenLop,HS.GioiTinh,HS.NamSinh,COUNT(KQ.DapAn) AS SODAPAN
  FROM HOCSINH AS HS
  INNER JOIN KETQUA AS KQ
         ON HS.MaHocSinh = KQ.MaHocSinh
GROUP BY HS.MaHocSinh,HS.TenHocSinh,HS.TenLop,HS.GioiTinh,HS.NamSinh
HAVING COUNT(KQ.DapAn) > 2
--Câu 16. Cập nhật trạng thái ‘Da het han su dung’ đối với những đề thi đã phát hành trước
--31/12/2014
UPDATE DETHI
SET TrangThai = 'Da het han su dung'
WHERE YEAR(ThoiGianThi) < 2014 AND MONTH(ThoiGianThi) = 12 AND DAY(ThoiGianThi) = 31