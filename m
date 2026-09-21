Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA24E4305
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025447; cv=none; b=pa0e4nTzgDmRr5QpGv1HKXmXO9UrGB9VbJz0SCvxkoMvAz2afEGsXT/KjSos5tNGBJ3dr1NTWPPm2SgzaAe74FTkEfbr1A6QGJWqyqRZ2F/xBds7RcIBKqf+uViw+anhgF4vyRYu/ZeCLVeY3R9VQ7jc+lOsjUqhJU4747En2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025447; c=relaxed/simple;
	bh=9E01pAg8oT9htHnqU80DkB8JhgUU71Qq3V8l9lt9LRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wn8xBdn9lo11eVP207ce5DuIWi9yP5Onf/gnGlX3jI9obVKpZ+hIAjcihr32kipFzKYGWPE1UXccSMGM9svke5AVGi2DwIzF54s8v/Z3USHCR3xYkwqUHj9WvcwSdU8zQWdS2HCSvMma7lLUgHFwGqgarFGzjpAotNOcamxYR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVhiJk7W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVhiJk7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790025444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BTGLw0u5wZsYdLeba0o67Y/uJV4wahD4Zjze/EY0qik=;
	b=ZVhiJk7WCopfqOnKVLwp8fx/12g98Cc8YqNxMWvfFaLD5N6NtYdqlzDrF0pXNFRTnVHbia
	iBTR0vt7Gh4ir3E7zDbmqILaMk0fJteCVZo05df8YlyVEczUOhm4bvsPWrWuBr1B3ZAjQc
	sMKmx9hHwROaCKXCh1ehH+yZx94t/GQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-O7KXu9-qM42wMXQejxamoQ-1; Mon,
 21 Sep 2026 17:17:20 -0400
X-MC-Unique: O7KXu9-qM42wMXQejxamoQ-1
X-Mimecast-MFC-AGG-ID: O7KXu9-qM42wMXQejxamoQ_1790025439
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB3721802670;
	Mon, 21 Sep 2026 21:17:18 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60D0F1956095;
	Mon, 21 Sep 2026 21:17:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/gfs2: prevent premature evict in prune_icache_sb
Date: Mon, 21 Sep 2026 23:17:11 +0200
Message-ID: <20260921211712.1563575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Introduce a new I_NOPRUNE i_state flag for preventing prune_icache_sb()
from pruning specific inodes.

prune_icache_sb() prunes clean inodes under memory pressure ("direct
reclaim").  An inode is considered clean when none of the i_state flags
are set; the assumption is that evicting inodes that don't have any
i_state flags set will be fairly cheap.

Unfortunately, on gfs2, inodes can be clean in the sense that they won't
require writing back to disk, but they may still have outstanding
revokes (as indicated by the GLF_LFLUSH inode glock flag).  To evict one
of those inodes, those outstanding revokes need to be written out first.

This requires flushing the log, which is already an expensive operation.
When in data=ordered mode, all the ordered data needs to be written out
before the log can be flushed, which makes things even worse.

As previously discussed [*], we are currently also running into the
following warning in iomap_writepages() when flushing ordered data:

    /*
     * Writeback from reclaim context should never happen except in the case
     * of a VM regression so warn about it and refuse to write the data.
     */
    if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) ==
                    PF_MEMALLOC))
            return -EIO;

So we need to prevent prune_icache_sb() from evicting inodes that have
any outstanding revokes.  This patch achieves that by introducing a new
I_NOPRUNE i_state flag.  When that new flag (or any other flag) is set,
prune_icache_sb() will skip those inodes.

In the filesystem code, we set and clear the I_NOPRUNE flag in sync with
the GLF_LFLUSH inode glock flag.

An alternative approach might be to allow filesystems to refuse evicting
inodes that prune_icache_sb() has already selected.  This could be
achieved by changing the ->evict_inode super operation to return a
lru_status code or similar.  prune_icache_sb() would then have to
resurrect inodes that were already marked I_FREEING and put them back
onto the lru list.  This approach doesn't seem obviously better than
introducing I_NOPRUNE, so I haven't pursued this any further.

[*] https://lore.kernel.org/linux-fsdevel/CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com/

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h   |  3 +++
 fs/gfs2/inode.c    |  2 +-
 fs/gfs2/log.c      | 43 +++++++++++++++++++++++++++++++++++++++++--
 fs/gfs2/lops.c     |  2 +-
 fs/gfs2/trans.c    |  4 ++--
 include/linux/fs.h |  3 ++-
 6 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 61465777826a..e37e5d057608 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -379,6 +379,9 @@ static inline u64 glock_number(const struct gfs2_glock *gl)
 	return gl->gl_name.ln_number;
 }
 
+void glock_set_lflush(struct gfs2_glock *gl);
+void glock_clear_lflush(struct gfs2_glock *gl);
+
 enum {
 	GIF_QD_LOCKED		= 1,
 	GIF_SW_PAGED		= 3,
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 9fce2d3e8e7d..22b5b404b8d5 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -466,7 +466,7 @@ static void gfs2_final_release_pages(struct gfs2_inode *ip)
 	truncate_inode_pages(&inode->i_data, 0);
 
 	if (atomic_read(&gl->gl_revokes) == 0) {
-		clear_bit(GLF_LFLUSH, &gl->gl_flags);
+		glock_clear_lflush(gl);
 		clear_bit(GLF_DIRTY, &gl->gl_flags);
 	}
 }
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 78bba8cc10b8..1f0bb3da4df6 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -24,6 +24,7 @@
 #include "incore.h"
 #include "bmap.h"
 #include "glock.h"
