Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B521D3F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305418; cv=none; b=SGrALqyIZiP8KwS6xbU6M5VZc5TtIzquN6AgQ5JB4YAjshT/yIf/tHDMtASNZr3Gmb82C+LIgu3nQM7d1mC4vPEdhgX/O6+dJ6XYfrdcWD+4TSU+2gw4GGpbhcXryDI5V7lDIyT1rQqFWgRGDlDdrfStnULPxklQmcnNCdkYAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305418; c=relaxed/simple;
	bh=kmRDzuzSxUzmKbGRzP/3VYwZcxOwjNUmYMw9sfTlkzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nAzri7/kncvBmFd90CuApXLNJEKuTnT5SkV/2GwI7TXeFj/pVDRr/pCl+delgkzv5qEwQ10Sis7VdfEPSzr7O20GEKgcnUBqGegxnQRMurqs4jXLYvJgESumO0sCxxmUAKxqI0umuAH673hRQh4LRZypBivblI1Fp2VmZjzn/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Nv+7Nsx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GJ5ZZo8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Nv+7Nsx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GJ5ZZo8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Nv+7Nsx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GJ5ZZo8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Nv+7Nsx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GJ5ZZo8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BECFE5BD1F;
	Mon, 27 Apr 2026 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777305415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y9EH/uVh6foaQdx7xGTFQeZ639ICswCMWcDrbZZ2M4Y=;
	b=2Nv+7NsxahHbskHdBs6uL9Yh2qRrtam3Msl0OB/UPmf7VgapI1i6uy/OMS0h9MKbo8WvDe
	qcreDWfLbmhdvYe89u1j2+PRZkXz2+ZxYNLiN1smB1iEnBohtGagUTR73Ficvax4Mc46b5
	LkYE22EeM7zoZ5MvtAR6ai7HRBnlXtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777305415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y9EH/uVh6foaQdx7xGTFQeZ639ICswCMWcDrbZZ2M4Y=;
	b=0GJ5ZZo8nKxFiG1LKHK9COLYrlYu1SDpYThPWqjpu6j66mAZupndIWLTCdQpqTQKfVBDx2
	zMj3cDh8KcicHOCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777305415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y9EH/uVh6foaQdx7xGTFQeZ639ICswCMWcDrbZZ2M4Y=;
	b=2Nv+7NsxahHbskHdBs6uL9Yh2qRrtam3Msl0OB/UPmf7VgapI1i6uy/OMS0h9MKbo8WvDe
	qcreDWfLbmhdvYe89u1j2+PRZkXz2+ZxYNLiN1smB1iEnBohtGagUTR73Ficvax4Mc46b5
	LkYE22EeM7zoZ5MvtAR6ai7HRBnlXtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777305415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y9EH/uVh6foaQdx7xGTFQeZ639ICswCMWcDrbZZ2M4Y=;
	b=0GJ5ZZo8nKxFiG1LKHK9COLYrlYu1SDpYThPWqjpu6j66mAZupndIWLTCdQpqTQKfVBDx2
	zMj3cDh8KcicHOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B78AA593B2;
	Mon, 27 Apr 2026 15:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xQzWLEeH72mmbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 15:56:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 754E4A0B3C; Mon, 27 Apr 2026 17:56:51 +0200 (CEST)
Date: Mon, 27 Apr 2026 17:56:51 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] isofs and udf fixes for 7.1-rc2
Message-ID: <wh5wtvlsfd62xo3dbar5wgp3wz25gzqq6hruqpotis6xt2bg6o@o7kjkqne5uco>
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
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.1-rc2

to get several isofs and udf fixes.

Top of the tree is 13917f71a95a. The full shortlog is:

Michael Bommarito (3):
      isofs: validate Rock Ridge CE continuation extent against volume size
      isofs: validate block number from NFS file handle in isofs_export_iget
      udf: reject descriptors with oversized CRC length

Thorsten Blum (1):
      isofs: use QSTR_LEN() in isofs_cmp

Ziran Zhang (1):
      docs: isofs: replace dead ECMA-119 FTP link

The diffstat is

 Documentation/filesystems/isofs.rst |  2 +-
 fs/isofs/export.c                   |  2 +-
 fs/isofs/namei.c                    | 11 ++---------
 fs/isofs/rock.c                     |  9 +++++++++
 fs/udf/misc.c                       |  8 ++++++--
 5 files changed, 19 insertions(+), 13 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
