Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212274;
	b=x78KQgZYodVE3Kq2uI1fj9qFq0zER7x+5IsxNDFxjASNBjkE1CYnt/5JgBHaW041B5vN
	 l3RnM3/dMKxtDM486P23uKJ15TxN+zy/lxX13aYJWQ07EdXWaxfGtXyBNSJxEj9qCi5l5
	 sTKutReaxX5t+xFwKBvrjnTFxY4ETL/p/7GGGX9nUkOH2ujPOsnU/39B/pfSdzCMA2wk7
	 8djxLjnLjh30/kA68KkYoFDF3vLevUodU0Y75qB6gs498dHPdkpHY/EMPTSg8gwk6DNSk
	 YuvChalPjOTbSNNO1UMWni5uHv1kNejKgqjT04kPbx4IkdNV0THOcETq9vy0qo5ibTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aa7qEaxeOlG6UrT9v6iaZAnn/jfDxPey+mYNfYgCTvs=;
	b=RRna+Ub44ucvfik+Q3hdfL4dBHLvNUsDtOaZDTdWxFCOUmed5QNEqZe6OsEaPeMZ1a0A
	 vKSHuUSlyFoiuhFA87Dzg5eqDLCICYjWtqhn+Vc/ghIRkv8R9rNypPK4wIpXtXcsH5dSe
	 ufi+VSDyYhYgjRVHVav4w4HQZgJnvq1P1UTgV6j8CvMhLv31CspulLl6+4UYRVspyW5Ls
	 efG31KgPh8LnBvNsbwt3NCQixDvxvZF+dYvt0jNAsN0lvmIGNkOG6IcV7Ex2jayAWeW7j
	 RLSoqU0uXCO25eIEuBkCwxlyDO/LbwC+Kbz4B5emMMuG8PitneN3eNJWb7NWuXbLBGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cg+8Bhwg;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C6606A6A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 22:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9C6606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cg+8Bhwg
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e3b22e971so777669f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212263; x=1795817063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aa7qEaxeOlG6UrT9v6iaZAnn/jfDxPey+mYNfYgCTvs=;
        b=cg+8BhwgWbN2VZWtTAwg5us6kIYKWVDH3XaOE5L7EweTD2fWI4FPIVM5Gpk3DZ0Dz5
         uAQOwVFUx4wAO6fS+ImuvU1Irf84hJ9Wdd1qy0HBJx/JKpLVUNXbFEuU8Pdfmyfgg2W1
         ecX0vZQo/hmo2KrLnsd/kHP3Ub3QbLLYxraLlMQGCxaC/ZT/TtIpmS7blfidlkF7/OY2
         GX9R2t2F//APRQXoeZYDiFg1I3q/LXrsZxOeoiyISxjt/ybh6IwjY70Li7N3j9GcnN8i
         7LmDxTrITawHLsTvrgwpVe+FMaea4NuPEuXt8D+rDQ4Bi5GzfuKFRr47kpGG/sTWmmeH
         6mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212263; x=1795817063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aa7qEaxeOlG6UrT9v6iaZAnn/jfDxPey+mYNfYgCTvs=;
        b=J7DCxwLj6puJA9EnW+YmpCepF5MjHD7H4bOtZyv6miau42EK3UjGknni10HWs7b+l4
         fJJ2/yTX7ON68u0OuevzoFmrPlBPl9JkQCAWpiRt2v68wk6xLh0R7jQQXzK0HTGjccpL
         sZZgwaiCSDCG7gJcjz4vWuvj3Vbu+SDU4KbvmiV7WjrXyXXF2EP49xK0mBQ99MFeT7wC
         OoepstM2KIhrO+ovBSvEHRpIXQ+x0VURDjdzI5zx+20J4oBU+PNGOazI3vcjkz8r5EW1
         2mzbQh6KKURKtMN6nxYELXTCo4m1yubOs3vRNFuG6DROWN6YNc8rW5ZKxDNTvHaUQKmO
         0IHw==
X-Gm-Message-State: APuU4Z+c6hnAa81aTxGnd/mwr6ksnaVoJn89SqgffySS6FlIskRoJPmF
	db5uNVBijDtdt+DdjbFnAE6cq0WGrfsK5jBCOOnSiDZYSOX3SMkEZTG7fFGhPYzd
