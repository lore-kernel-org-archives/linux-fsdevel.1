Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3737BE93
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349612; cv=none; b=jWBPFoWj8uYZ3c08PwQzhjzP74FW5ViinbORuaNZx7HA9t7BJ6uO2VPf68lKTp9XO/iKOoZmOHQP2RgmcgI9NHua/gzVRcUSkD7vTyVnFgJVrNSYVrBtWkVVsIGyFp8AH0c/xTqqLvjr4X0E4gnjs4BXfM23npAr2wgkMcyFweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349612; c=relaxed/simple;
	bh=CwJlZ2F2j9UsEK5kSvG6l7TjTKlTSfs3n/eqtsjvywo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdkf2f+MXH6zqjW+e8kz7RVAC4sSskyDNaLsX7n5YQAn8Lst7CmaXt43/IzKzbPpol2Y52BWEKRqjQBhe1gg/WRCItyRbQEyar7CojyxtxboJNb1U/yKL6yaNLqxbM4g/0gNApGnY0cP6Bcdt/osjhARx6/T/vDtB+UcEha6SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VWCQHOFs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=06TEXqDA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8CO5d1D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z+11IdvD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VWCQHOFs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="06TEXqDA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8CO5d1D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z+11IdvD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3CEE4D1D4;
	Tue, 24 Mar 2026 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774349610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/4S5XjHKz0DZYQMim8XLyACc+SBQ9v7y1dKFSSo7LOA=;
	b=VWCQHOFsw+C3++nfrnccFjgcIse/w7jQNnbsrHUAA4xU+x2G86bgRGQDDMbfL5H8ryOy70
	7H2vtRvNyJFoE8FW0JgsOmeKK+pqUF57b+Q7Bwr2NXsBpvQe8vsFF8RW5ytbeqIm/lT6w5
	BTPZDqyARKjc5CH+3jQQ0XfqzWheg3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774349610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/4S5XjHKz0DZYQMim8XLyACc+SBQ9v7y1dKFSSo7LOA=;
	b=06TEXqDAAYcnNLT5SVI7823gppHVrxWZpGicSL4cu8cGDQYCmECGW7zmQrAV9KlOTDTq1K
	ie/ID0wPh0P/lwAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X8CO5d1D;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z+11IdvD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774349608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/4S5XjHKz0DZYQMim8XLyACc+SBQ9v7y1dKFSSo7LOA=;
	b=X8CO5d1DUmHp2VO4QyI0H5v+ba+GcIH7FXU6W867cFUtwBKXab+U543IyJJg3wO2N+jd/P
	SMoMKTe8k460Rd3x8qeH9dy57himSdROQA+6xJlCBJjVd8arMeao3pv0qtSyg2jzasxPDY
	5xsiLVV4lzg3mUSgT2XB/ROKcoWmtMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774349608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/4S5XjHKz0DZYQMim8XLyACc+SBQ9v7y1dKFSSo7LOA=;
	b=Z+11IdvDXlya3KDoXCFUESeCdvU7wkcRKE0CUx7NvJDpwOT0/9AfAZQyYyYAiuRwwOa3NK
	4nUR6oWd/KUd8SDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA88243DD2;
	Tue, 24 Mar 2026 10:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G9CeKShtwmnQBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Mar 2026 10:53:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 61743A0B32; Tue, 24 Mar 2026 11:53:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/2] udf: Fix race between file type conversion and writeback
Date: Tue, 24 Mar 2026 11:53:11 +0100
Message-ID: <20260324105132.30490-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=547; i=jack@suse.cz; h=from:subject:message-id; bh=CwJlZ2F2j9UsEK5kSvG6l7TjTKlTSfs3n/eqtsjvywo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpwm0WsUFOhPgucO5Dgi0d1wsakUOnBDCw7v+/w UxeyuMVBf+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacJtFgAKCRCcnaoHP2RA 2cXeB/9qge8TluLLC2ZDJUdJDmU9+x6/Vc3RSdp6QzsvevXoWz/m1wnJgCwlLZzpTEuQKyHbLUm 8zVaGHWawVhqK9do5cFLlDK7YC2Jh0ymblMFLuD9VpSAoT2Hbmigel1IHOFyt6HkpFiXrM/XV5b +QE9pBm/+CteZ8bPZuP65fWz0m19mqFCy3GphJj5EVkxJgwxMSj3IhiHP1d4gopJF0KoW3I/KVe SkOP7sefaFojzxFWu9jIYdt9i1qOXATgFyQYYIfKtxzOfJ03njfhi0gWFab4MlyTh1bh2HcrLrn +p4kdO2Iec2sEeeC0Qm4QM9SuChhNOgj3ybC0ZCyi7z7wUVG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: B3CEE4D1D4
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hello,

here is a second version of patches to fix a race between conversion of UDF
file from inline format to the standard format and writeback resulting in
possible memory corruption. Review/Acks are welcome in particular for the
export of folio_prepare_writeback(). I'd like to push the fix to Linus soon as
it's kind of nasty issue.

Changes since v1:
* Fix crash in udf_writepages() when file had no folio in the mapping


								Honza
Previous versions:
Link: http://lore.kernel.org/r/20260323162617.2421-1-jack@suse.cz # v1
