Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BE190473
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864695; cv=none; b=C6wT7f2KFK9HVIakMAJeqgXHouf7rZ5ASllI6PsU7qn+HFb2++e3r8VHNEGSr48+a7lUsOnWqf0bvSTt3M05+H+Lb65IxrlBthNlNs88DDkbvASHBon/wztqTNPdoYZ9opDQlmweI8bex9hNZeI9RMQuH1jt1/nAcFODzrMIQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864695; c=relaxed/simple;
	bh=GHBQ4M07NJw6IdGMb/Vsg8l8qqZbiKFmM+Iz88nZqN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH52sjCu+M5m/Y3M6RltnEUjsXxBBihHxfzsrUGyZKpe+8GD6RBAymAX2lez1AAeuJcuPYPq2pBMU+7aPx1UqquCeBttBFLWLXKl4nAZnHSJ/QfW86EmmcscbhRWGamclPiQFHJP7If0dQ6kcVsAadj1uro/Bd+HZC1coY9F7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhwB8u8e; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhwB8u8e"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a198cdc4e4so25237eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864692; x=1783469492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzFOMzoZ/TuBR5zRrI/HwvF0+uDiZgYlmh/DCwsRYfQ=;
        b=GhwB8u8etTnd9n5iRgB1BTYVIuNcB0ZR2OXbJ3HvknmiKzKvnRE6xb1VWvDtsv69Kg
         omHRMW1qAufmzCerd1yzHGIytBvUojoNRO4BuUn+MG0auRNotSz/Ln45diMZs7qBm/Hf
         sdD7C6XVV3HTEBDOKSy5BL+lkbft9Whzqr39dlnFdhuySrqrdtZaxWJ41aCNVGFk4wk8
         5vc3Cp7nch+KOY0hFiwgEdq2US4ADbgVLAolXappqaurTi3Dt8OKCiaJV16BRAYa5v0t
         yHRB28NyGms6ezd5/gjryeXgPHZu6QDjhasCoLkHh+NNmwH2HOusoX+zKvDeZlf5MZh5
         WZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864692; x=1783469492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzFOMzoZ/TuBR5zRrI/HwvF0+uDiZgYlmh/DCwsRYfQ=;
        b=knAuBlJNHAWskUrMJAjYMhtuZH+kDSL36nenRuTaQeIM2Ffm3UU5MCFA7bMDBTdG9U
         xit4xX37iFo9pExz7OIOyygEXX/wdJVCP8nXf2zO2s3MKSyUwjQLuNOWr+EYwC8x4xLq
         Jo46p74no6YgywkI82pi22kxffcOfzb4dN1H1rkd91f/NDeYD2hFeitP/LGqPmRAO4CE
         lY59eA/1NOsqEATNws5YIzb01atvtFggDzwrWQykxwdd6YxskosubMZZLxZqhG50m+8a
         XG9WxhM4e912QaXj8gENwuiisjJH1U8uk/KxzJTqZ6MON2hEspo3VasSSh+vk084qqPO
         gsZg==
X-Forwarded-Encrypted: i=1; AFNElJ+/7Z15/Y2sjDlleU+BaockZ+COEAzVrpYAIxIuiMY9tJ2XJXkmDr72NvFJ+azWlZ2wrEPnJYN7rxTwuL2V@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4gjy5nNwp197XKIIlS5tVkI1UpW6+yuG5oTnoktTXmQHVavO
	eLJMeMGw7XrlqlhltdI1tOIqEq00F1wnJhDflfoSbOqVa+nei1SkI4eg
