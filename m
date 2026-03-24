Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A53E0231
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349619; cv=none; b=dgf08ygFeLru6OmekfUFcztdXGaK6EPOjamu5Z5L9/5NUmr/abHXBJwjDVdcD6MclmcYjZfHmvRSxf6hP/NlQO8miji+oEKGgb1CUC+5O1EZnuFtZNx9I6AhwRc1ZeHzRU3gmhx07CxEYaZ61bjKOp1t0fMOgCptdbXfXdmwMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349619; c=relaxed/simple;
	bh=FEnadp6JO+MPzPP68/+c/BaboXtOcLDZRx6+8ZGnQJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5R3KACfW0xVGg2DoR6QCHqN8q00fiahsJU1kX/IId3M4ODmQ/Ti8+qeqf1N+wRLsq4HVXmn0rTL35HXtBestKugKo0uDQH0S8muIjk+sWcZM+gnzHGW7fS9R4P6m5kiFU6hX8gCFuh2aWK78CooX1WHNW21EWLUO60z/358n3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HCyB0+Km; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9iFzn9ho; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ot6oNntE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JxJYfz7L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HCyB0+Km";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9iFzn9ho";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ot6oNntE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JxJYfz7L"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C68E95BCF5;
	Tue, 24 Mar 2026 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774349610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAVSeq8dc1iph9UfoaG2fu/c5Pxc7sA0ywOlkLaoOUQ=;
	b=HCyB0+Kmn1cS7QwldEmeC22pEHLOieuUpa38YG3Gbpw9LH2PKqucVFyhLEST7Qcj24yQtW
	YVcD+JgEddMrGVcQW9ak+MA/IVkXqiWkl10NVOAoG8XZb6BaURTreWH+Fs8A+dLBrWx/N6
	CHK55UkWl7wf3fNnxYc8RJKZadkCjrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774349610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAVSeq8dc1iph9UfoaG2fu/c5Pxc7sA0ywOlkLaoOUQ=;
	b=9iFzn9homkY3dK6aUS18DOWn6w+dcxM8Qeo7sDSOgU4y8EwWE9ZC7eHEWIGd6q+rjyDfQI
	wj9Ua3DbzZ3bAMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774349608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAVSeq8dc1iph9UfoaG2fu/c5Pxc7sA0ywOlkLaoOUQ=;
	b=Ot6oNntEoLlkRqTOhGZen79XcGAffkz6a8L95ex5du1oCI7wA59nIdlyqxVSZCPIkHwdyR
	UUhiU0tTd+EK0GLXlGFvbOB1FMhJJ1G/reakLfgsOeXkSXHZ9G6fzrMhA69qy7ah+gmuCE
	WK3iQ6zfQQJVMomDPv2LmFGbxSU7QiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774349608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAVSeq8dc1iph9UfoaG2fu/c5Pxc7sA0ywOlkLaoOUQ=;
	b=JxJYfz7Lu5nUKEvB23F7x8nDbVQfwlNnvQBKEQr+U+bwjj4JXZ09cdFPY+2WwrshRZsP9q
	dvOKxuhTlGPSSdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B510E43DD5;
	Tue, 24 Mar 2026 10:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /tUlLChtwmnRBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Mar 2026 10:53:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E00EA0B51; Tue, 24 Mar 2026 11:53:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>,
	Jianzhou Zhao <luckd0g@163.com>
Subject: [PATCH v2 2/2] udf: Fix race between file type conversion and writeback
Date: Tue, 24 Mar 2026 11:53:13 +0100
Message-ID: <20260324105316.28684-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324105132.30490-1-jack@suse.cz>
References: <20260324105132.30490-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2896; i=jack@suse.cz; h=from:subject; bh=FEnadp6JO+MPzPP68/+c/BaboXtOcLDZRx6+8ZGnQJ0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpwm0dWUXMWHI7dLfXxTt3zkIlX3w9BF/wstDZ3 xLYtNfNl8eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacJtHQAKCRCcnaoHP2RA 2XvBCADdApQa0zeY6tEuXjNT35ZHplRx55Kg9iQdNAUP1vp0pRcEbibFdEbxoEV7Q9PSSTIVzQ0 HGZv10bJZwYwXxkT1RY/9Z3HXEAh5j9X7xYQPHYBnIV0PfVLMrb97veYC7vuCTd4MqTwhysLG8E ZUz/C9CuYBoWcFM3Q9qYClND989dYkdpEbDo2eGB6VAN9bgWK6U+YmoQT4pk3guC0TYKnUr2ASP bnISrs3WeXzOrnOjrzO8wlDFfKeTDCVpt+/c0jJNfOMRxGo9qWiGHyzCXoLdcKIXvrDsJCWrb2V 2aIF582ej66azaWJLxHmK3JRJQes8D2JFS68o5wKl3y/1cfy
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,suse.cz,163.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com]
X-Spam-Flag: NO

udf_setsize() can race with udf_writepages() as follows:

udf_setsize()			udf_writepages()
				  if (iinfo->i_alloc_type ==
						ICBTAG_FLAG_AD_IN_ICB)
  err = udf_expand_file_adinicb(inode);
  err = udf_extend_file(inode, newsize);
				    udf_adinicb_writepages()
				      memcpy_from_file_folio() - crash
					because inode size is too big.

Fix the problem by rechecking file type under folio lock in
udf_writepages() which properly serializes with
udf_expand_file_adinicb(). Since it is quite difficult to implement this
locking with current writeback_iter() logic, let's just opencode the
logic necessary to prepare (the only) folio the inode can have for
writeback.

Reported-by: Jianzhou Zhao <luckd0g@163.com>
Link: https://lore.kernel.org/all/f622c01.67ac.19cdbdd777d.Coremail.luckd0g@163.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fae8002344a..a659cd7d7ec0 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -181,34 +181,38 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_adinicb_writepages(struct address_space *mapping,
-		      struct writeback_control *wbc)
+static int udf_writepages(struct address_space *mapping,
+			  struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	struct folio *folio = NULL;
-	int error = 0;
 
-	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
-		BUG_ON(!folio_test_locked(folio));
-		BUG_ON(folio->index != 0);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		struct folio *folio;
+
+		folio = filemap_lock_folio(mapping, 0);
+		if (IS_ERR(folio))
+			return 0;
+		/*
+		 * Recheck inode type under folio lock when we are protected
+		 * against udf_expand_file_adinicb(). Bail to standard writeback
+		 * path if file got expanded.
+		 */
+		if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+			folio_unlock(folio);
+			goto mpage_writeback;
+		}
+		if (folio_prepare_writeback(mapping, wbc, folio)) {
+			folio_unlock(folio);
+			return 0;
+		}
 		memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
 				0, i_size_read(inode));
 		folio_unlock(folio);
+		mark_inode_dirty(inode);
+		return 0;
 	}
-
-	mark_inode_dirty(inode);
-	return 0;
-}
-
-static int udf_writepages(struct address_space *mapping,
-			  struct writeback_control *wbc)
-{
-	struct inode *inode = mapping->host;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		return udf_adinicb_writepages(mapping, wbc);
+mpage_writeback:
 	return mpage_writepages(mapping, wbc, udf_get_block_wb);
 }
 
-- 
2.51.0

