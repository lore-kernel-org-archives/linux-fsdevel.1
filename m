Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558477;
	b=kurh3oy3/lhwvrD/uAt0Mz2ZWSDxoCCCtQUjkxUilga5oM3wz+fLXRKLY2eZ35W0OD3x
	 VQ0Hgen6j/OYaT9nshbFC1CxH4R74VxdYFtVDG3YWoejKZXqjLJj6aIhvSkc5hJTFUium
	 qJYOk+5dasgT42Tm+MN4Zj0QuFlzQaCNMMsJf+qR004AYbAZfSVTtHHeXobni0qy1bSQe
	 LUfXC5DDe1l55nsCUFz3+pZMgoRkRXCTxdLo+tF0tdWS21gyHDCGkZhTr9pisWzVRdECh
	 Wf1DBy+mpp9Y/wZNfVk6fAf+l8vU9U8woHterod8SIki/uoGds7J4H5oVFlQ4e897mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558477;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=IrI6hUt0g2I57Vj4T8BErsew5Omk26HDFgucMHVWLkQ=;
	b=sNIcYoHRZ6w4WQCovMDuJO8rDr6+ATUyduMCbCMUzgeVCi48dzAiVyXSBxqHJFV7R0fH
	 pvZ7IWUtPdXgIW9x2UnAhIcG+uP3MWyErzicuNVwCqvXaIHPHcZ5Yux81gl7zxVA958wP
	 VmRjGdts8pnQ+f5a+kYwCdAL7AtE74nVzm8Bpx/IWQj65i2XTKTVJVsuiTicF234HAH6s
	 uSNCriUDwmLtU+NDFE/3WzGq9SAZF+UYtyBrAdebYXo+y28xDrvCgiAjstaP1E1iWDEDC
	 sUkqZw73WkuSbi51kOqrpK63flMSt6ICC06Rd/G/iKZKB2Dy5blGjlU4Wh59sPwblmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LIKHGlXN;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y5XB2d13;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LIKHGlXN;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y5XB2d13;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED07606A337
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 08:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED07606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LIKHGlXN;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y5XB2d13;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LIKHGlXN;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y5XB2d13
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CF7B1F7B5;
	Fri, 13 Nov 2026 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794558474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IrI6hUt0g2I57Vj4T8BErsew5Omk26HDFgucMHVWLkQ=;
	b=LIKHGlXN9GtIVZWotiVUdsHgmjbQ9Xl6SxkqmAPaPj9s/jO7FBDM5qI3gLbjDtgRpclqrS
	WElHnqT5uqUCf5+5GgbFPqNBSuTgJzFsd0S8/9XK/9EyEY1LJPg6qQuWCmdQU9Wc+sy8Ku
	VzMr6oH5Ybz9b8rdshGUkQ31GeoXoC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794558474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IrI6hUt0g2I57Vj4T8BErsew5Omk26HDFgucMHVWLkQ=;
	b=Y5XB2d13i/aP/K21zajq1fd0NuYyYK1XYEt5F02u1nwyR5sAlc18TI9GnQnj57KXeSc0JQ
	gwnt/9iQkT6LMWAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794558474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IrI6hUt0g2I57Vj4T8BErsew5Omk26HDFgucMHVWLkQ=;
	b=LIKHGlXN9GtIVZWotiVUdsHgmjbQ9Xl6SxkqmAPaPj9s/jO7FBDM5qI3gLbjDtgRpclqrS
	WElHnqT5uqUCf5+5GgbFPqNBSuTgJzFsd0S8/9XK/9EyEY1LJPg6qQuWCmdQU9Wc+sy8Ku
	VzMr6oH5Ybz9b8rdshGUkQ31GeoXoC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794558474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IrI6hUt0g2I57Vj4T8BErsew5Omk26HDFgucMHVWLkQ=;
	b=Y5XB2d13i/aP/K21zajq1fd0NuYyYK1XYEt5F02u1nwyR5sAlc18TI9GnQnj57KXeSc0JQ
	gwnt/9iQkT6LMWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123D4134C3;
	Fri, 13 Nov 2026 08:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UukjOAnK9mpGAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:27:54 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 92D2E22C21; Fri, 13 Nov 2026 09:27:53 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Hongyu Jin <hongyu.jin.cn@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3] writeback: Avoid postponing periodic data writeback indefinitely
Date: Fri, 13 Nov 2026 09:27:45 +0100
Message-ID: <20261113082744.737189-2-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6364; i=jack@suse.cz; h=from:subject; bh=ozTjbqsnkDY+3ZL4TV5O6d73qWCQRmT2ACLzJbeTmKA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9soAQIjOYHg95O3TGAg/FWEiOsNrW75/2x+4Q VHo/BVF4raJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbKAAAKCRCcnaoHP2RA 2eeUB/49PrfrL3NRg/eBQZc8T7goYXE7ezK3ImGuAAc6ceoHFgYZwEGA+fSFEaoTWQ689cXh/Jg W0vDIZ1e581UPLUzs51EPfT/BAlgO6usR7RO4pB5GprA3g+r/FxJ+rYdWNpkn2wjcfQGOlcjtnP 1AhuL2m36M6dWwRIcy1Wi5fMT4YgH6TBPkan5v4tKHiW9/BFEV0Vgo+qmRtLZXa7oGzxjKYb9rA OOMLOkqmgGlDv4MIQa3LkX+fP8SvVZOVhf9EcVxLt22gxfGRWXr2Y4VbOEfE5XborN1sCwa9gRF vrN97lazEtztsuE/N3t/I2cvP41TxnH7zIJcSw95Yp/sUo60
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-10.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -10.30

