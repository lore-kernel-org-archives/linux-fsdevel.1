Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1A3246F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534013; cv=none; b=BAYzMWtZsJKOQyR+sCmJui9SB79aM9H2Yo0aJkyZaGiOlYDwGF8YnN5Cq6hHg85+E6z2rcDi6HZXyTL19+yEo1zQaKujj6AYUj53maTPMUgwhRtbUdUiJkRaQX0InX+3Htfc+JvoXw8C2mQnGc32ZGzE+UIWcv6AoSWtVw1BYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534013; c=relaxed/simple;
	bh=0eeXOZEJhaNA/5T98rqkNwx5KkpMrY5XFuLG3Gzq0TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWblEWkFjXJKEPhG47Beh7z3v0scD8Nm5N9zL+MaTEsCMRC9DpNwfaHUdbSyIn8v4RTo8sBfwELGAbr4uMoMqTSVkPUFnPfxquE9iavOlwvmou6i8nNOhardiQYPuKkbDq+cHO03GpZtjQTnlWUkuVzWNmIeirhwJPWYQRlKjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TyQ5kFUP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GAfHsjui; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TyQ5kFUP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GAfHsjui; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TyQ5kFUP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GAfHsjui";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TyQ5kFUP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GAfHsjui"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A83755BD1A;
	Thu, 26 Mar 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6XS9/2qLsuo6VbiiaRs5FrT4JsmV+az1pFxwtIa/5bQ=;
	b=TyQ5kFUPvJBNPIuzUGraeESlzow9HwyfgNbCCpyMMWMsI7nZZEiu0Pg8jz/x6HK8T1GkcI
	Bn1ENSYUT4vvLOgPNil8c7h3DDOzcFpcq3ATF/JS0TdF03yrZoOPT4IQOqp8cUB0Hcw4bz
	KjtsO8pfJf5bHBXPMS8Fle8L67NncfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774534010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6XS9/2qLsuo6VbiiaRs5FrT4JsmV+az1pFxwtIa/5bQ=;
	b=GAfHsjuiWSy+vVo06TZgtzHaVscI04Q+QtY79FDEqV6HNNfeEHRdooUgtRfya6oqkGtAgh
	aaV4khLgDnzY5xCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6XS9/2qLsuo6VbiiaRs5FrT4JsmV+az1pFxwtIa/5bQ=;
	b=TyQ5kFUPvJBNPIuzUGraeESlzow9HwyfgNbCCpyMMWMsI7nZZEiu0Pg8jz/x6HK8T1GkcI
	Bn1ENSYUT4vvLOgPNil8c7h3DDOzcFpcq3ATF/JS0TdF03yrZoOPT4IQOqp8cUB0Hcw4bz
	KjtsO8pfJf5bHBXPMS8Fle8L67NncfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774534010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6XS9/2qLsuo6VbiiaRs5FrT4JsmV+az1pFxwtIa/5bQ=;
	b=GAfHsjuiWSy+vVo06TZgtzHaVscI04Q+QtY79FDEqV6HNNfeEHRdooUgtRfya6oqkGtAgh
	aaV4khLgDnzY5xCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E5504A0A3;
	Thu, 26 Mar 2026 14:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5necJno9xWm/DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 14:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5286DA0976; Thu, 26 Mar 2026 15:06:42 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v4 0/2] udf: Fix race between file type conversion and writeback
Date: Thu, 26 Mar 2026 15:06:30 +0100
Message-ID: <20260326140257.15908-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=jack@suse.cz; h=from:subject:message-id; bh=0eeXOZEJhaNA/5T98rqkNwx5KkpMrY5XFuLG3Gzq0TU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpxT1l6amHakTuW6+FNFnZkL897GB2AeOmqLVS3 7MJEp6GKG+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacU9ZQAKCRCcnaoHP2RA 2bUhCADC7FbbPBnPCidXoHHe44mo0z89Kf/P44D49FSvubfz9kVXAQQEWM400SY25r9Qyiq1GCz jijKLQNPAJ+cockflpnxiFOFLpHQJEDGczSnOTAiWJZXivP8q5qFWsRSWgCBWlVPFNjMED9h3EF J9cL75jiMxet0Lv0IRluOW90wDsIW/g7uYoOEJcyV/cue3m+TcxjSQOd4rw2ytp4wadg20Wb3B/ mX5eTsj4ZynHGWYt4dFjNVdw7FAlatHJfi5XXpTuhNxz8tnFJFQgKrnqD+P3vX0wUfI4FPt7clC aiHJf7bIJhAV6Q2rqG32e4REBBJotOfsnawVbB3Ed+JYU4zU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.955];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO

Hello,

here is the third version of patches to fix a race between conversion of UDF
file from inline format to the standard format and writeback resulting in
possible memory corruption. As Christoph didn't like opencoding
folio_prepare_writeback() in UDF either, this version provides
mpage_writepages() variant with a per-folio callback instead. Review/Acks are
welcome in particular for the first patch. I'd like to push the fix to Linus
soon as it's kind of nasty issue.

Changes since v3:
* Create mpage_writepages() variant with a callback instead of opencoding.

Changes since v2:
* Opencoded folio_prepare_writeback() in udf instead of exporting it

Changes since v1:
* Fix crash in udf_writepages() when file had no folio in the mapping


								Honza
Previous versions:
Link: http://lore.kernel.org/r/20260323162617.2421-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20260324105132.30490-1-jack@suse.cz # v2
