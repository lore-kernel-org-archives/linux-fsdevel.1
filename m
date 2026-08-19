Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977B2641C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151799; cv=none; b=YWIi9ON9WR9YkOiaz58NEHyh3XOOvhRSqlHM9l9rLyULud1pi+WcIcFnGi0zUm1cHFhgDFWlb8Po55CEGQ3wPu0S/xTlJSxeABlBUnuSOg08Ulpti3cNLduQeS564mxoSA2iPa40rgMpvNy+O44zEUn+WImCcfQSQfD562FWpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151799; c=relaxed/simple;
	bh=vRahrYm8DN9jOqrbsPWVdo4T3CLHtwEIOfx7y/oPWKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qo6u2I9qvrvWMC3PzdnCwTR3rK+XclKMg2t8riIHUIoRkBiaheFjOt1P0udR3kFwxpo4+MF2JUq3KH8c/UbyhNoqW6M0bftwGT+6C5qhk8xLBrD1oyfC+XS0rJbP4/RVMr/rksuIqgaj3ZF5hIcGH+7orY9zI5bY+L1mscSUJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1z+5vlhz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U14zC76K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MN6U2vMr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNHUH0FE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1z+5vlhz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U14zC76K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MN6U2vMr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNHUH0FE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A2EB84BBB;
	Wed, 19 Aug 2026 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787151792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VsWqUiS3AnsN1BomAXwpFYtAnhWSn1b5zsxDUn+NlLE=;
	b=1z+5vlhzaS+nJc/Cp+bl2gymzLBYKfDUM9GEs5ucATVbUo0jlVTFDONBcspT+whnhuzRZ8
	gNuPooXVNYEDKZI+fHtbzoL7LqzRAQnWJZJzHu5txx5+xLCP3A2lVwwJ8dqJhCyP+e1LxE
	11FrppkOmDVhzF21CfB8cUglNU1CiUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787151792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VsWqUiS3AnsN1BomAXwpFYtAnhWSn1b5zsxDUn+NlLE=;
	b=U14zC76Kek7t9pP86CV2+UXADK6eGXEfuUbJEcnHUGXKoZqLiOuQ3XA0TPEfW8IwnJG2+p
	2RErO03wfYHU5OCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787151788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VsWqUiS3AnsN1BomAXwpFYtAnhWSn1b5zsxDUn+NlLE=;
	b=MN6U2vMrDg8Kd4GAiUKVk/ewAo+cL1ujNNyP7qnGyWfFWdDquTEiMAIeDuDWf5xyrctcHB
	pttbCVPcy3lM5SMaqdfqBEgvlk/XfQn+p8+pcB4lda1D/7F2d7NBuLlhpnAZhEeE5nWBjV
	iClUWWnCRmcLiYhYwuxAbDoYCvcxo3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787151788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VsWqUiS3AnsN1BomAXwpFYtAnhWSn1b5zsxDUn+NlLE=;
	b=PNHUH0FE4LAm88cAv9+6JRKAAasexMfmVw8qpejYOzzbe2X134BmL7lk4Y/OZsXInGR8jW
	Fq/HGQJIArhwKHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123A42F81;
	Wed, 19 Aug 2026 15:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bxdwBKzFhWpBKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Aug 2026 15:03:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A791EA13B2; Wed, 19 Aug 2026 17:03:03 +0200 (CEST)
Date: Wed, 19 Aug 2026 17:03:03 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, udf, isofs, and quota fixes for 7.3-rc1
Message-ID: <tphtwc3dv7cvvj2eviegoqhifpsyfoukrsm24b4psba4atrewo@gmuw7mnqcdrp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]


  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.3-rc1

to get:
  * Removal of deprecated quota code printing warnings about exceeded quota
    directly to console
  * Various udf & isofs hardenings for handling of corrupted filesystems
  * Fix of a possible data loss in udf when converting files from inline to
    out-of-line format
  * Simplify EIO error handling in ext2 xattr code

Top of the tree is 62333e480d12. The full shortlog is:

Aleksandr Nogikh (1):
      udf: Mark LVID buffer as uptodate before marking it dirty

David Lee (2):
      udf: reject VAT indexes equal to the entry count
      UDF symlink pathComponent header OOB read

Deepanshu Kartikey (1):
      udf: avoid recursive s_alloc_mutex deadlock when freeing AED blocks

Jan Kara (5):
      udf: Fix bh leak for unallocated space entries
      isofs: Drop support of directory entries straddling blocks
      ext2: Simplify error handling of IO error when adding xattr
      udf: Move udf_map_block() up
      udf: Fix data loss when converting inline inodes to out of line

Jay Vadayath (1):
      udf: bound lengthAllocDescs from unallocated space entry

Jiri Slaby (SUSE) (1):
      quota: remove CONFIG_PRINT_QUOTA_WARNING code

Kyle Zeng (1):
      udf: validate extent partition references in udf_current_aext()

Xiang Mei (1):
      isofs: fix out-of-bounds page array access on empty zisofs block

Yichong Chen (2):
      isofs: release zisofs block pointer buffer head
      isofs: validate directory records consistently

Zhan Xusheng (1):
      udf: Fix i_lenExtents truncation on 32-bit kernels

The diffstat is

 arch/loongarch/configs/loongson32_defconfig |   1 -
 arch/loongarch/configs/loongson64_defconfig |   1 -
 arch/mips/configs/bigsur_defconfig          |   1 -
 arch/mips/configs/ip22_defconfig            |   1 -
 arch/mips/configs/loongson2k_defconfig      |   1 -
 drivers/tty/tty_io.c                        |  27 -----
 fs/ext2/xattr.c                             |  14 +--
 fs/isofs/compress.c                         |   7 +-
 fs/isofs/dir.c                              |  31 +-----
 fs/isofs/export.c                           |  10 +-
 fs/isofs/isofs.h                            |   3 +
 fs/isofs/namei.c                            |  59 +++++-----
 fs/quota/Kconfig                            |  10 --
 fs/quota/dquot.c                            |  81 +-------------
 fs/udf/balloc.c                             |  12 ++-
 fs/udf/inode.c                              | 162 +++++++++++++++++-----------
 fs/udf/partition.c                          |   2 +-
 fs/udf/super.c                              |  23 ++--
 fs/udf/symlink.c                            |   2 +
 fs/udf/truncate.c                           |   2 +-
 fs/udf/udfdecl.h                            |   3 +-
 21 files changed, 186 insertions(+), 267 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
