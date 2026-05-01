Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079639B482
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633343; cv=none; b=DTgGzXjJdNtl7KBQKysWdNLzIHwGUDMWkQWHsCyKcby1+VaHa8zUGo7Z3PFR5MNdh2mJ8vo5uJXCM6qTAydQwmSQjZGbckOHEczc4CCtmE8E89rNnLnjyZOQSs3LlWjpTNty13p5vQnCHCoHSGNGE6r35L0btawp9TTjBywmHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633343; c=relaxed/simple;
	bh=e96F4VL0FqghnjCcfD5j5AlSChhZ6jZluo6CEFl4jqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx3uAWb/ujRL8JVgH/HauKXyXcnbXCBeEkt/8uMswFFDht9Q0CFZh1v1/q5DlJkX3yCDv//ldamWVO4w+ml+0uWx7Pi1kc6DmjJguUJKnvbMvaphvaXcmPdhJHieqjVea/thPVc/kXf31xDMI2Kmr/e3mwpGLTyqab1foYonXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnTolhOI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnTolhOI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so17627855e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633340; x=1778238140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8YgggC+mPdbH7rnccFGr/mooO19vkDnSnGo0lHMmlI=;
        b=WnTolhOIWmbDz2RYtAOoRocfSl7akvFcw8CR9SyNd5auy33oaOR7OwiLojc8PokBCU
         vhnsWpQgXojrgCbZhd24FsWAhgsXhhIe4pz8kaVaEI1bEHMGbQk+DDh5MFqYfamJBunm
         pAo87wZvrxWStPugMN+kfPqjzzY5r+DeTl1AC5tckoJcUV3lLNihAO0TtvwsNDDbU2Ri
         DuYW6rWVYnkB7Y+KXOUyf2Jm6g1UK8fn/Ui/16tz2O9J2ZSdOCaIeogfhHSuMX3MEvnj
         CVIECKGkmz6PC+RWWXm+t12xFStGYcAOER6JSXSwBisVZZhdZaWLelCkhXLyLUnzoelJ
         72Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633340; x=1778238140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8YgggC+mPdbH7rnccFGr/mooO19vkDnSnGo0lHMmlI=;
        b=r6ezoiyhyxWnpwRyV0givdQf3VEX4W7XsqK/nxrBi2UViWe6Lp2Sncpd0AcYYhg6ZN
         MjUL60x6Mcwi/iE0FF70caqPWK+71KO/MXjfmIhSNQ59teWiXx773/ZdhFTtTU1E5hx6
         i9v87XzstYCm6iN/65L+RKjOdXPrZ5tQ4qtBu7/HOgl9REzpA9HpH9ITXVbZxpD/X5uz
         VPT0LL3wOYL/Ghmc+eNin3B8cvC3H3igJEpkhCFhMhUnC0jRatTnviio+KQw4OkSgbXA
         jpLBETryBYzGOdJ11iFfBjMcVIJgMC+WhxEARq/hVn4aQNqZCDSSg0B+Hv8AGGbb3sX2
         eKZA==
X-Gm-Message-State: AOJu0YxhTeWStWsz/9Fe/NacUNyImgvwzayrN9yKvfKmBAHB/Y/kDe9x
	JvYbrHDBQ5hQOuQz7nCXy3++1G6XMnOKRYCgMU0el1io8D/wm/9JBz5RUokk
X-Gm-Gg: AeBDieuWnT5eQOPvdRto1g+2yrb+S5oZZIPBfIQog/YGVEclbG1XemjP93jdWcBkjZX
	U+9y/7xi8JCyArS/+Cl68vNKo+jOUBTuxbnk+NRssZm7Y6IWK1rW6ncE9C0BjWh6RiF9TkUAYwv
	OkEXixCOiR5D+faQuovpaUvOq3oHM462itXXcjjqumFOxjzZDy/7xN1WWed7zQ7z85tnEBRMTTw
	Eb01ZCdf9SWlhuxgReh3LWfB97a766lxOxgJY9pauTMTXPkLcRyoGCzNuIW4zek76yIsVfLmncc
	U2a8lcklqb7pC38CgoW4kLx7dgjIAXhdP6KLwJJCzQpX+y0goBBxbopXx0DUUwEkyphBxZNgmvL
	X1J0l7I5NxQbjhUxMlvVhuSKR7xZuhWCZLPx6u074g/F3CnxDDJtDix5vsLwowZUZK+NTQ7jyrU
	8CQIA=
X-Received: by 2002:a05:600c:a40e:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48a83f6e2e9mr85879755e9.1.1777633340022;
        Fri, 01 May 2026 04:02:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm121627405e9.4.2026.05.01.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Subject: [PATCH 2/3] hfs/hfsplus: initialize data buffer in hfs_bnode_read_u16 and hfs_bnode_read_u8
Date: Fri,  1 May 2026 11:02:16 +0000
Message-ID: <20260501110218.29906-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data buffers
without initialization, then pass them to hfs_bnode_read().  If
is_bnode_offset_valid() fails inside hfs_bnode_read(), the function
returns early without writing to the buffer, leaving it uninitialized.
The caller then returns the garbage value to its caller.

This triggers KMSAN uninit-value reports when a corrupted HFS+ image
has a node_size of 1, causing rec_off to underflow in hfs_bnode_find()
and the subsequent hfs_bnode_read_u16() to operate on an invalid offset.

Zero-initialize both buffers so that callers get a deterministic zero
value when the underlying read fails.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c     | 4 ++--
 fs/hfsplus/bnode.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index c00645a4a5733..08307faea7a68 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -97,7 +97,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 {
-	__be16 data;
+	__be16 data = 0;
 	// optimize later...
 	hfs_bnode_read(node, &data, off, 2);
 	return be16_to_cpu(data);
@@ -105,7 +105,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 {
-	u8 data;
+	u8 data = 0;
 	// optimize later...
 	hfs_bnode_read(node, &data, off, 1);
 	return data;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff5..35790085b5b2e 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -55,7 +55,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 {
-	__be16 data;
+	__be16 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 2);
 	return be16_to_cpu(data);
@@ -63,7 +63,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 {
-	u8 data;
+	u8 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 1);
 	return data;
-- 
2.47.3

