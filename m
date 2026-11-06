Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978122;
	b=CBvK2kq7k5WlatSB9Sh3HO4JYUgt385VaHsebeuZIjxEzEl4MrpE7NYYFBtELk6w/4F6
	 gu5NJjofnu6O+xDuIugck+XkIYt0/biJWumST5KTAy7RxkKdTo9ztbvdAt/0aAxkACM7n
	 N+PoeLh63IOvcSnYFxnT7yru8K28aV+8GcNChJbNp/BjHvP9U2AtHUwGJxdpM5e2VDZSW
	 hUt1u9QsxDM8Ci3IDXOduZWVIdxJafkeHLhYDIQJrXbVjNG6KLqjjH2BuB96gFIBnO9Yb
	 dWq+TR3DuQ/E11yCaAKkxgUCKAFcWGihxnrA8pA3X+0JR5mRqXeWtm3/dFO+KsndrPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978122;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=RKBOr2Uvgk0TVgwtfSMFrp+4uISUamTqoJZmjbQ31gM=;
	b=oC46V/waXUFhJhD45mWgHpaola9b4G8WV4ljh+N7c5HoDNbzU0ZfazqqdLQNeAbnKBJ0
	 vqIwXQMEuO6+XvKFleRWN8hQcPesYc0AaKT3zGuUmhq5xo3LnUKIpQqmV+Y9A3cCFKVkR
	 BOwMZGv0Atsn9dyWcLiZkoMaBAx8IjT8RYdyITofvwPcAgyhNXwQ3XMaGorUjjFrZ7jqz
	 MnhYFPQ8sXgE66np5C5Vfh7KWunHzk6PneIGHQvV57gtZXDPNGyfY6LuR5S2ry9cbNlIm
	 9Vcy9p4cUXvd5dQ6/F/BSnAMClt/FNMP8p2JR65oFrY8K8LUb3EfrWMrDreSXwG2ZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mtpgGF2k;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jjhmh4NP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mtpgGF2k;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jjhmh4NP;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97281606A329
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 15:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97281606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mtpgGF2k;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jjhmh4NP;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mtpgGF2k;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jjhmh4NP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8FBE21B12;
	Fri,  6 Nov 2026 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793978119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RKBOr2Uvgk0TVgwtfSMFrp+4uISUamTqoJZmjbQ31gM=;
	b=mtpgGF2kcKOxazNVqp6n/9fxEDtHGUlby8xPTlkFowLZFSaWkIR92Em1MEUk8NudqhpgK/
	NYyEf/GZ5gJLSGNOlV7sTpI3TGPh82fOKx7Y6PdLWw4sHk/LpFk67LAFippVwOu09bmJ6d
	iK3Fh5MKlSUIxFkDvoyQQnGPkVoYN+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793978119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RKBOr2Uvgk0TVgwtfSMFrp+4uISUamTqoJZmjbQ31gM=;
	b=Jjhmh4NPujEVHwhOYRHK1aYNHDAcPVVCmf9yM36oAR4ZsDZ4GrQrJPq69aiGpRxe45kDe/
	feqGit1czeLhh7Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793978119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RKBOr2Uvgk0TVgwtfSMFrp+4uISUamTqoJZmjbQ31gM=;
	b=mtpgGF2kcKOxazNVqp6n/9fxEDtHGUlby8xPTlkFowLZFSaWkIR92Em1MEUk8NudqhpgK/
	NYyEf/GZ5gJLSGNOlV7sTpI3TGPh82fOKx7Y6PdLWw4sHk/LpFk67LAFippVwOu09bmJ6d
	iK3Fh5MKlSUIxFkDvoyQQnGPkVoYN+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793978119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RKBOr2Uvgk0TVgwtfSMFrp+4uISUamTqoJZmjbQ31gM=;
	b=Jjhmh4NPujEVHwhOYRHK1aYNHDAcPVVCmf9yM36oAR4ZsDZ4GrQrJPq69aiGpRxe45kDe/
	feqGit1czeLhh7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EB84134E9;
	Fri,  6 Nov 2026 15:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJ8UGgfv7Wq2JAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 15:15:19 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 1814321BAC; Fri, 06 Nov 2026 16:15:19 +0100 (CET)
Date: Fri, 6 Nov 2026 16:15:19 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf, ext2, isofs and quota fixes for 7.4-rc2
Message-ID: <mlorvbdtnqywaghslq472ylg7yckewhbu4fk5mhaq6gwyp43to@ppnfgyl6xezl>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.4-rc2

to get several assorted fixes:
  * Some disk format validation improvements for udf
  * Fix isofs handling of dates before 1900
  * Fix ext2 inadvertedly syncing buffer on every directory modification
  * Fix ext2 O_DSYNC handling for direct IO
  * Couple smaller ext2 fixes
  * Fix tmpfs quotas for root filesystem
  * Unify my email addresses in MAINTAINERS file

Top of the tree is e5801273f93e. The full shortlog is:

Hui Peng (1):
      udf: validate vat20->lengthHeader and VAT inode size in udf_load_vat()

Hungyu Lin (3):
      ext2: preserve completed DIO bytes when buffered fallback fails
      isofs: handle Rock Ridge long-form dates before 1900
      ext2: preserve IOMAP_F_DIRTY for extending direct writes

Jan Kara (4):
      udf: Validate extended attribute space is large enough
      udf, ext2, quota, jbd2: Unify email addresses in MAINTAINERS
      udf: Simplify udf_table_prealloc_blocks()
      udf: Fix incorrect error code in udf_current_aext()

Josef Bacik (1):
      ext2: only flush DIRSYNC directories on every change

Matthias Goergens (4):
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: check the unallocated space table when it is loaded
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table

Nathan Chancellor (1):
      ext2: Make sbi an proper alias for EXT2_SB(sb) in ext2_fill_super()

Pedro Falcato (1):
      ext2: take invalidate_lock in ext2_write_failed()

YouYou Yu (1):
      quota: initialize dquot cache before mounting rootfs

The diffstat is

 MAINTAINERS              |  8 ++---
 fs/dcache.c              |  2 ++
 fs/ext2/dir.c            |  3 ++
 fs/ext2/file.c           |  3 +-
 fs/ext2/inode.c          | 17 +++++----
 fs/ext2/super.c          |  9 ++---
 fs/isofs/util.c          |  8 ++---
 fs/quota/dquot.c         | 10 +++---
 fs/udf/balloc.c          | 37 +++++++++----------
 fs/udf/inode.c           |  9 +++--
 fs/udf/super.c           | 94 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/udf/truncate.c        |  7 ++--
 include/linux/quotaops.h |  5 +++
 13 files changed, 157 insertions(+), 55 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
