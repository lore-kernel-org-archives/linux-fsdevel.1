Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B138B9A4;
	Wed,  4 Feb 2026 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189348; cv=none; b=TiVI7j/8uC2SUIVKKe9xcvYtOtGPOvzwXjEP6dI3aOX8fAhxrXgrPle+BGqiADWOEJFeisdo6Mf6zyCI4YKoV6LaShwNn8piu4xir9fUf48ldhJc4iyx+ooYvuI1sb8GVfQrABzSIQgB55Hs/rMyvyuL8h6fLLy9wP78CDjqb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189348; c=relaxed/simple;
	bh=8+VVyNnnVM/hZaHRZA+vzZxfWGisKCgzb2VP4uHworo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlw4wT3QdjwVcZpb10IUC6yMM6yhQ93sL5zU8o3g5TiQdVKDrQ6anZUeSQWcp3WcwhN0KW02I/i6DqqMlxEoZRf4x0borHbTZnYmbxQRjj0lT2+UrZQm2lcJS8iCCUTGm8oL9rfz7uSWpZIdlMV+EQeFc8vfYITws6wLq2BzKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lFmeQg3o; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lFmeQg3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VC
	TdpQIoqFwOfDQNVC34Y4X4fALh4ZTd4lNF+rUayDI=; b=lFmeQg3o8PqGvEZNmF
	rD7ciMIivtpltPlizoqHO/i/c40yxBTOpdqJCIxhf4ZThqIXK9l+24SNMpK2Izfk
	2Y2hQZfaXwr+Ef0jLcEwCJP4GlkXLw3YLPLJAhajmIQoAAXBZXf83scJ6EK6jGAh
	1R9fH/7O+P7ef0U2bMBX90p7s=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3TegF8oJpYIHPNw--.186S4;
	Wed, 04 Feb 2026 15:15:21 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 2/3] exfat: drop parameter sec for exfat_mirror_bh
Date: Wed,  4 Feb 2026 15:14:34 +0800
Message-ID: <20260204071435.602246-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204071435.602246-1-chizhiling@163.com>
References: <20260204071435.602246-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3TegF8oJpYIHPNw--.186S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DCF43tF43ZFy7CF1UGFg_yoW8Xw4Upa
	y5Ca93tr4jq3WDW3W7JrsYvw4Sv3ykJFy8CrWrC3W0vr9YyryvvFy8tFWF9a1q9asIyr1F
	g3Wjqry5GwnrGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDEf5UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wm5V2mC8glsFwAA37

From: Chi Zhiling <chizhiling@kylinos.cn>

The sector offset can be obtained from bh->b_blocknr, so drop the
parameter and do some cleanups.

No functional changes.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 0c17621587d5..0bc54aa5d122 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -11,11 +11,11 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
-static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
-		struct buffer_head *bh)
+static int exfat_mirror_bh(struct super_block *sb, struct buffer_head *bh)
 {
 	struct buffer_head *c_bh;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	sector_t sec = bh->b_blocknr;
 	sector_t sec2;
 	int err = 0;
 
@@ -25,10 +25,7 @@ static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
 		if (!c_bh)
 			return -ENOMEM;
 		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
-		set_buffer_uptodate(c_bh);
-		mark_buffer_dirty(c_bh);
-		if (sb->s_flags & SB_SYNCHRONOUS)
-			err = sync_dirty_buffer(c_bh);
+		exfat_update_bh(c_bh, sb->s_flags & SB_SYNCHRONOUS);
 		brelse(c_bh);
 	}
 
@@ -83,7 +80,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
 	fat_entry = (__le32 *)&(bh->b_data[off]);
 	*fat_entry = cpu_to_le32(content);
 	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
-	exfat_mirror_bh(sb, sec, bh);
+	exfat_mirror_bh(sb, bh);
 	brelse(bh);
 	return 0;
 }
-- 
2.43.0

