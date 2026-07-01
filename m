Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB324255F52
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864734; cv=none; b=UwKyTEkDyBBbtMr+Y+W8HXA/ACnU9OLr2av2Xip+AYjMi//irnM4e/VgbyI4RUyN5wq01TbQgX3dutwnZClNjuzhBsmXLdr9Kf0e8qz4z+Wgqqz0pcNpvlf1VPNSYQ3cjvZLXCSja1bybGOcvVfRblBWo+R1p+rerraAKj8hUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864734; c=relaxed/simple;
	bh=h59JTdqn/42/gchFGAM3LUvGK0F8x7ML/DBAqwZs1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvgGwUkuRJ4M4/v0QRDLG6qXPsBuErUeBeWhrEj+iuOjsjO7TKnb+/i+ykPYnQnjbLo1LVd4ATAGfVdESb3xUsXhonTbXH+vgKOKZ3Ckoh7yf6peIHLdidWUPD5K9JcKhXvGp7w4m2qIVWFJg5DIHfkNUfvdrxLGoqes5qkdFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsKvZAIo; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsKvZAIo"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9cd40e582so36499a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864732; x=1783469532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUC+pIYjnCyM2bPhe5VdWcXqL/RoPGRahY8oP++6v8c=;
        b=dsKvZAIosQidEDEPPCxtfJTrXwIYA0ndsmHDWF3hASj71ZRTLkdzGBjMTd3cqDbDqE
         3d74Fjihept9QpEh82UwQnnnurdtFXYGVr5lw8oA5y+TUXTyyB8l7scap8xyeHFGxwyP
         6TVfD88dFHRpJg7U/IgxyTu8X1w0FYaVZm4dwiPJm15srQRe4MhwghYzkLKM1Umd5cZF
         JmpY910cxXeGiie7GRLTJFsuuYXJ0o/Z6Y61QQ0jvtrPF45QuzsLviyfWNIbgUpB0BAq
         DUKQR+V9DSNCGjMu2oCakaGWBOFWSeYMTgQw2m69UBZL2YYXSbaRTKn2sQ+VguWXq/YR
         8rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864732; x=1783469532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uUC+pIYjnCyM2bPhe5VdWcXqL/RoPGRahY8oP++6v8c=;
        b=lsbtJWdWu6J3APAb8IQjQkwvHTpJBp42d62beuN7SmSxNTOweJrbP9Y1H3HcC0SIjo
         Y4pVwhEEaNyL8kG37Sd7BV6x5aXxx8jwYGtHQAphnazYSo8b5+c9b5Fty6grQPGMX586
         cVtOQyXMAAeHBKBZjb/px7/NJtKRxd0ht7ORHDbzjkmz+4OLP6pQH0aWja+/btRUv7yy
         72vifZT5+nyntBNkjYs5ht8fmFqoXePDCxnAnk8/ZKVeIdmz/xzbY/GgjB5T16DGkPSB
         0bvCxXjKWo4vPbqEuFKZwnY8vQC1HNvMSE9wNH82dryujxrqC5blCn4ujsZB4qACfJzP
         mtAw==
X-Forwarded-Encrypted: i=1; AFNElJ+snDNGO57yKmMwA1RiLp1omf9iIY8dpw52OZUD4NqThYFrPQnF2+Uh91aTGQBds+vzgeftBf0d5RNETjty@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhu9Vt3Bi5X+OUuKwziTAsK9OG6CyfZ76Wf6icFNT+PJmaRLJ
	mi7zzZ3Fa0zvNaQcIfCt7nHOMYTflQSS65Up2kZ79pRebpfZtSRv/WXa
X-Gm-Gg: AfdE7cnjuAVwU4v+9nW4penJqnkpXiKIjcz6VpHm3cYSpcylBMpyIHNQ63u4JuOKQa0
	qNB04c8veJgb3vdA3njjeFAhdmpxyoUxb35e/fjmtpCY0cYKCeOx3ma42fz9h9faE14wyr6RQ2i
	00HdHzcvsJoPsaWQx2sQksd8EwyOtbW1XaavfD1zt4YU8et7o8IFsa/YqN+3Ii9adoWjaoJBTxD
	hJBvVfXS0I2L67Y8MFeUI5jPdme2+fwxvPXqVzYGSBN6Qly6JYp5viTYTiV0D8RrMAO0HcuuA/4
	dKG7gnxgaGR4Y2rM6VZflI54+qtOvZbxxUJlNHcWx14/Uplkw/vwoULXSYaVfbBJA8r5IZHrblt
	aNxBGgdTnKF5vf4vye5+uORZ3ZYaEAU7slWc3RzyVKFliDFplKtz5kTWYBi1C5VOcY+zwpdBaRG
	0ItUswxtlvdew5LVLvhtGqG5DhYG6Vu4/045CqTkf6F+ftrH83K494HUAYmhrOvO8H
X-Received: by 2002:a9d:3e18:0:b0:7e9:f8e8:d8fe with SMTP id 46e09a7af769-7e9f8e8e560mr1802853a34.24.1782864732015;
        Tue, 30 Jun 2026 17:12:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2ba18esm3690107a34.16.2026.06.30.17.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:11 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 15/18] exfat: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:30 -0700
Message-ID: <20260701000949.1666714-16-joannelkoong@gmail.com>
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

Convert fuse iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/exfat/iomap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 1aac38e63fe6..8d33690a562d 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -151,8 +151,14 @@ static int exfat_write_iomap_begin(struct inode *inode, loff_t offset, loff_t le
 	return __exfat_iomap_begin(inode, offset, length, flags, iomap, true);
 }
 
+static int exfat_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, exfat_iomap_begin, NULL);
+}
+
 const struct iomap_ops exfat_iomap_ops = {
-	.iomap_begin = exfat_iomap_begin,
+	.iomap_next = exfat_iomap_next,
 };
 
 /*
@@ -186,9 +192,15 @@ static int exfat_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static int exfat_write_iomap_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap,
+			exfat_write_iomap_begin, exfat_write_iomap_end);
+}
+
 const struct iomap_ops exfat_write_iomap_ops = {
-	.iomap_begin	= exfat_write_iomap_begin,
-	.iomap_end	= exfat_write_iomap_end,
+	.iomap_next	= exfat_write_iomap_next,
 };
 
 /*
-- 
2.52.0

