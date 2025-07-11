USE [ShoeShopDB]
GO
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (4, NULL, CAST(N'2024-05-19' AS Date), N'Nike')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (5, NULL, CAST(N'2024-05-19' AS Date), N'Adidas')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (6, CAST(N'2025-06-17' AS Date), CAST(N'2024-05-19' AS Date), N'Puma')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (7, NULL, CAST(N'2024-05-19' AS Date), N'Bata')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (8, NULL, CAST(N'2024-05-19' AS Date), N'Converse')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (9, NULL, CAST(N'2024-05-19' AS Date), N'Vans')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (10, NULL, CAST(N'2024-05-19' AS Date), N'New Balance')
INSERT [dbo].[Brand] ([ID], [UpdateDate], [CreateDate], [Name]) VALUES (11, NULL, CAST(N'2024-05-19' AS Date), N'Fila')
SET IDENTITY_INSERT [dbo].[Brand] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Title], [Image], [Description], [BrandId], [Status], [CreateDate], [UpdateDate]) VALUES (1, N'Nike Air Max 270', N'unnamed.png', N'Nike Air Max 270 is a lightweight and comfortable running shoe.', 4, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[Product] ([ID], [Title], [Image], [Description], [BrandId], [Status], [CreateDate], [UpdateDate]) VALUES (2, N'Adidas Ultraboost 22', N'giay-the-thao-nike-air-force-1-paris-2022.jpg', N'Adidas Ultraboost 22 delivers maximum energy return for every run.', 5, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductVariant] ON 

INSERT [dbo].[ProductVariant] ([ID], [Name], [ImportPrice], [Price], [ProductID], [Status], [CreateDate], [UpdateDate], [Image]) VALUES (7, N'Nike Air Max 270 - Black/White', CAST(100000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 1, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date), N'unnamed.png')
INSERT [dbo].[ProductVariant] ([ID], [Name], [ImportPrice], [Price], [ProductID], [Status], [CreateDate], [UpdateDate], [Image]) VALUES (8, N'Nike Air Max 270 - Red', CAST(90000.00 AS Decimal(10, 2)), CAST(145000.00 AS Decimal(10, 2)), 1, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date), N'giay-the-thao-nike-air-force-1-paris-2022.jpg')
INSERT [dbo].[ProductVariant] ([ID], [Name], [ImportPrice], [Price], [ProductID], [Status], [CreateDate], [UpdateDate], [Image]) VALUES (9, N'Adidas Ultraboost 22 - Core Black', CAST(110000.00 AS Decimal(10, 2)), CAST(160000.00 AS Decimal(10, 2)), 2, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date), N'giay-nike-jordan.jpg')
SET IDENTITY_INSERT [dbo].[ProductVariant] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([ID], [Value], [Status], [CreateDate], [UpdateDate]) VALUES (1, N'38', 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[Size] ([ID], [Value], [Status], [CreateDate], [UpdateDate]) VALUES (2, N'39', 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[Size] ([ID], [Value], [Status], [CreateDate], [UpdateDate]) VALUES (3, N'40', 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[Size] ([ID], [Value], [Status], [CreateDate], [UpdateDate]) VALUES (4, N'41', 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[Size] ([ID], [Value], [Status], [CreateDate], [UpdateDate]) VALUES (5, N'42', 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[Size] ([ID], [Value], [Status], [CreateDate], [UpdateDate]) VALUES (6, N'43', 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductVariantSize] ON 

INSERT [dbo].[ProductVariantSize] ([ID], [SizeID], [ProductVariantID], [QuantityInStock], [QuantityHolding], [Status], [CreateDate], [UpdateDate]) VALUES (2, 4, 7, 50, 10, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[ProductVariantSize] ([ID], [SizeID], [ProductVariantID], [QuantityInStock], [QuantityHolding], [Status], [CreateDate], [UpdateDate]) VALUES (3, 3, 7, 30, 5, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[ProductVariantSize] ([ID], [SizeID], [ProductVariantID], [QuantityInStock], [QuantityHolding], [Status], [CreateDate], [UpdateDate]) VALUES (4, 1, 8, 60, 0, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
INSERT [dbo].[ProductVariantSize] ([ID], [SizeID], [ProductVariantID], [QuantityInStock], [QuantityHolding], [Status], [CreateDate], [UpdateDate]) VALUES (5, 2, 9, 20, 3, 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13' AS Date))
SET IDENTITY_INSERT [dbo].[ProductVariantSize] OFF
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (13, NULL, N'admin', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'admin@gmail.com', NULL, N'admin', NULL, N'0111222333', NULL, N'a5d4f738-2bf5-4c52-8e50-ea6c061dbcb3', CAST(N'2024-06-16' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (14, NULL, N'Sale 1', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'sale@gmail.com', NULL, N'sale', NULL, N'0111222333', NULL, N'41dc20aa-63a6-454d-875e-3cbf37bd73d8', CAST(N'2024-06-16' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (15, NULL, N'sale manager', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'salemanage@gmail.com', NULL, N'sale manager', NULL, N'0111222333', NULL, N'f5b1e44c-9bcc-4587-be73-9ace0db795b8', CAST(N'2024-06-16' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (16, NULL, N'maketer', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'maketer@gmail.com', NULL, N'maketer', NULL, N'0111222333', NULL, N'4aa869dd-223d-4f68-b84a-a7cde575a868', CAST(N'2024-06-16' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (17, NULL, N'Hoàng Trung Hòa', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'hoa@gmail.com', NULL, N'Y Yen Nam Dinh', NULL, N'0111222333', NULL, N'11336602-65b4-4e0b-b3ef-b97775ba0b33', CAST(N'2024-06-16' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (18, NULL, N'Sale 2', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'sale2@gmail.com', NULL, N'sale 2', NULL, N'0111222333', NULL, N'10be95b5-231a-45c3-ab5a-933f28ffc7ad', CAST(N'2024-06-16' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (19, NULL, N'Hoàng Trung Hòa', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'hoa2@gmail.com', NULL, N'Tống Xá, Yên Xá, Ý Yên, Nam Định', NULL, N'0971617281', NULL, N'641cfe30-4af9-47b0-877c-701505b6d71f', CAST(N'2024-06-18' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (20, NULL, N'Nguyễn Thị A', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'nguyenthia@gmail.com', NULL, N'Địa Chỉ 1, Xã 1, Tỉnh 1', NULL, N'0111222333', NULL, N'63c5134f-9e05-4ecb-b366-e567794229e6', CAST(N'2024-06-22' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (21, NULL, N'Warehouse', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'warehouse@gmail.com', NULL, N'warehouse', NULL, N'0111222333', NULL, N'5e1f3478-3939-47f8-b3cf-b98b07f0d0df', CAST(N'2024-06-22' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (22, NULL, N'Hoàng Trung Hòa', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'hoahthe172735@gmail.com', NULL, N'Tống Xá, Yên Xá, Ý Yên, Nam Định', NULL, N'0999888777', NULL, N'ba170d6e-94fc-4a1f-88b6-fb3a8fae3a1e', CAST(N'2024-06-22' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (23, NULL, N'user2@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'user2@gmail.com', NULL, N'Ý Yên - Nam Định', NULL, N'0999888777', NULL, N'b0a66d9f-5e58-4271-98bd-83ddf61491f2', CAST(N'2024-06-22' AS Date), 0)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (24, NULL, N'User 2', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'user5@gmail.com', NULL, N'Ý Yên - Nam Định', NULL, N'0999888777', NULL, N'54a0264e-4d43-4d21-ae3b-5d41d2524595', CAST(N'2024-06-22' AS Date), 0)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (25, NULL, N'User 5', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'user4@gmail.com', NULL, N'Ý Yên - Nam Định', NULL, N'0971617281', NULL, N'00def25a-5adb-4d1f-b07c-2493c7c4b0e2', CAST(N'2024-06-23' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (26, NULL, N'User 6', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'user6@gmail.com', NULL, N'Tống Xá, Yên Xá, Ý Yên, Nam Định', NULL, N'0999888777', NULL, N'33d358b6-72ee-4e18-858c-38e7482b4f42', CAST(N'2024-06-23' AS Date), 1)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (27, NULL, N'Hoàng Trung Hòa', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'hoaht.dev03@gmail.com', 1, N'Thị Trấn Lâm, Ý Yên, Nam Định', CAST(N'2025-06-08' AS Date), N'0395071064', NULL, N'bdd6ad77-59e5-418b-9ac4-0ac8d25444c6', CAST(N'2025-06-08' AS Date), 0)
INSERT [dbo].[Account] ([ID], [Image], [FullName], [Password], [Email], [Gender], [Address], [Birthdate], [Tel], [UpdateDate], [token], [CreateDate], [Status]) VALUES (28, NULL, N'Hoàng Trung Hòa', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'hoahthe172735.openai@gmail.com', 1, N'Thị Trấn Lâm, Ý Yên, Nam Định', CAST(N'2025-06-08' AS Date), N'0395071064', NULL, N'253a11e9-2716-44ae-b061-7aabd7f1a968', CAST(N'2025-06-08' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
INSERT [dbo].[PaymentMethod] ([Method], [Note], [imageLink]) VALUES (N'COD', N'Cash On Delivery', N'https://s3-sgn09.fptcloud.com/lc-public/app-lc/payment/cod.png')
INSERT [dbo].[PaymentMethod] ([Method], [Note], [imageLink]) VALUES (N'VNPay', N'Thanh toán qua ví VNPay', N'https://s3-sgn09.fptcloud.com/lc-public/app-lc/payment/vnpay.png')
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [CreateDate], [UpdateDate]) VALUES (5, N'Giày thể thao', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Category] ([ID], [Name], [CreateDate], [UpdateDate]) VALUES (6, N'Giày thời trang', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Category] ([ID], [Name], [CreateDate], [UpdateDate]) VALUES (7, N'Giày pickleball', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Category] ([ID], [Name], [CreateDate], [UpdateDate]) VALUES (8, N'Giày Hoka', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Category] ([ID], [Name], [CreateDate], [UpdateDate]) VALUES (9, N'Giày đá banh', CAST(N'2024-05-19' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 7)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 7)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 8)
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([id], [Title], [Thumbnail], [Content], [Status], [CreateAt], [UpdateAt], [AccountID]) VALUES (11, N'Kết quả Đức Scotland: Khai màn thuận lợi cho đội chủ nhà', N'img_YO_kZCbct0b1RhGW3h1dDDeGK0aXMVCH.jpg', N'<p><strong>Kết quả Đức Scotland&nbsp;</strong>Euro 2024 đ&atilde; chứng kiến m&agrave;n hủy diệt của cỗ xe tăng Đức trước đối thủ trong ng&agrave;y ra qu&acirc;n. Với lợi thế s&acirc;n nh&agrave; c&ugrave;ng lực lượng c&oacute; phần ch&ecirc;nh lệch, đội tuyển Đức đ&atilde; kh&ocirc;ng gặp qu&aacute; nhiều kh&oacute; khăn trong việc l&agrave;m chủ thế trận v&agrave; c&oacute; kết quả như mong đợi. C&ugrave;ng Ho&agrave;ng H&agrave; Mobile t&igrave;m hiểu chi tiết hơn về diễn biến trận đấu n&agrave;y nh&eacute;.</p>
<p><span id="elementor-toc__heading-anchor-0" class="elementor-menu-anchor "></span></p>
<h2>B&agrave;n thắng v&agrave; đội h&igrave;nh thi đấu</h2>
<p>Trước khi đến với&nbsp;<strong>kết quả Đức Scotland&nbsp;</strong>cũng như diễn biến trận đấu n&agrave;y, ch&uacute;ng ta sẽ kh&aacute;m ph&aacute; một số th&ocirc;ng tin quan trọng như:</p>
<p><strong>B&agrave;n thắng</strong></p>
<p>Trận đấu giữa Đức v&agrave; Scotland chứng kiến c&aacute;c b&agrave;n thắng li&ecirc;n tiếp từ ph&iacute;a Đức với c&aacute;c cầu thủ Wirtz ghi b&agrave;n ở ph&uacute;t thứ 10, Musiala với b&agrave;n thắng ở ph&uacute;t 19 v&agrave; Havertz từ chấm phạt đền v&agrave;o cuối hiệp một. Tiếp đ&oacute;, Fullkrug cũng kh&ocirc;ng bỏ lỡ cơ hội, n&acirc;ng tỷ số l&ecirc;n ở ph&uacute;t 68. Trong khi đ&oacute;, Scotland c&oacute; b&agrave;n danh dự nhờ b&agrave;n phản lưới của Rudiger v&agrave;o ph&uacute;t 87.</p>
<figure id="attachment_357077" class="wp-caption aligncenter" aria-describedby="caption-attachment-357077"><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-357077 webpexpress-processed entered litespeed-loaded" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-768x432.jpg 768w" alt="ket-qua-duc-scotland" width="800" height="450" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture>
<figcaption id="caption-attachment-357077" class="wp-caption-text"><em>Cỗ xe tăng Đức mở m&agrave;n Euro 2024 cực kỳ thuận lợi</em></figcaption>
</figure>
<p><strong>Thẻ đỏ</strong></p>
<p>Scotland nhận th&ecirc;m tổn thất khi Porteous bị đuổi khỏi s&acirc;n ngay trước giờ nghỉ.</p>
<p><strong>Đội h&igrave;nh thi đấu</strong></p>
<p>Đức: Neuer, Kimmich, Tah, Rudiger, Mittelstadt, Kroos (Can 80&prime;), Andrich (Gross 46&prime;), Musiala (Muller 64&prime;), Gundogan, Wirtz (Sane 63&prime;), Havertz (Fullkrug 63&prime;).</p>
<p>Scotland: Gunn, Robertson, Tierney (McKenna 77&prime;), Hendry, Ralston, Porteous, McGregor (Gilmour 67&prime;), McGinn (McLean 67&prime;), Christie (Shankland 82&prime;), McTominay, Adams (Hanley 46&prime;).</p>
<p>Lưu &yacute;, bạn c&oacute; thể đăng k&yacute;&nbsp;<strong><a href="https://hoanghamobile.com/topup/kplus">g&oacute;i cước truyền h&igrave;nh K+</a></strong>&nbsp;tại Ho&agrave;ng H&agrave; Mobile với mức gi&aacute; ưu đ&atilde;i cho m&ugrave;a Euro để thưởng thức to&agrave;n bộ 51 trận đấu một c&aacute;ch trọn vẹn nhất.</p>
<p><span id="elementor-toc__heading-anchor-1" class="elementor-menu-anchor "></span></p>
<h2>Kết quả Đức Scotland &ndash; Hiệp 1</h2>
<p>Hiệp một của trận đấu giữa Đức v&agrave; Scotland diễn ra v&ocirc; c&ugrave;ng s&ocirc;i động. Đội chủ nh&agrave;, với sơ đồ 4-2-3-1 đ&atilde; nhập cuộc hết sức mạnh mẽ. Kai Havertz dẫn dắt h&agrave;ng c&ocirc;ng được hỗ trợ bởi Florian Wirtz, Ilkay Gundogan v&agrave; Jamal Musiala. Ở tuyến giữa, Toni Kroos v&agrave; Robert Andrich kiểm so&aacute;t nhịp độ trận đấu, trong khi h&agrave;ng ph&ograve;ng ngự vững chắc với Maximilian Mittelstadt, Jonathan Tah, Antonio Rudiger v&agrave; Joshua Kimmich.</p>
<figure id="attachment_357076" class="wp-caption aligncenter" aria-describedby="caption-attachment-357076"><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-1.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-1-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-1-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="wp-image-357076 size-full webpexpress-processed entered litespeed-loaded" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1-768x432.jpg 768w" alt="ket-qua-duc-scotland-1" width="800" height="450" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-1-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture>
<figcaption id="caption-attachment-357076" class="wp-caption-text"><em>Đức dễ d&agrave;ng &aacute;p đặt thế trận ngay trong hiệp 1</em></figcaption>
</figure>
<p>Chỉ sau v&agrave;i ph&uacute;t thi đấu, Đức đ&atilde; l&agrave;m chủ thế trận v&agrave; kh&ocirc;ng l&acirc;u sau đ&oacute;, họ đ&atilde; mở tỷ số. Từ một đường chuyền của Kroos, Kimmich đ&atilde; thực hiện đường tạt b&oacute;ng cho Wirtz, cầu thủ n&agrave;y đ&atilde; kh&ocirc;ng chần chừ dứt điểm mạnh mẽ mở tỷ số ở ph&uacute;t thứ 10. Đội kh&aacute;ch chưa kịp hồi phục th&igrave; đ&atilde; phải v&agrave;o lưới nhặt b&oacute;ng lần nữa. Lần n&agrave;y l&agrave; Musiala, sau pha chuyền b&oacute;ng kh&eacute;o l&eacute;o của Havertz đ&atilde; s&uacute;t tung lưới Scotland ở ph&uacute;t 19.</p>
<p>Bất chấp việc bị dẫn trước, Scotland kh&ocirc;ng thể hiện được nhiều. Họ gặp kh&oacute; khăn trong việc gi&agrave;nh lại thế trận v&agrave; t&igrave;nh h&igrave;nh c&agrave;ng trở n&ecirc;n tồi tệ hơn v&agrave;o cuối hiệp khi Ryan Porteous nhận thẻ đỏ v&igrave; lỗi phạm với Gundogan. Sự kiện n&agrave;y đ&atilde; dẫn đến quả phạt đền cho Đức, v&agrave; Havertz đ&atilde; kh&ocirc;ng bỏ lỡ cơ hội, n&acirc;ng tỷ số l&ecirc;n 3-0 ngay trước giờ nghỉ.</p>
<p><span id="elementor-toc__heading-anchor-2" class="elementor-menu-anchor "></span></p>
<h2>Kết quả Đức Scotland &ndash; Hiệp 2</h2>
<p>Sang hiệp hai, Đức tiếp tục thể hiện sức mạnh vượt trội tr&ecirc;n s&acirc;n. Với lợi thế hơn người, họ li&ecirc;n tục gia tăng sức &eacute;p l&ecirc;n khung th&agrave;nh Scotland. Mặc d&ugrave; mất nhiều thời gian để t&igrave;m kiếm b&agrave;n thắng, cuối c&ugrave;ng Niclas Fullkrug đ&atilde; ghi b&agrave;n thắng thứ tư cho cỗ xe tăng Đức.</p>
<p><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-2.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-2-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/ket-qua-duc-scotland-2-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-357075 aligncenter webpexpress-processed entered litespeed-loaded" style="display: block; margin-left: auto; margin-right: auto;" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2-768x432.jpg 768w" alt="ket-qua-duc-scotland-2" width="800" height="450" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/ket-qua-duc-scotland-2-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture></p>
<p>Scotland sau đ&oacute; bất ngờ c&oacute; b&agrave;n thắng r&uacute;t ngắn tỷ số xuống 4-1 v&agrave;o ph&uacute;t 87. Trong t&igrave;nh huống gỡ b&agrave;n n&agrave;y, trung vệ Rudiger của Đức kh&ocirc;ng may mắn khi đưa b&oacute;ng v&agrave;o lưới nh&agrave; sau một t&igrave;nh huống hỗn loạn. Tuy nhi&ecirc;n, Đức kh&ocirc;ng để điều đ&oacute; ảnh hưởng tới t&acirc;m l&yacute;. Emre Can v&agrave;o s&acirc;n thay thế Kroos, đ&atilde; ấn định tỷ số chung cuộc 5-1 với c&uacute; s&uacute;t xa đầy hiểm h&oacute;c.</p>
<p><span id="elementor-toc__heading-anchor-3" class="elementor-menu-anchor "></span></p>
<h2>Tạm kết</h2>
<p><strong>Kết quả Đức Scotland&nbsp;</strong>Euro 2024, Đức khởi đầu giải đấu một c&aacute;ch thuyết phục, đầy hứa hẹn cho những trận đấu sắp tới. Trong lượt trận tiếp theo của bảng A, Đức sẽ đối đầu với Hungary, c&ograve;n Scotland sẽ gặp Thụy Sĩ, cả hai trận đều diễn ra v&agrave;o ng&agrave;y 19/6. B&ecirc;n cạnh đ&oacute;, bạn cũng c&oacute; thể tham khảo trang tin nhanh của Ho&agrave;ng H&agrave; Mobile để cập nhật c&aacute;c th&ocirc;ng tin li&ecirc;n quan đến Euro nhanh v&agrave; sớm nhất.</p>', 1, CAST(N'2024-06-17' AS Date), CAST(N'2024-06-17' AS Date), 16)
INSERT [dbo].[Post] ([id], [Title], [Thumbnail], [Content], [Status], [CreateAt], [UpdateAt], [AccountID]) VALUES (12, N'Thông tin 17 đội tuyển tranh đấu trong sự kiện LPL mùa hè', N'img_Xlvo4q3Z-2KXzD4GB5aT_sd73lxeGnyc.jpg', N'<p><strong>LPL m&ugrave;a h&egrave; 2024</strong>&nbsp;đ&atilde; ch&iacute;nh thức khởi tranh từ ng&agrave;y 1/6 với sự xuất hiện của 17 đội tuyển h&agrave;ng đầu khu vực Trung Quốc. Giải đấu n&agrave;y đặc biệt quan trọng, bởi v&igrave; những tấm v&eacute; tham dự CKTG 2024 chỉ d&agrave;nh cho những đội tuyển xuất sắc nhất khu vực. Dưới đ&acirc;y l&agrave; th&ocirc;ng tin về c&aacute;c đội tuyển tham gia LPL Summer 2024 lần n&agrave;y v&agrave; c&aacute;c th&ocirc;ng tin li&ecirc;n quan, đừng bỏ qua nh&eacute;.</p>
<p><span id="elementor-toc__heading-anchor-0" class="elementor-menu-anchor "></span></p>
<h2>LPL m&ugrave;a h&egrave; 2024 diễn ra v&agrave;o thời điểm n&agrave;o?</h2>
<p>Giải đấu Li&ecirc;n Minh Huyền Thoại Trung Quốc, LPL Summer 2024 sẽ ch&iacute;nh thức khởi tranh v&agrave;o ng&agrave;y 01/06, ngay sau khi giải MSI 2024 kết th&uacute;c v&agrave;o ng&agrave;y 19/05. Điều n&agrave;y đặc biệt thu h&uacute;t sự ch&uacute; &yacute; bởi khoảng thời gian ngắn ngủi chỉ vỏn vẹn 11 ng&agrave;y nghỉ ngơi giữa hai giải đấu. Th&ecirc;m v&agrave;o đ&oacute;, đ&acirc;y l&agrave; một th&ocirc;ng tin đặc biệt quan trọng đối với Bilibili Gaming, đội đ&atilde; tham gia trận chung kết MSI, v&igrave; họ chỉ c&oacute; rất &iacute;t thời gian để phục hồi v&agrave; chuẩn bị cho một m&ugrave;a giải mới.</p>
<figure id="attachment_356397" class="wp-caption aligncenter" aria-describedby="caption-attachment-356397"><img class="size-full wp-image-356397 webpexpress-processed entered litespeed-loaded" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-768x432.jpg 768w" alt="lpl-mua-he-2024" width="600" height="337" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"><br>
<figcaption id="caption-attachment-356397" class="wp-caption-text"><em>LPL m&ugrave;a h&egrave; năm 2024 sẽ diễn ra sớm hơn dự kiến</em></figcaption>
</figure>
<p>Việc bắt đầu sớm của&nbsp;<strong>LPL m&ugrave;a h&egrave; 2024</strong>&nbsp;được nhiều người h&acirc;m mộ cho rằng l&agrave; do thất bại của đội tại trận chung kết MSI tr&ecirc;n s&acirc;n nh&agrave; ở Th&agrave;nh Đ&ocirc;. Họ tin rằng điều n&agrave;y th&uacute;c đẩy nhu cầu trở lại s&acirc;n đấu sớm để chuẩn bị cho sự kiện lớn tiếp theo, đ&oacute; l&agrave; Esports World Cup 2024. Giải n&agrave;y kh&ocirc;ng chỉ l&agrave; một trong những sự kiện eSports c&oacute; giải thưởng lớn nhất thế giới m&agrave; c&ograve;n l&agrave; một cơ hội để phục th&ugrave; LCK sau k&igrave; MSI vừa rồi.</p>
<p>Với 17 đội tham gia, LPL l&agrave; giải đấu c&oacute; số đội tham dự nhiều nhất so với c&aacute;c giải quốc nội kh&aacute;c. Điều n&agrave;y y&ecirc;u cầu một lịch thi đấu d&agrave;y đặc, với c&aacute;c trận đấu diễn ra gần như mỗi ng&agrave;y, v&agrave; l&agrave; giải đấu quốc nội cuối c&ugrave;ng kết th&uacute;c trong năm. Thực tế, ngay cả giai đoạn bốc thăm của MSI 2024 cũng diễn ra ngay sau đ&ecirc;m chung kết LPL, qua đ&oacute; c&agrave;ng l&agrave;m nổi bật tốc độ v&agrave; mật độ của lịch tr&igrave;nh thi đấu tại Trung Quốc.</p>
<p><span id="elementor-toc__heading-anchor-1" class="elementor-menu-anchor "></span></p>
<h2>Danh s&aacute;ch 17 đội tuyển h&agrave;ng đầu tham dự LPL m&ugrave;a h&egrave; 2024</h2>
<p>Để dễ d&agrave;ng tiếp cận th&ocirc;ng tin về 17 đội tuyển LPL Summer lần n&agrave;y, ch&uacute;ng ta sẽ t&igrave;m hiểu danh s&aacute;ch th&ocirc;ng qua từng bảng đấu. Cụ thể l&agrave;:</p>
<p><span id="elementor-toc__heading-anchor-2" class="elementor-menu-anchor "></span></p>
<h3>Bảng A</h3>
<p><strong>JD Gaming</strong></p>
<ul>
<li>Flandre &ndash; Li Xuanjun &ndash; Top lane</li>
<li>Sheer &ndash; Xu Wenji &ndash; Top lane</li>
<li>Kanavi &ndash; Seo Jin-hyeok &ndash; Jungle</li>
<li>Yagao &ndash; Zeng Qi &ndash; Mid</li>
<li>Ruler &ndash; Park Jae-hyuk &ndash; Bot</li>
<li>MISSING &ndash; Lou Yunfeng &ndash; Support</li>
<li>Yimeng &ndash; Chen Mingyong &ndash; Mid (dự bị)</li>
</ul>
<p><strong>EDward Gaming</strong></p>
<ul>
<li>Solokill &ndash; Mak Fu-keung &ndash; Top</li>
<li>Jiejie &ndash; Zhao Lijie &ndash; Jungle</li>
<li>Cryin &ndash; Yuan Chengwei &ndash; Mid</li>
<li>Thesnake &ndash; Kang Guang &ndash; Bot</li>
<li>Leave &ndash; Hu Hongchao &ndash; Bot</li>
<li>Wink &ndash; Zhang Rui &ndash; Support</li>
</ul>
<p><strong>FunPlus Phoenix LPL m&ugrave;a h&egrave; 2024</strong></p>
<ul>
<li>Xiaolaohu &ndash; Ping Xiaohu &ndash; Top</li>
<li>TheNiu &ndash; Zhao Yongzhuo &ndash; Top</li>
<li>Milkyway &ndash; Cai Zijun &ndash; Jungle</li>
<li>Care &ndash; Yang Jie &ndash; Mid</li>
<li>deokdam &ndash; Seo Dae-gil &ndash; Bot</li>
<li>Life &ndash; Kim Jeong-min &ndash; Support</li>
</ul>
<p><strong>ThunderTalk Gaming</strong></p>
<ul>
<li>Hoya &ndash; Yoon Yong-ho &ndash; Top</li>
<li>Beichuan &ndash; Yang Ling &ndash; Jungle</li>
<li>Ucal &ndash; Son Woo-hyeon &ndash; Mid</li>
<li>1xn &ndash; Li Xiunan &ndash; Bot</li>
<li>Feather &ndash; Wangtian Cifu &ndash; Support</li>
<li>Qiuqiu &ndash; Zhang Ming &ndash; Support</li>
</ul>
<figure id="attachment_356395" class="wp-caption aligncenter" aria-describedby="caption-attachment-356395"><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-1.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-1-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-1-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-356395 webpexpress-processed entered litespeed-loaded" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1-768x432.jpg 768w" alt="lpl-mua-he-2024-1" width="600" height="338" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-1-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture>
<figcaption id="caption-attachment-356395" class="wp-caption-text"><em>Bảng A l&agrave; sự xuất hiện của c&aacute;c đội tuyển h&agrave;ng đầu khu vực</em></figcaption>
</figure>
<p><span id="elementor-toc__heading-anchor-3" class="elementor-menu-anchor "></span></p>
<h3>Bảng B</h3>
<p><strong>Bilibili Gaming</strong></p>
<ul>
<li>Bin &ndash; Chen Zenbin &ndash; Top</li>
<li>XUN &ndash; Peng Lixun &ndash; Jungle</li>
<li>Knight &ndash; Zhuo Ding &ndash; Mid</li>
<li>Elk &ndash; Zhao Jiahao &ndash; Bot</li>
<li>ON &ndash; Luo Wenjun &ndash; Support</li>
<li>LvMao &ndash; Zuo Minghao &ndash; Support</li>
</ul>
<p><strong>Team WE&nbsp;</strong><strong>LPL m&ugrave;a h&egrave; 2024</strong></p>
<ul>
<li>Wayward &ndash; Huang Renxing &ndash; Top</li>
<li>Heng &ndash; Yang Cuiheng &ndash; Jungle</li>
<li>FoFo &ndash; Chu Chun &ndash; Ian &ndash; Mid</li>
<li>Stay &ndash; Guo Yiyang &ndash; Bot</li>
<li>LP &ndash; Li Fei &ndash; Bot</li>
<li>Mark &ndash; Ling Xu &ndash; Support</li>
</ul>
<p><strong>LGD Gaming</strong></p>
<ul>
<li>Burdol &ndash; Noh Tae-yoon &ndash; Top</li>
<li>Meteor &ndash; Zeng Guohao &ndash; Jungle</li>
<li>Haichao &ndash; Zhang Haichao &ndash; Mid</li>
<li>Kepler &ndash; Zou Jiale &ndash; Bot</li>
<li>Shaoye &ndash; Chou Guobin &ndash; Bot</li>
<li>Jinjiao &ndash; Xie Jinshan &ndash; Support</li>
</ul>
<p><strong>Royal Never Give Up</strong></p>
<ul>
<li>Zdz &ndash; Zhu Dezhang &ndash; Top</li>
<li>Wei &ndash; Yan Yangwei &ndash; Jungle</li>
<li>Tangyuan &ndash; Lin Yuhong &ndash; Mid</li>
<li>Xzz &ndash; Liu Zhu &ndash; Mid</li>
<li>Huanfeng &ndash; Tang Huanfeng &ndash; Bot</li>
<li>Ming &ndash; Shi Senming &ndash; Support</li>
</ul>
<p><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-2.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-2-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-2-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-356396 aligncenter webpexpress-processed entered litespeed-loaded" style="display: block; margin-left: auto; margin-right: auto;" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2-768x432.jpg 768w" alt="lpl-mua-he-2024-2" width="600" height="338" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-2-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture></p>
<p><span id="elementor-toc__heading-anchor-4" class="elementor-menu-anchor "></span></p>
<h3>Bảng C &ndash; LPL m&ugrave;a h&egrave; 2024</h3>
<p><strong>Top Esports</strong></p>
<ul>
<li>369 &ndash; Bai Jiahao &ndash; Top</li>
<li>Tian &ndash; GaoTianliang &ndash; Jungle</li>
<li>Creme &ndash; Lin Jian &ndash; Mid</li>
<li>Xiye &ndash; Su Hanwei &ndash; Mid</li>
<li>JackeyLove &ndash; Yu Wenbo &ndash; Bot</li>
<li>Meiko &ndash; Tian Ye &ndash; Support</li>
</ul>
<p><strong>Rare Atom</strong></p>
<ul>
<li>Xiaoxu &ndash; Xu Xingzu &ndash; Top</li>
<li>Yo &ndash; Liu Yu &ndash; Top</li>
<li>Xiaohao &ndash; Peng Hao &ndash; Jungle</li>
<li>VicLa &ndash; Lee Dae-kwang &ndash; Mid</li>
<li>Assum &ndash; Zou Wei &ndash; Bot</li>
<li>Jwei &ndash; Sun Junwei &ndash; Support</li>
</ul>
<p><strong>LNG Esports</strong></p>
<ul>
<li>Zika &ndash; Tang Huayu &ndash; Top</li>
<li>Xiaoyu &ndash; Zhou Yu &ndash; Top</li>
<li>Weiwei &ndash; Wei Bohan &ndash; Jungle</li>
<li>Shadow &ndash; Zhao Zhiquiang &ndash; Jungle</li>
<li>Scout &ndash; Lee Ye-chan &ndash; Mid</li>
<li>GALA &ndash; Chen Wei &ndash; Bot</li>
<li>Hang &ndash; Fu Minghang &ndash; Support</li>
<li>Xin &ndash; Li Yudong &ndash; Support (dự bị)</li>
</ul>
<p><strong>Oh My God</strong></p>
<ul>
<li>Hery &ndash; Wang Heyong &ndash; Top</li>
<li>Xiaofang &ndash; Fang Zheyu &ndash; Jungle</li>
<li>Lingfeng &ndash; Qin Jiahao &ndash; Jungle</li>
<li>Angle &ndash; Xiang Tao &ndash; Mid</li>
<li>Starry &ndash; Lei Ming &ndash; Bot</li>
<li>Ppgod &ndash; Guo Peng &ndash; Support</li>
</ul>
<p><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-3.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-3-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-3-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-356394 aligncenter webpexpress-processed entered litespeed-loaded" style="display: block; margin-left: auto; margin-right: auto;" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3-768x432.jpg 768w" alt="lpl-mua-he-2024-3" width="600" height="338" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-3-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture></p>
<p><span id="elementor-toc__heading-anchor-5" class="elementor-menu-anchor "></span></p>
<h3>Bảng D</h3>
<p><strong>Anyone&rsquo;s Legend LPL m&ugrave;a h&egrave; 2024</strong></p>
<ul>
<li>Ale &ndash; Hu Jiale &ndash; Top</li>
<li>Croco &ndash; Kim Dong-beom &ndash; Jungle</li>
<li>Relife &ndash; Ouyang Jincheng &ndash; Jungle</li>
<li>Shanks &ndash; Cui Xiaojun &ndash; Mid</li>
<li>Hope &ndash; Wang Jie &ndash; Bot</li>
<li>Kael &ndash; Kim Jin-hong &ndash; Support</li>
</ul>
<p><strong>Ninjas in Pyjamas</strong></p>
<ul>
<li>Shanji &ndash; Deng Zijian &ndash; Top</li>
<li>AKi &ndash; Mao An &ndash; Jungle</li>
<li>Rookie &ndash; Song Eui-jin &ndash; Mid</li>
<li>Photic &ndash; Ying Qishen &ndash; Bot</li>
<li>Zhuo &ndash; Wang Xuzhuo &ndash; Support</li>
<li>Zero &ndash; Yoon Kyung-sup &ndash; Support (dự bị)</li>
</ul>
<p><strong>Ultra Prime</strong></p>
<ul>
<li>Decade &ndash; Zhang Huaxin &ndash; Top</li>
<li>Qingtian &ndash; Yu Zihan &ndash; Top</li>
<li>H4cker &ndash; Yang Zhihao &ndash; Jungle</li>
<li>Yuekai &ndash; Zhang Yuekai &ndash; Mid</li>
<li>Doggo &ndash; Chiu Tzu-chuan &ndash; Bot</li>
<li>xiaoyueji &ndash; Luo Shihao &ndash; Bot</li>
<li>Niket &ndash; Ying Xinyuan &ndash; Support</li>
</ul>
<p><strong>Weibo Gaming</strong></p>
<ul>
<li>Breathe &ndash; Chen Chen &ndash; Top</li>
<li>Youdang &ndash; Zeng Xianxin &ndash; Jungle</li>
<li>Tarzan &ndash; Lee Seung-yong &ndash; Jungle</li>
<li>Xiaohu &ndash; Li Yuanhao &ndash; Mid</li>
<li>Light &ndash; Wang Guangyu &ndash; Bot</li>
<li>Crisp &ndash; Liu Qingsong &ndash; Support</li>
</ul>
<p><strong>Invictus Gaming LPL m&ugrave;a h&egrave; 2024</strong></p>
<ul>
<li>YSKM &ndash; Chau Shu-tak &ndash; Top</li>
<li>ZUIAN &ndash; Cheng Zihao &ndash; Top</li>
<li>Tianzhen &ndash; Guo Qifan &ndash; Jungle</li>
<li>glfs &ndash; Li Hao &ndash; Jungle</li>
<li>neny &ndash; Zhao Zhihao &ndash; Mid</li>
<li>Ahn &ndash; An Shanye &ndash; Bot</li>
<li>Vampire &ndash; Zhao Zhecan &ndash; Support</li>
</ul>
<figure id="attachment_356392" class="wp-caption aligncenter" aria-describedby="caption-attachment-356392"><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-5.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-5-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-5-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-356392 webpexpress-processed entered litespeed-loaded" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5-768x432.jpg 768w" alt="lpl-mua-he-2024-5" width="600" height="338" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-5-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture>
<figcaption id="caption-attachment-356392" class="wp-caption-text"><em>Bảng D sẽ c&oacute; sự xuất hiện của nhiều đội tuyển hơn so với c&aacute;c bảng đấu kh&aacute;c</em></figcaption>
</figure>
<p><span id="elementor-toc__heading-anchor-6" class="elementor-menu-anchor "></span></p>
<h2>Lịch thi đấu ch&iacute;nh thức của LPL m&ugrave;a h&egrave; 2024</h2>
<p>Sau khi t&igrave;m hiểu về th&ocirc;ng tin của to&agrave;n bộ c&aacute;c đội tuyển tham dự LPL Summer 2024, ch&uacute;ng ta sẽ c&ugrave;ng kh&aacute;m ph&aacute; lịch thi đấu ch&iacute;nh thức của giải đấu n&agrave;y nh&eacute;.</p>
<p><span id="elementor-toc__heading-anchor-7" class="elementor-menu-anchor "></span></p>
<h3>Lịch thi đấu tuần 1</h3>
<table width="576">
<tbody>
<tr>
<td width="131">Đội 1</td>
<td width="129">Kết Quả</td>
<td width="145">Đội 2</td>
<td width="87">Giờ</td>
<td width="84">Ng&agrave;y</td>
</tr>
<tr>
<td width="131">UP</td>
<td width="129">2 -1</td>
<td width="145">IG</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">01-Thg6</td>
</tr>
<tr>
<td width="131">WBG</td>
<td width="129">1-2</td>
<td width="145">NIP</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">WE</td>
<td width="129">2-0</td>
<td width="145">RNG</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">02-Thg6</td>
</tr>
<tr>
<td width="131">RA</td>
<td width="129">0-2</td>
<td width="145">TES</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">OMG</td>
<td width="129">0-2</td>
<td width="145">LNG</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">03-Thg6</td>
</tr>
<tr>
<td width="131">WBG</td>
<td width="129">2-1</td>
<td width="145">IG</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">AL</td>
<td width="129">2-0</td>
<td width="145">UP</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">04-Thg6</td>
</tr>
<tr>
<td width="131">TT</td>
<td width="129">1-2</td>
<td width="145">FPX</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">LGD</td>
<td width="129">0-2</td>
<td width="145">WE</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">05-Thg6</td>
</tr>
<tr>
<td width="131">EDG</td>
<td width="129">0-2</td>
<td width="145">JDG</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">RA</td>
<td width="129">2-1</td>
<td width="145">OMG</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">06-Thg6</td>
</tr>
<tr>
<td width="131">RNG</td>
<td width="129">0-2</td>
<td width="145">BLG</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">JDG</td>
<td width="129">2-0</td>
<td width="145">TT</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">07-Thg6</td>
</tr>
<tr>
<td width="131">LNG</td>
<td width="129">0-2</td>
<td width="145">TES</td>
<td width="87">18h00</td>
</tr>
<tr>
<td width="131">NIP</td>
<td width="129">0-2</td>
<td width="145">AL</td>
<td width="87">16h00</td>
<td rowspan="2" width="84">08-Thg6</td>
</tr>
<tr>
<td width="131">UP</td>
<td width="129">2-1</td>
<td width="145">WBG</td>
<td width="87">18h00</td>
</tr>
</tbody>
</table>
<p><span id="elementor-toc__heading-anchor-8" class="elementor-menu-anchor "></span></p>
<h3>Lịch thi đấu tuần 2</h3>
<table width="581">
<tbody>
<tr>
<td width="132">Đội 1</td>
<td width="123">Kết Quả</td>
<td width="151">Đội 2</td>
<td width="85">Giờ</td>
<td width="90">Ng&agrave;y</td>
</tr>
<tr>
<td width="132">FPX</td>
<td width="123">0-2</td>
<td width="151">EDG</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">10-Thg6</td>
</tr>
<tr>
<td width="132">BLG</td>
<td width="123">2-0</td>
<td width="151">LGD</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">IG</td>
<td width="123">0-2</td>
<td width="151">AL</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">11-Thg6</td>
</tr>
<tr>
<td width="132">NIP</td>
<td width="123">2-0</td>
<td width="151">UP</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">LNG</td>
<td width="123">1-2</td>
<td width="151">RA</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">12-Thg6</td>
</tr>
<tr>
<td width="132">TES</td>
<td width="123">2-0</td>
<td width="151">OMG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">AL</td>
<td width="123">0-2</td>
<td width="151">WBG</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">13-Thg6</td>
</tr>
<tr>
<td width="132">WE</td>
<td width="123">1-2</td>
<td width="151">BLG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">RNG</td>
<td width="123">1-2</td>
<td width="151">LGD</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">14-Thg6</td>
</tr>
<tr>
<td width="132">IG</td>
<td width="123">2-1</td>
<td width="151">NIP</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">EDG</td>
<td width="123">&nbsp;</td>
<td width="151">TT</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">15-Thg6</td>
</tr>
<tr>
<td width="132">FPX</td>
<td width="123">&nbsp;</td>
<td width="151">JDG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">RA</td>
<td width="123">&nbsp;</td>
<td width="151">LNG</td>
<td width="85">16h00</td>
<td rowspan="2" width="90">16-Thg6</td>
</tr>
<tr>
<td width="132">OMG</td>
<td width="123">&nbsp;</td>
<td width="151">TES</td>
<td width="85">18h00</td>
</tr>
</tbody>
</table>
<p><span id="elementor-toc__heading-anchor-9" class="elementor-menu-anchor "></span></p>
<h3>Lịch thi đấu LPL m&ugrave;a h&egrave; 2024 tuần 3</h3>
<table width="576">
<tbody>
<tr>
<td width="132">Đội 1</td>
<td width="123">Kết Quả</td>
<td width="151">Đội 2</td>
<td width="85">Giờ</td>
<td width="85">Ng&agrave;y</td>
</tr>
<tr>
<td width="132">WBG</td>
<td width="123">&nbsp;</td>
<td width="151">UP</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">17-Thg6</td>
</tr>
<tr>
<td width="132">AL</td>
<td width="123">&nbsp;</td>
<td width="151">NIP</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">LGD</td>
<td width="123">&nbsp;</td>
<td width="151">RNG</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">18-Thg6</td>
</tr>
<tr>
<td width="132">BLG</td>
<td width="123">&nbsp;</td>
<td width="151">WE</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">NIP</td>
<td width="123">&nbsp;</td>
<td width="151">IG</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">19-Thg6</td>
</tr>
<tr>
<td width="132">TT</td>
<td width="123">&nbsp;</td>
<td width="151">JDG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">EDG</td>
<td width="123">&nbsp;</td>
<td width="151">FPX</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">20-Thg6</td>
</tr>
<tr>
<td width="132">OMG</td>
<td width="123">&nbsp;</td>
<td width="151">RA</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">UP</td>
<td width="123">&nbsp;</td>
<td width="151">AL</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">21-Thg6</td>
</tr>
<tr>
<td width="132">NIP</td>
<td width="123">&nbsp;</td>
<td width="151">WBG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">WE</td>
<td width="123">&nbsp;</td>
<td width="151">LGD</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">22-Thg6</td>
</tr>
<tr>
<td width="132">BLG</td>
<td width="123">&nbsp;</td>
<td width="151">RNG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">AL</td>
<td width="123">&nbsp;</td>
<td width="151">IG</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">23-Thg6</td>
</tr>
<tr>
<td width="132">TES</td>
<td width="123">&nbsp;</td>
<td width="151">LNG</td>
<td width="85">18h00</td>
</tr>
</tbody>
</table>
<p><span id="elementor-toc__heading-anchor-10" class="elementor-menu-anchor "></span></p>
<h3>Lịch thi đấu LPL tuần 4</h3>
<table width="576">
<tbody>
<tr>
<td width="132">Đội 1</td>
<td width="123">Kết Quả</td>
<td width="151">Đội 2</td>
<td width="85">Giờ</td>
<td width="85">Ng&agrave;y</td>
</tr>
<tr>
<td width="132">TT</td>
<td width="123">&nbsp;</td>
<td width="151">EDG</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">24-Thg6</td>
</tr>
<tr>
<td width="132">JDG</td>
<td width="123">&nbsp;</td>
<td width="151">FPX</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">IG</td>
<td width="123">&nbsp;</td>
<td width="151">UP</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">25-Thg6</td>
</tr>
<tr>
<td width="132">WBG</td>
<td width="123">&nbsp;</td>
<td width="151">AL</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">TES</td>
<td width="123">&nbsp;</td>
<td width="151">RA</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">26-Thg6</td>
</tr>
<tr>
<td width="132">LNG</td>
<td width="123">&nbsp;</td>
<td width="151">OMG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">RNG</td>
<td width="123">&nbsp;</td>
<td width="151">WE</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">27-Thg6</td>
</tr>
<tr>
<td width="132">LGD</td>
<td width="123">&nbsp;</td>
<td width="151">BLG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">FPX</td>
<td width="123">&nbsp;</td>
<td width="151">TT</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">28-Thg6</td>
</tr>
<tr>
<td width="132">JDG</td>
<td width="123">&nbsp;</td>
<td width="151">EDG</td>
<td width="85">18h00</td>
</tr>
<tr>
<td width="132">UP</td>
<td width="123">&nbsp;</td>
<td width="151">NIP</td>
<td width="85">16h00</td>
<td rowspan="2" width="85">29-Thg6</td>
</tr>
<tr>
<td width="132">IG</td>
<td width="123">&nbsp;</td>
<td width="151">WBG</td>
<td width="85">18h00</td>
</tr>
</tbody>
</table>
<p><span id="elementor-toc__heading-anchor-11" class="elementor-menu-anchor "></span></p>
<h2>Thể thức thi đấu LPL m&ugrave;a h&egrave; 2024 c&oacute; sự thay đổi lớn</h2>
<p>Mới đ&acirc;y, LPL đ&atilde; c&ocirc;ng bố thể thức thi đấu mới mẻ cho m&ugrave;a giải h&egrave; 2024, hứa hẹn mang đến nhiều cạnh tranh v&agrave; thử th&aacute;ch cho c&aacute;c đội.</p>
<p><strong>Bốc thăm v&ograve;ng bảng LPL</strong></p>
<ul>
<li>Sẽ c&oacute; 17 đội tham gia, chia th&agrave;nh 4 nh&oacute;m hạt giống dựa tr&ecirc;n kết quả của m&ugrave;a xu&acirc;n.</li>
<li>Để đảm bảo t&iacute;nh c&ocirc;ng bằng, c&aacute;c đội c&oacute; s&acirc;n nh&agrave; sẽ được ph&acirc;n v&agrave;o những bảng đấu ri&ecirc;ng biệt.</li>
<li>Bốc thăm sẽ x&aacute;c định vị tr&iacute; của c&aacute;c đội trong c&aacute;c bảng A, B, C v&agrave; D.</li>
</ul>
<p><strong>V&ograve;ng bảng LPL</strong></p>
<ul>
<li>&Aacute;p dụng thể thức cấm chọn &ldquo;Fearless Draft&rdquo;, đ&ograve;i hỏi chiến thuật đa dạng từ c&aacute;c đội.</li>
<li>C&aacute;c trận đấu sẽ theo h&igrave;nh thức BO3 hai v&ograve;ng t&iacute;nh điểm, qua đ&oacute; x&aacute;c định thứ hạng trong mỗi bảng.</li>
<li>Hai đội cuối mỗi bảng sẽ chuyển xuống nh&aacute;nh thấp hơn trong giai đoạn tiếp theo, c&ograve;n lại tiếp tục tranh t&agrave;i ở nh&aacute;nh cao hơn.</li>
</ul>
<p><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-6.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-6-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-6-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-356391 aligncenter webpexpress-processed entered litespeed-loaded" style="display: block; margin-left: auto; margin-right: auto;" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6-768x432.jpg 768w" alt="lpl-mua-he-2024-6" width="600" height="338" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-6-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture></p>
<p><strong>V&ograve;ng bảng LPL m&ugrave;a h&egrave; 2024 giai đoạn 2</strong></p>
<p>Thi đấu BO3 theo thể thức cấm chọn truyền thống. Loại bỏ 4 đội c&oacute; kết quả yếu nhất, c&ograve;n lại chia th&agrave;nh nh&oacute;m cao v&agrave; trung.</p>
<p><strong>Giai đoạn tăng tốc</strong>: 6 đội giữa sẽ đấu BO5 để tranh 3 suất cuối c&ugrave;ng v&agrave;o V&ograve;ng Playoffs.</p>
<p>Cuối c&ugrave;ng, c&aacute;c đội tuyển xuất sắc nhất sẽ bước v&agrave;o V&ograve;ng Playoffs, với một số điều chỉnh nhỏ về c&aacute;ch thức tổ chức v&agrave; xếp hạng dựa tr&ecirc;n kết quả c&aacute;c giai đoạn trước. Những thay đổi n&agrave;y vừa tăng t&iacute;nh hấp dẫn vừa thử th&aacute;ch kỹ năng v&agrave; chiến thuật của c&aacute;c đội tuyển h&agrave;ng đầu.</p>
<p><span id="elementor-toc__heading-anchor-12" class="elementor-menu-anchor "></span></p>
<h2>C&acirc;u hỏi thường gặp</h2>
<p>Để hiểu r&otilde; hơn về c&aacute;c th&ocirc;ng tin li&ecirc;n quan đến&nbsp;<strong>LPL m&ugrave;a h&egrave; 2024</strong>, bạn n&ecirc;n tham khảo th&ecirc;m c&aacute;c c&acirc;u hỏi thường gặp v&agrave; c&acirc;u trả lời tương ứng ngay b&ecirc;n dưới:</p>
<p><strong>Thể thức thi đấu mới của LPL Summer 2024 l&agrave; g&igrave;?</strong></p>
<p>Thể thức thi đấu mới bao gồm bốn giai đoạn ch&iacute;nh: Bốc Thăm V&ograve;ng Bảng, V&ograve;ng Bảng, V&ograve;ng Bảng Giai Đoạn 2 v&agrave; Giai Đoạn Tăng Tốc. Thể thức n&agrave;y &aacute;p dụng h&igrave;nh thức cấm chọn &ldquo;Fearless Draft&rdquo; v&agrave; c&aacute;c trận đấu được thi đấu theo h&igrave;nh thức BO3 v&agrave; BO5.</p>
<p><strong>&ldquo;Fearless Draft&rdquo; l&agrave; g&igrave; v&agrave; n&oacute; ảnh hưởng thế n&agrave;o đến trận đấu?</strong></p>
<p>&ldquo;Fearless Draft&rdquo; l&agrave; thể thức cấm chọn trong đ&oacute; c&aacute;c đội kh&ocirc;ng được ph&eacute;p sử dụng lại c&aacute;c vị tướng đ&atilde; chọn trong c&ugrave;ng một trận BO3. Điều n&agrave;y đ&ograve;i hỏi c&aacute;c đội phải chuẩn bị chiến thuật v&agrave; đội h&igrave;nh rộng hơn, l&agrave;m tăng t&iacute;nh chiến thuật v&agrave; dự đo&aacute;n trong từng trận đấu.</p>
<p><picture><source srcset="https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-7.jpg.webp 800w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-7-300x169.jpg.webp 300w, https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/06/lpl-mua-he-2024-7-768x432.jpg.webp 768w" type="image/webp" sizes="(max-width: 800px) 100vw, 800px"><img class="size-full wp-image-356390 aligncenter webpexpress-processed entered litespeed-loaded" style="display: block; margin-left: auto; margin-right: auto;" src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7.jpg" sizes="(max-width: 800px) 100vw, 800px" srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7-768x432.jpg 768w" alt="lpl-mua-he-2024-7" width="600" height="338" data-lazyloaded="1" data-src="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7.jpg" data-srcset="https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7.jpg 800w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7-300x169.jpg 300w, https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/06/lpl-mua-he-2024-7-768x432.jpg 768w" data-sizes="(max-width: 800px) 100vw, 800px" data-ll-status="loaded"></picture></p>
<p><strong>Những thay đổi n&agrave;o được &aacute;p dụng trong V&ograve;ng Playoffs LPL m&ugrave;a h&egrave; 2024 so với m&ugrave;a trước?</strong></p>
<p>V&ograve;ng Playoffs vẫn giữ nguy&ecirc;n c&aacute;c quy tắc ch&iacute;nh từ c&aacute;c m&ugrave;a giải trước nhưng c&oacute; một số thay đổi nhỏ trong c&aacute;ch thức sắp xếp c&aacute;c trận đấu v&agrave; xếp hạng dựa tr&ecirc;n kết quả từ c&aacute;c giai đoạn trước của m&ugrave;a giải.</p>
<p><strong>C&aacute;c đội sẽ được chia nh&oacute;m như thế n&agrave;o trong Bốc Thăm V&ograve;ng Bảng?</strong></p>
<p>C&aacute;c đội được chia th&agrave;nh 4 nh&oacute;m hạt giống dựa tr&ecirc;n kết quả của LPL M&ugrave;a Xu&acirc;n 2024. Đội chủ nh&agrave; sẽ được ph&acirc;n v&agrave;o c&aacute;c bảng đấu kh&aacute;c nhau để tr&aacute;nh lợi thế s&acirc;n nh&agrave;, sau đ&oacute; c&aacute;c đội c&ograve;n lại sẽ được bốc thăm v&agrave;o c&aacute;c bảng tương ứng.</p>
<p><span id="elementor-toc__heading-anchor-13" class="elementor-menu-anchor "></span></p>
<h2>Tạm kết</h2>
<p>Kết th&uacute;c b&agrave;i viết về 17 đội tuyển tham dự&nbsp;<strong>LPL m&ugrave;a h&egrave; 2024</strong>, c&oacute; thể thấy rằng mỗi đội mang trong m&igrave;nh những chiến lược v&agrave; kỹ năng đặc biệt. Điều n&agrave;y hứa hẹn một m&ugrave;a giải đầy kịch t&iacute;nh v&agrave; kh&ocirc;ng k&eacute;m phần cạnh tranh. Th&ecirc;m v&agrave;o đ&oacute;, sự thay đổi trong thể thức thi đấu kh&ocirc;ng chỉ thử th&aacute;ch khả năng th&iacute;ch ứng của c&aacute;c đội m&agrave; c&ograve;n đem lại cơ hội để c&aacute;c t&agrave;i năng mới tỏa s&aacute;ng. Do đ&oacute;, người h&acirc;m mộ chắc chắn sẽ được chứng kiến những trận đấu đỉnh cao v&agrave; đầy bất ngờ trong giải đấu lần n&agrave;y.</p>', 1, CAST(N'2024-06-17' AS Date), CAST(N'2024-06-17' AS Date), 16)
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
INSERT [dbo].[PostCategory] ([CategoryID], [PostID]) VALUES (5, 11)
INSERT [dbo].[PostCategory] ([CategoryID], [PostID]) VALUES (5, 12)
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([ID], [RoleName], [CreateDate], [UpdateDate]) VALUES (1, N'ADMIN', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Role] ([ID], [RoleName], [CreateDate], [UpdateDate]) VALUES (2, N'CUSTOMER', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Role] ([ID], [RoleName], [CreateDate], [UpdateDate]) VALUES (3, N'SALE', CAST(N'2024-05-19' AS Date), NULL)
INSERT [dbo].[Role] ([ID], [RoleName], [CreateDate], [UpdateDate]) VALUES (4, N'MARKETER', CAST(N'2024-05-23' AS Date), NULL)
INSERT [dbo].[Role] ([ID], [RoleName], [CreateDate], [UpdateDate]) VALUES (5, N'SALE MANAGER', CAST(N'2024-06-16' AS Date), NULL)
INSERT [dbo].[Role] ([ID], [RoleName], [CreateDate], [UpdateDate]) VALUES (6, N'WAREHOUSE', CAST(N'2024-06-22' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (1, 13)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 17)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 19)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 20)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 22)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 23)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 24)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 25)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 26)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 27)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (2, 28)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (3, 14)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (3, 18)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (4, 16)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (5, 15)
INSERT [dbo].[RoleAccount] ([RoleID], [AccountID]) VALUES (6, 21)
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (19, N'Tống Xá, Yên Xá, Ý Yên, Nam Định', N'0971617281', 19, 0, N'Hoàng Trung Hòa')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (54, N'Thị Trấn Lâm, Ý Yên, Nam Định', N'0111222333', 19, 0, N'Dương Huy Hoàng')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1026, N'Thạch Thất, Hà Nội', N'0111222333', 19, 1, N'Hoàng Trung Hòa')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1027, N'Địa Chỉ 1, Xã 1, Tỉnh 1', N'0111222333', 20, 1, N'Nguyễn Thị A')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1028, N'warehouse', N'0111222333', 21, 1, N'Warehouse')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1029, N'Tống Xá, Yên Xá, Ý Yên, Nam Định', N'0999888777', 22, 1, N'Hoàng Trung Hòa')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1030, N'123', N'0111222333', 22, 0, N'HEHEH')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1031, N'Ý Yên - Nam Định', N'0999888777', 23, 1, N'user2@gmail.com')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1032, N'Ý Yên - Nam Định', N'0999888777', 24, 1, N'User 2')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1033, N'Ý Yên - Nam Định', N'0971617281', 25, 1, N'User 5')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1034, N'Tống Xá, Yên Xá, Ý Yên, Nam Định', N'0999888777', 26, 1, N'User 6')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1035, N'Thị Trấn Lâm, Ý Yên, Nam Định', N'0395071064', 27, 1, N'Hoàng Trung Hòa')
INSERT [dbo].[Address] ([id], [Address], [Tel], [AccountID], [isDefault], [FullName]) VALUES (1036, N'Thị Trấn Lâm, Ý Yên, Nam Định', N'0395071064', 28, 1, N'Hoàng Trung Hòa')
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
SET IDENTITY_INSERT [dbo].[Slider] ON 

INSERT [dbo].[Slider] ([id], [title], [image_url], [link_url], [Status], [CreateAt], [UpdateAt], [startDate], [endDate]) VALUES (1, N'Fire Exit', N'slider1.jpg', N'http://localhost:8080/BookShopping/books/book-detail?book_isbn=9781959030553', 1, CAST(N'2024-06-03' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Slider] ([id], [title], [image_url], [link_url], [Status], [CreateAt], [UpdateAt], [startDate], [endDate]) VALUES (2, N'Hirayasumi, Vol. 1', N'slider2.jpg', N'http://localhost:8080/BookShopping/books/book-detail?book_isbn=9781974746910', 1, CAST(N'2024-06-03' AS Date), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Slider] OFF
GO