X-Gm-Gg: AfdE7clJ0f6/3fk6Mbu5YqJXd7vvpe8hUrYpkMhlfAoj3DLn0xb0tuounUuix7S/VFY
	aFCBgGr2mqzTYvI7eYhJk1Cyj1/TarP6EcmdDzqAWWV4zE5OvotHK8vi5GVyh96/pkflU3sYjCA
	4OoDln58ko22VTQf1uJwyZOc8k4FssitdyDbPWV+BfNAPjAgBBX4QU1K0OxNiZZfQYFSUbvAITY
	oc2ZU/+iczD4KvaswNqxqX3kA+YswMBspUpdxBC8Bt5t3dQO7+NTMHC+GqqyxuqgEL8O5kHAvUx
	ToA5u/lTLfNYa9KGSZ8Q7CxEzIk0O2ktoTZCt9lNxbLImZMOvUE0f2d8ZnanMdMClE48RVIwfij
	kqMTWe1vffM3gqDbm8ZIv+tRb5i+ujJNaS33yPMRBmV7Sbrzr1MPJECKEmYSvx/dOZJT3mCHTlX
	9miSfnRKMo8kt+LZPmTCgrYW/0NUk+NMQNc3DUONP67RQzM0YOzBXMmaGJHpnxYt0=
X-Received: by 2002:a05:6820:4c11:b0:6a1:50eb:d50d with SMTP id 006d021491bc7-6a196cbb08dmr1695221eaf.62.1782864692434;
        Tue, 30 Jun 2026 17:11:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a1891cf544sm3043560eaf.5.2026.06.30.17.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/18] ntfs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:20 -0700
Message-ID: <20260701000949.1666714-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ntfs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ntfs/iomap.c | 56 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256..0f9f02e1593e 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -277,8 +277,14 @@ static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t leng
 			srcmap, true);
 }
 
+static int ntfs_read_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_read_iomap_begin, NULL);
+}
+
 const struct iomap_ops ntfs_read_iomap_ops = {
-	.iomap_begin = ntfs_read_iomap_begin,
+	.iomap_next = ntfs_read_iomap_next,
 };
 
 /*
@@ -329,13 +335,25 @@ static int ntfs_zero_read_iomap_end(struct inode *inode, loff_t pos, loff_t leng
 	return written;
 }
 
+static int ntfs_zero_read_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_seek_iomap_begin,
+			ntfs_zero_read_iomap_end);
+}
+
 static const struct iomap_ops ntfs_zero_read_iomap_ops = {
-	.iomap_begin = ntfs_seek_iomap_begin,
-	.iomap_end = ntfs_zero_read_iomap_end,
+	.iomap_next = ntfs_zero_read_iomap_next,
 };
 
+static int ntfs_seek_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_seek_iomap_begin, NULL);
+}
+
 const struct iomap_ops ntfs_seek_iomap_ops = {
-	.iomap_begin = ntfs_seek_iomap_begin,
+	.iomap_next = ntfs_seek_iomap_next,
 };
 
 int ntfs_dio_zero_range(struct inode *inode, loff_t offset, loff_t length)
@@ -764,9 +782,15 @@ static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static int ntfs_write_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_write_iomap_begin,
+			ntfs_write_iomap_end);
+}
+
 const struct iomap_ops ntfs_write_iomap_ops = {
-	.iomap_begin		= ntfs_write_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_write_iomap_next,
 };
 
 static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
@@ -777,9 +801,15 @@ static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
 			NTFS_IOMAP_FLAGS_MKWRITE);
 }
 
+static int ntfs_page_mkwrite_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_page_mkwrite_iomap_begin,
+			ntfs_write_iomap_end);
+}
+
 const struct iomap_ops ntfs_page_mkwrite_iomap_ops = {
-	.iomap_begin		= ntfs_page_mkwrite_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_page_mkwrite_iomap_next,
 };
 
 static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
@@ -790,9 +820,15 @@ static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
 			NTFS_IOMAP_FLAGS_DIO);
 }
 
+static int ntfs_dio_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_dio_iomap_begin,
+			ntfs_write_iomap_end);
+}
+
 const struct iomap_ops ntfs_dio_iomap_ops = {
-	.iomap_begin		= ntfs_dio_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_dio_iomap_next,
 };
 
 static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
-- 
2.52.0

