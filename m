Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432499;
	b=C+tSpxLFWULKgg0TDfncLtSM52ICRBbqh0vLN2+sz9z109OeK75S82m9WgYg3G9gdUmg
	 Pu0epTjS1C1EhRncU7pfDYYgkMJHKm2arWtDiavkDybFB8l7TxzXO900rfayHksKS/xw5
	 WD1RtQHn07jT2CkTWSw87lfkmfgU2wAe3Qy3VPb0MeljmLeSB5lyu9lQjmQuSJ4KIr0i4
	 OpZzJKHdWtR4kBU/nw+cSpIJvhSDpAcMYlmXgEjSsQ+74Z/GJo4jpP7y8vLlitKZ+BPMd
	 L8jFoWPLqM1uQTm/r/kWJ9QFw3KCVU6ZmyBzd2pjM59XS9EP+fWKcwVsT4SpDQqnbMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
	b=gQlDZgglK4rzP+0oK1Pla5Op5/4iu5WjtTwUvaQMcrVMTp694ZuAKnFOxWg0xia7djS9
	 tP0xIQFXRkY0EL751jemCiNhXeyWQqi8kKHYbUhVioChPgmzowq5aYkGYAub/BF/Vo3hZ
	 et85mB9xrnXUD18AlkChfzzt67TVsTnLpsN5zOhxRY95SiuoEmwBu5LDVNCU0YL9uf70u
	 tTqTFugqENWf8z5qcX1FNuE4qNYOk4r+CuvrOuMRuP2c5FNSV62+jV0LA/FS76lynYBQ/
	 QvWXoyVpYPb9jEqVc3sdejgvTKPKuzbU5laAqoXpzblR/PLKCfL0tgmkNKSyYNTitNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEuQYgd9;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA5606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 11:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCA5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEuQYgd9
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso1744105a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432498; x=1796037298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
        b=wEuQYgd9aTMaRZMu8Fc8uQ9+z8eQzvLYLuJRlLT7wIS7NWQ/wbFslmzkdbAmHbleFV
         w8KhFw2ZOd1rLauzizxyN/Q1sVkP9Hlku2rgQs63qAipnTqBr+GiOUkS4IF8Jlcz6A4U
         O2b/U7NmMQfVWpCjvZGK0QBmjLTg2yMbsd1Ar0m6fTyLnVbXWpldKB/8rKnh9ifygbP/
         x1DWX8gGyFeMxmsX9AmtaFoZWjjAUlwEDv9j33EYV9x8Tdcv5ktG3OriZNmXyNeK2vTl
         cPOzYd9xyQqae2bVqgqKzZstPwew4pN5OP8zL/JnzLKLW/gnJlidhE5g//FY4dAeySXI
         M3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432498; x=1796037298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
        b=AyN8zMQgi3AAvdaw9YxaUahDlvr4cgWCg22sHFX24sd9dTwXqM3uMTIECl68yXcrqc
         w5xiEVxOLkBS4fvms2gyWCUG9rjAMrj+rapDzsvNCGT6Fr9cY5RuA8EbPO0w6LoiP0UZ
         YrRGsgDMx7JYMinDogygePgOcI5yVfIL/5HollZkGZGmLX1kwuEP1UPvvzRZP0gL6R08
         QsmFTnc53hm4+7sFqo3nICU0DeB/kGOl1jUgsHVJTnRl9UhLuOtjAlCgobj4ADRUgNlz
         liVEP+t64fn8pD6fACEQ+cgTvUdhLw5d0vS633vWp1ZCjRWlrPC5T5RCOLGVF18GA6NS
         BFqg==
X-Forwarded-Encrypted: i=1; AL+hErHishCvEut/csPEp0/3ugTkpoOF5H8WPRLZ5H8lS4vnvQGjn2rl0d15Vtea4OjOYmpGY0j9oSMD7BwmBHyE@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hfs+IQ3hYXkKp/iQ8TOK3+IV956Ok5QFmZZ05QoNKBouYt5I5
	KGsPVy+ANhVhZcRtiOgcyVuFld84nc7aVMFxeDUHbJ8LMiyl6T4Uxa9Z
