Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBB21146C
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435410; cv=none; b=aavFAW3QnTwR8syJepoWlfKf/qaQeUAy8HDeHMSu5G1MHAK6DufksaCyoSyIUqcGLovmp7euXfln0uprkScpdUOyCmIfhvbFbiO0MNrUwWsZIq0i0fR4/Be/Ds6GvWZUSOHkgGS3KAHgC8OeccBqJ+IxMHsrYMM8H0eq+gS+er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435410; c=relaxed/simple;
	bh=YSDhspDGTCrjBSjrSw0N905nTPf+OqUsSBvrpmHCJ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uDC2dKiKwAEzEc/CsL11gbl5qff2HJwlrhmwRkrer5Tz1FcpxlxwJvsbJ4ajqVz3xRU5CfdsnLZNod2rox/CjswrHWS35lSSm8AGB+NjVi6X6avzIG773293lBzeZQ1c/MdeJDrEyN0Htab8OhbobD5GEey1lU1V2NuogkYJk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n96Q4n0H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YQXPcjKo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rhVOTvnG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kCL9YoK1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n96Q4n0H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YQXPcjKo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rhVOTvnG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCL9YoK1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C9AB3F2B;
	Sat, 22 Aug 2026 21:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787434901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=onyhFgGJXGDl5zXKyxWPPR98B+6m31dG+HwdFDjbByY=;
	b=n96Q4n0HFgrFJl0kw5qbgZNPDEUIev59garDH+mGWHQfHAPi3jixjgIJ6/l4VEkahBDDpO
	TYW1bQLQa4HdMR57gM67aLw9Ix14UaVfP6AWlbnPN2/0+YyuyU335gQ72yXsocH8MOjW4v
	Co5WWX5wj6bloeMBg6nNhyPgbbDqVeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787434901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=onyhFgGJXGDl5zXKyxWPPR98B+6m31dG+HwdFDjbByY=;
	b=YQXPcjKoGXMmF1dDtUWHel4zey0T7lUF+5OolzIg2jHLShv/TF57QQdNNghIVrJzqq8TOx
	qad3RvBgZVvRBYCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rhVOTvnG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kCL9YoK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787434897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=onyhFgGJXGDl5zXKyxWPPR98B+6m31dG+HwdFDjbByY=;
	b=rhVOTvnGf8vXMM3tQ0aPb6YViyd0R6d9i2qjXsF0c2kr7HCV8wsd2xTXH72oh/6HWmcUIb
	6M9bwCJzWtTO/BtE6mspU+wC/nb7kK7PenlGb+VQx3uYHzolZqKsgLrUSJJkbuz1J6hS6K
	JXXrSRWkx2qQuNwBWXbAmr8+3Sv4Uas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787434897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=onyhFgGJXGDl5zXKyxWPPR98B+6m31dG+HwdFDjbByY=;
	b=kCL9YoK1nvfYyjplatSeGu19SD+VU6FWSKWi31r9Rfg8XRABpOtaGwJRkRTAahBMKhdEDj
	coU3XV0qYXxjLJAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B6A112FF6;
	Sat, 22 Aug 2026 21:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3BD+L5AXimr0GgAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 22 Aug 2026 21:41:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PULL] unicode changes for 7.3
Organization: SUSE
Date: Sat, 22 Aug 2026 17:41:34 -0400
Message-ID: <87zeydsui9.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,mailhost.krisman.be:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 9C9AB3F2B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Linus,

This time I have a small fs/unicode pull request for you.  Nothing
really fancy, just a clean up and a fix for parsing the unicode version
in the command line. I apologize for not getting it to you during the
first week of the MR, I'm halfway through my summer vacations today.

Please, pull.

The following changes since commit 8ba098e6b6ff0db8edf28528d1552be261af30d4:

  Merge tag 'v7.2-rc5-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2026-07-30 17:41:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-7.3

for you to fetch changes up to a511442085c140da9cdbe60e3f0fab1c71480801:

  unicode: Properly reject invalid encoding version strings (2026-07-31 16:33:14 -0400)

----------------------------------------------------------------
This update includes two minor fixes that have been siting on linux-next
for the past weeks.

  - A patch from David removing the normalization function that we no
    longer use.

  - A patch from me fixing a parsing issue in the encoding version
    argument passed by filesystems.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      utf8: Remove unused utf8_normalize

Gabriel Krisman Bertazi (1):
      unicode: Properly reject invalid encoding version strings

 fs/unicode/utf8-core.c  | 30 +++++-------------------------
 include/linux/unicode.h |  3 ---
 2 files changed, 5 insertions(+), 28 deletions(-)

-- 
Gabriel Krisman Bertazi
