Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320709;
	b=xs/8XE9ujySea8MkZP74NtFD+QFndvYajD672Rf+ZmP6qjBQL3vC07rmWKvM3HEuCFkR
	 0yj/CCWFizmw0pEB1TWqqoC3YEdLrEgXuR7E0n1wLJV/y+I6j/R5Q30C0Wknj/NDHnRsj
	 gGkOVq03reyrpn48SshUsnpx3cln49btkgELFn7elJQs54rBxgNdO+b4eJ9UQ2khDz65S
	 V6zTzjW71578shCgwKxjd7ca11BSehuby52ZtwGc7R4cwsxyiy7TvL11UEF2zroe8rvAN
	 wbm5P/1OJm1cw6/HYXPP6q8zpWxzTTd5E8alEmFUfJHIrdMpnykZKgpIdxA5OZo9Krw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CHRGWu1y5sMNZSgTrnkNI2iw6oVF/DA3QQv0fadpr6s=;
	b=G4zOYCvL2Qr5mN72M67gCaKMaxJE/9We6uIhLtVjnrj2XCQ2auS/9WBt3PrKcuwh+vRd
	 cmEr4TfvYONxyBO7I9OYgwXGiHgpA5RsfWaBCjci+eDRZSBpWnGR7rBUkND21iv2aXitY
	 9LchEBkO6zK5jLY6mFzasBGWMsteIHLWQVn+ToIfnzhDNx7b93FDRTTn1eXfCf9B10KhJ
	 IjqqM2pnoB49KTiYfy/DdzCB060LMln+RerbhRUMTEfZq4Dx/LxJN/ql4TvSDQLxw1J7U
	 evepke/BgoRbDgszgMyEzrT8lHcb+Ma8ZeeUDm067TaDFfABRfAlVC86j+HlX2WdTtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lKZUvQMZ;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C460A5BE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B55C460A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lKZUvQMZ
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5364648ae07so18106811cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320708; x=1794925508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHRGWu1y5sMNZSgTrnkNI2iw6oVF/DA3QQv0fadpr6s=;
        b=lKZUvQMZynJS+GHKNCUte33bDALUA5PKA4BxdV3Fd11vvY4DEqEz01Vs22uUOWYHBd
         lPL0S55k9KDvzgFc8wN7iQWvS3l5u/1qNXSMljvidbWijEuFW2IY8JzzDhbc5+vH8fBS
         aul4ssXxH/RLA9ZAP0If3dpjAlvB/yy941OEyNnbEWPdtwIL8JgH1sDftKDPZnfHJcS8
         LCj3akdvA4we497EAKkL51el1shfwBgUeuniGahuRbPtaKNkIAJ1iG23gogmEnOXWt28
         TaM6r1qTsapZbNZ50Q5blaEZAE3bQdIHKz7qx/ZFFYVNmdB5CXplVOFBUwzFhoqbm7iq
         IQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320708; x=1794925508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHRGWu1y5sMNZSgTrnkNI2iw6oVF/DA3QQv0fadpr6s=;
        b=UMx5mg+eCA98EGXm10SHhszTLmyiDSd9swBkxEFjNeRgVZAWrZAqKiJj0+UAwc6c8r
         XxzutvSD2JNPMlTU15CSlVeB3LueFBY12IgRnUTroA2h1Vauk/FpjFIRukptkBL9F7ZF
         r5lHsU77InER8mY+v9u2lv1FuYcQdH3ohghq1GXJlnENMsuxImNu88B74LjOGeTh7blO
         v0IW/QVU2Tti1JJiLDi8kA7x6mEsDlfZ49+KR3jUzLV1exQiuz3xFCcywmtz9qAAmHeK
         kKFxr8ZmPlqkdp8+Fz5KFVN/wQIJZ6P2W5m35X3qofOW3Lq6GOJT4OWyeqSNu7kKUrgs
         62/g==
X-Forwarded-Encrypted: i=1; AL+hErEHFtpO5yKXN/FZrUZlZ/ekoWrwPqvC2wdr3/kz2M8KtToOZiHqcWrGEu55bZqkux50OvN8heLqwBUSbh46@vger.kernel.org
X-Gm-Message-State: APuU4Z8oS7AYd3wtUZOVRPp0LV1FtBEzsS8Cn1q2rtUqZ1atTE0v4L3z
	/kLDnWzymeZpJtZKZYZ+b1sFTftRnNbHMthnCLPh4sbnnZvV9MgZbgabTo8pb3FKSKU=
