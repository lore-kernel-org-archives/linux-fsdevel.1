Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9D324B31
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254667; cv=none; b=PNx5IageVv3PMhhLL5J4KQXRZsWFVmq4QArnkYIvg4grtZwMDcvlGqOPJ12gGurwK9YQK+Z598CAvfbPRFWUeqjPbl1x3bl3VOdRCPNuAA6wOHYyPKjrp+qOOSv3V/bIV+OQ9k4rA6PyZmIDvJ33byBIhCm9h8TRsYcvrfbuPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254667; c=relaxed/simple;
	bh=AbGoexunWbucO4ZlIsC9dUyot4v0nhVV6ZTKu86MGVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZiSP7VmavgA4reedECL2Jwfpxu8eZtu1eJi+uPH0KRiHXpeHfjqSl1xUTWFzWSgPDZezle582SFyaRvIe+J9iLS48LERquqdF/+XSu8F5qo/thzUGjutWyVWoBKyJETREyrrc0iYP3erUmNKbColqy2odC/4b39ULtGtCRhBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yjENYBOg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dL2y5shM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GogFxN+w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i1s/ptLv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yjENYBOg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dL2y5shM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GogFxN+w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i1s/ptLv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F7B17C415;
	Tue, 28 Jul 2026 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785254659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyuhZ0b8OZdd4AiYggIUPLQqad78RpwZfrcWrPHSzGo=;
	b=yjENYBOg2Pb+ZpK2Ez3M/sK40KSMZgMQck1ZbyPRy4uvyugFqjUt5w+uzVNzleg22OlNLr
	Iv6m+W5X2+tHa9ERh1eNRDEXS8/lnvDXrsL75tJjiCGFMkfP6yP5ZuP67ZgWlVAvy9wjmB
	VFfVoZOFsmXaHYbG1FLjy+jGQ2A18cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785254659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyuhZ0b8OZdd4AiYggIUPLQqad78RpwZfrcWrPHSzGo=;
	b=dL2y5shMDwo8lKvrlZnqQcGdG8M37xcSQfrh9vZrCutJWxXu/ewLXUkkT2fgW0+HBhPEQ1
	17HyID43qUlYVXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785254655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyuhZ0b8OZdd4AiYggIUPLQqad78RpwZfrcWrPHSzGo=;
	b=GogFxN+wrfIi/OU+e5WLAACCcZ+cdb90cHWVjICkOk+yy2AjBoyR9EcXEfbN0dIQbWiR7z
	VSPIDjfhu/HWQk6bn/8peT5z0hlHIxocxjRpZq3RPl7lD+y2RDLwkmHMqy4r/nkltIYWn+
	jB7mjwFMgnb8Q0CdJ3OAlXyDReRzid0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785254655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyuhZ0b8OZdd4AiYggIUPLQqad78RpwZfrcWrPHSzGo=;
	b=i1s/ptLvLryvzGsB1hTcNy7VVNuRmvbVbk2FmQ9dKkXK7DfNSjR1/pTdOBxslplwpPU4YY
	D+Na/yUSXfMFLZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23C0A779B1;
	Tue, 28 Jul 2026 16:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUa3CP/SaGptcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 16:04:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BDEAAA10B6; Tue, 28 Jul 2026 18:04:06 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] isofs: Drop support of directory entries straddling blocks
Date: Tue, 28 Jul 2026 18:03:59 +0200
Message-ID: <20260728160359.3939399-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Based on isofs standard (ECMA-119) directory entries are not allowed to
straddle sector boundaries. Isofs images I have available seem to follow
this. Now that we have code verifying validity of directory entries (and
so we'd properly refuse such entries), let's just drop the code merging
directory entries straddling sector boundaries.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/isofs/dir.c   | 28 ++++------------------------
 fs/isofs/namei.c | 35 +++++++----------------------------
 2 files changed, 11 insertions(+), 52 deletions(-)

I plan to merge this patch through my tree.

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index a96268c9ca41..c7ca7603e97a 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -84,7 +84,7 @@ int get_acorn_filename(struct iso_directory_record *de,
  */
 static int do_isofs_readdir(struct inode *inode, struct file *file,
 		struct dir_context *ctx,
-		char *tmpname, struct iso_directory_record *tmpde)
+		char *tmpname)
 {
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
@@ -133,24 +133,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		offset_saved = offset;
 		offset += de_len;
 
-		/* Make sure we have a full directory entry */
-		if (offset >= bufsize) {
-			int slop = bufsize - offset + de_len;
-			memcpy(tmpde, de, slop);
-			offset &= bufsize - 1;
-			block++;
-			brelse(bh);
-			bh = NULL;
-			if (offset) {
-				bh = isofs_bread(inode, block);
-				if (!bh)
-					return 0;
-				memcpy((void *) tmpde + slop, bh->b_data, offset);
-			}
-			de = tmpde;
-		}
-		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
-					    de == tmpde ? de_len : bufsize)) {
+		if (!isofs_dir_record_valid(de, offset_saved, bufsize)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %llu\n", block,
 			       inode->i_ino);
@@ -252,16 +235,13 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 {
 	int result;
 	char *tmpname;
-	struct iso_directory_record *tmpde;
 	struct inode *inode = file_inode(file);
 
-	tmpname = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	tmpname = kmalloc(1024, GFP_KERNEL);
 	if (tmpname == NULL)
 		return -ENOMEM;
 
-	tmpde = (struct iso_directory_record *) (tmpname+1024);
-
-	result = do_isofs_readdir(inode, file, ctx, tmpname, tmpde);
+	result = do_isofs_readdir(inode, file, ctx, tmpname);
 
 	kfree(tmpname);
 	return result;
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index a161b28893d6..010682f5901a 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -48,7 +48,7 @@ isofs_cmp(struct dentry *dentry, const char *compare, int dlen)
 static unsigned long
 isofs_find_entry(struct inode *dir, struct dentry *dentry,
 	unsigned long *block_rv, unsigned long *offset_rv,
-	char *tmpname, struct iso_directory_record *tmpde)
+	char *tmpname)
 {
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(dir);
 	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
@@ -91,25 +91,7 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		offset += de_len;
 		f_pos += de_len;
 
-		/* Make sure we have a full directory entry */
-		if (offset >= bufsize) {
-			int slop = bufsize - offset + de_len;
-			memcpy(tmpde, de, slop);
-			offset &= bufsize - 1;
-			block++;
-			brelse(bh);
-			bh = NULL;
-			if (offset) {
-				bh = isofs_bread(dir, block);
-				if (!bh)
-					return 0;
-				memcpy((void *) tmpde + slop, bh->b_data, offset);
-			}
-			de = tmpde;
-		}
-
-		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
-					    de == tmpde ? de_len : bufsize)) {
+		if (!isofs_dir_record_valid(de, offset_saved, bufsize)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %llu\n", block,
 			       dir->i_ino);
@@ -169,17 +151,14 @@ struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned i
 	unsigned long block;
 	unsigned long offset;
 	struct inode *inode;
-	struct page *page;
+	char *tmpname;
 
-	page = alloc_page(GFP_USER);
-	if (!page)
+	tmpname = kmalloc(1024, GFP_USER);
+	if (!tmpname)
 		return ERR_PTR(-ENOMEM);
 
-	found = isofs_find_entry(dir, dentry,
-				&block, &offset,
-				page_address(page),
-				1024 + page_address(page));
-	__free_page(page);
+	found = isofs_find_entry(dir, dentry, &block, &offset, tmpname);
+	kfree(tmpname);
 
 	inode = found ? isofs_iget(dir->i_sb, block, offset) : NULL;
 
-- 
2.51.0

