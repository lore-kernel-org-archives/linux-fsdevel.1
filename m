Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4D483BD4;
	Wed, 30 Sep 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764441; cv=none; b=evuSuLCCSWGS+3nVj0ysV4E/BRyrHKIrXEOhsOys9dfXRsCFJuONn8XY0xcxJUoiJ7BVP/9vyRGlXQUCtMqn9sfk9EOQPbe9a2wLABoH4Im8leC5Z0sDuw5vypPqSH4rTzJu4/UwWPBQhO12nvaVBST/IeLr7WhxcCf1M/1Q8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764441; c=relaxed/simple;
	bh=pclhcS+oEXz9qoaU/+oVeWBo0CBH4Q75MxhmcaMjh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJUI2hRkahsQdZUg0jm9GrmjjpSjs8m7H8bKzzxOkmwDxEusz19Bnaxoh7EPksmRdSc/Ra4Nwg0xQYz7bgcOLDIBypZmaGXBm6v1FnJsUUySd0ztduKCqOf/BeId3knnG3z7zPZggYHpEJhbknsBr2G5IbDbTaB8B600ev6RZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CulZebVr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHg20LeL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZAAB23WA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A+Wendfd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CulZebVr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHg20LeL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZAAB23WA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A+Wendfd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05E231F8AE;
	Wed, 30 Sep 2026 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790764433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lN9tulOi+NuRWY1qCkdMWYOrA9uda5VmNH5BOCw+PB4=;
	b=CulZebVrrTl1YsuN7cEMDCPiHbQlwVbR1HYODMR/JWMCPKxWU86Kte39SrsewNhG74JE9S
	atUKz6BVSrM3QLlGfvQW3+H+IJDSAAv5w1fUsFl1O56KBULXVwoBYHmdwLiGbE9vpLnWc6
	suPzzThcwmN9jSVMp4NfW41Vr0ozwiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790764433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lN9tulOi+NuRWY1qCkdMWYOrA9uda5VmNH5BOCw+PB4=;
	b=VHg20LeLlM/qGOkWXG/NaYwzaPWLdWlY6MZzKtJRXPFn0Pm0nC+I6DnoozkWymJtlV48kz
	fXdkLYCLswAVGIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790764429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lN9tulOi+NuRWY1qCkdMWYOrA9uda5VmNH5BOCw+PB4=;
	b=ZAAB23WAoHoYSQAhvqr+4uXvAJ5h7N8QyAfUpC/IqwmXZY6GE/okZKPf7ytM2GK6r0IEBL
	1SZrSb3uLpOTHshE2u1fdNfzsfl3lzQrBFWj9y29XME3VAveZ3Q8eHoAj5UVF/KcYdEj7/
	0a+noo3Ugm0eC/BKbUTic4Te1wXm3Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790764429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lN9tulOi+NuRWY1qCkdMWYOrA9uda5VmNH5BOCw+PB4=;
	b=A+Wendfd/kAFQul3cQJuQsWmJ2l+V14XXkw/g7gfX9G6pAAq5HbHT7NavQacGO8O4w8/8e
	wcO9SeCCBxOklMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF6DA13722;
	Wed, 30 Sep 2026 10:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1WepJIzlvGrAfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Sep 2026 10:33:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A34AA13AD; Wed, 30 Sep 2026 12:33:48 +0200 (CEST)
Date: Wed, 30 Sep 2026 12:33:48 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Hui Peng <benquike@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: bound empty directory blocks in
 isofs_read_level3_size()
Message-ID: <xr6nxaat4f4zlmnk6dcn6fyiih336io2qaxm6lytxyb23oznw6@xcd4rjwpg4di>
References: <20260919222553.3792320-1-benquike@gmail.com>
 <20260923175215.1577791-1-matthias.goergens@gmail.com>
 <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
 <20260924151356.3287733-1-matthias.goergens@gmail.com>
 <20260925043804.2091174-1-matthias.goergens@gmail.com>
 <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
 <20260926083517.556576-1-matthias.goergens@gmail.com>
 <cm3n7vjwbdnafttuz5ftkzz5wdbalgews4dfs5zlwvkyuzotuq@jo2nhsplhstc>
 <20260930033940.175021-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="467kcs2hjto4mpid"
Content-Disposition: inline
In-Reply-To: <20260930033940.175021-1-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,zeniv.linux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO


--467kcs2hjto4mpid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 30-09-26 11:39:40, Matthias Goergens wrote:
> Hi Honza,
> 
> > Any reason why don't you do just "++i > 100" here and completely
> > remove the empty_blocks variable?
> 
> Yes: i has one other use.  The "if (i == 1)" further down records
> where the second section starts (i_next_section_block/offset).
> Counting empty blocks in i would move i past 1 before the second
> record is read when an empty block sits between the first two
> records, so the next-section link stays 0 and isofs_get_blocks()
> reads past the first extent into whatever follows it on disk.  I
> tried your variant on a two-section image with one empty block
> between the records: v1 reads the file correctly, the variant returns
> different bytes.
> 
> I'm happy to send a v2 that adds a comment saying why the count stays
> out of i, if you'd like one.

Right, that needs a bit more care but still, something like the attached
patch should work?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--467kcs2hjto4mpid
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-isofs-Simplify-isofs_read_level3_size.patch"

From 8474b0d97f2c136f9870b85852e5b76bd4e4103e Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 30 Sep 2026 12:28:56 +0200
Subject: [PATCH] isofs: Simplify isofs_read_level3_size()

After recent changes it is possible to further simplify
isofs_read_level3_size() by reorganizing the loop a bit and removing
empty_blocks, block_saved, offset_saved variables.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/isofs/inode.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index e884618c0c53..c8f0f8803a7b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1173,9 +1173,8 @@ static int isofs_read_level3_size(struct inode *inode)
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	int high_sierra = ISOFS_SB(inode->i_sb)->s_high_sierra;
 	struct buffer_head *bh = NULL;
-	unsigned long block, offset, block_saved, offset_saved;
+	unsigned long block, offset;
 	int i = 0;
-	int empty_blocks = 0;
 	int more_entries = 0;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
@@ -1209,7 +1208,7 @@ static int isofs_read_level3_size(struct inode *inode)
 		 * chain of empty blocks could be walked without bound.
 		 */
 		if (offset >= bufsize || de->length[0] == 0) {
-			if (offset == 0 && ++empty_blocks + i > 100)
+			if (offset == 0 && ++i > 100)
 				goto out_toomany;
 			brelse(bh);
 			bh = NULL;
@@ -1225,21 +1224,17 @@ static int isofs_read_level3_size(struct inode *inode)
 			return -EIO;
 		}
 
+		/* Save the first continuation directory entry in the inode */
+		if (more_entries && !ei->i_next_section_block) {
+			ei->i_next_section_block = block;
+			ei->i_next_section_offset = offset;
+		}
 		de_len = de->length[0];
-		block_saved = block;
-		offset_saved = offset;
 		offset += de_len;
-
 		inode->i_size += isonum_733(de->size);
-		if (i == 1) {
-			ei->i_next_section_block = block_saved;
-			ei->i_next_section_offset = offset_saved;
-		}
-
 		more_entries = de->flags[-high_sierra] & 0x80;
 
-		i++;
-		if (i + empty_blocks > 100)
+		if (++i > 100)
 			goto out_toomany;
 	} while (more_entries);
 out:
-- 
2.51.0


--467kcs2hjto4mpid--
