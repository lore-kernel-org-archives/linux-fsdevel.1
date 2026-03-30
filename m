Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5983CCA1B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873577; cv=none; b=EboJJtkBt+iuQpwMv3Q7bmIwVO0EO2OQJGdplolBbErgZYFzz9KGsbQ3ZVfp0dx1mgm6z7epHIGDEllJBWRgDfERrv5SPm6eu7F4LiqNYbBIckW0D93DkLjosUtTTU1wZauZUYx3aRMezAEySDyqlrXSkXCktGb10YVJLJS1FfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873577; c=relaxed/simple;
	bh=HHQdlPXWfQ0bdc5Tr17fd+OYag4Slbu5vp5M9ZuZwb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJEidowZWU7CG9VwbyuTpyLaE95qohAcEBndMMWSl3/x85NRJr9RvbnUXpCAv8QYWK6mgmuefnAtGpRS57bCzcsll4PhhnnMpsCarYdE63y4UiP2KkDeE6lNqd+MtyAlQH3h5Ov+HWbAWQWTB9ZXzerqSny3hji/pxlRMwvW0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvxNZGG/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvxNZGG/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fb112c09so43176715e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873574; x=1775478374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FScv3i6uAosiDBVQ3BCLq5X7rIHAG+u+NDcPUFmbj9Q=;
        b=FvxNZGG/yIbXKzYYDidIcHzHENx5nmzfMD3FdZ6OBA3GW1x2VIKx+XDmA0SP8dJGRA
         u4iXClCkqpOkFeo5gqHC/jrehzFUZ32XLsUpSm0OM47yghO16qMiSGqQoMUnZ03Wj9oq
         jdPOJ3s2fPUO1AAhGjTBQAMISxy+WjQ6I24oxK/cst6B8SSSaOCrlxI4vIj9OjrMbHpa
         jlVNSBL4w+jvpf2wK8gWHdHaH2q5kz4q0eOGp92XGN6JJoSPgxl14T1+gjrFqq3T5eCJ
         1UD0/k6WXtEmmhi6TiBhOIwEnt8hLkXIITwiPQUF/VKSVFIN6liojrAHRkVd59Ee6/t9
         ZmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873574; x=1775478374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FScv3i6uAosiDBVQ3BCLq5X7rIHAG+u+NDcPUFmbj9Q=;
        b=QzA7BL0m1uu7GOkgVlxIQa5VDqlZp6Y0n1jiXxsKqzKEew3zxI7m8+cu1+rU7l9jXy
         /nzh2pMsHQtg2jneW92DwtC7UfffdCZgl5WUYlFNKl4nwHW9MQMwECmFKD5U79fUZBLP
         pR4Bh/akhvVgqCV6woGeWkB5hETo6ZDb+AFmYll7ECuFW12v4ZOMEi5fDRImoMeLal0j
         N5nxaqj4YWZF0cWvVhQ7hB16fzWVfQlKkWTFFxKXJtPAIKHHInLl/ZhKIlFxbpQDpBgw
         fXD724Kx9LgOMAGmI0343h3QVIdg0iOk3rFV2PiaBJkrG2HbZ37EMfSWVO5qtVAZGRCl
         KC4A==
X-Forwarded-Encrypted: i=1; AJvYcCXhxHYv/jleVjwnKnK/n9f7Olmxmt3voP78UvdUz0p/DS+YO3niR6NzPznFD8W/ZM4qcvsCogOvt1qC8rQk@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQ9VgPGWTveWRNzjwTCdHSD6PHnfuqTMqHI3BB9/sRzwGLFqu
	qGSH6tPw8VlI1HK1/y8+anjegMs0UAnk+wpWyVQXSk2suwvx4jSB1SXu
X-Gm-Gg: ATEYQzyagquwkyhS7cdonybx0KhE2Dpd3YKQil94zPTKUaFUzK1JN8gc6u2ioO63pau
	ZndYNqhQFP/ZFITLCZI1sd38EVud4ZaHnPUYkM/KRGCRqUNTmbjQqtwHkPae2tREgsbk7faEgpV
	rcLpqWCzrMaMv3+Cc7Yw+0lsxQVCloOL5xT+hAhGz9S50yNGVX/tOi8pWUCeEJ8XlZ5kt1tpsMm
	nhakJ9rK00c7p2evMGt08xjdKRoh9NOqU1jCFvvkZoHqn26Q9et2jqJPCksmm6xwRkfT1UOmytY
	0fxavuRVrvQij2grQ/9VZJ7V6T6jSYs4uhk59INvgM8QIpJ+5EBy06GHUdLe5AFFTUSnh1G3LV+
	y8j2PFTZHt3baQAYTdhYbbGq9Gvo6xXjJt3IHfQYDwlmWnq58tL7Jqe6XeMSbl/QWvT1PvhllDZ
	vWJ1u2DzdxPHbQP7i26x4xknwNaVw3KrJ3cNGx86J/IsSTl+4lzCCjvk28VXpLtWBHcRskKAl2h
	w==
X-Received: by 2002:a05:600c:1d15:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48727ee99f6mr200832315e9.5.1774873573523;
        Mon, 30 Mar 2026 05:26:13 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725da0333sm113541525e9.2.2026.03.30.05.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:26:12 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 3/4] fs: handle potential filesystems which use I_DONTCACHE and drop the lock in ->drop_inode
Date: Mon, 30 Mar 2026 14:26:01 +0200
Message-ID: <20260330122602.3659417-4-mjguzik@gmail.com>
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

f2fs and ntfs play games where they transitioning the refcount 0->1 and release
the inode spinlock, allowing other threads to grab a ref of their own.

They also return 0 in that case, making this problem harmless.

However, should they start using the I_DONTCACHE machinery down the road
while retaining the above, iput_final() will get a race where it can
proceed to teardown an inode with references.

The easiest way out for the time being is to future-proof it by
predicating caching on the count.

Developing better ->drop_inode semantics and sanitizing all users is
left as en exercise for the reader.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e397a4b56671..a06edd557e84 100644
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

