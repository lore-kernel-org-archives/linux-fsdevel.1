Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31634D912
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711923; cv=none; b=g0fcxs/jdtxmxnSTCtX97biQhVG0MH6y8xGaTHQ03q1zzGLyWDVhhudh5N3ddgScvbxQGq8vvy2isZbYt2p5QlIvrbHImU6LvtjVoshs4TQNCWEPc2ckAmup2gEDOKJyEaXyXsr+isArPOz6l7dXi8IG8fzyMd6GHUQHJS9rr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711923; c=relaxed/simple;
	bh=q6/M4OdZtc+alS1DwnvRyoUObRGRNii9NRUn255hTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX0PnSJ4bLeQItIcN5GUDfvDhOMdlI5xvXhufCV+T45g7vpyKxyH+Bi+5DBtl50i6O2RThjBtYb0cUAPnFem1caCSD/EQPoSFcmWpiTozImUm5g90iGC/AKVuKiSr55NxoKM8SLuomlGOUEiIoWtvLJ3H9xvnR9VCOW9lIpe704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=om9yepfQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om9yepfQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso2101015f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711921; x=1775316721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuBtMTHfXISMz1y0xRBvnd5xru82Lmp3xXwNF/dfxA=;
        b=om9yepfQRr8klFNMvWLAWi2Kab1UlzKAjEjBAqi0HPoGBjhw5Mb3yaICWhsYG2GMTJ
         wiBrcbBaMavI+LxFOhKPf6guVOzUTLWV6/ARU3uUGhFlk2JZUyR3bkde7a1SF6jmw/ao
         eegKZfUTjeMx61exPWqMkWxo3Do/siBJZO/urJ8MYKenhux+hX8TiOnKXjx2wFyiPCyr
         FQhrUbGLpMwBJF88EsKSNqXnehFGEfO/K9N82HhK0FC+yVzh43TyOUS++UIwC59H6TWm
         VIxivIpIAwbGgdcaVlwQf2YjvapUjCkgbD6FG9UYbDrWB0YdWMZDA0eQUuZeoGj5LCzs
         GlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711921; x=1775316721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuBtMTHfXISMz1y0xRBvnd5xru82Lmp3xXwNF/dfxA=;
        b=l/PH9ZJLcusMhkkmB/mWPvQgPcEiE5eHY4FZkNt/1sH7+SAntEH7VXbEqw5C6VbKvq
         7k7M4bzfwXzKH4aGB58HGSDkRLS0YKW9M67GNviTn2KtVi+GzPlDQrXe2N3WrSYhpCib
         s2vUr0+8IlHtU3Uev1r264lfa1GV/0DissgZ/zw8JNvkiL21VOlYXD++LR5zy8b5PMkR
         sgnTpg7FFSsXvbNRWBNH5nbYUkaTjQthOHpmqG/i7izurnal3KBXIxeRGj+ZVYSyvN4I
         lULf9MUnwioB8GfFKuLbkvPEiiE+ETSa3U+gbl07D1aniuG2Ot3ElPM0vBF1SB/clSOt
         RAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhE9nZ3C1r1JzG+qFeBlDbA4Y1/hkcwy/Mb7+Bv8tVIHAJD50P3LzHpQSgm3qf0RABTVd3rJA8l0m5Z65k@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8taMUUt+sKpzEWP4nB5qXsnMAwQBwkUaE7NnILPDgOViDHVn
	6IAuY3VK/Lb6HsVFNz/9khH1nP4drmdlb/25Df0IFekVbBZCrtKpzDtbAb18rg==
X-Gm-Gg: ATEYQzyl0dRqMOFyyeRE6u4kAgxKiQE0YBmLZqH2RxlAa4A2UAA2cIgc4iEUuk1zhvi
	wm3jIDI7ueq43Rh+avZQJx/Du4l8JFzO2mAyVZp+Gqh76zr0FqDD2JgmFZSAQMmlnBpuXBNZPuw
	X36NFRzwvCLtAAvUhhxlIUHN3uqYL7COzrdcgzbH4Vp7N7GTopv+ve8SyXfCOV+PV1gC88rw/y6
	nQOjd7sB167wpLWrCLUp4cnseY1uhjMSY9uOtvT1zUjkxKC5bkg3GSQ3ts4D+E2d65HkE4Bo8+L
	6CcyS2u8f9zSLfscGs7mFhs3NSniM+DlHuJXf8ZstS3hzsQIq7BGVLnG/cfwHtmv371wq26nBAZ
	xHkM/XGjcJ57ojODsCfV+BjkCX1QxnGPAwJPY0YiQE1prd4iCoqJVyX298gX6vv04FsAeu9W+fm
	kyhKfOhJbePusPgT1eY+EufWiCYperWgSTYAevCZc/4LTnp/vka6IrOmIp739fs6NujF6xJsoZf
	Q==
X-Received: by 2002:a05:6000:2013:b0:43b:8fa4:194d with SMTP id ffacd0b85a97d-43b9e9d5eacmr10558088f8f.6.1774711919377;
        Sat, 28 Mar 2026 08:31:59 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm6725310f8f.24.2026.03.28.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:31:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/5] fs: add icount_read_once()
Date: Sat, 28 Mar 2026 16:31:41 +0100
Message-ID: <20260328153146.3368470-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153146.3368470-1-mjguzik@gmail.com>
References: <20260328153146.3368470-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used to denote the caller acknowledges how the count can
change from under them.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8afbe2ef2686..0cf27085a579 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,6 +2225,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+static inline int icount_read_once(const struct inode *inode)
+{
+	return atomic_read(&inode->i_count);
+}
+
 static inline int icount_read(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
-- 
2.48.1

