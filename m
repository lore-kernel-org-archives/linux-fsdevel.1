Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7162314B8C
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803561; cv=none; b=fLyHchT1zlG9+rRRcjZNj4p5cvtnm+4yemc6lVYz69eSi5lMxxsjRL/xKAUjY8P/1uBfUgUL7NUIZATue+Qie0+5UhzD3Wr1NwmJmKzDwXdQYH1VsXI2uaYT56FzKpXF7Mdiq4qheQ4EXEPuSdDjeAfZwG2GlDWoOiYPsIaUBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803561; c=relaxed/simple;
	bh=eimG9XEE0URF2SzaH136zk48Fc7acApR5oefaesDiWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQZC7Nu77NIZP3Sh6G/IfQogInoK4MORLzjJVL6lEBtfmyG6gULRw0+RhwUi69C9o1dUMxxRm45P7QwwVAnEbMH8w3pOktggR60Jr6WNaFB14sYj1RdCDHL9V1gxRheJWYTFl0Thrb7+2NzshTYi2W3kt3f48L/iXWMffF5oHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y66xVp4O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y66xVp4O"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848882fdb18so1031598b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783803559; x=1784408359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJJSoaUqwCHC2v0nACew6MdUN87VPmOrK8EaocGT768=;
        b=Y66xVp4O8bggq/neX8dAbEtaCo67rlP6oLdcsP618W8U9cS4v/d07+qtavRxJD98k1
         LWOtTtWp+OXAMBc2ZCNhKFS/qOe3BNSrfr1BVC1+KucVFNXtaxd1+89KAJBAIwtGF6QQ
         MKOh4lrgXFgbbIv6PCB6qCP6+1pIHljFawz8xjXIrTez7hPH6DAyOU/KBBEkxwSKbFUb
         UBjev+l+u0LNvicpAyZctustHcIPDPu0J/OCIEv6ogwjB1xE8eyf3yo/48WgUNOIutze
         9nP/0h73WxbZzDLMFCFinnKu5eerBTasHSSfNmmuogO9Ldz2E/jCk40NUbxdWDd+DiBe
         3kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803559; x=1784408359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJJSoaUqwCHC2v0nACew6MdUN87VPmOrK8EaocGT768=;
        b=L12IoIcmmeze/D79s8UXqvsgbMtr49Pj43QqbhbaR9FlAEX3eyrAMCk8QedkJ65ogf
         i1vyPhgEOLaC/ECI5GH0iIlasn9Tox9MEj5V0s0R8cjX/IythStbcYXYsHqJl9s2dmSV
         SeW4NCzOwsNTubrlA5sjv/+S7ndwzaVh07aeKjAQjJOxn0d7NXuktUU9Nhq8OWo2gKSg
         VuCdzypbj3a1seb42C9M3xhBkB59vI0ZeNVX9BQ8H43EVOM50qvhpGV4QyfwlwNWmbG4
         1Sp6HEn3OY4OWl8cw0hr7uRwyrmNWv3gO+JVzqWs2zfDkl4ItGkdpGHU4w9joiX7599b
         rgeA==
X-Gm-Message-State: AOJu0Yxr2pIDsVFKP27qIgnK1vmn4fZAtu8eIFs5xDoCVfiNGHUkR5Vi
	CktzZf8mr+dNi+KsjK7QcGuKMYrIpnqGExqnHkCgWsk2aczNNTwQDA2Jon7h7A==
X-Gm-Gg: AfdE7cmj5ANwNRrxkktd/C92G/yHmssW4/sMLy+0DMYXARn3ZaNeDJXZH1KMDfub6Cr
	S2YoFObg6pwRGyxXH4MwIbtKADaI3h7eWmnUi+qzEgEBsJZ2FHvNFcY2yHphj91QfHS3Lrx83I3
	Int8ILxqp3l086NAoFN04wHeQKLPcsGbn5R1AY5StBHS8LZN668KiLFPwwW9yjS7b6UHoUQfObs
	XQrGMDSVf/Ec44nx0o10grL/f1QMyjHGeVWX78/xaE2nlRRxEEihFfDvff7OSQ/PpJJzYA7s3Ry
	8g1tYYRWDL5A1tvkmJUB9UU9VUkXdFaFb7SR9+rMBNSg/o3MNGhaKOXYCBOw0w/ob2IPdB9Ahsv
	+uzt1wbN2U8OKOT1mPVd0F6qT6II/UyPtBmRHTMkAVVWcEAyyyaT3L9npGfyj7tA=
X-Received: by 2002:a05:6a00:3494:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-8488965bcdfmr3290961b3a.24.1783803558981;
        Sat, 11 Jul 2026 13:59:18 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm2092057b3a.20.2026.07.11.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:59:18 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v3 1/5] iomap: add iomap_symlink_write
Date: Sat, 11 Jul 2026 13:59:05 -0700
Message-ID: <570b47ec69233efcdde6644fc11bc5a8af6a9577.1783707063.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783707063.git.jbingham@gmail.com>
References: <cover.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new iomap_symlink_write function as an iomap based equivalent to
page_symlink found in fs/namei.c. This implementation was suggested by
Darrick J. Wong, who also provided the initial implementation that I
only needed to change slightly to get working.

Suggested-by: Darrick J. Wong <djwong@kernel.org>

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/iomap/buffered-io.c | 31 +++++++++++++++++++++++++++++++
 include/linux/iomap.h  |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 276720bc18dc..6f3f79fdbd8b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -2066,3 +2066,34 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 	return error;
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
+
+int iomap_symlink_write(struct inode *inode, const char *target, int len,
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
+{
+	struct kvec vec = {
+		.iov_base	= (void *)target,
+		.iov_len	= len,
+	};
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= 0,
+		.len		= len,
+		.flags		= IOMAP_WRITE,
+		.private	= private,
+	};
+	struct iov_iter iov;
+	int ret;
+
+	iov_iter_kvec(&iov, ITER_SOURCE, &vec, 1, len);
+
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.status = iomap_write_iter(&iter, &iov, write_ops);
+
+	if (unlikely(iter.pos == 0))
+		return ret;
+
+	mark_inode_dirty(inode);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_symlink_write);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 56b43d594e6e..9274fa256bc9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -393,6 +393,10 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
 
+int iomap_symlink_write(struct inode *inode, const char *target, int len,
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
+
 /*
  * Flags for iomap_ioend->io_flags.
  */
-- 
2.47.3

