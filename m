Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E8541E70
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079586; cv=none; b=JN/pg+d6PnV9oYLBLrdAx422W0/cVVrx+L6oUY5MW1J12ga69KU/QuLZqMgUbFr+seRy10R3/X2LNjqffHW1/uLhEgRHrkDhkte6TclvycEVlMHvfYsJxl1S5lzqh4Mkleb4Ygac07y9d/dFAC2I3f8ONWAJBsTfS8eWRqjkr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079586; c=relaxed/simple;
	bh=UPL5CHhAiMBcm4H3rZCXPaZ3rCf8n63NaMTRjPzmPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5z8iD2jrptzT/AtVLSDn74glj9mTSbhEIujcpvSLI1lN4jDs1i/I0sjhHCqNI+sVuak3DKU43TeplryHMQMyxeChIQajyjNJ1sRhHIm1u+cE2/iP5hSVFJJlCGgKGxOulezx5WAm7eVHwYYNGIvh3BOz2/9MJAaAtQiRe30u54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAPrHMK4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+g2hk8V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wftS4GwG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5V2m2iRP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAPrHMK4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+g2hk8V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wftS4GwG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5V2m2iRP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D38D1F896;
	Tue, 22 Sep 2026 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790079578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXkR3+d2i2CCtM7QkyqhDWiv2qHZbVrh+hIexhYH8l4=;
	b=VAPrHMK4MbshTZObJf7XZnwoAI9hfT4/X/PebXNgWPOob5o+Ty6H4SjlGYUhQuVTFiVQKd
	nqV8hM4t+FyrUGUlsCzdR+8FJxL8Uk6+vDwfE9x5aWi01VOJln33oOap77bJIkD4vgkpSX
	uTfdS//cVys15Ljj1he47JZ7dpDmIyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790079578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXkR3+d2i2CCtM7QkyqhDWiv2qHZbVrh+hIexhYH8l4=;
	b=c+g2hk8VdtXF0GddGLL4Cy8xDXl0F6yVuhjrKGJPYJm735PnZs0QDrGYpheKayvbX+K1Ra
	UmjIuwTENVX5aZDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790079574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXkR3+d2i2CCtM7QkyqhDWiv2qHZbVrh+hIexhYH8l4=;
	b=wftS4GwGZCDKhJrNEH1e8JQ48TmBhy91uS8cUxqrGVWVCQ/ECovBoWhIBrN1t/Evi04FHC
	t9HswXiSxYTOkF8XYJ3h8ymmBtXzplQp2dYz/fCADoZy+s1cdd3FcVNIXNoTliacJDKQjQ
	hxFBiS6yLZpod5LAdfHY3XL4Z/Huja4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790079574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXkR3+d2i2CCtM7QkyqhDWiv2qHZbVrh+hIexhYH8l4=;
	b=5V2m2iRPfec1dzefZMhiSgLbQ2pu/7VBz6ZBfpbENuGNfmNzhqMu9UZEc9K3yBxQmUOs2N
	dcbMzF9ZONwh86Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56369136D9;
	Tue, 22 Sep 2026 12:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kAHYDFZysmrlJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Sep 2026 12:19:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA96DA13D4; Tue, 22 Sep 2026 14:19:33 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Thomas Schmitt <scdbackup@gmx.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] isofs: Fix handling of directories with tight blocks
Date: Tue, 22 Sep 2026 14:19:13 +0200
Message-ID: <20260922121912.2258134-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=jack@suse.cz; h=from:subject; bh=UPL5CHhAiMBcm4H3rZCXPaZ3rCf8n63NaMTRjPzmPP4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqsnJAQd36v154pNPsflBoc5IzXJRCRORZDpHwO SQDCZdOp6KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCarJyQAAKCRCcnaoHP2RA 2VSoB/kBX+YpJIFSWPvitD/L0/Y/8yvi/aS6u/Un5vELw51aTIAW/0G9HoUmPPyH1NAn9Vo+Jqs y9kKMDUSys53V3fysB1pa1gW+pFYcm4ZN2I4O7PCeLuUa9wA2wwiHV6LAWvjnVDu1I8vtfVSQlU GL41j951ZLNp1mTImByenQc/7qOJBYT28mCpauYir+9h0oVX6FZrm2RiL9HkJRELthnzNA4yYVw lOKisWm7anaHmCx6KfSfKQJTUVhVEPS7MCsn7wHleqHBTZn2vWDrHUC2Ilhe3BPgYo2Xpd20Dyl CM/jgZ4YoSWpGzNhtSvRG60Kd99ZnxwLaY51PCTRAjDJnuf1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmx.net,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]

Thomas has reported that after commit b2eb2e288604 ("isofs: Drop support
of directory entries straddling blocks") some isofs images of Fedora
miss some entries in some directories. The problem is triggered when
directory entries are packed in a block in such a way that they exactly
fit the block (which BTW mkisofs doesn't do so I didn't catch this bug
when testing with my images). Fix readdir and lookup code to properly
transition to the next block when directory block is tightly packed.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2535353
Reported-by: Thomas Schmitt <scdbackup@gmx.net>
Reported-by: Matthias Goergens <matthias.goergens@gmail.com>
Fixes: b2eb2e288604 ("isofs: Drop support of directory entries straddling blocks")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/isofs/dir.c   | 18 +++++++-----------
 fs/isofs/namei.c | 14 ++++++++------
 2 files changed, 15 insertions(+), 17 deletions(-)

I plan to push this fix to Linus at the end of the week.

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index c7ca7603e97a..5e541e765f54 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -110,25 +110,21 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 				return 0;
 		}
 
-		de = (struct iso_directory_record *) (bh->b_data + offset);
-
-		de_len = *(unsigned char *)de;
-
+		de = (struct iso_directory_record *)(bh->b_data + offset);
 		/*
-		 * If the length byte is zero, we should move on to the next
-		 * CDROM sector.  If we are at the end of the directory, we
-		 * kick out of the while loop.
+		 * If we are at the end of a block (or at its zero-padded
+		 * tail), move on to the next CDROM sector.  If we are at the
+		 * end of the directory, we'll abort the while loop.
 		 */
-
-		if (de_len == 0) {
+		if (offset >= bufsize || de->length[0] == 0) {
 			brelse(bh);
 			bh = NULL;
-			ctx->pos = (ctx->pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
+			ctx->pos = round_up(ctx->pos, bufsize);
 			block = ctx->pos >> bufbits;
 			offset = 0;
 			continue;
 		}
-
+		de_len = de->length[0];
 		block_saved = block;
 		offset_saved = offset;
 		offset += de_len;
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 010682f5901a..e7efeea16451 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -74,18 +74,20 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 				return 0;
 		}
 
-		de = (struct iso_directory_record *) (bh->b_data + offset);
-
-		de_len = *(unsigned char *) de;
-		if (!de_len) {
+		de = (struct iso_directory_record *)(bh->b_data + offset);
+		/*
+		 * If we are at the end of the block or at its zero-padded
+		 * length, move to the next block.
+		 */
+		if (offset >= bufsize || de->length[0] == 0) {
 			brelse(bh);
 			bh = NULL;
-			f_pos = (f_pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
+			f_pos = round_up(f_pos, bufsize);
 			block = f_pos >> bufbits;
 			offset = 0;
 			continue;
 		}
-
+		de_len = de->length[0];
 		block_saved = bh->b_blocknr;
 		offset_saved = offset;
 		offset += de_len;
-- 
2.51.0

