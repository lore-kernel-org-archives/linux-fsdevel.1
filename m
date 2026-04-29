Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76683330662;
	Wed, 29 Apr 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473123; cv=none; b=rC3DImnOjCegrMHQukV7TlGzlod/EVKagH0gMKBb0OQ64II5odxTmnT/csz9Ix7X9HHt1z+KQD482wxgxQpREG3+wrrWFDWZ/4fChr4uRD6znNyNPYoxdLSYeOfySv03Bh9booqrpLGXtiz1HJAV75trFWL2cqHQwzO9YBET3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473123; c=relaxed/simple;
	bh=ihPeJSPeV5CcVHFUBS2wW+9UUrvBdcKsD4PxxSE5qUc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edWc46RGPH3miyyF3OBLvgP0AjQAk2p780cfF73Jf6NevbQ0PZwGKlDOpu6ZTt5RUyM/mHvzFmu7YREI73pb3bRWuf81lK88SSIQL5EQ5Pm6qwphOM5ZP4jTrHfrZAfqQdzJeoOwLFDL6UBECYnjxb2JNI6rZ6+Wn4vqQ9ze2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss1yx218; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss1yx218"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F311C19425;
	Wed, 29 Apr 2026 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473123;
	bh=ihPeJSPeV5CcVHFUBS2wW+9UUrvBdcKsD4PxxSE5qUc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ss1yx218tGintF68DnJBohUSfHF3vO/YgEX9Fqv+eYIH8UcEbzEaYc+gSTSBamqct
	 7/JsalKtiyKYhYqY7RtB7GCoLIUHP4+S2rKP4sRUqc53jQlqTiN5KuQWPqD6yg+5yZ
	 KPw7rOSkJI2JUoNNitBWWayLC8/Cd9ltFCeOnNf+B2NOL8dOAKXbgxK2iGVSqQs6Vq
	 2sq96En0NY0C0lHhXl8T9J5x16GBHzZcEij4X+dG8v+lqKNZ9pO8DKiVY2Ed/GZiUu
	 a6guX9JaKuut+pl/NrTV0Ahdt+LBt8XtpEss7NmW/Rj198/VrHmnKx6sBPgKa9e9FM
	 WNFQNQ2YDo+dQ==
Date: Wed, 29 Apr 2026 07:32:02 -0700
Subject: [PATCH 32/33] fuse: enable swapfile activation on iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205834.4101881.6028637441703823637.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

It turns out that fuse supports swapfile activation, so let's enable
that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h      |    1 +
 include/uapi/linux/fuse.h |    5 ++++
 fs/fuse/fuse_iomap.c      |   54 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index de7d483d4b0f34..63cc1496ee5ca1 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -300,6 +300,7 @@ struct iomap;
 	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
 	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
 	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }, \
+	{ FUSE_IOMAP_OP_SWAPFILE,		"swapfile" }, \
 	{ FUSE_IOMAP_OP_WRITEBACK,		"writeback" }
 
 #define FUSE_IOMAP_TYPE_STRINGS \
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 9e59fba64f48d9..5f3724f36f764a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1406,6 +1406,9 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
 /* pagecache writeback operation */
 #define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
 
@@ -1460,6 +1463,8 @@ struct fuse_iomap_end_in {
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
 
 struct fuse_iomap_ioend_in {
 	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 1e01e0011a412d..cf52e2747e7f7f 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
+#include <linux/swap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -202,13 +203,16 @@ static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_flags)
 #undef XMAP2
 #undef XMAP
 
+#define FUSE_IOMAP_PRIVATE_OPS	(FUSE_IOMAP_OP_WRITEBACK | \
+				 FUSE_IOMAP_OP_SWAPFILE)
+
 /* Convert IOMAP_* operation flags to FUSE_IOMAP_OP_* */
 #define XMAP(word) \
 	if (iomap_op_flags & IOMAP_##word) \
 		ret |= FUSE_IOMAP_OP_##word
 static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_flags)
 {
-	uint32_t ret = iomap_op_flags & FUSE_IOMAP_OP_WRITEBACK;
+	uint32_t ret = iomap_op_flags & FUSE_IOMAP_PRIVATE_OPS;
 
 	XMAP(WRITE);
 	XMAP(ZERO);
@@ -757,6 +761,13 @@ fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
 	if (inarg->error)
 		return true;
 
+	/*
+	 * Always send an ioend for swapoff to let the fuse server know the
+	 * long term layout "lease" is over.
+	 */
+	if (inarg->flags & FUSE_IOMAP_IOEND_SWAPOFF)
+		return true;
+
 	/* Send an ioend if we performed an IO involving metadata changes. */
 	return inarg->written > 0 &&
 	       (inarg->flags & (FUSE_IOMAP_IOEND_SHARED |
@@ -1801,6 +1812,43 @@ static void fuse_iomap_readahead(struct readahead_control *rac)
 	iomap_bio_readahead(rac, &fuse_iomap_ops);
 }
 
+#ifdef CONFIG_SWAP
+static int fuse_iomap_swapfile_begin(struct inode *inode, loff_t pos,
+				     loff_t count, unsigned opflags,
+				     struct iomap *iomap, struct iomap *srcmap)
+{
+	return fuse_iomap_begin(inode, pos, count,
+				FUSE_IOMAP_OP_SWAPFILE | opflags, iomap,
+				srcmap);
+}
+
+static const struct iomap_ops fuse_iomap_swapfile_ops = {
+	.iomap_begin		= fuse_iomap_swapfile_begin,
+};
+
+static int fuse_iomap_swap_activate(struct swap_info_struct *sis,
+				    struct file *swap_file, sector_t *span)
+{
+	int ret;
+
+	/* obtain the block device from the header iomapping */
+	sis->bdev = NULL;
+	ret = iomap_swapfile_activate(sis, swap_file, span,
+				      &fuse_iomap_swapfile_ops);
+	if (ret < 0)
+		fuse_iomap_ioend(file_inode(swap_file), 0, 0, ret,
+				 FUSE_IOMAP_IOEND_SWAPOFF, NULL,
+				 FUSE_IOMAP_NULL_ADDR);
+	return ret;
+}
+
+static void fuse_iomap_swap_deactivate(struct file *file)
+{
+	fuse_iomap_ioend(file_inode(file), 0, 0, 0, FUSE_IOMAP_IOEND_SWAPOFF,
+			 NULL, FUSE_IOMAP_NULL_ADDR);
+}
+#endif
+
 static const struct address_space_operations fuse_iomap_aops = {
 	.read_folio		= fuse_iomap_read_folio,
 	.readahead		= fuse_iomap_readahead,
@@ -1811,6 +1859,10 @@ static const struct address_space_operations fuse_iomap_aops = {
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
+#ifdef CONFIG_SWAP
+	.swap_activate		= fuse_iomap_swap_activate,
+	.swap_deactivate	= fuse_iomap_swap_deactivate,
+#endif
 
 	/* These aren't pagecache operations per se */
 	.bmap			= fuse_bmap,