X-Gm-Gg: AYBFou3eP0Kaf8pqz9/dFsKj8PxhxMUjsvuUQyXtsBIeSnG4Ux0yoihNrCwQl42U0QP
	qC6PdXQlu5DWu5EjfJ9H9+tZAuODAWUhtO9FC8/mB26WbgbTmjJ3IjVKWMb0tC7C8yisySjZEux
	6iykFn7s+3axaSzNOzIzk6RYYVwRYvMmLFLXy5mAp89PENZfNLD3WpX6B6+8Y5ITnsBBv+owroW
	aFxz24b4vnLy2lpJYRCsDZBO7MMBg2BPapSN4r4avq3LNyCM82rR08buX1cu79CUQltqH0fx7XM
	aCjOP4kJpWj6MmLzgEz6j+sjy8LjInOeXYZXZAKjLkdbINBSkZF8p9JuVFvetzeZQ5DKONBL/ky
	CDLqLY2qlHkVHT+CofbT2hYme8N0hJi67hEctIFD3sjtW4bOxMMaKysdL1pxtOo7cfhnmHmCjH7
	5OgMT49Tk7GVPdUwxp8UQcyfN5A/foOLkJC4nTt0W2gfLXVJlFUXWTPhWCpYtCq7J1vwM3r6UT8
	iIV45AFg1dtZ30OdUHBbIKYyrEULRqM80Xeo3Mhfma5cOxRdFwuPhOBE0wNCHdfQ7jWVxbc4KJ7
	aVY8kSr20+JbBnan9pkWqfe9S0stdgpGBpHbzkQrRh9JOA==
X-Received: by 2002:ac8:5e49:0:b0:536:5ee8:cca9 with SMTP id d75a77b69052e-55527f0f4eemr40813811cf.12.1794320707556;
        Tue, 10 Nov 2026 06:25:07 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0547744sm22110936d6.44.2026.11.10.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Nov 2026 14:24:53 +0000
Subject: [PATCH v6 5/9] ovl: implement overlayfs' own ->write_inode
 operation
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
Message-Id: <20261110-b4-ovl-containerized-sync-v6-5-43d1be16a4d6@toxicpanda.com>
References: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
In-Reply-To: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=8033;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eeak9zEOr5GWnl7gy4E2TACDB4aj0LomXdxwbSspm2g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPV+2OULPVHvLGtNj6GKNE6oqaDNJ23o3VPSWR0tYgp0sB75e11tnHZQOAY8aLPFomE9dAwt9Vw
 dMHaHplqjeAY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Sync dirty data and meta of upper inode in overlayfs' ->write_inode()
and redirty overlayfs' inode.

The overlay inode is only redirtied while the upper inode is open for
writing, dirty or under writeback.  So a clean overlay inode means that
everything written through it has been written back, or could not be.

The periodic pass of the flusher does not write the upper inode, the
flusher of the upper filesystem does that.  syncfs() waits for the data and
leaves the commit to ->sync_fs(), like sync_inodes_sb() does with for_sync.

The VFS ignores the return value of ->write_inode(), so record errors in
s_wb_err of the overlay for the next syncfs().

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: everything after the first paragraph]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/overlayfs.h | 13 +++++++++
 fs/overlayfs/super.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/util.c      | 52 +++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d82c4bed5af2..1d7b102a1127 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -512,6 +512,19 @@ const struct ovl_layer *ovl_layer_lower(struct dentry *dentry);
 struct dentry *ovl_dentry_real(struct dentry *dentry);
 struct dentry *ovl_i_dentry_upper(struct inode *inode);
 struct inode *ovl_inode_upper(struct inode *inode);
+
+/* How ovl_write_upper_inode() writes an upper inode */
+enum ovl_write_mode {
+	/* Start the writeback and do not wait for it */
+	OVL_WRITE_START,
+	/* Wait for the data, ->sync_fs() is going to commit the metadata */
+	OVL_WRITE_WAIT,
+	/* A write_inode_now() that waits, for a caller that is not a sync */
+	OVL_WRITE_COMMIT,
+};
+
+int ovl_write_upper_inode(struct super_block *sb, struct inode *upper,
+			  enum ovl_write_mode mode);
 struct inode *ovl_inode_lower(struct inode *inode);
 struct inode *ovl_inode_lowerdata(struct inode *inode);
 struct inode *ovl_inode_real(struct inode *inode);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 22a8d4eb3b7c..41d0d37accda 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,8 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/file.h>
 #include <linux/fs_context.h>
@@ -314,12 +316,85 @@ static int ovl_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return err;
 }
 
