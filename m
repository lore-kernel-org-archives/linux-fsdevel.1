Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DAA3EFFD2
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412161; cv=none; b=hhoxEirWRZH+QbM7NvlH7lVlH/+xFn+hg1CsTuVFzIP0W2EljC4QpwwQqlYqVzsAl+KHoVu0KDmmPpYO6xi7woVpU8/hn0MXl8RXWifkSlfAhdbCSpUcpNiVouhR19Q2rvgHgsW20AhRrPRWyuM5rHmv2bSD3SAVyQBAzHRA1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412161; c=relaxed/simple;
	bh=vGap4JP8w+1GM4ie5HW5GX4d787JPxH4X5jc79I1D4A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kUE+M1JqekqFy5omH4apM4CYqhUOjzxeAO2WyfYFIAX2NaimxhyWkFreJ4QsvPx3frpobZtkgyLNfDDMLNX3l7zJT0TJmCq3g4mZjfsV4jXBm4NxmoUsXtqmaPyZasj/2oozo/SVm5GAf8nnoXsItyS2j9yVr7iImGnIMGhJ69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=paiheXFc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T4puUeFn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=paiheXFc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T4puUeFn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="paiheXFc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4puUeFn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="paiheXFc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4puUeFn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B273F21CE8;
	Mon, 19 Oct 2026 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792412157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=PGIdc6OiOpnPFkk0pHqh+qHHB29QKMxmT3sr0Hl3sZw=;
	b=paiheXFcvNZbh3r+45sW1cjWiDLTPFsoNQ1V5zNHx+8j/nlydQ0jIAMADMVAML0eZVBJVS
	+e3txLZIFw6RBOs14rHOe2Rr9MEX+cO5o/HfvvR424vye3LabpNOjc2t6GWZAtY3GMyMY4
	GCnPb3HyOvf+auCmTO0jrrWgplybP5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792412157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=PGIdc6OiOpnPFkk0pHqh+qHHB29QKMxmT3sr0Hl3sZw=;
	b=T4puUeFnu8fYsQVeIc3mCpA6kC/Sz2TJBDzzQoFX1eb3KDD+SYQ1o1VvLhdZYAuK/nzqkE
	9/sUp+zRx6sx1cCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792412157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=PGIdc6OiOpnPFkk0pHqh+qHHB29QKMxmT3sr0Hl3sZw=;
	b=paiheXFcvNZbh3r+45sW1cjWiDLTPFsoNQ1V5zNHx+8j/nlydQ0jIAMADMVAML0eZVBJVS
	+e3txLZIFw6RBOs14rHOe2Rr9MEX+cO5o/HfvvR424vye3LabpNOjc2t6GWZAtY3GMyMY4
	GCnPb3HyOvf+auCmTO0jrrWgplybP5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792412157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=PGIdc6OiOpnPFkk0pHqh+qHHB29QKMxmT3sr0Hl3sZw=;
	b=T4puUeFnu8fYsQVeIc3mCpA6kC/Sz2TJBDzzQoFX1eb3KDD+SYQ1o1VvLhdZYAuK/nzqkE
	9/sUp+zRx6sx1cCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 817ED136CC;
	Mon, 19 Oct 2026 12:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id svJ7F/0J1mq2WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 12:15:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D037A1413; Mon, 19 Oct 2026 14:15:57 +0200 (CEST)
Date: Mon, 19 Oct 2026 14:15:57 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 7.4-rc1
Message-ID: <2zkvzrlxlbtreayny7ljhyy2jjny2mbpruz3j4dgjvxhq2ntkp@q6vb2gwvyf6z>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.4-rc1

to get a couple of smaller changes for fsnotify.

Top of the tree is ff05910cb1b7. The full shortlog is:

Hemanth Selam (1):
      fsnotify: fix typo "anonynous" in comment

Jan Kara (1):
      fanotify: Re-add Matt Bobrowski as a reviewer

Matthias Goergens (1):
      fanotify: report names longer than NAME_MAX

The diffstat is

 MAINTAINERS                        |  1 +
 fs/notify/fanotify/fanotify.c      |  7 +++++--
 fs/notify/fanotify/fanotify.h      | 21 ++++++++++++---------
 fs/notify/fanotify/fanotify_user.c |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
