Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D247884D
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336389; cv=none; b=GPvOY8u4RU1W9yWjMUBNJ/4oqw8uXQ0G32TUNiyZK1MX4UeeFxprNiTZYJPscj8mcE5QNyk+htE3BHhDyc1WXdLo+8NQK0Vl/Yte00S/L9bFM0fciObeIIsKSUeMLmly5AP9WadTBSSyrZoRcCZ9KOkhK87wy+O0yvlRkx7ELB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336389; c=relaxed/simple;
	bh=28Fi1b6nkTwNV9bJkT+IGnPDH7KbGBeWEWWDRwfhOg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLpjL7kUv73tIhAuxAcX2rKjNBGnalR0ZCwUS4FCXk7YhUAjF6D40rk8kNFxDg/QC1XAJ+EmWuFWmeMvAqS4U/fUenhw8KshdkWlQUz4Ywt1rlNJFt/Oo7aMDt3/WTnmDnxiB4QuQsPgMKLKmte1GWe68o7h1nc7OiSZFF2wtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bvj4QwiJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3D7kFoM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsEXHobh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ugADbYhS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bvj4QwiJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3D7kFoM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsEXHobh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ugADbYhS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A955A21976;
	Fri, 25 Sep 2026 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790336375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3lrzIR/HAL8KmjcAEumopjCc2a2LMn/5F37lhi0qObc=;
	b=Bvj4QwiJuBs//xowpIXBRLUdZbjFyu3P+5elR9g+WG2OLUai/ycbk5PZpm9//VEELzfI7t
	3fz2S1TaSbHPdi7zdZHpnZZoTJS8evEgfWlRbnugI8VFQ5uNJ97m8SjMWY3GXfWTJ4sRvv
	YpZfXw47KT12kgsxPWie7KsEBkutaMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790336375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3lrzIR/HAL8KmjcAEumopjCc2a2LMn/5F37lhi0qObc=;
	b=Y3D7kFoM/WFK894sbsvv+9STmP2jPd2vwNUgHG3jRTe4HQAmbxjX2ZYSxfORzjuEnV8+T9
	eRP1OsU5vsK28MBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xsEXHobh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ugADbYhS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790336371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3lrzIR/HAL8KmjcAEumopjCc2a2LMn/5F37lhi0qObc=;
	b=xsEXHobhng+Voc0wYDCaN0gvwSddLqnuBXolAYdnXbtLF4IfoNZo1bh9LsSs2kXrJXJt14
	/FdC7+tOyv7Q5AbPYxvVAtfDmbUAFiR3PWjl8Mmq4LO2FKeK5DRdq1pcEXEUiknpfUh9NH
	3ZNisbKcOkrUcbSzNxjcUt6XsQFr4S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790336371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3lrzIR/HAL8KmjcAEumopjCc2a2LMn/5F37lhi0qObc=;
	b=ugADbYhSvljDB1KiCtjJYBFX7TWiNVhd1jTD3i6ZwIZrMI91QUoSc6LYVqShZ7y9kDs/kh
	OJQioi7vDq/KyKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A1F13432;
	Fri, 25 Sep 2026 11:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X/tDF3NdtmoqOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Sep 2026 11:39:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08096A13DA; Fri, 25 Sep 2026 13:39:27 +0200 (CEST)
Date: Fri, 25 Sep 2026 13:39:27 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] isofs fix for 7.3-rc5
Message-ID: <kt5msp6vjbhfe74t5yj7cx6wfey2z3lnou2gdn64cltxhjqaq4@qp3h26tbvrqz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A955A21976
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.3-rc5

to get a fix for reading of tightly packed isofs directories.

Top of the tree is 883b776abe48. The full shortlog is:

Jan Kara (1):
      isofs: Fix handling of directories with tight blocks

The diffstat is

 fs/isofs/dir.c   | 20 ++++++++------------
 fs/isofs/namei.c | 16 +++++++++-------
 2 files changed, 17 insertions(+), 19 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
