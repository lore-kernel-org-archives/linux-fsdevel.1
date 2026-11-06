Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972249;
	b=E4a+DRZQ8e0l8O9HNjpGX41zA0MHHsbY2l3os0Z+oxkq0A2qiKWlrXTYEMzkjCvWeykq
	 907BhSntnq0RPHvHTg3JXpRVsyVE9915fKk93PZjc+/uNrBoDNvb90xJhO8zEzIqsLzfD
	 kfzPnEW2zzNxr34k2mRnhbbKXfgWXolf0UbCPW8QeaOT0vndHpEMENf2IONvaaEw03tNX
	 N5qK6NkoIRysFX38ayzAiiFHFSk82E5lJGK13EGFzSRF+WNn7J3A7VV5eqNSUk5YpUy+J
	 E7cYHCg9sICEev0AuG8i9z/03PT4HM8bQ6iDbNfN08irgcU1sFM7mZCtXWWfnClWhJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xLV0NTItWVb6Of/QLnfvc3FL+Jzfuvj2EKq+VHcPs88=;
	b=2jtdz32J+X0Adf1or72sVFrif5bp9xXOZMw1CWUyaUW4wQQtBiw7czN+P1PMR3rChacZ
	 VRNvaF54PXTfp1u511hpEmelaJ/d6UhKiwBYEleCMS8amO7XbArMSpAf6o9DfljypyNkh
	 3TxbYeom+raUEXecYrgs0D82+GZpcYLuz4YhbkcT6kH2xfYtHMXK5HG8+GN/VysMisAIM
	 X+D5s+tFeHDWQ7ZSH0FjHaCwb1ixV8I1aQ/htJOwledm14lHKIDSR37WppEVEYgZcOEQ8
	 N+sH41FVqad5tDfvXvw6rChlSvEh1XNfDfoAQ69T1vn9mKwrqNYqjpDgUicnxEy2nDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=U6kTvX5b;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B3606EE89
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E65B3606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=U6kTvX5b
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eb5559b34so1210766d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793972230; x=1794577030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xLV0NTItWVb6Of/QLnfvc3FL+Jzfuvj2EKq+VHcPs88=;
        b=U6kTvX5bh/Ii+g6KaruNuhE9tu0zNCnZIF+M+hcRoKzjSTEBWhjv6XPCdk/+TET6aa
         9clPbFlhvS4IOPmLLY6pNi6fK4NGQ49f6JjpoboYdB/10+wH196nxQ+P+DmJPGUFwoNF
         ybI8NSupoP+4gSUvNOSCBbXDleW4+V5lMzInL2oepK4tysDt3LS9Uh28e824XOJz/ECd
         X5rWB1y91GrnyoVg8/gZXQ9JJjF+GPVZCkroSN3ToGUsc4tZkSTrQS0SJ4Db7t6Pm4Qd
         hTxFkMwt8WVEnBCs5VXYy/mVlhNNJptGFJpeDUQj+SxvM9+CoVBE5NdMLXmft7glqSLR
         aIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972230; x=1794577030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xLV0NTItWVb6Of/QLnfvc3FL+Jzfuvj2EKq+VHcPs88=;
        b=N0xMePvjRvAYmDebOJBANS9jlJNI0k4jZPUBXMhve69EoaZl6E8FPTIf8CTViiWOfc
         ldZiY8xT9kpADr2AqA1qavmO5EbCufjrtHyncWms+1/UNvqu4OIDdFeDzvT01qu6Mu7e
         Q88bJA+BNuXP38hR/rt4FHxY7ulj7vVL+9sPbStF0SNCz2UT4iM0XJJ5yfmg4v6Zjhpo
         Q0VodCVz19o91RrWaRFfOw5u8O0Xt2ums1CqF1/jPmn6X09MbfpEjHA60N9hOoz4/4QR
         eb8bg8+7NlwyNoP95Fct8OBKtOC25gcSV9DJJSWHCLxbV1ZW7Q1LHo8BZjETCPssmKtT
         nl3w==
X-Forwarded-Encrypted: i=1; AL+hErG27hiXU/2j4tiknjmujGhaSOd+GV/0n1zGO83jHIxQiHNyYMQzEYVEee6++NXffRo8P9rv1Hu6m3ORM6Jl@vger.kernel.org
X-Gm-Message-State: APuU4Z9hchn6wD2lqcbLHGMbDp75D6NV2rGC3BB/kWa/+G1Vytm0EnwW
	b1/+9mgSvW2RrfuelXvLmz/ibAr5+ASDPFyGKTUhc857ma7LHYjqn/mevJyEeiCpjdY=
X-Gm-Gg: AYBFou2mqwrvz6hI9SO2VPGUdPy1HZDwn+rJrTio3+A+3+4yrE5lcNKo1RqpAIbiehl
	GgYBjq0DDZ+psvUEzgQDVAsGKk72gRD+rhf4+jgHx6937Nuyxg2mRsIFc3kbUFAD3vlO3Zm6+80
	DMpaX+7xa7NS3njYhwjlTkELE2QQlYhHMEyarrXQU8HJHCV1HA/yoW+56XiWeWlZ5ZLseGHjpm9
	lA7TdSRFodwi5cEq20VIecrsT6FpLm3GItiSDvBEZ6w4U5k5gu8XGMhxCQzFcHOvisM8n4k6fUk
	aIZXRU7KU4X9GXvyEb3akdG5mWq+MsOiZrsF7DztooUq02kb7XvMKaYdS34cLp2bpNkMHuA4bnC
	Gmg8bO3Od0Y8nQIKw5VThIggTL3TVQvqbg7PqGYn71C2SsrNmSv5qU2Bs3Xxpkj8Xdcr+IR2aAe
	Ztqt31Y4XwDaFf+OCZmo7HG7T3ayA4sMif7dJD1C+BlWWZzB5KThI4TkNUbKNX+ENGlJHILF2vH
	9CjfJZIGsjwyC+9Ki11RJabRHlunvsbobU4br59dr+wEJXondpDD1VwFr0zCOlEACPrHaA+0RzC
	+0itintN3AcFPfeBmyLOgPBYYeBduUqFKU23kdCZeejnpw==
