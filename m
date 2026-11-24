Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521549;
	b=mzJMGaC1l+JQM6N0hQ0zrOiyTci4xdjw0tEOA1EjIhRRVgZeLIe11TFRdqQQoRUCelNW
	 PmfwBrRr5ij+D+8GtEmwNPWfaZ/vZ4WPruqUdlN0arx1a/K/YM1x5CgJmhxDoaJmK5tCk
	 lvvVE/3tAqWmP5xqtOem1c3NA+UQuijKGh9+GP8oHdkDqduglvmY+iRLS3mxfT4jRPwHC
	 a9D6Z8Q0LffCFwyV55sHA4VsVRxRBIZHwQSXkVxVw77T65J62vrQ6qp+L0RazwzNcIGVp
	 qRhULqba0diXKLu3cWFvmgOV9pZrXLERYlkb9pQPh9Iffglr6aItGQWowwu5U5JvQuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521549;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=F8rZXwgteqbZbs17ttmtOi9dk6Yv88pwn4UCPhm5Pu0=;
	b=WVVwtAg9AHbq/dWux6SDN153QX9B2lnPlv7+5405c1CBIwh8DlOrp9ca+BQtrKZzMdhG
	 tVyCIJazNk32B4XdvjNhcOsO0neboeend0K0pFx2HofSxy1YBT4hnjaGd182RphXVqwRN
	 C2HL8z77UYTxB52bJuOLEjLZKc+NXtDzKB1Kcv9FMiAvfOE0MDr4whoDzy6Yf/N04TWzi
	 IWT2cNjdVd6VCKzCeBTfVqvxGFFRRfp24mbVlWVggYi5ElBXtqkbXGUf3TLaXJTQDQLc3
	 fhuvCRbyphkr8pI/jfjPaxL8nMb1z3jUYbxf2wLMFDNmp026ENDhTawtGaJEcmGzxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qqN7+pit;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YgiKa8gA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qqN7+pit;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YgiKa8gA;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDF606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7BDF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qqN7+pit;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YgiKa8gA;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qqN7+pit;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YgiKa8gA
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45E1422244;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8rZXwgteqbZbs17ttmtOi9dk6Yv88pwn4UCPhm5Pu0=;
	b=qqN7+pit0cJBGQ/CO9g9Ef83VzDK+aDh1wVlT1UdoRFmiLGsWM0EdCMNUvulbyvd91V9fK
	KCbw7WqWOXkJgDsb6TuKlyqEZ14EgdtUFU/g4bTmeEGqkA3XvHlKjfsOpjiB6olM03d4Wd
	9HKOBOtX56K78WeoWcalw65v8uK91Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8rZXwgteqbZbs17ttmtOi9dk6Yv88pwn4UCPhm5Pu0=;
	b=YgiKa8gAaEZBOMiynYKCrMLdT6BFP4sWMo7WwRRM9JrigvtclPlAdVEQNn7m0HytdzVaC9
	gRNIbRzm1TVUKHAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8rZXwgteqbZbs17ttmtOi9dk6Yv88pwn4UCPhm5Pu0=;
	b=qqN7+pit0cJBGQ/CO9g9Ef83VzDK+aDh1wVlT1UdoRFmiLGsWM0EdCMNUvulbyvd91V9fK
	KCbw7WqWOXkJgDsb6TuKlyqEZ14EgdtUFU/g4bTmeEGqkA3XvHlKjfsOpjiB6olM03d4Wd
	9HKOBOtX56K78WeoWcalw65v8uK91Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8rZXwgteqbZbs17ttmtOi9dk6Yv88pwn4UCPhm5Pu0=;
	b=YgiKa8gAaEZBOMiynYKCrMLdT6BFP4sWMo7WwRRM9JrigvtclPlAdVEQNn7m0HytdzVaC9
	gRNIbRzm1TVUKHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2F011352B;
	Tue, 24 Nov 2026 11:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mucAJgp8BWtDZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:06 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D108127847; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/8] writeback: Fix missed lazytime flush
Date: Tue, 24 Nov 2026 12:58:45 +0100
Message-ID: <20261124115850.3512-9-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124113450.3451-1-jack@suse.cz>
References: <20261124113450.3451-1-jack@suse.cz>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=jack@suse.cz; h=from:subject; bh=tLXfmzOP5aDRq6/jjTuDwN0YV3g4qhMuQ+lBEQh65LU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXv6DckjefXnIPfvqV9LY2Om2mltH57I/iZxn kiceOSv+1CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV7+gAKCRCcnaoHP2RA 2TbGCACLhrVvaliQDB+Km6NTkFURoQsVTlJbuEaQqzXe3iYCpnUN6NTmoWgWzpGRnPUW5JHZo1v rozd7lU80kFBkVyLqV573vVQiaiejmEjwar9+j0F23pp6JqZxToxjrTZu0OYtC7pv5RhNRQ6sZe 82MGVhOZlZbgmN9i9dFMnjTk4AH4ufTXx3Lb7Dh8MiWy4Gj/q51cl4Tt1+184Z+Vq/LIseySzXA QIRWJRBk5POZwCwUZHrngfT0EbdNDGBmegz+UvuJUdu2Y5YKFGfd4yp08gFTSFllVjxDml2v4EJ SdU/Oo8Pamd1WzEP/WJaVTWP/FBuhTwNdZ/VnLuLTpU/drG6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

move_expired_inodes() moves to b_io list inodes which were dirtied at
current_time - dirtytime_expire_interval or before.
__writeback_single_inode() however calls sync_lazytime() only if the
inode was dirtied strictly before current_time -
dirtytime_expire_interval. It can thus happen that inode with dirty
timestamps gets queued to b_io list, then fails the check in
__writeback_single_inode() and as a result is just placed back to
b_dirty_time list with a refreshed timestamp and so timestamps aren't
written when they should have been.

This is a very difficult race to hit in practice but changes to how
dirty time expiry is handled on last iput() will make this much easier
to hit.

Fixes: 5fcd57505c00 ("writeback: Drop I_DIRTY_TIME_EXPIRE")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index de77b6bc1dc4..65b1af2879e8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1910,8 +1910,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 */
 	if ((inode_state_read_once(inode) & I_DIRTY_TIME) &&
 	    (wbc->sync_mode == WB_SYNC_ALL ||
-	     time_after(jiffies, inode->dirtied_time_when +
-			dirtytime_expire_interval * HZ)))
+	     time_after_eq(jiffies, inode->dirtied_time_when +
+			   dirtytime_expire_interval * HZ)))
 		sync_lazytime(inode);
 
 	/*
-- 
2.53.0

