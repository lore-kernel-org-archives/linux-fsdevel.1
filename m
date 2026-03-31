Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919A3822B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957806; cv=none; b=qFyHrL+dLEZNf5qM33oo+ltQECgahtTORoD/fWyfk+xjhTp1U9LNeyi66jLjyE6befI9774KRv7utInFPTf5vfH+Rnq/yHXmpS6JpeXvB9rgi/bFvEkx7xtJhCSEQoV3ZPxeBvjiyKrCs/jKHEFdtb1BWqM4zgev0Wrgso/sFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957806; c=relaxed/simple;
	bh=bbTxkKoHw2sSLdH217P4BRAhIbJRWgyPu8eAyKhy6aE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ov52q9ybglDZUacV+Ureg+pyh+m1Ht07MnX0rPBAeFeCojGpgdMzRgs/nF4fjtFk8Nm7O3neOPHYoAU9LyZ23w1GgT0U6ANoBLnqEfudAXR0maxF8segdmMvHUKVcoS2vDjd2ypndSgp3yG0yCpgwJLeoA8YN9Bc8pYs7O0JAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqCfcbVn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nN0PX46Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqCfcbVn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nN0PX46Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqCfcbVn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nN0PX46Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqCfcbVn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nN0PX46Y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CB1F4D202;
	Tue, 31 Mar 2026 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774957803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HlF2jOi5S4ViMJ9UYWxd/VHrRGA5yA26jDOX9r/G2B8=;
	b=XqCfcbVnwPbHcqdhoIO+szKpA/Mw/FXPbxoqBjIci9JIV6p836hF6vEzKt7/BtjomvOTLA
	BQW0sJhpQA1VO8GNMnkFhk19gqmP0qgiwOKFaO5tNz+N/0BdRX/QqdzRCEL5Lgmnuh/laa
	3L9bo95QhLa+Xm6oq0bx6MTGndQq2nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774957803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HlF2jOi5S4ViMJ9UYWxd/VHrRGA5yA26jDOX9r/G2B8=;
	b=nN0PX46YYBtTfAcM/DwApsw7OLRW56DeJ/1ttBdr4EdqcRjScY7rdkrbPLv3bsaWAthpxG
	8o1YlAdbBQHywvDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XqCfcbVn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nN0PX46Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774957803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HlF2jOi5S4ViMJ9UYWxd/VHrRGA5yA26jDOX9r/G2B8=;
	b=XqCfcbVnwPbHcqdhoIO+szKpA/Mw/FXPbxoqBjIci9JIV6p836hF6vEzKt7/BtjomvOTLA
	BQW0sJhpQA1VO8GNMnkFhk19gqmP0qgiwOKFaO5tNz+N/0BdRX/QqdzRCEL5Lgmnuh/laa
	3L9bo95QhLa+Xm6oq0bx6MTGndQq2nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774957803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HlF2jOi5S4ViMJ9UYWxd/VHrRGA5yA26jDOX9r/G2B8=;
	b=nN0PX46YYBtTfAcM/DwApsw7OLRW56DeJ/1ttBdr4EdqcRjScY7rdkrbPLv3bsaWAthpxG
	8o1YlAdbBQHywvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129664A0A2;
	Tue, 31 Mar 2026 11:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LreCBOu0y2nVbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 31 Mar 2026 11:50:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2500A0AFD; Tue, 31 Mar 2026 13:49:54 +0200 (CEST)
Date: Tue, 31 Mar 2026 13:49:54 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf fix for 7.0-rc7
Message-ID: <462tylahq3txzns6guwf6huabgovydarvwhjxiumhiswmccodm@xagpzm2gozdq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 1CB1F4D202
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.0-rc7

to get a fix of a race in UDF that can lead to memory corruption.

Top of the tree is 102e57d56f81. The full shortlog is:

Jan Kara (2):
      mpage: Provide variant of mpage_writepages() with own optional folio handler
      udf: Fix race between file type conversion and writeback

The diffstat is

 fs/mpage.c            | 30 ++++++++++++++++++++++++------
 fs/udf/inode.c        | 33 +++++++++++++++------------------
 include/linux/mpage.h | 11 +++++++++--
 3 files changed, 48 insertions(+), 26 deletions(-)

Regarding your observation about uptick in fixes, what I can see in fs area
is that more people seem to be running syzbot & using AI to analyze the
reports (and come up with patches which are more often useless than not but
still good enough to show where the problem is).

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
