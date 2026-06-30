Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3945104C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849318; cv=none; b=V5thq4gY6Qz/wEmQSaQBlhanYGSoRAzy5gqW+Dq2SkUgCBIyX/j6N6Znxw5TSMniqTnZ1ksEF6v9pxBZC71C64OS/B1rjEY+UonW9LjMzniKcgcaKg/fkKa7AM6gFzzbRzGCz+BvQtM1gqaejgyWc2in9VFnSGezF1rTwYk9VJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849318; c=relaxed/simple;
	bh=ai3UJzQ/yrTNXu+VBVr9ja/gJyN8UsMuhCfnapBlWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wat6Mw4s4oR5kHecnaEhRHtMN+KlxsYakZKXMTf2E+M5iCJsVKkhBVKa6OaW60b/P0oPGv0eMHQMpmuWRDVgt1clXt2poE9Do949F2VFmvXHdjyYcYRMQIk884z2CR+ReETMuNioAz06J+7M4remghDY/I2kD7xToTqYi8ec0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l4uDvqPR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvXkTdni; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l4uDvqPR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvXkTdni; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l4uDvqPR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvXkTdni";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l4uDvqPR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvXkTdni"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2E4173718;
	Tue, 30 Jun 2026 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782849314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdnebGwB/sLJNe437cxhYb4KK11UT4zCtFlTfRqt+E=;
	b=l4uDvqPRPPFIFtaW2YjtlgadFm/dKGwcKNWxFAUNhNdCK1LXSBg/X/6TqbnveP9N5TtgHR
	aiqSPY5yz/sREyqORl9LyuDf06UjirUXvkSA+cY6+RhfIXUmjkpQIA0v5Kie1a/MunMJ+s
	JYdaWvfbFinFiTo8xNSwsRiMDrqNdZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782849314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdnebGwB/sLJNe437cxhYb4KK11UT4zCtFlTfRqt+E=;
	b=EvXkTdniK68q5f+czCz7c4P5SrmTsyg/ApETSL37zzcVgQSk4fXOEzynZOGWB+n7lVZw17
	GMdmkkRVi2+7wBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782849314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdnebGwB/sLJNe437cxhYb4KK11UT4zCtFlTfRqt+E=;
	b=l4uDvqPRPPFIFtaW2YjtlgadFm/dKGwcKNWxFAUNhNdCK1LXSBg/X/6TqbnveP9N5TtgHR
	aiqSPY5yz/sREyqORl9LyuDf06UjirUXvkSA+cY6+RhfIXUmjkpQIA0v5Kie1a/MunMJ+s
	JYdaWvfbFinFiTo8xNSwsRiMDrqNdZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782849314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdnebGwB/sLJNe437cxhYb4KK11UT4zCtFlTfRqt+E=;
	b=EvXkTdniK68q5f+czCz7c4P5SrmTsyg/ApETSL37zzcVgQSk4fXOEzynZOGWB+n7lVZw17
	GMdmkkRVi2+7wBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF4D6779A8;
	Tue, 30 Jun 2026 19:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8NDfJiEfRGrtQQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 30 Jun 2026 19:55:13 +0000
Date: Tue, 30 Jun 2026 20:55:12 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Hagberg <ehagberg@janestreet.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akQekZUyoKadiGCH@pedro-suse.lan>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQIIav_zaK6RmIC@pedro-suse.lan>
 <akQO8JtTxmp89GS8@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2hgan5khfldrqqbn"
Content-Disposition: inline
In-Reply-To: <akQO8JtTxmp89GS8@pedro-suse.lan>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Level: 
X-Spam-Score: -4.30


--2hgan5khfldrqqbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 07:49:12PM +0100, Pedro Falcato wrote:
snip
> 
> Other idea: perhaps doing filemap_write_and_wait() after the nr_thps
> increment in collapse_file() will Just Work and result in a _much_
> simpler fix. And it avoids any weird forward-progress issues as no one can
> write to folios at that point.
> 

Gregg, if you could test this patch, it would be much appreciated. This patch
(hopefully) makes it so no dirty folio will ever coexist with a ro-THP, thus
hopefully sidestepping the entire issue in a simple way. Only compile-tested
and not reviewed.

-- 
Pedro

--2hgan5khfldrqqbn
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-khugepaged-write-all-dirty-folios-when-collapsing.patch"

From 43d90a937f0b24656a8d0405035c3efcfdf0961e Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pfalcato@suse.de>
Date: Tue, 30 Jun 2026 20:48:41 +0100
Subject: [PATCH] mm/khugepaged: write all dirty folios when collapsing

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/khugepaged.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a97b20617869..3f0f90ab16ba 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -60,6 +60,7 @@ enum scan_result {
 	SCAN_STORE_FAILED,
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
+	SCAN_WRITEBACK_FAIL,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1812,7 +1813,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
-	int nr_none = 0, result = SCAN_SUCCEED;
+	int nr_none = 0, result = SCAN_SUCCEED, err;
 	bool is_shmem = shmem_file(file);
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
@@ -2043,6 +2044,17 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	 */
 	try_to_unmap_flush();
 
+	/*
+	 * If collapse looks to be successful, flush any dirty pages
+	 * out the page cache. With the nr_thps incremented, there won't be
+	 * any new writers (nor new dirties).
+	 */
+	if (result == SCAN_SUCCEED && !is_shmem) {
+		err = filemap_write_and_wait(mapping);
+		if (err)
+			result = SCAN_WRITEBACK_FAIL;
+	}
+
 	if (result == SCAN_SUCCEED && nr_none &&
 	    !shmem_charge(mapping->host, nr_none))
 		result = SCAN_FAIL;
@@ -2210,9 +2222,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	/*
 	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM
 	 * file only. This undo is not needed unless failure is
-	 * due to SCAN_COPY_MC.
+	 * due to SCAN_COPY_MC or SCAN_WRITEBACK_FAIL.
 	 */
-	if (!is_shmem && result == SCAN_COPY_MC) {
+	if (!is_shmem && (result == SCAN_COPY_MC ||
+	    result == SCAN_WRITEBACK_FAIL)) {
 		filemap_nr_thps_dec(mapping);
 		/*
 		 * Paired with the fence in do_dentry_open() -> get_write_access()
-- 
2.55.0


--2hgan5khfldrqqbn--
