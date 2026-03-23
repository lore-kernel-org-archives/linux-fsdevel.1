Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112372550D5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283436; cv=none; b=gUJF/fC9wqVuUCo9apLADR3hxku6Hcn9AMeXGpnpU589DWQFVZJMsitqU1Kh081nTIHbVoYCKWzZqCHLm6zidiJkiOvyJVOUAH9EID4kd0DilGr4MJnHfUlYh3FjLd7jpYjBuzCrXuYdOTlYEXBd/7repEtkNJPG3cscy61rFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283436; c=relaxed/simple;
	bh=drBU03f7QI88s4x6d0Lpqfmv3CW37W7rs74N1PvScuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5VP6wulPtPhUylQPmeAtg58nufbhGCi0eI1y2TgWeoM557eXcboBQWR3AZzcJAg5MT4Lx/uf0NElpJ/iJTwmNcr4zdxGHNPow8q2heeKMOqOm6tVAdFBoeCzJFdZ/fkvE2dyhAsqOLOdGu9NdTAHJwMm8g29aH5awc5aGNLZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vnph5DgT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQ7YF+BW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0+9DRAy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+RteFXbC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vnph5DgT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQ7YF+BW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0+9DRAy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+RteFXbC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FC765BE47;
	Mon, 23 Mar 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774283433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=Vnph5DgT2nV2ZAC7XCxFcN9qE7YevKBUUUJA8e+4iHRj6e8Uew4OUKOp9jx2W8P8S6L4eR
	ehK4fgOx/lt4z+wk9K8EdCDS3k95ZgcYVWb3lpujHbBuSx+3vqBxPTtVoCVYT6NsJjXxeK
	DpoD9cquCS5CgcyiWd7Cg6QLlXlNK5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774283433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=oQ7YF+BW++dZ8jioZswvtnLoCNATMWv9FJGnDRUzEQk9BytpkuNxcpU+Mke0t9K+WIvdHj
	tPohrXITm3MQxRAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774283432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=O0+9DRAyTBzvTVPowH+3MjZJbMIw7U1FuyfkyrbU/mWEbIltcYAV4XKloymrJ1QXjhZOjo
	umulhWLmIYmTK3K8K88+NwZWstSU2Sa6+cTAtgDMShzqPS4SI9NIhOU7YA9+z0yWrSfZEE
	WwRpvXNahhZZazOl+pF8VMV6CEi1MtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774283432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=+RteFXbC1XKKxrmjqs5+JIHqy8fOOZLUrauz5SD8u872TBzgJ77mPVANYvwc6YBs48zF2V
	w09D/7vWGCtDEGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F6BC43984;
	Mon, 23 Mar 2026 16:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7a/A6hqwWm7IAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 16:30:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9CD0A0B3C; Mon, 23 Mar 2026 17:30:27 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] writeback: Export folio_prepare_writeback()
Date: Mon, 23 Mar 2026 17:30:11 +0100
Message-ID: <20260323163015.3734-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323162617.2421-1-jack@suse.cz>
References: <20260323162617.2421-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=jack@suse.cz; h=from:subject; bh=drBU03f7QI88s4x6d0Lpqfmv3CW37W7rs74N1PvScuE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpwWqY2uE6LQXataL8c4wj77Q2GsrSlP23o/0g4 StFXPgh75WJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacFqmAAKCRCcnaoHP2RA 2W1ZB/96GkEQrkRMbG6QYX9NArHU5xZQowAPFMSC1QChSiy653phew8l5zGucUjP54BozwKlWdq zgBVOXXbCHe090Uz0T5M3JMlrz+tW9eqqlb77iWvlq23CESq6FBYd1mGhcssziKj2yqWcBcoOK7 2dgeJbAcHGVOSZAOKixPVIIa9tRS/ijArlhKy9PTEW+EHWNjgjWiAroxdyJzK13ohRYSkTp5viO 6ejKSQJB+2I9LTpcZt37Ph66fJOrAYH8GREUQ8uybiYvJBzWMollG2J5IXfjUnYaUs4unGxc0qr VIfOMgKVEHq3kjRt2U9DDp+tw0aObHuWvjJVI4WKjazioMzw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The sequence of operations done in folio_prepare_writeback() is needed
practically by every writeback method. UDF is unable to easily use
writeback_iter() for inodes with inline format (due to complexities with
racing conversion and fallback) so export folio_prepare_writeback() for
it instead of opencoding it in UDF. Later we can use this helper from
other filesystems as well.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/writeback.h | 2 ++
 mm/page-writeback.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e530112c4b3a..3e5d215c8d27 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -357,6 +357,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
 struct folio *writeback_iter(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int *error);
+bool folio_prepare_writeback(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio);
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 601a5e048d12..ceb78798fc00 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2358,7 +2358,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static bool folio_prepare_writeback(struct address_space *mapping,
+bool folio_prepare_writeback(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio)
 {
 	/*
@@ -2389,7 +2389,7 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 
 	return true;
 }
-
+EXPORT_SYMBOL_GPL(folio_prepare_writeback);
 
 static pgoff_t wbc_end(struct writeback_control *wbc)
 {
-- 
2.51.0

