Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C436F42D
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788614999; cv=none; b=O9EKHJBzqAzLtbs/tpQs2tbE18y32qq6shknywS4M+viFglacELY9aDFotQX0lIOtnQ1ZbZBlyyMpemGLS/H7330q5rBKO5jSvvc31o8SU1bRNkD39vI0fJFBbWuXNh7AEL5Kyn4tdVwpm4+5X1zxyCx9tNafJ9YnMlqaLBkwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788614999; c=relaxed/simple;
	bh=SltN6IXvVZySJLNlF9QjGwMOqiRfXZapoOtgvjPGYc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/iHstt5+QLhlLrIFJhDZURCBzMm3Cl8SGN7ncM1MvIzN7vzqBb5E0K+TKG0wbhMxMR4yt/sbQ/yxZUHmnu+IHBKU+oycyv8utY4QCvnO7uIa+JvzeH3PdC9XHI86Gzy/eOaWJuCF2u5MgAeQwOaR4mFS45bAkIYHy+k/ztb/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/J8uzzS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/J8uzzS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so1314215a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2026 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788614989; x=1789219789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=;
        b=N/J8uzzSJHC2Y/zhuamwIuQiBr4fSCcySVSUF9pnuntkDLlKk2Y9EKBp/AokxqGDPN
         UbQT/iAatYPG4beX3RLt0yDg8JVt6vhojDfY6mMzpa1ERZGQ2BdD6hDKL8L0rj+wnKtu
         Czdvqz79AACcWPMgqv6wKAuqv5WLff+ZScu9lWzD1toFlLG0g7xAkDaveofOKYzNQF+x
         PxN7W2L0wBdi5Cic/8nk8anc3d+wU0s84hobz1YaWwBB1njRaIwPw2htpKMaylz1T8Sl
         IPbbtBnM4VssRsZBIamvjvSsBwFTWxhX9iAkDMLtnOazGl2TNRHsqxtrH68PzBBypbHN
         JNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788614989; x=1789219789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=;
        b=Q8HSFFKsEney2ZZ/WR+3A79RkHo7tLDqdIGqMQkv1TyEu4Z7p+pPY9VtnqbAm0b3bj
         S0Dmgsi3N5nxTd1iUBbczznL2QajtwRodZObmS2sU8BFEsjQegqq6PCkxypr7wBNZuxH
         Hx8rArmP2GKC2X5bB/Y/mpAr4dtI3ViyZcb+LhqfywCfwUlSHlrWSgUUxAqJYsasvCQc
         Js5IDneNs2Z3luPTQbWa1YzIY2t6pkJkMm4thMB1kXs7UI9YWf2ZjPFUs+FqvTpq1nxf
         BxU73JDMePTA6N125ETTjWUrJ0kWn4Rve/9HUjjgzkQ4jkGSFJUEW3OA33Kp4bMuOpDL
         2kIQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3i64okK9GSjKQi4rKxa0KBYwMy/AQ92TeiSvCyIfDNchIaZhKl5iETvITo1pAg1Taf2grjzHeXWX9Qofc@vger.kernel.org
X-Gm-Message-State: AFuF++kZLXXmxuxZlyQl75W+i4U6FgkT11JODk8GTtZGtrS/siHZ/+KX
	Hz4UVbERd/iOkKbgvmhaz6WXOdnEEXgPH444OkiwS01ghZGxJ1+hVauu
X-Gm-Gg: AYBFou3FkRMbP+BVflIoxtMDpjAIFq2meB3Szt2SDE9aB7qz0SR+vGwyg9VAYtM/pJz
	c80UD3lTBInmvqvoBR4heulP78TsWJUj1Dw03mhWIGOVX5Ay7HYl8x38Z6w3oYJRSbR9H925gvU
	eE7nrc8wfMABOqOeTvwrtj7bm/LVLs1aBYzTPb8OM3fWs1HjJ6eiys/6HpsJnik5Ezc4ecgacNd
	9KZuvEjruN6N+yCgSaPTjIdMrVIU4nEGy5XRLGdY6C7KnqvmrjX7jiU9sMo12ZWrmFf9VVlitmG
	i0eXusL5W521NQWz7M+EAsKKMMRYFRpYoDxOdYFl7F9+pekXLknsUTRBw7NgbbrB9hn27qqK9IG
	SZUVMA2iLbs6l0B4BodVYyAhsjX3DvPBP8LlH19A0KCbgaQX6iDllM3NDbFk39Pyrfwol2m07ms
	3rAYVzq0/v+dI+A14E97Mlls7JsSdJRaekCbwAA7Y9mKzXlWwA3Fo9+Ic7jh5HmpslRDYQinXDM
	p/o9SyEZ/pfIAGMuHmSjQ==
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39b2614df74mr17583898a91.1.1788614988974;
        Sat, 05 Sep 2026 06:29:48 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c397b1sm16146499a91.8.2026.09.05.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:29:47 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Cc: syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH] f2fs: handle NULL kiocb in write_begin
Date: Sat,  5 Sep 2026 21:29:40 +0800
Message-ID: <5fdd4d960a6b47ab7cfa6ef0f44fb575fc45d1ca.1788611415.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qiwenjie@xiaomi.com>

The address-space write_begin callback is also used by internal callers
that pass a NULL kiocb, including page_symlink().

Check iocb before propagating IOCB_DONTCACHE into the F2FS-specific folio
lookup flags.

Fixes: cd5bc4fbb900 ("f2fs: enable buffered RWF_DONTCACHE")
Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
#syz test

 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e816c9349a..63625ab3f1e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3890,7 +3890,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
-	if (iocb->ki_flags & IOCB_DONTCACHE)
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
 		fgp_flags |= FGP_DONTCACHE;
 
 	trace_f2fs_write_begin(inode, pos, len);
-- 
2.43.0
