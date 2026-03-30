Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A53CBE6B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873575; cv=none; b=uP3NRU1Hcrd7BCzdalVuuuZ2HhkVBq8bPk0RFr+2Q5K2WvOzHbBR1QqPm5FXFFrEAE5NLRpjPvsWThOry/Y8ZvJ532W6lsKB20rfYvVI8tPcDwgW/NuyvoajMEFJ+qCAqVHRc0ILf7fgV1ZgocnId+OILOLCo6EAonz9qhkaXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873575; c=relaxed/simple;
	bh=COKwH1VH8BuYCRynamMlTkaMzJ4AGwGGF/sBUjJNvDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZIi+POb/ikXkL0LiYgHMky27Nx1pD58/t2MqqdlDBnbFj/Icje+V3BrOAMP3Sc04CLByQ2SQ8tz5DI+sYxHvTVQZBgwTsST1KJkYM/ppUEi3zbH+UBiS/CheGYwCi4uVm0ULIXaMWrLmajpCck4PwpBWA0YAEtpajDs85FzKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSRcTdML; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSRcTdML"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb112c09so43176505e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873572; x=1775478372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBIfgeXR6ZzaVZZprJJKEW+34xpz6VJfBbaNi9NqWK8=;
        b=HSRcTdMLvmqF/ibNsUK6wJquEZjZLD8VZwhzYzeY5MDFT6UQjz6l30yjqkzumdTKnJ
         ANONMBfO5pTRTVsmXZa4Z3k2gSKX77XW4daTICfYLi0uznuEATOsEkNvHmC1HkYSiWii
         7/aLUGmuYpxLaMXhMqjZ6jqeAQFiFapsTynbZfc3VNfr/FCd6J3r4H+Zl2cvaHsQDXXj
         R8jA/zaCyZHyhWm3cDBclSazdOgMf+HEnHcPR00LwhjWP4rUm6SnFO/QhxfquZz9jA/O
         RJfhDcWzfwdRvSK0lygWRsLApP9KvYDNIh6R3VYkNpIHSwok5q0wXlfVdR5jns7SXoQI
         mggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873572; x=1775478372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBIfgeXR6ZzaVZZprJJKEW+34xpz6VJfBbaNi9NqWK8=;
        b=KUnbhdKyffOVYHlMm47oubazJ6cUxZl8y17p24CVu+f9SEOb1bJbvxekb1eou5BDBb
         IKhorNMhi6dlhvVGeKLMUP891BQma9i5zfUUnofUdIrB/Yt67PSubXWoRbFwWUlp50cx
         yGv2abLIm4eEQ5Y28oY8A7DVyW0Mv/1D+eWX6jeHypkAa3jUFfS/Cxmyf156xuxSpfcF
         BFw3LraOjIy939CzY+Rl/j2AoRgq6aDEzVQnRJjSDxwsFlq7eIFSm1JIri+q1nFgbjbE
         JD9kZdx+7nPevIpmdlysAeBTyIkzwtSywzdQ9hlJSFq6hZYY7JBp4QCWvpBAUHuLpop6
         17iw==
X-Forwarded-Encrypted: i=1; AJvYcCX1+4Lrm7I6Cs6Mm2IR6gAs7fNYagO38zPgq/oGGqc43K5mFSg00Q10Iv9/YpihEMSonCohFBBtycsZaBc7@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUbYaGsYouzxelpvjIJROo8amtmTkWzOnxyc+x2/JOBmaVfR1
	lhBiAMPUEXxKszA8cCkSO6r3ZSlZyQvsChX5nN1AuzcUmKQsX0PzGbiXDhU8Cg==
X-Gm-Gg: ATEYQzzxg1GCetafhTCfNP20DmGV6LR+pF88XFbuHAFZ9qIThmN+O/iLc3JpAKY+sk5
	O5hXK0xAV5rSK6QvjQZ9LZvWrs4AITd5VK8bP8x9lIZCRVb89uG7kigOxWNjmhtPDFYtGv31UTT
	pNnouhJ8N8HDGd7DRF6T7L35Y3/3MyHRJXJeG2eh605m3y4ASVunhc9U4SNP4rlCpRqOO6QDrYi
	Jnaqu5B9vjUEJLhRkgQUcKn9MBWFu7xTol4wmkTej5uN/Ndqyw0Xt7Kp4Qy2o6Zl5f9uY2RfD/K
	JlqglIeN40qc2X7foblmFCFULsolpSuOaFRqit7HOpVhZLoHTmPETmRVw/09lydgk+fxz9+e0NY
	HaBWj/plY5IKDlRRyFzQup38XuHhQKDMWQ/xAiWmlRRe7bF+c4YrwfAssUljNDTOwzlmx+gHY33
	TlApfwSvFD0utR0Zq/2LTykt148Pnhc2bxH3XsbRnZWW/6/kLd2k6o5wXbrSTvmqwkLij92DwTc
	g==
X-Received: by 2002:a05:600c:3e88:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-48727ee98a2mr194363335e9.6.1774873571860;
        Mon, 30 Mar 2026 05:26:11 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725da0333sm113541525e9.2.2026.03.30.05.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:26:11 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 2/4] fs: relocate and tidy up ihold()
Date: Mon, 30 Mar 2026 14:26:00 +0200
Message-ID: <20260330122602.3659417-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330122602.3659417-1-mjguzik@gmail.com>
References: <20260330122602.3659417-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The placement was illogical, move it next to igrab().

Take this opportunity to add docs and an assert on the refcount. While
its modification remains gated with a WARN_ON, the new assert will also
dump the inode state which might aid debugging.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1f5a383ccf27..e397a4b56671 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -522,15 +522,6 @@ static void init_once(void *foo)
 	inode_init_once(inode);
 }
 
-/*
- * get additional reference to inode; caller must already hold one.
- */
-void ihold(struct inode *inode)
-{
-	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
-}
-EXPORT_SYMBOL(ihold);
-
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 					    struct inode *inode, u32 bit)
 {
@@ -1578,6 +1569,17 @@ ino_t iunique(struct super_block *sb, ino_t max_reserved)
 }
 EXPORT_SYMBOL(iunique);
 
+/**
+ * ihold - get a reference on the inode, provided you already have one
+ * @inode:	inode to operate on
+ */
+void ihold(struct inode *inode)
+{
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
+	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
+}
+EXPORT_SYMBOL(ihold);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-- 
2.48.1

