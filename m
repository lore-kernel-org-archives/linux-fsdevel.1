Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F942A783
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187485; cv=none; b=T1CWHnH58qZd7u7McIpRiJaryFXyoNpTCQAEsORQUVOfVKA2FKa6vN06SFwIw41PbCKzOlELI56KGaqpo7EXjxGg+BGLN+ZcRAX8ZmQXMjhr5cew1qk6GaJdts4l67XZwoZ/w3L5Jg9koF1T+yPMNHNe4fu7c14i8O87vp1f2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187485; c=relaxed/simple;
	bh=opq3fTnsrXEXUis6orE/E1kvybn4ouWYX+/mNx4cXic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey2h134ur+lsnynEVX6Jhcprnkk3YSz8WK3sATMcYPcX1OLUUml41m6W9H+3oOU0H+24nuVSKuZfX0mmg0cbZu9zqUyUuRuQUPULaKj9ICL/qBmxN/Q7ojH6DAtvvZVfwPyFxDY5X0A6zxfIjoHxkDboowqC+vdFzyz9cUy3HZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRPBA9YB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRPBA9YB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so32852025ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187483; x=1785792283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBriYrscy2lsMSBh5lhjAC8bZyEaS+6CxeuOVAvAWO8=;
        b=LRPBA9YBbftSDfU7JQOkIbjNgi+qzmebnTsJiSQt7PuJsQvmQ/chuCLVVbP2Gpyia5
         79bHhOGluM/kD/MUL+l9I2S9EejNja5RJ2EdO2SmY4TS61yvjLLtmjtGrw7KrG0AnYeQ
         QhnQx9CUG5N0yx5rzIJdpyxSBgj2IlwPI0W+MygvYHRedNHX48MpHLbjCjbjzfeQrCwg
         CTLMP/Aco3bmLnoKZSzDYx/Us2hDmAMjSC1WX5F+wSys5nkVB/sH2s2bNUi9UMp4VlGG
         U8DtXEFA8yJ/0Ir98KCl/YXeCmDUEHZ3f1wQpAIh/NSmI8OZtORm2/xz2fEGj7KM/4R1
         K3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187483; x=1785792283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBriYrscy2lsMSBh5lhjAC8bZyEaS+6CxeuOVAvAWO8=;
        b=E5qkat27BSiZ6NjFznfyjbDRQA8+Nn1WoqoNCQqj2z2O8f3mMNVTE2Dyrfm6Zz2VUg
         03sS7lAs/BYkOp/9J1nzUEpyvoztFvP/7IVsjzHPphPt8X1v36d6AER3iZCMmOZwi36F
         hcWMZbLHzdMOYjj0tBTOKorBl2xAAgXaWwg6D6nJ+6XbnCyyWEL+2/eFtrfzavIlr2cw
         VUnwWmwciUY/uDPhi4m3+x5j94TrgRFpReagx9F89U59YAq5G/3JYMCdOS2V2GKylof9
         a+hKMfFqRxVGZ01rFSqxTbKI0ufegXkqPwQkbk6Iu9xFF1Y50Ck/ofpYC7IGBu3AQiBU
         WqPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkTt41E4TqenbWMynMcjVt/Sbn4AxV8emKkcNxoQ4isqNuQRWAigfxsf/yw/aF/dLKxKdR33LBJM9nfKKD@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsFOftDkl5mOPucikzrVZfr6WM02xuGsWW7F2jalBaFw5exUZ
	UcKYcWARpua5pr3zFaA6RrpZrRuaz0E675dhs13u/0LiPJt6B4ACe8FY
