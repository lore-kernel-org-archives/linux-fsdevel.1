Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079195;
	b=cpUCRKB5Kl4IO3gtAKRqMpfjO4icbTulIhWbTsutlVBEWkJQ4Hb7MO16p8wCYUwoAisp
	 tPoCsyavWlV8USu3CSGUiXAHZISIpsj9Shal4fxuT1aVCRcZH8P6VN4GNITVKYORcQi0u
	 eB+na6VWWOFGHmQgSBfyrcB+P4PJcd0FnFl4TSgxfL7oWH1KJ4PpqXGRb/FVM9J77YkAX
	 1imEKEk/ADs2GHbYVHFMjF+EtmPMnpJ1TTXeWMeDUYNpE7J/V53xC2FXnePVRrgxEOmit
	 bSYBWqUIqEWnouYGan7fP/PKReLa1mdHvgVxIY8yUss09iYSvBCCruBZMXJXZM4yQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CHRGWu1y5sMNZSgTrnkNI2iw6oVF/DA3QQv0fadpr6s=;
	b=imqOREJQBbtAhxuFCwY1v/0AL6OuORTe36e37Ic6OaMJIx+E+rHtg9sH2qPMnD81/BXu
	 pdw1ZdmkTGuAjpga0A3KnLzFiCpvFvcNLmBuOBOxeAMF0/PXT3BrluUZYrVWNFqJaO+RL
	 Bo98A6OPcXBtNQmJ9R20gzi2cHa27f+rXCDOcvJoYnnMZ6N9Ibp8bhDyVaGuIBJzMgijB
	 7w3tNW1W5oFpgfnMtDgn9bWZvLBey8698wRFCJ+7yidPaRFCAIf0l6UpxaD8+TXddpskG
	 +pXUXPXgCaOGoI3FypSRzpsACPZjb5SVwXCWV7HRAzv6DTN+lXcZubEYfZRP++erQXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="A4k/UZoR";
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB9606D82A
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 19:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BB9606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=A4k/UZoR
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e6eb77f0bso156771785a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794079194; x=1794683994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHRGWu1y5sMNZSgTrnkNI2iw6oVF/DA3QQv0fadpr6s=;
        b=A4k/UZoRaoydIQDmj3d8G0MekiYwq2THpLuDQxddKBvrAv8ps+DDqQhvBqDFyYBK38
         l7oVO2IXHaTBadEZgOaQakH8RHMAKEHofy5NsC7cbzHRzDhF4OSem8IUvKsHV/2WoADO
         Lwv/5IW0QzCBy7xGxDm1NGNvOF3zALZU/ubGFmhwRgNVvwa3Q0B3rvs+Stg+SyEAC74N
         Z7Pwzd3JvbV11O3dr0ZUoo8NOuGiiNFBMxklrOgakJVoK3EmVeBFQbpAZ4Zkk5/s8o1d
         CZ72YrF97TUhhN/xjybw3qcGBEaN9oR83iw1xwYGoathdZ7U/JJQHszhSqrsF2cUu7EU
         cm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079194; x=1794683994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHRGWu1y5sMNZSgTrnkNI2iw6oVF/DA3QQv0fadpr6s=;
        b=z+LoIQxiwf/3Gg5F2eyhFp/XIVASfzyFhaa4gdnlIAmvrER8vn9nlSe/mLKY0nA6My
         +tRSOhl1bTVGkLAtjIpSAsCwtN9JwIi+IoQ84/0qAH1NEzbbyyYMAiDZra8n7GIfV9Jd
         bxQm4iwipCZX3UDMbOGaCMKA6YOTzK37AbJ8eRe4uU+fcrIHtAVwOzL6RNkXzBvyP3ja
         l1adejdT1TH4C+A5ccbNdbeIY8pQQL9aoFNf8c0PozcuDye6BY/21FctflBT2ZkufKtJ
         mFqoRVUUPWs5253N3dl7SNmCI814d+Hz92iLzpgBMoXklIHz/Oxu+BG2pFv3y1cs2//M
         +z9w==
X-Forwarded-Encrypted: i=1; AKwUvBxhZUXDSDSFnEv2yZxwKfO5kEWEopenERA9y3eB5G566htLeVJu968r8Ith5s/C8DlqeX7o5Ym0bbFe5d9u@vger.kernel.org
X-Gm-Message-State: APuU4Z+roANfGLO1Flohl/w4sGb/OJAfQcy2f2O/WLoOXKbxVSaDsedN
	4Fpv5lRoIq0Q2GNAUPxkrCYvkdcktt1RFjaLWlZ1Od2djA+45Aiqiy6zyXg8mA5tpA4=
X-Gm-Gg: AYBFou2WI1UXPd7cLbuswQja6Q0RmPSC7b1JDcB09Ca0jmVClcPSXdh4jiPCqYXDXP4
	5xtj7VNxiziyOiTymW6fZxNVlupJh1wjF3NuDoyO4KxwVtWtGu6lO5rR6RvH3+ih7YPvx3VKkIa
	QflYkfBz2CqHobQsCL1bORy94Q4f4a2X1IWeaYnF9CoR0GfkNNhiju4/2uyq4D/YQ+ADlmk8EOP
	0lHUm3NpkDrBl+MYph/ADeDEtUFcF5YaSanFXIn4qwcmdo28LSdYgY3f3GwOWGI5M8q+SpmfC+h
	GXwyuDR6snM5xJ4sqMeE0qPZ4mD67C/aDP9NSIYICZw32C+jq6bxEkcvB+B3rRPrsyZyl5CfG54
	My6rhUjfB4SAmwFg82lvr9z3KOYY9AGbBt0aZQ2Xm8pFHJ/v/f4EuLPGj18GdywTZJZrBY21b8b
	ZGzSYezZzxxGSePubg9wr2+pTjNCOwVtzjKQ7VtFIO7zWY7V1+96stmX/RoELwwTyhkYIrFnMWA
	/ddgEqt7PRjNtPRzssB+0UcDwMkRZnyfxPHx4cS1Bf+pm8YiSxMRdrU9gB5OZhU4DjNMXN9f4+M
	MR0TF6illOTO5/bV6U8p9mcHDJuiE0NyernxaQGJcnICuQ==
X-Received: by 2002:a05:620a:aa14:b0:943:b019:f011 with SMTP id af79cd13be357-946811b9167mr218000185a.28.1794079193774;
        Sat, 07 Nov 2026 11:19:53 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782dce4edsm2362385a.36.2026.11.07.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:19:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 07 Nov 2026 19:19:34 +0000
Subject: [PATCH v5 5/8] ovl: implement overlayfs' own ->write_inode
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
Message-Id: <20261107-b4-ovl-containerized-sync-v5-5-d34b4ae57fdf@toxicpanda.com>
References: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
In-Reply-To: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794079181; l=8033;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eeak9zEOr5GWnl7gy4E2TACDB4aj0LomXdxwbSspm2g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNkzRyKPjRlqtEdNFtxWzXRoEDnBGo6UCEmaeflc3bMqDZ3PLcVDLP6spyC6s1B1rVSRCwwfafG
 orcrgU5MQ0wo=
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

