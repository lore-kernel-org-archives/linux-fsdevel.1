Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079192;
	b=SyBvT3oMKtwDslUUfQxM/YD+QtHgwCRRnyPsjWNc808oKvJEupRZZH3prudQZ6v2CBs7
	 UOv6RJfjEXQxQ0av4yQ37Zc3y5kRuUp7IMVck+smk+lsOpsV8QUnl2cWSt4xP+pj5Fjbb
	 UCE7snlzS0y4IosUN99zNqrhx/IANIEf341QumBRgRknanCU7F7GcJWjP9/7jedcxRCxl
	 fd9rsTi5oFX1P57jtlvCXxnOODwchfT5BuhD4IDCQEagH+gHDVnIBCR9BkUonUyRpZXrI
	 gi6SoL2jlmVF/ACefMYSkbdHDcyo7OFGBZ+PpvOKevVlEBE0UcnmU1lkZ290YOlWL5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
	b=pIINa9abHjH9rFSFdjt4uQmrDVyDuNli9bMa9Bbvqf0kfwPiolau2SQEDyHyhk0KLmab
	 w2Vv7y/6w2chS9+6s7kdmLSLOBoLgXud7KWgj4S9P9gGmIDdi3fWg2PL+YsfAi1YNSndv
	 X1gsQnJ+eBs3H1/sJBSKm1Dhk0/xBMukXi4qh4DCC1c4QPjQsoaJli5t1DA1HZ4x2VcRc
	 5okgyHniyyyJ+/DGpYZSTDsviyJvQi30G+dVTtVYIiEAXNwQftVlmgzBlcgaz8jDGJ3/X
	 94lpM5/6AsOjDwV/CVZodEo/KVIiEwM3T1JxjFA4UtWVz7CaXaH/L5mMwV8hOGtkWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Z7Cak0sV;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32170606A333
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 19:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32170606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Z7Cak0sV
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f3c8958d5so218177285a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794079191; x=1794683991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
        b=Z7Cak0sVPYDVlTVtWN6Ehc8TdfydtFdbYV4fK9sTpR2rgLokdojTHPgr16ezty/AHS
         5ILzEEg9zIYy+0nMbgQp+dbEsix9RGwRbf+h4pEaCkb3kktB4kWnOQ+UrbC4D3jTy1jX
         wpy5kJ60tBqsYp465NuMSi4DM6ZZDLrW6T8RMR3mHchkAOK8Wn3ii/uHY4vdhi8Xo2Y9
         TlIkdID1id2sUJ2gCsyVWLRKdtbQaM5OfC5UhEcHI9WWx30KdBM5qUZHbbLXwK8Pp5JR
         MZqJw20C0b9Nzx4R/o+sVSZGqk5bjnKvD5zACVQCxYYLPVOPW2loSY6novsLpgTHTt1c
         HuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079191; x=1794683991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
        b=gqHXwGNVDidYPMmzTNgZsl6vXbm+URNVjHWijGav6KdQPzcyOKnAXBprSF0rht53aY
         J7w55VX+p/jVgb2ml9SyQ4D5VoHNf/kbR4MQgEM+KAi7Wj0cLxaHu3d8T2d00tLuIGtS
         LH9R77eWdznpsSCAH5CTmWnvGvLUC3zZQOpWXUEpXY2+0V6Yv8Ly2Nj7wmg8WWTZ0w5V
         9cssBlwvTM5oSMM2WaqGlbBuaniDn1Reblo0MSAcoA0iBuwmuxlDsBeOaxd0NEiEfwJ9
         2uwoJV5u2xpak1aYB6VfGZ44x2mGOgAdwc7HO21EQKpvq/FqkjimCq9OLQ0WVX1MvUvN
         YCfg==
X-Forwarded-Encrypted: i=1; AKwUvBy5BsW5ouVLgKlLQERcFEGxc3fG3HMGkQ6rwHX/0xetU5PtufBgHnZ0RJV+qhC31iUuxs51juDzJixK7QZh@vger.kernel.org
X-Gm-Message-State: APuU4Z8pxPnlxVcObq1eOqW7I6vt5JSqIqxephYS3Wtb9U4+WT1p9jBv
	cs2oPiW15qNLyTOK+yg2gaOc/0yPTLaRB4POMq7H3+kDormcBpQWHzIAsAPC1u7bzr0=
X-Gm-Gg: AYBFou1um5ouutzgP5Qt6P5O4nSyle+XyDDwwEuJE8gZ/fQ59ZQSwBQh3mbJpLr4RnT
	fNa7CGQhkdr6JkfFgBlXTL9t7wvsp9ZH5BdY7EbDCRFl33iiWYb/6LCqxmcmypYxLLarO76G9qD
	rT7Aj0VW2qYeAoEGGYn+4kDuf5Wjf1dqnaPv8P2yKe06rBejmhkF0hRlKJ3trF96xjqPStWknMx
	sQyO0OfcCwYc3RbnTbgksCCYODwJIAbjQUlWzJeNUbFeekTMUXDgC3Q/fy7sPdJiu+yNFr7u/F/
	BorKHb4e3e25a/OmLZ80/MSBJR0EliwFKcQSoeb8OuJN9lGohUqe8nEdRVZNP1KnUB3L3i/IqL0
	DRFDtvUukhLMiOPxNJXdefdCHOJY7W7eqruhrItESKqxDmJ4ndOv26ryYbdOkAK5V/XaM8J2xMM
	s5DoXApWpGcFYaYeGJWk/L1BPPnSorpTV/rJnPywx1hYh0U5+24aY1lIU6lnxVnpD3/G8LTCY2w
	fOdwJI5ap88fwIhbRuCuNDgp95aCvI+TI9+C52Qr3VJkosLNMMZ4b7/wo+bqKS62l14GTIzgo9q
	qYf38RzBzlgs9sT6YytvVrGPhFjdSq8KDWuc8aFlWPf3xp/9l8+8IkU/0oTihC2gqto=
X-Received: by 2002:a05:620a:4156:b0:93e:646c:9133 with SMTP id af79cd13be357-945f35bfe65mr1012265885a.64.1794079191223;
        Sat, 07 Nov 2026 11:19:51 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782daa389sm2934085a.26.2026.11.07.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:19:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 07 Nov 2026 19:19:32 +0000
Subject: [PATCH v5 3/8] ovl: setup overlayfs' private bdi
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-b4-ovl-containerized-sync-v5-3-d34b4ae57fdf@toxicpanda.com>
References: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
In-Reply-To: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794079181; l=1000;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oigsy1vUIPeqGe01IWwnaOrpAKAk76udNuQNtC58Mj4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNI/mI7OdiJcEaP0mvnF4I92ol6HamcTIv5i6f7c4gVJLbFmOBMSe1XrqWUH4y/1LsDC0DWIHi8
 /QqJSQz9ABAE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Setup overlayfs' private bdi so that we can collect
overlayfs' own dirty inodes.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: only for an overlay that tracks dirty inodes]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 81da70fd53a6..22a8d4eb3b7c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1490,6 +1490,16 @@ static int ovl_fill_super_creds(struct fs_context *fc, struct super_block *sb)
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
 
+		/*
+		 * Dirty overlay inodes go on the lists of this bdi.  fsync_mode
+		 * is final once ovl_get_workdir() has returned.
+		 */
+		if (ovl_tracks_dirty(ofs)) {
+			err = super_setup_bdi(sb);
+			if (err)
+				return err;
+		}
+
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}

-- 
2.55.0

