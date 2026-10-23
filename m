Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753995;
	b=xDAkvWxy/Bx/nblpkpwF6WhyeOf8fzmXE+LkZ4LrGoc5+LQQ+WxB3am2rPGIDVZ5jWgX
	 M3cEBkq44q/920TV90a6ajZWNQnXh+HZWB29AxAPnMjnD47GjaiyXMYB9Byb1AJQzBaXa
	 WVWfQDbTrCvBQqa/aU/lLsCvDz4rYPnc7k6cZwyoIvG3krQgX8YAN9Tb4sRi7MROfmHgP
	 6OVTa80Ln72bHln4A1qjXg/W59Ar/cNrm8VPY+lR2mny1THBMO/P5RDsITzd4iqbTdRBQ
	 rhPxbG6PwgWKffuJ9nbGPzWoQ2m3cxGKT4WpMWsepD6Mf/gmabcnXr+MiP0GPXz29Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753995;
	h=DMARC-Filter:DKIM-Signature:Message-Id:Content-Transfer-Encoding:
	 X-Original-From:Mime-Version:X-Lms-Return-Path:To:From:Date:Cc:
	 Subject:X-Mailer:Content-Type;
	bh=wNDIMRkMF3tcEtSy4kW/MkLFNBn6nfDXBhXmfecsvyw=;
	b=4zrzGVNnVyv4n+r4ebFgD68B9jfHEz/6awbff48kv/gTk/AYqMLq7VtZ5sMNHA9B45Vd
	 f0D+CuW/po/TOwz851g7i+pyStw8MJvnf8e4WzcVaShbXa33/o2ynOOnlbvEsTDz9/BBM
	 B/fW86uYXDSYwF+Eum+AizYx3ZRQd+3iez47b4iQ38z9kihaxO2aqHSL5TQddyOfTQCoR
	 BvYe8LRVCbGBqwBqI9Vs5p0Uzmgz8JrTiTbRWA/avxvvh0+FACqJMJj5tNM6vRBIrEEdp
	 Px8ySTs5GAAOg5z6U8opBCE2EVD4oWnN3/REf4LwttzoZgKwFUW+V/jrARGo0rEG+TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=FHaYMkIR;
	arc=none smtp.remote-ip=209.127.230.115
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C4606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 11:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=FHaYMkIR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792753988; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wNDIMRkMF3tcEtSy4kW/MkLFNBn6nfDXBhXmfecsvyw=;
 b=FHaYMkIRJZ+M7OQ3Jls/nE397gb1s9X223X7Phd7w7IUfDzfVhyJQCBrn/mFKv/iGO3w6B
 yCilbOTPmILFhoh6VSSmiF8zBuDx7Ora8PNZdWg6FeEVOIY5fdL5rlwsJwsqY0lixqNwwB
 1fJzfQPuMs8zanv1uBTnV7DJJN3u/u+YhxTKMt3dvAVvYi2DsHUOfYM7lCxlTotdHotYYj
 R2CX3UIwJAxULEJe2Nel77O+zMMa3TMgDHjANirarghJtEdhaJLxdl90kaaersWapgo95p
 MZsygacZGVZZYOtpoO32jNY5IE4glEzscpHg0Kbl64SQ9bFx6jFrNYrXPuUuIg==
Message-Id: <20261023111250.17696-1-zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26adb4142+b492f5+vger.kernel.org+zhaogongyi@bytedance.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Fri, 23 Oct 2026 19:12:50 +0800
Cc: <jack@suse.cz>, <jlayton@kernel.org>, <cel@kernel.org>, 
	<neil@brown.name>, <linux-fsdevel@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH v2] filelock: keep superblock active through delegation wait
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=UTF-8

A caller may drop its path after try_break_deleg() returns a delegated
inode but before break_deleg_wait() finishes. The extra inode reference
held in struct delegated_inode does not keep the superblock active.