X-Gm-Gg: AR+sD10Vfk11EG4AGPdoDfBFuA7n0IM416u9pBzpOK63HZ1GRIe2brpTCO14zJbkuaX
	okogTsSfO7HBw1t3qQ0reWH4W8OVgeg3Tf+9aKEY/W2t+aYGRUwEYxGzhIUUL74l2wcXq2H5dcs
	HQtdhxMHDzl+RszVHJCGTkTXc6FXNX8GmE2C/9oROHhDQG53NOlmvcHHKdI/I7tLY4ClbS2puK6
	9QP/v5EHRTeW2KpwIqOHp31VVPnwwijqKpwhljh8ZslrhaMstiipo8n0KJdLmWOm5I+P+9TRm9M
	7Z8rInlsA5JFu+TghvjZIPPH0XUwwNTrsqO64pf4GhAKqwQ4jwBvmklNsLdX+Oa8tlExrrLndqT
	fTKehvF15HH3OJW0JX/nMaatHWpM4fNWd5GCl5DBSb0Kklm3o1PLyXFb4CsbduDFlKF6raTa3Wu
	LtHKFIk6qgOnmslZYTYruoJ7sDy6DKZ1wFCtIS1UFAvGgiu9Q7w2BzXA==
X-Received: by 2002:a17:903:1aa7:b0:2ca:ca48:c380 with SMTP id d9443c01a7336-2cfde8a5229mr95192185ad.47.1785187483211;
        Mon, 27 Jul 2026 14:24:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde4650a5sm41237635ad.0.2026.07.27.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:42 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 08/21] ntfs: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:45 -0700
Message-ID: <20260727211758.1116539-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ntfs iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ntfs/iomap.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256..d0964ac840d9 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -277,8 +277,10 @@ static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t leng
 			srcmap, true);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ntfs_read_iomap_next, ntfs_read_iomap_begin);
+
 const struct iomap_ops ntfs_read_iomap_ops = {
-	.iomap_begin = ntfs_read_iomap_begin,
+	.iomap_next = ntfs_read_iomap_next,
 };
 
 /*
@@ -329,13 +331,17 @@ static int ntfs_zero_read_iomap_end(struct inode *inode, loff_t pos, loff_t leng
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_zero_read_iomap_next,
+		ntfs_seek_iomap_begin, ntfs_zero_read_iomap_end);
+
 static const struct iomap_ops ntfs_zero_read_iomap_ops = {
-	.iomap_begin = ntfs_seek_iomap_begin,
-	.iomap_end = ntfs_zero_read_iomap_end,
+	.iomap_next = ntfs_zero_read_iomap_next,
 };
 
+static DEFINE_IOMAP_ITER_NEXT(ntfs_seek_iomap_next, ntfs_seek_iomap_begin);
+
 const struct iomap_ops ntfs_seek_iomap_ops = {
-	.iomap_begin = ntfs_seek_iomap_begin,
+	.iomap_next = ntfs_seek_iomap_next,
 };
 
 int ntfs_dio_zero_range(struct inode *inode, loff_t offset, loff_t length)
@@ -764,9 +770,11 @@ static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_write_iomap_next,
+		ntfs_write_iomap_begin, ntfs_write_iomap_end);
+
 const struct iomap_ops ntfs_write_iomap_ops = {
-	.iomap_begin		= ntfs_write_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_write_iomap_next,
 };
 
 static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
@@ -777,9 +785,11 @@ static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
 			NTFS_IOMAP_FLAGS_MKWRITE);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_page_mkwrite_iomap_next,
+		ntfs_page_mkwrite_iomap_begin, ntfs_write_iomap_end);
+
 const struct iomap_ops ntfs_page_mkwrite_iomap_ops = {
-	.iomap_begin		= ntfs_page_mkwrite_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_page_mkwrite_iomap_next,
 };
 
 static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
@@ -790,9 +800,11 @@ static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
 			NTFS_IOMAP_FLAGS_DIO);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_dio_iomap_next,
+		ntfs_dio_iomap_begin, ntfs_write_iomap_end);
+
 const struct iomap_ops ntfs_dio_iomap_ops = {
-	.iomap_begin		= ntfs_dio_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_dio_iomap_next,
 };
 
 static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
-- 
2.52.0

