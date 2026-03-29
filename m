Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F93859DE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804823; cv=none; b=c7c9Fsn/WWCmO+/8kiwtTvx8ReepGN0MfNcX0AIUjYnxuEz1xGhFUPBUMNHVAl270uQLeFpAp7a4ye0MAqF7lzjTh3NT5GkjnhprP8o64hV6WRQmpGOpf3wOAIjeYLwcn2CqRw5wPfXS/GC1/QVTdQnx6ZemlFVjUtBufkpvDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804823; c=relaxed/simple;
	bh=3wWUg5LSl4md60Gl4sfBqptcrZXuVuHRnorf8MypEC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpRnRZUAUMChRI8SDVX+bpVMx2ENh16orhyeIVlRlB38tXdb49xCrOKVxDbp107+FgzdYrQRFQgcW3ZaM4ecv/UZIdBrY5cen6shvWVrLBf+jEv/27jdTCTyiGvcfmuoPL99xA8XyEs3dEtbyDFInbsgW00QVFYRirqOTM90hAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAK+FuEw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAK+FuEw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso36743165e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804820; x=1775409620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE4V2dhR2jT7NrbkOWfwwUAC12jyCa2VsCL+/A8CWNg=;
        b=PAK+FuEwo/FnUbA43J7PQTFpjD49fEADnsWzoNXP89Wzi+9d17xRcJSmTE2U+w7JbJ
         CM44nYK+RDKJXs6YIV0utHwXFipKwrrcsA3scUJkYDJ4u4yvAnw766M0/xgNWq/wBOzj
         oq0eC7aybl7+TNoOEzkVhFEarq9tvG/609S/73Rn414ffX39/A9PD0hVCAJDic+MRMVc
         Lix/rkYrEkDtGYChQUMFmid6TxGisngmR4gjjs0IR/Ny2dxGpvfuZcclqHSL7K4JIbZp
         Wen7ZAplzGGOgyu7n4DmCNJ5QpV7AvU8ExpcWRQKW0/ZE7N2xAtbdS5ZxfsHPB1jzDdv
         8ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804820; x=1775409620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tE4V2dhR2jT7NrbkOWfwwUAC12jyCa2VsCL+/A8CWNg=;
        b=qjvtVCuF+8087MuYDj+C9PuJQMI8hu5EdPoQBzWg/iRHiaCPTxPeqGMHw0zdpPL8Jg
         wNBg5WFrSp0P6rC/Pdz/KuR7LLrTE+ifybWXQoQEnzzMG6Q9fBBGgfFCNE4wWs6pVLP5
         hwb5HKcWrF8IVD53lgC+j/SacXY+h0kRHWwxbXC+wPo5Lvj6cHxjhvg6CLa6OrVdIhOO
         JcUdlmK7r8n/hG5cjfB0SLghm7PG0WjBpdF3Q/rcyu/2c8kdALibx/OxTro+4uGRfQSw
         pvXgBqqUx5jbTdfZ6EXCPwkXf45C0HS5CznqesobCSLuDNU6jdTzTAuriGVgaoD4i7mC
         wsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ho9bUjFahGca+hsqcuz/hF6UmvzTvUe4t42+JSpgADwHzNE7EP3E9/5QaUuTf8Yfppv7xAjMX+mitwHF@vger.kernel.org
X-Gm-Message-State: AOJu0YwhS7RQ0JSHvCGwrsWYWEEZKJok2+CB2iDcU52LOLxl7i1A+Y4J
	V7YAEFuyZsQhThp0tqUbEZlMf+L9WTdAxWnOH/LA1etjPwqwhpbpxgBDBHECug==
X-Gm-Gg: ATEYQzx1NRCnF8h9LcY23NdSrKIvNATKUiexIYk3d6A4W7p7GG96VpGDeufJ5SRFC8W
	ix0a6JRcdezCmXFAFY/HVnC6dXrTRIYNSuPRKQWmFtZ5I668UkYhddIi1JRLgSpjpo8HBgHCdu9
	PM1UfJ0Ik60Vn4Ef4HKFhNDqxR8k95u5O16JWi9x0hnqQeyJNHE/fADzGvTh3caR5Ty91/TiNNz
	r+pWUnpWrCxuPpTdyXU/BNf/iGBbL3+Fjr4yu8tNQzE5cRnltqlsA3V1bzYRsnROOMUaN2tZuno
	sXXNF2vhcckAtYR6oSqHVJs7tJXmvHA7FMzGQKQW5ACqYBvSuTfl9kAt3GDGjxZT7JrwbJI1tkq
	QvF3YFz23y6qANZX7vlhsFDgNW55uzZrMaEvghifsDQpJidjHZ6458lZNDiFIBzzpg2qRYXNxD0
	4tguuNy4Sq6/lMm26zjhSmB4Xd5NKwP+vmu3kKQuEQi8JQhFtHLoDgyeabSqdisxqaT232nGud9
	g==
X-Received: by 2002:a05:600c:34c3:b0:485:3f65:94a1 with SMTP id 5b1f17b1804b1-48727eda72fmr171565335e9.18.1774804819534;
        Sun, 29 Mar 2026 10:20:19 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:19 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 5/7] fs: handle hypothetical filesystems which use I_DONTCACHE and drop the lock in ->drop_inode
Date: Sun, 29 Mar 2026 19:20:00 +0200
Message-ID: <20260329172002.3557801-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs and ntfs play games where they transitiong the refcount 0->1 and release
the inode spinlock, allowing other threads to grab a ref of their own.
They also return 0 in that case, making this problem harmless.

Should they start using the I_DONTCACHE machinery down the road while
retaining the above, iput_final() will get a race where it can proceed
to teardown an inode with references.

Future-proof it.

Developing better ->drop_inode and sanitizing all users is left as en
exercise for the reader.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0050eca6d83f..a417abc64822 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1935,20 +1935,29 @@ static void iput_final(struct inode *inode)
 	else
 		drop = inode_generic_drop(inode);
 
-	if (!drop &&
-	    !(inode_state_read(inode) & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
+	/*
+	 * XXXCRAP: there are ->drop_inode hooks playing nasty games releasing the
+	 * spinlock and temporarily grabbing refs. This opens a possibility someone
+	 * else will sneak in and grab a ref while it happens.
+	 *
+	 * If such a hook returns 0 (== don't drop) this happens to be harmless as long
+	 * as the inode is not marked with I_DONTCACHE. Otherwise we are proceeding with
+	 * teardown despite references being present.
+	 *
+	 * Damage-control the problem by including the count in the decision. However,
+	 * assert no refs showed up if the hook decided to drop the inode.
+	 */
+	if (drop)
+		VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
+
+	if (icount_read(inode) > 0 ||
+	    (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE))) {
 		__inode_lru_list_add(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
 
-	/*
-	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
-	 * Note we only execute this if the verdict was to drop the inode.
-	 */
-	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
-
 	if (drop) {
 		inode_state_set(inode, I_FREEING);
 	} else {
-- 
2.48.1

