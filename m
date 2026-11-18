Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039329;
	b=K0yZW2WSmX/hAFVDrJMuuVkXfHsc7tMrxLLDgdku2RoSXAobS5KQomUI8M65K+2rFxNF
	 B8UPpAIMCFSRSn0vGT2UmpghJPMTuDuzhllaeT86tk1kcEsG6w/L17WYSMYhbJNFjl2TR
	 nHFl0ywRr7YYNfEHTERzmGO07Hf6mtgvFQQab8ofgwLA3SybRjhKi+ApgV4OF/Y8h8OVL
	 jWjYkuIrisc3xjCSOCCsMXvsqZ0c6AinCZsRE+kidUYefcEXPcziWe6E1zWXXKlJIyQVI
	 NE4U9Gr35SKcStodddS6mE8nQupigm7dYFtMXITPYMpgNJA3QZ4TyPq2qAEMRQbSGhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039329;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dsLrDyEWbz+FxTmzr1hiOWbLBqwFQDIMBIXxuGuo1+o=;
	b=eUJzJDoeTnlnwq4yQlH1rQ+ViEbK4Q6PB7bKclakIIQ3CWH7ZSQLrtP5sjkQFsGw/64Q
	 V/UQY5qkjfEXRMdhQcdE4l8Q5zl6uup1pH/q+Q2FM+JSXFDVeMkwhaSLJx+AXxtUB7Glc
	 nDWScW8dt6LJc80mNHb5CxRPzCaysUrCTteFtulBsssyagFz6XSuTfbuR/qj6TI4H5kSj
	 UHnx22NTyzc5ZXyd9chEycabfEYuGULvZfOJE8b44O0fPxmwlTtDyCF6hkMhKij6i4DcR
	 /sQ97gJUQgq1MxLx0k9CIBEhVPCaCtfTdcApu9LCTpAFA0R8n3C6OG920TGfvmknVvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=szoOfojn;
	arc=none smtp.remote-ip=95.215.58.128
Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E1606A330
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 936E1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=szoOfojn
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+w/td86AL1OiB0ag/cvwouwLI4x3vgdy6/G0vf1xatM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795039326; v=1; x=1795644126;
 b=szoOfojnkE+4kLZquEh9Y2wg4ssDIZDJ7+Ua8HHYKeVqnor94DYcf6HNV70gCH0V/UOrakPc
 S4kHQug92L2WHV9Ac3qHnjXrk0zjWWpjSIJBCMuJmubiW5r6hMq8YJUc/3A90FRYQlU4DrEZVtr
 KdA3Zs+aHuptQhfOxsIdR9AA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d3be7b250bfc536d;
	Wed, 18 Nov 2026 22:02:06 +0000
X-Mizu-Trace-ID: d3be7b250bfc536d
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Ian Kent <raven@themaw.net>,
	"T . J . Mercier" <tjmercier@google.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] kernfs: report times and link count from the node in getattr
Date: Wed, 18 Nov 2026 14:01:48 -0800
Message-ID: <20261118220154.2965621-2-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261118220154.2965621-1-shakeel.butt@linux.dev>
References: <20261118220154.2965621-1-shakeel.butt@linux.dev>
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

getattr and permission copy a node's attributes into its inode while
holding kernfs_iattr_rwsem for reading, so several of them can write
the same inode at once.  That is safe only because every update of
these attributes takes the lock for writing, so they all write the same
values.  Commit aa1d058d48f2 ("kernfs: dont take i_lock on inode attr
read") relies on this.  Setting up a node's first iattrs from setxattr
does not take the lock, but a refresh that misses them writes no times.

The next patches let a directory's times and link count change without
that lock.  A slow refresh could then write an old value after a newer
one, and stat() could return a stale or torn time or link count.

Make getattr report the times and link count from the node instead of
the inode.  Permission checks use neither.  Nothing changes yet, except
that a stat() racing a node's first setxattr can report the new times.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/inode.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 53b1a2796e0b..3616161a56cb 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -162,9 +162,22 @@ static inline void set_inode_attr(struct inode *inode,
 	inode_set_ctime_to_ts(inode, attrs->ia_ctime);
 }
 
+/*
+ * Get the link count of a directory: its subdirectories plus two.
+ * Return false for other nodes and for a directory being removed.
+ */
+static bool kernfs_dir_nlink(struct kernfs_node *kn, unsigned int *nlink)
+{
+	if (kernfs_type(kn) != KERNFS_DIR || (kn->flags & KERNFS_REMOVING))
+		return false;
+	*nlink = kn->dir.subdirs + 2;
+	return true;
+}
+
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs;
+	unsigned int nlink;
 
 	inode->i_mode = kn->mode;
 	attrs = kernfs_iattrs_noalloc(kn);
@@ -175,8 +188,8 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 */
 		set_inode_attr(inode, attrs);
 
-	if (kernfs_type(kn) == KERNFS_DIR && !(kn->flags & KERNFS_REMOVING))
-		set_nlink(inode, kn->dir.subdirs + 2);
+	if (kernfs_dir_nlink(kn, &nlink))
+		set_nlink(inode, nlink);
 }
 
 int kernfs_iop_getattr(const struct mnt_idmap *idmap,
@@ -186,10 +199,25 @@ int kernfs_iop_getattr(const struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_root *root = kernfs_root(kn);
+	struct kernfs_iattrs *attrs;
+	unsigned int nlink;
 
 	down_read(&root->kernfs_iattr_rwsem);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+
+	/*
+	 * Other refreshes may store older times or link counts in the
+	 * inode at the same time.  Report the values from the node.
+	 */
+	attrs = kernfs_iattrs_noalloc(kn);
+	if (attrs) {
+		stat->atime = attrs->ia_atime;
+		stat->mtime = attrs->ia_mtime;
+		stat->ctime = attrs->ia_ctime;
+	}
+	if (kernfs_dir_nlink(kn, &nlink))
+		stat->nlink = nlink;
 	up_read(&root->kernfs_iattr_rwsem);
 
 	return 0;
-- 
2.53.1-Meta

