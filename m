Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049030;
	b=eSfCir/AdjQqUPC1yVHap5QJmGSDbsajdpb6MsNM9ldCMzmVVSni7Acs9vGliA3h/Ono
	 5NDDxqMaZa+m9n+wYzgm1KjC3Z+qznnE8PjLQJ72FWiwHR3tNJ8KjbIfnYJ1Py7XA66vy
	 jZwXCdt4pIehrF5hfmdKrFrPtRyvSt2CZ+lrxOrtHCgarAfI75ojaf3NI+0HwT6WKTed4
	 WFB22fXGgycbzc1lwZpYWX9Y74wHgH7kHoCWiYKmrYIgaDNQMIQtLoB6rZhpZs+Vf3HKc
	 UEUsuZYTZAkGvi7oMirQMAfoSVLzU6rLYJ9v75yFFcQGEJCklbYmzDVD4ureXdvFAtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049030;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=pSEDfAlqXI/S32U1/jnjltTtW2n+3JWXI6t6akNESB4=;
	b=drUdcGk5LhtGkHT359J1XHQwkPlsC+c0b+T77PD6nhF8tOnSR418ZEE2mnqGsiF4QPmj
	 brDRG6L31I8wEKvi4jnlO9CfZLx8CT5eVfRG9CV7K8fbcSGQGN5cIkQF/j4/ngJLyHT+S
	 KzI6Zyqs342csFAO3QzKK2CKmxaVazVB88N+HQxl/CA2AqidHcabrKxeSuxu3G0Jsqmu+
	 wPrQovvXPR4XCNoAJV5Q1bVfCjiKO5vod/DbN9EPl73pD2mBz/TKZ8+DkG1JvPKoNV9QZ
	 7UTdKkYywEfpeATlNEHfr23JXfvb/Ag1Zc3wjV+6ea68eKRXqqOj4/ngkQ6suEHZu2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DG9ammKb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GcWhOWsI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DG9ammKb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GcWhOWsI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA543606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA543606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DG9ammKb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GcWhOWsI;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DG9ammKb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GcWhOWsI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC0B621F72;
	Mon, 26 Oct 2026 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793049027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pSEDfAlqXI/S32U1/jnjltTtW2n+3JWXI6t6akNESB4=;
	b=DG9ammKb+it8E1SNrcSdp7cANRXmVGR96pvujY2eQdmtq2cOGfQZs9nQBUQk71pigNF0Tz
	fcKSjlmqFbDeoctn2wqV+HtGG1KzI0baoUkQ2lrd6j02USo0hch5ElGZVkUzgGE3Y8tnn0
	aM0W3ieajmhiGo6v5SyQ2w0+grwBgyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793049027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pSEDfAlqXI/S32U1/jnjltTtW2n+3JWXI6t6akNESB4=;
	b=GcWhOWsIt+uKSceb1IiqxMxQ/eEe16QYtSXMqgb1dPuWG58cHxnGB3hmsEo8Cq2Tf+VaQ+
	WCVZa6j5EWo5RbCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DG9ammKb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GcWhOWsI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793049027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pSEDfAlqXI/S32U1/jnjltTtW2n+3JWXI6t6akNESB4=;
	b=DG9ammKb+it8E1SNrcSdp7cANRXmVGR96pvujY2eQdmtq2cOGfQZs9nQBUQk71pigNF0Tz
	fcKSjlmqFbDeoctn2wqV+HtGG1KzI0baoUkQ2lrd6j02USo0hch5ElGZVkUzgGE3Y8tnn0
	aM0W3ieajmhiGo6v5SyQ2w0+grwBgyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793049027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pSEDfAlqXI/S32U1/jnjltTtW2n+3JWXI6t6akNESB4=;
	b=GcWhOWsIt+uKSceb1IiqxMxQ/eEe16QYtSXMqgb1dPuWG58cHxnGB3hmsEo8Cq2Tf+VaQ+
	WCVZa6j5EWo5RbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82E0A13319;
	Mon, 26 Oct 2026 21:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OvsrF8PB32rjWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 21:10:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00E26A1419; Mon, 26 Oct 2026 22:10:22 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hongyu Jin <hongyu.jin.cn@gmail.com>
Subject: [PATCH] writeback: Avoid postponing periodic data writeback indefinitely
Date: Mon, 26 Oct 2026 22:10:11 +0100
Message-ID: <20261026211010.3733399-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=jack@suse.cz; h=from:subject; bh=B0ZC11LJRPT2Nfss+zjn41nfOV1/3RkQsCmRtLOI54c=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq38GyCoZ5Rn7WJ2CMbKE24NaB32GT5S/zg8iWd OEFORl4LlmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCat/BsgAKCRCcnaoHP2RA 2dHDCACht/hD2vao+EJU93E1y5uhy700/2CFf+ymo3uejjL/0VcePrT9V2WgMALrELzP+BmVQ20 qGcs1e25iQfWwwkyCZSlOTkgtCWG/7PdnNpBCMh4t5IZxJ4UvvriNwjxrdA5xUK5rDhh1HP01DW GglqNUV6LoCeo1Hax9FcBjQq7wsl59z6qcn33J5DCd0mM6xZ9/D2RPMXW+AnWvVBiguhSaf8TyU cxH4XhfQTnGFgHDFmmjIuGrJt4GuyxprEmZkoUDLSzeAYakZ3dQlUr0jdJf5tXhTsHG9dfm2Xqi YCmGQT0WHBWiA76rJhXDpSFZOL7xAJVZ78wMG3gsTJwa9GGv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-10.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -10.51
X-Spam-Level: 
X-Rspamd-Queue-Id: AC0B621F72

Hongyu Jin has reported that f2fs periodically calls
sync_inode_metadata() for some inodes. The logic in
writeback_single_inode() thus periodically calls to redirty_tail() and
the inode's dirtied_when timestamp never gets old enough for the inode
to be eligible for periodic data writeback. Thus dirty data from it is
only ever written on explicit request (fsync(2), sync(2), unmount) or
on dirty limit pressure.

The redirty_tail() logic in writeback_single_inode() actually should not
be necessary. Since this function is used only for once-off writeback,
there's no need for any livelock protection among inodes and
writeback_single_inode() is only responsible for demoting inode to "less
dirty" list based on dirty bits cleared as a result of writeback. So
remove the redirty_tail() logic and add a comment explaining the rules.

Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..de86c9055ffb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1946,22 +1946,31 @@ static int writeback_single_inode(struct inode *inode,
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
2.51.0