X-Gm-Gg: AZFdTZeLlXy0XbXWczJ9uWW7wFjaWaYuyNwpqi2rGh68dHqpGSwyQBsSkt/OrdtGnJM
	hwS7eip+YzpY94OevRyGRtjr7r6aHteWnAPdVv9MXrgfcnZF+KkV55WvwQ1dapjSu6EJVCz2Slu
	vADd+8M4a+6dFVUdKbEJj08yH4rg1g0vxlR869iK5Y6TgeckdWwkH/43V5me8zJbfCO1bcgWDqo
	ev7BdVt8y0c3N2+ec2B3GWGxPMnOSRxzvTTENomDDdQnG38/AVB3/7u2QoNFzwL5DnxkjRN1fuM
	yRh/nEBvUjnqGew8whfUnMvpj4IFO5SbgYG30omCpwiLsnNEKN+XklXQeTDeot23MovlX2GDjsn
	GG7owGYmdBqK7mwbEy2M1tzOpDqXqZNpsLaL89MrpcmdNVKKPkx2hdQqFzMshg2Au2Ai1KYxPXv
	sG1Mr57QG6Ea8CGQbDiOO+zMeIBwiyQfPhGZ7waGzx3hU372h4Rt1uAsOLmEcj7NTX+aVr88sqE
	cQjmSZXAstFG9vjlDqHwwvV+9inHi4yy3HdnWWZ3+bWT5q19g4Uq7dWGPwsZbM2W40WduSsHA27
	Y3v1SdKk/G4IRzR4t1J5vobwXKpqrA==
X-Received: by 2002:a17:90b:3d4d:b0:3a4:fe48:d410 with SMTP id 98e67ed59e1d1-3b41c92cfe2mr10003902a91.30.1795432498380;
        Mon, 23 Nov 2026 03:14:58 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac5:d452:16c8::245:e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm18070874a91.12.2026.11.23.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:14:58 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
Subject: [PATCH] ima: key iint mutex lockdep class per filesystem type
Date: Mon, 23 Nov 2026 18:14:52 +0700
Message-ID: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
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

syzbot reports a circular locking dependency between the iint mutex,
a 9p inode's i_rwsem and the sb_writers of the cachefiles backing fs:

  sb_writers#12 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_key#25

The three edges are:

  backing fs O_TRUNC open:  sb_writers(backing) -> iint(backing inode)
  9p open + IMA hash:       iint(9p inode)      -> i_rwsem(9p inode)
  9p truncate/writeback:    i_rwsem(9p inode)   -> sb_writers(backing)

The last one is inherent to netfs: it writes to its cachefiles backing
file under its own inode lock. The cycle only closes because the iint
mutex is keyed by s_stack_depth alone, so the 9p and backing fs iints,
both at depth 0, share one lockdep class. They are different inodes
and nothing waits on a netfs iint while holding the backing fs's
sb_writers, so this is a false positive.

Key the iint mutex per filesystem type as well as depth, as is done for
i_rwsem with s_type->i_mutex_key. The overlayfs case covered by the
depth annotation is unchanged.

Fixes: e044374a8a0a ("ima: annotate iint mutex to avoid lockdep false positive warnings")
Reported-by: syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=deb8af81d91415fabac1
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU on v7.4-rc4 (syzbot config, ima_policy=tcb): cachefiles
bound on an ext4 disk, 9p over virtio with cache=fscache, then 50 rounds
of write + O_RDONLY|O_TRUNC open on 9p and on the backing fs, followed by
20 IMA-measured O_TRUNC opens through an overlayfs on the backing fs.

  unpatched: "possible circular locking dependency detected", same chain
  patched:   no lockdep report, debug_locks still 1; the syzbot C repro
             also ran 90s with no report

 include/linux/fs.h                |  3 +++
 security/integrity/ima/ima_iint.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77b..dab32eea21fc7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2325,6 +2325,9 @@ struct file_system_type {
 	struct lock_class_key i_mutex_dir_key;
 
 	struct lock_class_key d_lookup_key;
+#ifdef CONFIG_IMA
+	struct lock_class_key ima_iint_key[FILESYSTEM_MAX_STACK_DEPTH + 1];
+#endif
 };
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98d..bb964847af149 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -39,19 +39,22 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * files both on overlayfs and on underlying fs, we need to annotate the iint
  * mutex to avoid lockdep false positives related to IMA + overlayfs.
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ *
+ * Depth alone is not enough: a netfs inode writes to its cachefiles backing
+ * fs under its own i_rwsem, and both are at depth 0. So, like i_rwsem, key
+ * the mutex per filesystem type too.
  */
 static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
 					     struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
-	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
-
-	int depth = inode->i_sb->s_stack_depth;
+	struct super_block *sb = inode->i_sb;
+	int depth = sb->s_stack_depth;
 
 	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
 		depth = 0;
 
-	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
+	lockdep_set_class(&iint->mutex, &sb->s_type->ima_iint_key[depth]);
 #endif
 }
 
-- 
2.43.0

