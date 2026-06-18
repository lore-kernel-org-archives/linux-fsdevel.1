Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE43C6A2B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775233; cv=none; b=dNqWvzDxhUzaTOEGbs0nsETmA+7smnPd6dhmUZmJY/AwDvddf6FwH+akRJSmgfcGaPgMPouhLi/8lZQJLGNIAy7kzt2mIRydUL9o2CK+Io+Jf4750PlKzKrzThTsR+jfwHT+y0gfOl/PC0aE9e/2YAXUAZ7GARfzi8CeMMLPFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775233; c=relaxed/simple;
	bh=E4xoUQYAfB9R0ge2KzmyX8XIFQ3dWRQ3idjA62ysNwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j+bhzNot3f61QvlLt2IOdAAG2VpkP5/3w5OjBAiC4PAr89df4m8Q4P7/lpt8nAePfNRy/DdZiXajF5OgQjrTviKQd1gFAejUpCjwSvVRejqQRMvQb+dUKR06InWHVcUb66LRNKonKll1ctVHLXvq3nXMo5+qv/GmUyjrG5ykezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G03aI32N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7RKxyVjA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G03aI32N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7RKxyVjA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G03aI32N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7RKxyVjA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G03aI32N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7RKxyVjA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2381975E9B;
	Thu, 18 Jun 2026 09:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781775229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVVLU70cwo9EJtEuaWEnOrXpFmW4vh6QG9VII2Z/aj8=;
	b=G03aI32N7RkiWBYSl2YHVCRa1GbBQPfE2v0f8nensCcTP77bMmFSuVOnG1VHfPOvobplDC
	OnD09xZ/9p5Oae+k9Vp44yk7jGvewRO4JbAviH97WbFixaQAOFvIugesQMEfCcXg+fUf89
	O9J4SMx7zxxPkA0HARPqjfc/JBKi/ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781775229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVVLU70cwo9EJtEuaWEnOrXpFmW4vh6QG9VII2Z/aj8=;
	b=7RKxyVjAEshY6aWNIssNtIID5w35Oe1dC+SR86GkQcjaDu9dZ5MdJF3E4NrKOPJS9aF9ZN
	35zF8nHIPNxXo/CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G03aI32N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7RKxyVjA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781775229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVVLU70cwo9EJtEuaWEnOrXpFmW4vh6QG9VII2Z/aj8=;
	b=G03aI32N7RkiWBYSl2YHVCRa1GbBQPfE2v0f8nensCcTP77bMmFSuVOnG1VHfPOvobplDC
	OnD09xZ/9p5Oae+k9Vp44yk7jGvewRO4JbAviH97WbFixaQAOFvIugesQMEfCcXg+fUf89
	O9J4SMx7zxxPkA0HARPqjfc/JBKi/ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781775229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVVLU70cwo9EJtEuaWEnOrXpFmW4vh6QG9VII2Z/aj8=;
	b=7RKxyVjAEshY6aWNIssNtIID5w35Oe1dC+SR86GkQcjaDu9dZ5MdJF3E4NrKOPJS9aF9ZN
	35zF8nHIPNxXo/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB8B7779A8;
	Thu, 18 Jun 2026 09:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lj8GMHy7M2pvcQAAD6G6ig
	(envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jun 2026 09:33:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 18 Jun 2026 11:33:29 +0200
Subject: [PATCH] exfat: implement swap activate
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com>
X-B4-Tracking: v=1; b=H4sIAGi7M2oC/x3MQQqAIBBG4avErBM0yqKrRMRgvzWbCpUKorsnL
 b/Few9FBEGkvngo4JQo+5ZhyoLcytsCJXM2Vbqy2ppO4facpnjxMbFLcnKC6ixqb7huG3jK5RH
 g5f6vw/i+H24JJiBlAAAA
X-Change-ID: 20260618-exfat_swap_activate-86e4f1a475ef
To: Namjae Jeon <linkinjeon@kernel.org>, 
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
 David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jack@suse.cz, chrubis@suse.cz, Andrea Cervesato <andrea.cervesato@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781775228; l=4226;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=z4pKz31CFDg292SZtt35iHL1zS+tUamA6QxTT571STk=;
 b=UkTmhFYxLYBEdzE7aSs+80mdJaSCDpU4N3oz7wPAZqmsdz4R2zNkhFD12N8uwjQ+jtEFbKU9Y
 VKp/jQAGevjBujHxUEuSGwHCSgND97SlBxwQht7AfHkvPhJNBZmJgqT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2381975E9B
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

From: Andrea Cervesato <andrea.cervesato@suse.com>

exfat's fallocate allocates clusters without updating valid_size,
leaving them invisible to bmap(). Extend valid_size to i_size so
that generic_swapfile_activate() can map all blocks.

This bug has been found during a Linux Test Project regression test
using swapon/swapoff testing suite.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Fixes: bf1797960c20 ("exfat: add fallocate FALLOC_FL_ALLOCATE_RANGE support")
Link: https://patchwork.ozlabs.org/project/ltp/patch/20260608155241.270875-1-japo@linux.ibm.com/
---
bf1797960c20 - ("exfat: add fallocate FALLOC_FL_ALLOCATE_RANGE support")
introduces fallocate() support in exfat, but omits the swap activate
implementation, causing EINVAL inside Linux Test Project swapon/swapoff
testing suites which are testing these syscalls with many filesystems,
including exfat.

This turned out to be a bug inside the kernel. The patch implements
swap activate in order to ensure that exfat valid_size is correctly
updated and the generic_swapfile_activate() doesn't fail with EINVAL
due to valid_size=0, which is passed to bmap().
---
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     |  2 +-
 fs/exfat/inode.c    | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index aff4dcd4e75a55296d536c19306813a566d6f0bb..18382c661d4358f8b80e6f7b5032a356a5905614 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -489,6 +489,7 @@ int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
 
 /* file.c */
 extern const struct file_operations exfat_file_operations;
+int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size);
 int __exfat_truncate(struct inode *inode);
 void exfat_truncate(struct inode *inode);
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 91e5511945d11b12658908dc6287fabd572d1d6a..12ed28c3ff896fb545bad58b47cccf808b48618d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -642,7 +642,7 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	return blkdev_issue_flush(inode->i_sb->s_bdev);
 }
 