X-Received: by 2002:a05:6214:5c81:b0:91e:b505:c2c2 with SMTP id 6a1803df08f44-91eb505c7b5mr7561396d6.32.1793972229630;
        Fri, 06 Nov 2026 05:37:09 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ab9ba7sm20723976d6.40.2026.11.06.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:37:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 06 Nov 2026 13:36:49 +0000
Subject: [PATCH v4 7/8] ovl: handle lazytime on the upper filesystem
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
Message-Id: <20261106-b4-ovl-containerized-sync-v4-7-6ddde0b7dd8a@toxicpanda.com>
References: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
In-Reply-To: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793972217; l=5683;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yvlq657zwsc3/H0ga+5OlfjJGR58bqI8IsDA8XBZIvA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEQrtYMpnj4SKGNUkqBkMKo0YWZ0+s2IMSSqe9GROOaXH7o9w4OU5FJrjfK0es1bTMaWTVaZjg8
 gGwM4F04bSgY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With lazytime on the upper filesystem the flusher leaves timestamps in
memory for up to 12 hours.  The overlay inode must not be clean during that
time, or syncfs() would miss them.  It cannot stay dirty either, because
the flusher would visit it on every pass and it could not be reclaimed.

When deferred timestamps are all that is left to write, set I_DIRTY_TIME on
the overlay inode, like the VFS does on the upper inode.  Implement
->sync_lazytime() to pass the request on to the upper inode.

The VFS writes deferred timestamps on the last iput().  The upper inode
does not see that while the overlay inode holds it, so the last iput() of
the overlay inode stands in for it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/dir.c       |  1 +
 fs/overlayfs/inode.c     | 19 +++++++++++++++++++
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 27 +++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1194ccf981c3..fc47beffa67e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1489,6 +1489,7 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
 	.tmpfile	= ovl_tmpfile,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 9a4bf7c2502b..5895ee5aa771 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -743,6 +743,22 @@ int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	return err;
 }
 
+/*
+ * The overlay inode has I_DIRTY_TIME set because the upper inode has deferred
+ * timestamps, see ovl_park_inode().  The VFS calls this when the timestamps
+ * have to be written.  Mark the upper inode dirty, which hands the timestamps
+ * to the upper filesystem, and mark the overlay inode dirty, so that
+ * ovl_write_inode() writes the upper inode.
+ */
+void ovl_sync_lazytime(struct inode *inode)
+{
+	struct inode *upper = ovl_inode_upper(inode);
+
+	if (upper && (inode_state_read_once(upper) & I_DIRTY_TIME))
+		mark_inode_dirty_sync(upper);
+	ovl_mark_inode_dirty(inode);
+}
+
 static const struct inode_operations ovl_file_inode_operations = {
 	.setattr	= ovl_setattr,
 	.permission	= ovl_permission,
@@ -752,6 +768,7 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
@@ -763,6 +780,7 @@ static const struct inode_operations ovl_symlink_inode_operations = {
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 };
 
 static const struct inode_operations ovl_special_inode_operations = {
@@ -774,6 +792,7 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 };
 
 static const struct address_space_operations ovl_aops = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 1cc682f28cc3..2ef4b4b23990 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -891,6 +891,7 @@ static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
 
 int ovl_update_time(struct inode *inode, enum fs_update_time type,
 		unsigned int flags);
+void ovl_sync_lazytime(struct inode *inode);
 bool ovl_is_private_xattr(struct super_block *sb, const char *name);
 
 struct ovl_inode_params {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 87773b73f228..27e30d0ace80 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -364,6 +364,31 @@ static enum ovl_write_mode ovl_write_mode(struct inode *inode,
 	return OVL_WRITE_COMMIT;
 }
 
+/*
+ * All that is left to write for @inode are timestamps that lazytime has
+ * deferred on the upper inode.  The flusher leaves those alone for up to 12
+ * hours.  Set I_DIRTY_TIME on the overlay inode, like the VFS did on the upper
+ * inode.  This takes the overlay inode off the list that the flusher walks,
+ * syncfs() still finds it, and the VFS calls ovl_sync_lazytime() when the
+ * timestamps have to be written.
+ *
+ * One of those occasions is when the last reference to an inode goes away.  The
+ * upper inode never loses its last reference while the overlay inode exists, so
+ * the overlay inode has to stand in for it.  The last reference to the overlay
+ * inode may already be gone at this point.  iput() checks for I_DIRTY_TIME
+ * under i_lock before it drops the last reference, so either iput() sees the
+ * flag, or the reference count is zero here.
+ */
+static void ovl_park_inode(struct inode *inode)
+{
+	if (!ovl_tracks_dirty(OVL_FS(inode->i_sb)))
+		return;
+
+	__mark_inode_dirty(inode, I_DIRTY_TIME);
+	if (!icount_read_once(inode))
+		mark_inode_dirty_sync(inode);
+}
+
 static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct inode *upper = ovl_inode_upper(inode);
@@ -384,6 +409,8 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (ovl_upper_unfinished(upper))
 		ovl_mark_inode_dirty(inode);
+	else if (inode_state_read_once(upper) & I_DIRTY_TIME)
+		ovl_park_inode(inode);
 
 	return ret;
 }

-- 
2.55.0

