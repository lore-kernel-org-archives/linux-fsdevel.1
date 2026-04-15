Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D47342517
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248814; cv=none; b=B9hpQl8/wFocAJzbmGElOvWAm0rvgy20v/4FqaQmIMAb9IIM6Ubctj+eQU3R9BMDHQVE4g3w+Pukapo+UHJDIcLdESa/znkvyfesD0lYLpsWQZFF2yqWZyFYl0v5c6IEjtKkNFfz9aS/dngn7TB4aM5oShW1cQEhy3xD40oO5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248814; c=relaxed/simple;
	bh=4v0SKXqC4uz38EYskSauHBfvPwNXOC9QwPa1gqlcsmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f1CAnxdcoS+qEnWPZ8hs7V3siGYCxxIqt6Yg3Eh4TYa8ZKYNoK+IwCovK3oxYL9ebp02GCViyREUdyrFj4sRxvJGS5AVhd5qslFVFqxWr2xR0EGHB6aDs3yz02s9uE6JEMt1cnluOFPqMYQKKORCr4HW2b4S6HPO5DznPP3rznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mlPVwr9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3USGtrxx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mlPVwr9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3USGtrxx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mlPVwr9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3USGtrxx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mlPVwr9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3USGtrxx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B724B6A7E3;
	Wed, 15 Apr 2026 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776248811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Yjb4wUuW1fjymTU7Ip0iXUwjbh13noRYGVh3KhcQ/DE=;
	b=mlPVwr9mLFLsT0qEnRN7M2IqrLl9j+7ni+7nciArK3ZUJAbdipKbr485MJSQ+kj+dlH3TF
	gkfytiZlyKouzcCrs89MnYgzBH3uzgpcMT8mkaJH1tmHTh3O7hFyj6205aQQmHXVtvlr5I
	U2wcco7h3uRTh6Pj6rqI8q5wr3yI6FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776248811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Yjb4wUuW1fjymTU7Ip0iXUwjbh13noRYGVh3KhcQ/DE=;
	b=3USGtrxxbrDzmkr+c0BHodlHH9Akv1HGgTqdk41/7DRhQF57by96UURRuuBYDytPxRjpj1
	57RkksPaxl12wDAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776248811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Yjb4wUuW1fjymTU7Ip0iXUwjbh13noRYGVh3KhcQ/DE=;
	b=mlPVwr9mLFLsT0qEnRN7M2IqrLl9j+7ni+7nciArK3ZUJAbdipKbr485MJSQ+kj+dlH3TF
	gkfytiZlyKouzcCrs89MnYgzBH3uzgpcMT8mkaJH1tmHTh3O7hFyj6205aQQmHXVtvlr5I
	U2wcco7h3uRTh6Pj6rqI8q5wr3yI6FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776248811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Yjb4wUuW1fjymTU7Ip0iXUwjbh13noRYGVh3KhcQ/DE=;
	b=3USGtrxxbrDzmkr+c0BHodlHH9Akv1HGgTqdk41/7DRhQF57by96UURRuuBYDytPxRjpj1
	57RkksPaxl12wDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF4204B96D;
	Wed, 15 Apr 2026 10:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pS/DKutn32mBMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 Apr 2026 10:26:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 719C4A0B59; Wed, 15 Apr 2026 12:26:51 +0200 (CEST)
Date: Wed, 15 Apr 2026 12:26:51 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, udf, quota cleanups and fixes
Message-ID: <mymqle4yeuajzhwek6wmu5cwc7pezn26essmzhra3qxzcbdbnr@z265eiwpzcui>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.1-rc1

to get:
	* A fix for a race in quota code that can expose ocfs2 to
	  use-after-free issues
	* UDF fix to avoid memory corruption in face of corrupted format
	* Couple of ext2 fixes for better handling of fs corruption
	* Some more various code cleanups in UDF & ext2

Top of the tree is 25947cc5b237. The full shortlog is:

Adarsh Das (1):
      fs: udf: avoid assignment in condition when selecting allocation goal

David Carlier (1):
      ext2: use get_random_u32() where appropriate

Jan Kara (1):
      quota: Fix race of dquot_scan_active() with quota deactivation

Milos Nikic (3):
      ext2: remove stale TODO about kmap
      ext2: replace BUG_ON with WARN_ON_ONCE in ext2_get_blocks
      ext2: guard reservation window dump with EXT2FS_DEBUG

Seohyeon Maeng (1):
      udf: fix partition descriptor append bookkeeping

Vasiliy Kovalev (1):
      ext2: reject inodes with zero i_nlink and valid mode in ext2_iget()

Ziyi Guo (1):
      ext2: avoid drop_nlink() during unlink of zero-nlink inode in ext2_unlink()

The diffstat is

 fs/ext2/balloc.c         |  4 ++--
 fs/ext2/inode.c          | 17 +++++++++++++----
 fs/ext2/namei.c          |  7 ++++---
 fs/ext2/super.c          |  2 +-
 fs/quota/dquot.c         | 38 ++++++++++++++++++++++++++++++--------
 fs/udf/inode.c           | 11 +++++------
 fs/udf/super.c           |  4 +++-
 include/linux/quotaops.h |  9 +--------
 8 files changed, 59 insertions(+), 33 deletions(-)

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