After a lazy unmount, closing the delegation holder can release the last
mount reference and shut down the superblock while another task waits for
the delegation break. The waiter's final iput() can then enter the
filesystem's eviction code after its superblock-private state was freed.
This has been observed as a KASAN use-after-free in shmem_evict_inode().

When try_break_deleg() saves a delegated inode, take an active reference
to its superblock while the caller still pins the mount. Keep that
reference through break_deleg_wait() and the final iput(), then release
it with deactivate_super(). This protects every caller of the helpers,
including the mknod, mkdir, symlink and rmdir paths that drop their path
before waiting.

Fixes: e12d203b8c88 ("vfs: allow mkdir to wait for delegation break on parent")
Fixes: 4fa76319cd0c ("vfs: allow rmdir to wait for delegation break on parent")
Fixes: c826229c6a82 ("vfs: make vfs_create break delegations on parent directory")
Fixes: e8960c1b2ee9 ("vfs: make vfs_mknod break delegations on parent directory")
Fixes: 92bf53577f01 ("vfs: make vfs_symlink break delegations on parent dir")
Link: https://lore.kernel.org/r/20261016093421.90725-1-zhaogongyi@bytedance.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Changes since v1:
  - Hold an active superblock reference in the delegation helpers instead
    of adding mount references to the four fs/namei.c callers, as suggested
    by Al Viro and Christian Brauner.
  - Use &inode->i_sb->s_active in atomic_inc().

Validation:
  Built an arm64 KASAN Image with LLVM=1 on af32da41b032, using the same
  config, guest image, and local arm64 cpufeature compatibility change as
  the v1 tests. The tested filelock.h diff is byte-identical to this patch,
  which is based on v7.3-rc7 (24a19b953e2a). Image SHA-256:
    b7ad342b0020c31ab2be97ceb441ebc38c5840f023350462bb816552fd175870

  Ran the existing syzkaller reproducers under arm64 KVM with procs=6 and
  repeat=0. Each test had one run:

    syscall/variant    duration    programs    wait stack samples
    mkdirat             300 s         2028          7
    symlinkat           300 s         2064          8
    mknodat S_IFREG     600 s         4168         18
    mknodat S_IFIFO     600 s         4131         17
    rmdir               600 s         4174         16

  The stack samples identified the corresponding filename_*() waiter in
  break_lease(). Every VM remained responsive through the requested run;
  no Busy inodes, KASAN, WARNING, BUG, or panic appeared in serial output.
  The unpatched baseline crashes reported in v1 were not rerun.

 include/linux/filelock.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index ec11cc6b4..e909db319 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -530,8 +530,8 @@ static inline bool is_delegated(struct delegated_inode *di)
  *
  * Break delegations in a non-blocking fashion. If there are
  * outstanding delegations and @di is set, then an extra reference
- * will be taken on @inode and @di->di_inode will be populated so
- * that it may be waited upon.
+ * will be taken on @inode and its superblock, and @di->di_inode will
+ * be populated so that it may be waited upon.
  *
  * Returns 0 if there is no need to wait or an error. If -EWOULDBLOCK
  * is returned, then @di will be populated (if non-NULL).
@@ -545,16 +545,21 @@ static inline int try_break_deleg(struct inode *inode, unsigned int flags,
 	if (ret == -EWOULDBLOCK && di) {
 		di->di_inode = inode;
 		ihold(inode);
+		/* The caller may drop its mount before break_deleg_wait(). */
+		atomic_inc(&inode->i_sb->s_active);
 	}
 	return ret;
 }
 
 static inline int break_deleg_wait(struct delegated_inode *di)
 {
+	struct inode *inode = di->di_inode;
+	struct super_block *sb = inode->i_sb;
 	int ret;
 
-	ret = break_deleg(di->di_inode, 0);
-	iput(di->di_inode);
+	ret = break_deleg(inode, 0);
+	iput(inode);
+	deactivate_super(sb);
 	di->di_inode = NULL;
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)