X-Gm-Gg: AZFdTZdkbr+Jygilq65mUjMVE3a44RGtbVRMd9PFH3lv2DT3XhMmcjXWWzt5JiRMUEG
	j3Zqu2/RW6Vq5epBEr7V+GLexa4ITpXtXalVluS2THt7MvQj7f16PrIv0euo7jG23gif8oPDCqW
	vYCYoUflvRE02VKPF/PlwQ7uy26IlyKe4bj6u5UqwDV4ITeOPB4/+smbybcf4piDPZ6hzvetMcf
	+H+AtXgn18+5zWalHv9THzhtiYPgH0tbyXU9NrjI1cYU3UWXq4XRWECBudX2POOpNnSWgSsmrqp
	V2vRWw40ZUq4nCKGxt2WKUmLAGQBWUZre7FZOKGxkDBMpDogr6F3+6Ni3hbwSYVOCINB8p2PaeW
	HVhcIfPcMFz21FFxAl4xPYvfk6/YkSbHKzKdXcnIvYAob8BT4HWWXpEFsuwCfNwWdwdVcLmPoeI
	QanccR4c3eRnP6Ff9ijwgqQ/kNdj58QvAW1PFCuFQYJVpm5pealdcTjzfcMSKWtmyZj1o403Nip
	4SSkbZTyoj8iUdiIwcaT7ClEzu1JYEjv6rcUCyFZp8CJv5HopvFkDS8uoCSHTP7uU3QXHh2fnOI
	pUg4kedsF+c4Uh5d9UGUWd5AfQdzRfMAtHeyLf178AzjiLaZBSacNt+eqw==
X-Received: by 2002:a5d:588b:0:b0:48e:66d0:664c with SMTP id ffacd0b85a97d-4abaf64be12mr10171630f8f.15.1795212262648;
        Fri, 20 Nov 2026 14:04:22 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm7156629f8f.23.2026.11.20.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:04:22 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] qnx6: fix divide-by-zero and silent magic check in qnx6_mmi_fill_super()
Date: Sat, 21 Nov 2026 03:03:54 +0500
Message-ID: <20261120220355.137600-1-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a divide error in qnx6_mmi_fill_super() when mounting an
all-zero block device with MS_SILENT and the "mmi_fs" mount option:

  Oops: divide error: 0000 [#1] SMP KASAN PTI
  RIP: 0010:qnx6_mmi_fill_super+0x228/0x870 fs/qnx6/super_mmi.c:68

Two issues combine to trigger this crash:

1. When sb1->sb_magic does not match QNX6_SUPER_MAGIC, "goto out;" is
   nested inside "if (!silent)", so mounting with MS_SILENT falls
   through instead of aborting. An all-zero superblock then passes the
   crc32_be() check because crc32_be(0, zeros, 504) == 0.

2. The second superblock offset divides QNX6_SUPERBLOCK_AREA by
   fs32_to_cpu(sbi, sb1->sb_blocksize) before sb_set_blocksize()
   validates the blocksize, causing a divide-by-zero when
   sb_blocksize is 0.

Fix both by moving "goto out;" outside "if (!silent)" (matching the sb2
magic check) and validating sb1->sb_blocksize against
QNX6_SUPERBLOCK_AREA and sb_set_blocksize() before computing the second
superblock offset using a 64-bit addition and s->s_blocksize_bits,
matching qnx6_fill_super().

Reported-by: syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a0633f11d3fb88860bf
Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 fs/qnx6/super_mmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index b8afb6f38..bb4243872 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -51,10 +51,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 	sbi = QNX6_SB(s);
 	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
-		if (!silent) {
+		if (!silent)
 			pr_err("wrong signature (magic) in superblock #1.\n");
-			goto out;
-		}
+		goto out;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
@@ -64,12 +63,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
-	/* calculate second superblock blocknumber */
-	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
-					fs32_to_cpu(sbi, sb1->sb_blocksize);
-
 	/* set new blocksize */
-	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
+	if (fs32_to_cpu(sbi, sb1->sb_blocksize) > QNX6_SUPERBLOCK_AREA ||
+	    !sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
 		pr_err("unable to set blocksize\n");
 		goto out;
 	}
@@ -80,6 +76,10 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 
+	/* calculate second superblock blocknumber */
+	offset = (u64)fs32_to_cpu(sbi, sb1->sb_num_blocks) +
+		(QNX6_SUPERBLOCK_AREA >> s->s_blocksize_bits);
+
 	/* read second superblock */
 	bh2 = sb_bread(s, offset);
 	if (!bh2) {
-- 
2.53.0