+#include "glops.h"
 #include "log.h"
 #include "lops.h"
 #include "meta_io.h"
@@ -760,6 +761,44 @@ void gfs2_ordered_del_inode(struct gfs2_inode *ip)
 	spin_unlock(&sdp->sd_ordered_lock);
 }
 
+void glock_set_lflush(struct gfs2_glock *gl)
+{
+	struct inode *inode;
+
+	set_bit(GLF_LFLUSH, &gl->gl_flags);
+
+	if (gl->gl_ops != &gfs2_inode_glops)
+		return;
+
+	spin_lock(&gl->gl_lockref.lock);
+	inode = gl->gl_object;
+	if (inode && !(GFS2_I(inode)->i_diskflags & GFS2_DIF_SYSTEM)) {
+		spin_lock(&inode->i_lock);
+		inode_state_set(inode, I_NOPRUNE);
+		spin_unlock(&inode->i_lock);
+	}
+	spin_unlock(&gl->gl_lockref.lock);
+}
+
+void glock_clear_lflush(struct gfs2_glock *gl)
+{
+	struct inode *inode;
+
+	clear_bit(GLF_LFLUSH, &gl->gl_flags);
+
+	if (gl->gl_ops != &gfs2_inode_glops)
+		return;
+
+	spin_lock(&gl->gl_lockref.lock);
+	inode = gl->gl_object;
+	if (inode && !(GFS2_I(inode)->i_diskflags & GFS2_DIF_SYSTEM)) {
+		spin_lock(&inode->i_lock);
+		inode_state_clear(inode, I_NOPRUNE);
+		spin_unlock(&inode->i_lock);
+	}
+	spin_unlock(&gl->gl_lockref.lock);
+}
+
 void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 {
 	struct buffer_head *bh = bd->bd_bh;
@@ -772,14 +811,14 @@ void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 	bd->bd_blkno = bh->b_blocknr;
 	gfs2_remove_from_ail(bd); /* drops ref on bh */
 	bd->bd_bh = NULL;
-	set_bit(GLF_LFLUSH, &gl->gl_flags);
+	glock_set_lflush(gl);
 	list_add(&bd->bd_list, &sdp->sd_log_revokes);
 }
 
 void gfs2_glock_remove_revoke(struct gfs2_glock *gl)
 {
 	if (atomic_dec_return(&gl->gl_revokes) == 0) {
-		clear_bit(GLF_LFLUSH, &gl->gl_flags);
+		glock_clear_lflush(gl);
 		gfs2_glock_put_async(gl);
 	}
 }
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad790..8363c02f8b9e 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -127,7 +127,7 @@ static void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	list_add(&bd->bd_ail_st_list, &tr->tr_ail1_list);
 	spin_unlock(&sdp->sd_ail_lock);
 
-	clear_bit(GLF_LFLUSH, &bd->bd_gl->gl_flags);
+	glock_clear_lflush(bd->bd_gl);
 	trace_gfs2_pin(bd, 0);
 	unlock_buffer(bh);
 	atomic_dec(&sdp->sd_log_pinned);
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 65cbe06e301a..7a9da7253246 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -222,7 +222,7 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 	gfs2_assert(sdp, bd->bd_gl == gl);
 	set_bit(TR_TOUCHED, &tr->tr_flags);
 	if (list_empty(&bd->bd_list)) {
-		set_bit(GLF_LFLUSH, &bd->bd_gl->gl_flags);
+		glock_set_lflush(bd->bd_gl);
 		set_bit(GLF_DIRTY, &bd->bd_gl->gl_flags);
 		gfs2_pin(sdp, bd->bd_bh);
 		tr->tr_num_databuf_new++;
@@ -287,7 +287,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	set_bit(TR_TOUCHED, &tr->tr_flags);
 	if (!list_empty(&bd->bd_list))
 		goto out_unlock;
-	set_bit(GLF_LFLUSH, &bd->bd_gl->gl_flags);
+	glock_set_lflush(bd->bd_gl);
 	set_bit(GLF_DIRTY, &bd->bd_gl->gl_flags);
 	mh = (struct gfs2_meta_header *)bd->bd_bh->b_data;
 	if (unlikely(mh->mh_magic != cpu_to_be32(GFS2_MAGIC))) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d10897b3a1e3..270aa3dead91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -740,7 +740,8 @@ enum inode_state_flags_enum {
 	I_CREATING		= (1U << 15),
 	I_DONTCACHE		= (1U << 16),
 	I_SYNC_QUEUED		= (1U << 17),
-	I_PINNING_NETFS_WB	= (1U << 18)
+	I_PINNING_NETFS_WB	= (1U << 18),
+	I_NOPRUNE		= (1U << 19)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
-- 
2.55.0