Hongyu Jin has reported that f2fs periodically calls
sync_inode_metadata() for some inodes. The logic in
writeback_single_inode() thus periodically calls to redirty_tail() and
the inode's dirtied_when timestamp never gets old enough for the inode
to be eligible for periodic data writeback. Thus dirty data from it is
only ever written on explicit request (fsync(2), sync(2), unmount) or
on dirty limit pressure.

The redirty_tail() logic in writeback_single_inode() is only needed do
place inode in the dirty list when the setting of I_DIRTY_PAGES in
__writeback_single_inode() raced with filemap_dirty_folio(). So be more
careful in __writeback_single_inode() to make sure __mark_inode_dirty()
always places in the inode in the proper list and modify
writeback_single_inode() to only demote inode to "less dirty" list based
on dirty bits cleared as a result of writeback.

Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 74 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

Changes since v2:
- fix I_DIRTY_PAGES handling race leading to dirty inode not placed in the
  dirty list

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 15260cf2a29b..79e642aa45da 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1800,6 +1800,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	struct address_space *mapping = inode->i_mapping;
 	long nr_to_write = wbc->nr_to_write;
 	unsigned dirty;
+	bool pages_cleared = false;
 	int ret;
 
 	WARN_ON(!(inode_state_read_once(inode) & I_SYNC));
@@ -1839,30 +1840,42 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * after handling timestamp expiration, as that may dirty the inode too.
 	 */
 	spin_lock(&inode->i_lock);
-	dirty = inode_state_read(inode) & I_DIRTY;
+	dirty = inode_state_read(inode) & I_DIRTY_INODE;
 	inode_state_clear(inode, dirty);
+	if (inode_state_read(inode) & I_DIRTY_PAGES &&
+	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
+		inode_state_clear(inode, I_DIRTY_PAGES);
+		pages_cleared = true;
+	}
 
 	/*
 	 * Paired with smp_mb() in __mark_inode_dirty().  This allows
 	 * __mark_inode_dirty() to test i_state without grabbing i_lock -
 	 * either they see the I_DIRTY bits cleared or we see the dirtied
-	 * inode.
+	 * inode or folio tag.
 	 *
-	 * I_DIRTY_PAGES is always cleared together above even if @mapping
-	 * still has dirty pages.  The flag is reinstated after smp_mb() if
-	 * necessary.  This guarantees that either __mark_inode_dirty()
-	 * sees clear I_DIRTY_PAGES or we see PAGECACHE_TAG_DIRTY.
+	 * I_DIRTY_PAGES handling is hairy. The clearing above can race with
+	 * filemap_dirty_folio() so we don't see dirty tag yet but
+	 * __mark_inode_dirty() doesn't see I_DIRTY_PAGES cleared either. So we
+	 * have to recheck after smp_mb() and possibly reinstate I_DIRTY_PAGES.
+	 * We have to be careful with reinstating and only do that if we really
+	 * cleared I_DIRTY_PAGES. Only in that case we are guaranteed the inode
+	 * is already in the dirty list and so it doesn't need to be (nor
+	 * should be) moved. If we didn't clear I_DIRTY_PAGES, then either the
+	 * inode is already in the dirty list or we race with
+	 * filemap_dirty_folio() which will eventually call
+	 * __mark_inode_dirty() to set I_DIRTY_PAGES and place inode in
+	 * appropriate dirty list.
 	 */
 	smp_mb();
 
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+	if (pages_cleared && mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		inode_state_set(inode, I_DIRTY_PAGES);
-	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
-		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
-			inode_state_clear(inode, I_PINNING_NETFS_WB);
-			wbc->unpinned_netfs_wb = true;
-			dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
-		}
+	if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB) &&
+	    !(inode_state_read(inode) & I_DIRTY_PAGES)) {
+		inode_state_clear(inode, I_PINNING_NETFS_WB);
+		wbc->unpinned_netfs_wb = true;
+		dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
 	}
 
 	spin_unlock(&inode->i_lock);
@@ -1955,22 +1968,31 @@ static int writeback_single_inode(struct inode *inode,
 	 * as it can be finally deleted at this moment.
 	 */
 	if (!(inode_state_read(inode) & I_FREEING)) {
+		enum inode_state_flags_enum istate = inode_state_read(inode);
+
 		/*
-		 * If the inode is now fully clean, then it can be safely
-		 * removed from its writeback list (if any). Otherwise the
-		 * flusher threads are responsible for the writeback lists.
+		 * __mark_inode_dirty() is responsible for promoting inode to
+		 * the proper list (b_attached -> b_dirty_time -> b_dirty).
+		 * Here we are responsible for demoting inode after some dirty
+		 * bits were cleared.
+		 *
+		 * If the inode is now fully clean, then it can be safely moved
+		 * to b_attached list. If the inode is dirty, we don't want to
+		 * touch it - it should be already put to the dirty list by
+		 * __mark_inode_dirty() and we'd just unnecessarily clobber the
+		 * dirtied_when stamp (which is particularly problematic when
+		 * we were called from sync_inode_metadata()). We also cannot
+		 * touch the dirty list association when I_SYNC_QUEUED is set
+		 * and flush worker is responsible for it. Otherwise move the
+		 * inode to b_dirty_time list as that's the only remaining
+		 * possibility.
 		 */
-		if (!(inode_state_read(inode) & I_DIRTY_ALL))
+		if (!(istate & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
-		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
-				redirty_tail_locked(inode, wb);
-			else if (inode_state_read(inode) & I_DIRTY_TIME) {
-				inode->dirtied_when = jiffies;
-				inode_io_list_move_locked(inode,
-							  wb,
-							  &wb->b_dirty_time);
-			}
+		else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
+			WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
+			inode->dirtied_when = jiffies;
+			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 		}
 	}
 
-- 
2.53.0

