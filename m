Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1623815B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283436; cv=none; b=qMWahHhbP3o/eaRQBSEGn2R0xWaJkubCpnkykgLS3oGlMVJPMgr8+LYgcJYmGwpRZMTQGPrSOOqYCg1YBqa86wbL5DwwjMiDDKPuge/0fcWF6Nzv+gxiCNCLRtwm1toIA64CVcbKEwwb+4az8fvgVRv37CeiAELKkon8bqS+B2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283436; c=relaxed/simple;
	bh=NO8cAxClAqGsssaMA8oeXcUMKStK7FPcCHR/7Y3gbTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vaf+z9RFtjkQ+k5D9tfCsvqaKTbHPARLKoHC5vsSdyonjYtyghgK8Yij1PKLOvR6Yqod8HyItg3pOHEgn9mZRW43at8AOTZVAvF981MET5uvL9RPYUJL4VFG/tYSznExrLO4a0doS9cRRpWElLYA6buMkJ+8jcvzaJZnSnglfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bisqIszU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+th+FtZg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=evhy27M6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=khittVQW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bisqIszU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+th+FtZg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="evhy27M6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="khittVQW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 243F14D365;
	Mon, 23 Mar 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774283433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SJMWNkiLagjFGDjQC6+/v3NAdffr6/HOuKpCkuBEj4E=;
	b=bisqIszU5pOb5/kOb7cVmEdQKPBRcnIO55YLUpKUW/3uHAYt1daELm/VOJuEi4f+d626iY
	OTTHn1OMr32RSoWyNqvVjBvZaqK5D6y/BzaMXl8WDyvCkf80xOjQgghSGmjU8epi1hdP8O
	6uMyqIXP6VCTNPR1SYX+eclgcAm2h8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774283433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SJMWNkiLagjFGDjQC6+/v3NAdffr6/HOuKpCkuBEj4E=;
	b=+th+FtZgjwR5mtXJtBOcKx2Xa+bBRZozN11bwl+mcZ4SPSRyregRaGXYwhmAkwQK6VzFev
	hyaPju6+PBgm0JBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=evhy27M6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=khittVQW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774283432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SJMWNkiLagjFGDjQC6+/v3NAdffr6/HOuKpCkuBEj4E=;
	b=evhy27M6rW7jXFBav5R2LC+hAF+lv99ACkjw/uzDsRSZZeETOdFOnF3JtkLOEJ3+1tjWEL
	fw+6YBWg/i68orSbw8dxcOGOOhXybY3Hv7EQEHsc29lNb0o6OtvNbEQuFKgLgP+fhp3TSK
	6q0vP+IVT4he+thYR8t1traTsnQg69A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774283432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SJMWNkiLagjFGDjQC6+/v3NAdffr6/HOuKpCkuBEj4E=;
	b=khittVQWe3mDTyNq3doUCPuepd4avFXo8ktzHJBKVIPIA3L7vLp9bB+JysXSkDY/Nhz5Wy
	pa63ccij7mq1enCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11A6D43985;
	Mon, 23 Mar 2026 16:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /e3dA6hqwWm6IAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 16:30:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B42B4A0B32; Mon, 23 Mar 2026 17:30:27 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] udf: Fix race between file type conversion and writeback
Date: Mon, 23 Mar 2026 17:30:10 +0100
Message-ID: <20260323162617.2421-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=336; i=jack@suse.cz; h=from:subject:message-id; bh=NO8cAxClAqGsssaMA8oeXcUMKStK7FPcCHR/7Y3gbTA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpwWqRqTyiBfqCRPOla1cB5RovA6dDtOCNqZw5B yT6LWdFtm+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacFqkQAKCRCcnaoHP2RA 2fFGCACFb+4a5554mkaOQqvYIHqqhbX+QmSbNn2ovGjvn1r9oOdTMEeDQ5eQsKqemEatiaZjeJ1 fA0Ea8c4imJBFXTMzfrs4dvdZAD35nydURWn8efQQFsGgVdalBDom5CJPLoQ+yaZUGMt7cbpZ10 vvuuA0KqUJWlUlSuTBnHItO2IG53/omoG9u9seCkZKNcHWdGGekOxhHVwpDQDWAItOkWAGixwAs AbhXGNW7eIJHn+UILcW5toZkWQoaaFmwr/MdYgdxVbf5OPInZ5LCaVGBWZZBL6UqqooTmS4Y8ct gM/NVt9PWRUwfFKvGzCsBFniWYso7aQe7wxjzpiDb++S/7AA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.99 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.99
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 243F14D365

Hello,

these patches fix a race between conversion of UDF file from inline format to
the standard format and writeback resulting in possible memory corruption.
Review/Acks are welcome in particular for the export of
folio_prepare_writeback(). I'd like to push the fix to Linus soon as it's kind
of nasty issue.

								Honza