-static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
+int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
 {
 	int err;
 	loff_t pos;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 1ea4c740fef9ef6932a75e122e1b0130c85533b2..5a395851062e4a14b456fa79546541227d8427e6 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -11,6 +11,7 @@
 #include <linux/time.h>
 #include <linux/writeback.h>
 #include <linux/uio.h>
+#include <linux/swap.h>
 #include <linux/random.h>
 #include <linux/iversion.h>
 
@@ -534,6 +535,27 @@ int exfat_block_truncate_page(struct inode *inode, loff_t from)
 	return block_truncate_page(inode->i_mapping, from, exfat_get_block);
 }
 
+static int exfat_swap_activate(struct swap_info_struct *sis,
+			       struct file *file, sector_t *span)
+{
+	struct inode *inode = file_inode(file);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	int ret;
+
+	/*
+	 * exfat's fallocate allocates clusters without updating valid_size,
+	 * leaving them invisible to bmap(). Extend valid_size to i_size so
+	 * that generic_swapfile_activate() can map all blocks.
+	 */
+	if (ei->valid_size < i_size_read(inode)) {
+		ret = exfat_extend_valid_size(inode, i_size_read(inode));
+		if (ret)
+			return ret;
+	}
+
+	return generic_swapfile_activate(sis, file, span);
+}
+
 static const struct address_space_operations exfat_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
@@ -545,6 +567,7 @@ static const struct address_space_operations exfat_aops = {
 	.direct_IO	= exfat_direct_IO,
 	.bmap		= exfat_aop_bmap,
 	.migrate_folio	= buffer_migrate_folio,
+	.swap_activate	= exfat_swap_activate,
 };
 
 static inline unsigned long exfat_hash(loff_t i_pos)

---
base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
change-id: 20260618-exfat_swap_activate-86e4f1a475ef

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>

