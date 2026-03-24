Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94696359A66
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349612; cv=none; b=Jn05AG82iCMCgBEn18QnNv3l7WYevb4DTNJZp1mFM2DRsDNAHkUyKKnFnlY8dOD2Dgud2tzzYBlG3XP4iA9ce62EY/87nhKk9dzcOjikf2db1O6+braUc/wcSNCIgFMrRwVPPoqQ2Aq01PdgwKnEQWwlI0nZ+YJMXQ5g02lTwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349612; c=relaxed/simple;
	bh=drBU03f7QI88s4x6d0Lpqfmv3CW37W7rs74N1PvScuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG1YfJ/GUEA6n9RCo+jRLkhR1jMvbDXlSqOyMv3ElnYXd/5rpcQcBa4F0SiQ5QdL6caimOaeEjTUzArCpmxV3MslkwtpG2/vQRcDU0e0Dwx2HnC/Cu8dSJBDzXZypNppXh3w8J5NIXNiuSRnYQ0R3j4JzwOR4lSX0RFgitdB994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GI0tPE6a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCWI1Jz7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTF4HZmQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hk2xsjOM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GI0tPE6a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nCWI1Jz7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTF4HZmQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hk2xsjOM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C30E85BCDB;
	Tue, 24 Mar 2026 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774349610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=GI0tPE6aAzu21syTaeEseHgg4an+bKTpuYRXrRSHJ0/wnm7ivMYQlrtA77fhYH1YAfytxg
	peloACZM3ka9Gc+V+2G4qwS9pLMwvtYkwJL01fjWO+I/9dL8m2+pDR33p/iqKpEk62zrTW
	VbaLw45JEWIBCioVbrFOonA7MxuN2K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774349610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=nCWI1Jz7W283eQ20SeTGujrhd3mjASrJwAZZb3IGM4ZToJBlatuDfdhaHhwqmQr/JVRooW
	vSUufyF04/dzd+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774349608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=VTF4HZmQjFt+qYEd+hYgn8+2id2lBlgeew6r8Q7hIRVCTk2fBXWRhbjwuo8vmsVJ4NZ/sQ
	avtjz3G2OZbBCXdHlWMEvmIPUlIQjxqnmIvPp5gQ5BNRQLq/41kPEyQKEjQZqnS0WkKCrz
	iqMv7jdD+VEx2Tke8YokHSIjRgCZ/6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774349608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNdEBZhmsc6hucLIl4T7bCxD9jPms0lHLZLnsrtP3RY=;
	b=Hk2xsjOMmsxhI9xaZnuSPXz5FP0WURS3yJpm3EHKfwY4mCJMypYyXrPvujOWwnrviPZzv4
	tWBADs7AngTxtGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4C7943DD4;
	Tue, 24 Mar 2026 10:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FsAfLChtwmnVBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Mar 2026 10:53:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 662A1A0870; Tue, 24 Mar 2026 11:53:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/2] writeback: Export folio_prepare_writeback()
Date: Tue, 24 Mar 2026 11:53:12 +0100
Message-ID: <20260324105316.28684-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324105132.30490-1-jack@suse.cz>
References: <20260324105132.30490-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=jack@suse.cz; h=from:subject; bh=drBU03f7QI88s4x6d0Lpqfmv3CW37W7rs74N1PvScuE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpwm0c2uE6LQXataL8c4wj77Q2GsrSlP23o/0g4 StFXPgh75WJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacJtHAAKCRCcnaoHP2RA 2bZuCADYGLcwRXkm6oAkt9+TJ3ANZ31+xMTrwVbfu6z0H5eKMiodtjgBEF++dzsLY8kh2ta87y4 SnvxquJ2SWW9ffqQ4lpsR6/wj+l+1dQbEE36JCLG0pmkFWarEJVEtTTyhcak9dHTyliTkQmStHq pwfTHxsxoqAI6lQheGA7WmE4wHoQpQseSLNe1JteJifegPK0+GBnMpc6BWNSsdKP6pn1i2g7dh1 bVQimLLg/bfxGujYxWk+rwPPVGq7vu8XZ1B/onnuXjALw9mZw5VRBeyxqM59ZORJldG+Dr0IgO9 PSFRwEl0snCqDmdb6/xXT93binZ9vaxGCqFg/gzTJjfmQdR4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
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

