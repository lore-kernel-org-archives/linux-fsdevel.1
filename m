Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AE375ADE
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116735; cv=none; b=jllN0i0iC1ZfUl/Md+ztx8GIh/139/B2WZzN7HdcqmxtWqIwKic+Yab8PnoAHCCkWuwCGEhJsiavoCZioTrGUpFQm3/fMj3JG6y7DkUIr2f/kNc/OHgJvAVjQCN/txcudE8LHaKt35HCNhusUZ1trRMjxI0nDapo/1Mcr0wE4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116735; c=relaxed/simple;
	bh=doSl7XwBgbwlZmLOj7HhzP4E5NF4QH+660GbTlfCOcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH2citzU1E1BJ0cuqCprapABhYj9xega59i1yAUHkrhd6APC+Jq0obndkSPJNHHgfObtJy7mgntXl8QBuIW2bhda8ab2bnR2DJ5a1y5YibcR5FUrtK92HiFJ7FeBb1Y5paDZpKnmGQ6Gb8f9wK9XmqavbyWXHLadfVxgI5SENkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yViU6O/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ehcPena; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHMrEGxj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UpMcA5WW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yViU6O/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ehcPena";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHMrEGxj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UpMcA5WW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEA571FEEC;
	Fri, 11 Sep 2026 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=yViU6O/yD8U/VQwDOB+KUzonPwdyfXjPw/IOeSpePPTUcMTwpgLoScLbsofZpYLGEmwJsb
	Ev2waLbnevCAnJ2kCnxtAqw9Wo8L2FFRIiu/clcqdyUSo4XHY7caBCXV3ePxoxXL1Hntku
	B7c+pA66PcxoYjyytRFlTMi2BGVOADo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=1ehcPenaQpK85d1ajqQ6I96wC5DIMZ7S8QBzu/IYzP/RFwQD8VuBIEdJwOGSMhdYI/nkg8
	jG6rjb6JTKHkj1Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=rHMrEGxjxHYk5w5vXgE8P+S2Ie2xg5xPJC7wBbQJuyZrzxw9Gl7MgsnLkY6R505a90acDI
	w7SXzpDJGrsb9SoVLEgF1ez1a0wnpSKfWMkcIFKAK1TIUy/aJqJ0luC6ezB0p2eAWyz8ur
	5WQVrag08aXUX6t5djtRDN4I9DwmlBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=UpMcA5WWmIEyeXvu6VJNtJVzRlYIvPo1qfClA25MOPlmwEV+Zb4Vq9CbZRMy4rY3p1tNl2
	2rj8w9kBHYoymnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6301137EC;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DVxbMC7Bo2q4HwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D87E2A13BA; Fri, 11 Sep 2026 10:51:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 5/5] ext4: Defer inode reclaim if it has preallocations
Date: Fri, 11 Sep 2026 10:51:41 +0200
Message-ID: <20260911085142.1774803-10-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=jack@suse.cz; h=from:subject; bh=doSl7XwBgbwlZmLOj7HhzP4E5NF4QH+660GbTlfCOcI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqo8EiIqTi8A+6iwev57YKHpZUBj+QsAzBktcnM fhmESSEi3yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaqPBIgAKCRCcnaoHP2RA 2XQdB/oDHdqiVn0eFdzdcMFgMSrbsCTdzi5nYnqnBqLWUSGM5jTQkbeSIwgbVNy0vy/X8RjKEVg E6b0ARhfUTQ+rCPzYCj0PNaWPHyqlqXQnFNdwT2irgefL6nIT89h2JGwYU2Fc5M7VdsxjQXUdXf oxm2ORYuWORNtAAR9zT+1m4zwQpieUeEXpjllpGWxYuI8Rboyit8EEyBbWM7lRoLaoHvhY9uaf+ 2ZsV3GIn1qyaGfudxUcwW92NIE+yVTvQbtoR9pJxo0ErzwTrfK47g9htP2GEt7iM1za7lH+5Hnr upLH3TY8I4rNJ8pfFNYCsVbpTN8/cx1vFo1jHgbs+IxvthG1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]

When we have to free preallocations during inode eviction, we need to
load block bitmaps and run transaction to modify them. This takes time
and also requires GFP_NOFAIL allocations. Mark inodes with preallocated
blocks as needing offloading of inode reclaim to a workqueue so that we
don't block reclaim for long and potentially deadlock MM subsystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 06171a11db12..4891f252105e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3115,6 +3115,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (ac->ac_prefetch_nr)
 		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
 
+	/*
+	 * Freeing preallocations requires loading bitmaps and running
+	 * transactions. Defer inode reclaim to a workqueue.
+	 */
+	if (!RB_EMPTY_ROOT(&EXT4_I(ac->ac_inode)->i_prealloc_node))
+		mark_inode_reclaim_deferred(ac->ac_inode);
+
 	return err;
 }
 
-- 
2.51.0