+/*
+ * Could there be anything left to write or to wait for on @upper?
+ *
+ * A task that has @upper open for writing may have it mapped, and overlayfs
+ * does not see stores through a mapping.  The mapping holds the file open.
+ *
+ * Writeback that has been started but not completed, by us or by the flusher of
+ * the upper filesystem, shows in the page cache tags.  It does not show in the
+ * dirty flags of the inode, which are cleared when writeback starts.
+ *
+ * So dirty flags that are clear say nothing.  Dirty flags that are set do say
+ * that there is something left to write.  @upper may not have been written at
+ * all, see ovl_write_inode().  And a write_inode_now() that does not wait does
+ * nothing if the flusher of the upper filesystem is writing @upper.  A
+ * modification that was made during that pass is only recorded in the flags.
+ *
+ * i_writecount has to be read first.  If it is seen at zero, the tag of a page
+ * that was dirtied through a mapping must be seen as well.  The tag is set when
+ * the mapping goes away at the latest.  i_writecount drops after that, when the
+ * file is released, with the full barrier of the last fput() in between.
+ */
+static bool ovl_upper_unfinished(struct inode *upper)
+{
+	struct address_space *mapping = upper->i_mapping;
+
+	return atomic_read_acquire(&upper->i_writecount) > 0 ||
+	       mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
+	       mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
+	       (inode_state_read_once(upper) & (I_DIRTY | I_SYNC));
+}
+
+static enum ovl_write_mode ovl_write_mode(struct inode *inode,
+					  struct writeback_control *wbc)
+{
+	if (wbc->sync_mode != WB_SYNC_ALL)
+		return OVL_WRITE_START;
+
+	/*
+	 * syncfs() and unmount call ovl_sync_fs() next.  While the overlay is
+	 * being mounted, iput() writes a dirty inode because it cannot keep it.
+	 * Nobody has asked for that inode to be durable yet.
+	 */
+	if (wbc->for_sync || !(inode->i_sb->s_flags & SB_ACTIVE))
+		return OVL_WRITE_WAIT;
+
+	return OVL_WRITE_COMMIT;
+}
+
+static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	struct inode *upper = ovl_inode_upper(inode);
+	int ret = 0;
+
+	if (!upper)
+		return 0;
+
+	/*
+	 * Leave periodic and background writeback to the flusher of the upper
+	 * filesystem.  @upper is on its dirty list, and it knows when the data
+	 * is old enough to be written.  All there is to do here is to find out
+	 * whether the overlay inode can be clean again.
+	 */
+	if (!wbc->for_kupdate && !wbc->for_background)
+		ret = ovl_write_upper_inode(inode->i_sb, upper,
+					    ovl_write_mode(inode, wbc));
+
+	if (ovl_upper_unfinished(upper))
+		ovl_mark_inode_dirty(inode);
+
+	return ret;
+}
+
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
 	.destroy_inode	= ovl_destroy_inode,
 	.drop_inode	= inode_just_drop,
 	.put_super	= ovl_put_super,
+	.write_inode	= ovl_write_inode,
 	.sync_fs	= ovl_sync_fs,
 	.statfs		= ovl_statfs,
 	.show_options	= ovl_show_options,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a260c5a350e2..d7b08a46cb76 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -14,6 +14,7 @@
 #include <linux/fileattr.h>
 #include <linux/uuid.h>
 #include <linux/namei.h>
+#include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #include <linux/overflow.h>
 #include "overlayfs.h"
@@ -1526,3 +1527,54 @@ void ovl_copyattr(struct inode *inode)
 	__ovl_copyattr(inode);
 	ovl_mark_inode_dirty(inode);
 }
+
+/*
+ * Do what sync_inodes_sb() does to an inode: wait for the data, hand the inode
+ * to the filesystem, and leave it to ->sync_fs() to commit it.  It gets there
+ * by setting for_sync, which write_inode_now() cannot be told about.  If that
+ * waits, ext4 commits a transaction for every inode.
+ */
+static int ovl_sync_upper_inode(struct inode *upper)
+{
+	int err, err2;
+
+	err = filemap_write_and_wait(upper->i_mapping);
+
+	err2 = sync_inode_metadata(upper, 0);
+	/*
+	 * That does nothing if the flusher of the upper filesystem is writing
+	 * @upper, and the flusher may have looked at the inode before it was
+	 * modified.  Wait for the flusher in that case.
+	 */
+	if (!err2 && (inode_state_read_once(upper) & (I_DIRTY_INODE | I_SYNC)))
+		err2 = sync_inode_metadata(upper, 1);
+
+	return err ? err : err2;
+}
+
+/*
+ * Write @upper for the overlay @sb.
+ *
+ * Nobody may be there to take the error.  The VFS ignores what ->write_inode()
+ * returns when it walks the dirty list.  Record the error in the superblock of
+ * the overlay, like mapping_set_error() does for a page that could not be
+ * written, so that the next syncfs() on the overlay returns it.
+ */
+int ovl_write_upper_inode(struct super_block *sb, struct inode *upper,
+			  enum ovl_write_mode mode)
+{
+	int err;
+
+	/* sync_inodes_sb() does not wait for such a filesystem either */
+	if (upper->i_sb->s_iflags & SB_I_NO_DATA_INTEGRITY)
+		mode = OVL_WRITE_START;
+
+	if (mode == OVL_WRITE_WAIT)
+		err = ovl_sync_upper_inode(upper);
+	else
+		err = write_inode_now(upper, mode == OVL_WRITE_COMMIT);
+
+	if (err)
+		errseq_set(&sb->s_wb_err, err);
+	return err;
+}

-- 
2.55.0

