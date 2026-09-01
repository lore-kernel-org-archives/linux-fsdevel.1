Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F94772A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253986; cv=none; b=B36PVmlUewU2Z9tcQx1hlcgBVBUie4MxrBFiTLge2LjOF87qxJdVk4AbJodudDiDPcQpevtdSStz8WEiVDDAnoYT8Dp6vUiOTm0Y/kiskJZw8YVzu+iSlmhEq5ZqtnGsCkioxDmghSxZyl2QxHjmCjUh8arT4f67P0FU7sXFqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253986; c=relaxed/simple;
	bh=mWvp0iF830839oKJN7ZYlIHJHJdcLy5YKZxfqfKIMdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkGD1jwQ3/P3YggeCRdZwpLb1FOuR+GaJvTbY2DV2CUotJp+93MQWYVWzWSt3WT3WKniy4Pa0EB/6oLfApBVyXdl/LvfTbPa7YhPogYywcCZVFhAGN5BlkH+ogOOEvUiEPI6BZgqwIaTMx8nwKMrDoCin6tICTvCske0YSBsTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N/90P7VU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2SbwVC5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N/90P7VU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2SbwVC5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N/90P7VU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2SbwVC5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N/90P7VU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2SbwVC5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6309F1FD92;
	Tue,  1 Sep 2026 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788253982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fF5dNqQX5F7St/NoatC/tCbmxWtk3Hy5Qin3R0YEsOM=;
	b=N/90P7VURPQFpSu2vexSkKzHqWzgeKFfMsig08ImpVpz6Nmh+HfaE794FGRo3YSKJuoCFW
	+ajzDZZKo22ec4xFsWbMGJ1Eg0vFWMkwr5w7C5Rg3X/lhqN06yJxXbvdNjsOTtNguNko52
	SehFY+YDaWv1AhQAN7jW0N/Ue1Jw2sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788253982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fF5dNqQX5F7St/NoatC/tCbmxWtk3Hy5Qin3R0YEsOM=;
	b=R2SbwVC5q9hS0EqNiqxHa6UCSPpWkjLYpyKsr9s9aoMRpB9Z3gmNwovMeDISweR2Ai3QEl
	fuq/2wpzapuHu3CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="N/90P7VU";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R2SbwVC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788253982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fF5dNqQX5F7St/NoatC/tCbmxWtk3Hy5Qin3R0YEsOM=;
	b=N/90P7VURPQFpSu2vexSkKzHqWzgeKFfMsig08ImpVpz6Nmh+HfaE794FGRo3YSKJuoCFW
	+ajzDZZKo22ec4xFsWbMGJ1Eg0vFWMkwr5w7C5Rg3X/lhqN06yJxXbvdNjsOTtNguNko52
	SehFY+YDaWv1AhQAN7jW0N/Ue1Jw2sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788253982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fF5dNqQX5F7St/NoatC/tCbmxWtk3Hy5Qin3R0YEsOM=;
	b=R2SbwVC5q9hS0EqNiqxHa6UCSPpWkjLYpyKsr9s9aoMRpB9Z3gmNwovMeDISweR2Ai3QEl
	fuq/2wpzapuHu3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 437F613515;
	Tue,  1 Sep 2026 09:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hh95EB6XlmrFMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Sep 2026 09:13:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CFD1FA13AF; Tue, 01 Sep 2026 11:13:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] udf: Fix handling of device spec attrs
Date: Tue,  1 Sep 2026 11:12:24 +0200
Message-ID: <20260901091037.30587-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=203; i=jack@suse.cz; h=from:subject:message-id; bh=mWvp0iF830839oKJN7ZYlIHJHJdcLy5YKZxfqfKIMdU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqlpb3jEdJFwLT60uqd3o/a6hbU0nYGesRlq4QR 2+Yvgv1kM+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCapaW9wAKCRCcnaoHP2RA 2dXTB/9GSk9ICHbc2a2vJeTiRkN0LMjmMeRoYqyiqDsZOVFZDLft6/BdwTNT6R39POQZUEAELXD NF9HdJpbKkIRBmt/iJ6Pp8yM1e00v2rlnFWP/OiDB4htN2AMuArb3hbn9JuaWCq5VAgfApnSm2T DnGai9b95OiP+oxJD0RV0ctJRE3c//ekQZUnKIxFpG5SDDIqPLsjF1QfJvvPvpZ4PtaqoPrcxB1 2XTH6VvYei9bACYSaU8mX421fy4GTod9zUKHlG/EXeSSC90dWmttRl10qluPo/Mp7SkEyTe0gPS Cow0GrrBNX5jOtjW6geeyhJXR/3S4PLo2wfSQtV/Y0e1ljOg
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.99
X-Rspamd-Queue-Id: 6309F1FD92
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.99 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

Hello,

the two patches in this series fix validation of udf extended attribute
containing device information for block and character devices. I plan to merge
them through my tree.

								Honza
