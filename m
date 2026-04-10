Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D94400
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785116; cv=none; b=PIRYvvyQPnXQ+zNSEbnbCp5q+KNnKAflVjvY+VQibHVv2VL7zOay4r2Ru5209g0QHJvbZttiw4TnuV07oA7wHE6qOqj39hJ1pNRvrqooJWfpfjN17rBDkoi6Lpz7DAoRVSX8IfCoPSKFLZAmFhI2NzfDsXGUm4DoyX7XX+VxOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785116; c=relaxed/simple;
	bh=Qt7aZ9eqopPbuB7sh5lt3QZ9N5KDYbpHh65cYpT0K1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlndcqgniMZcqG67PyubYe3y4ok5da5n5lbpIyCSpiQSirEjWG30fiPADiWVq5qIExrD4ln4BHVWLhhe9jyh6R2ZNWzm9Acpg28pMdVyuEjQCspRT+juTqX/LcJq2q/l8NEdM2g7puGmBig7PO/rZM3o6Vk/0nlOOZK51rv2Nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VzKu2t76; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VzKu2t76; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VzKu2t76";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VzKu2t76"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34FB06A7E2;
	Fri, 10 Apr 2026 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1775785112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KwMteQnOM8iP0CQXvHtHTKm8/1r47qVTxPuIVswoyXg=;
	b=VzKu2t76fAx8crioyeUJfCcncdzJB7l9D3SeP83yiKALjvJV/L43Wm5d0vJFYziPJTi1Ps
	S1qeXO+/ocoP2tdDFBxzdkZkrXq8UeYQd39obtZYu7H0UagpzqV4fR/NreM8d2s/qy93yL
	uROTOVAgkv9Sr/d4gM0wUfWZyj36cyc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1775785112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KwMteQnOM8iP0CQXvHtHTKm8/1r47qVTxPuIVswoyXg=;
	b=VzKu2t76fAx8crioyeUJfCcncdzJB7l9D3SeP83yiKALjvJV/L43Wm5d0vJFYziPJTi1Ps
	S1qeXO+/ocoP2tdDFBxzdkZkrXq8UeYQd39obtZYu7H0UagpzqV4fR/NreM8d2s/qy93yL
	uROTOVAgkv9Sr/d4gM0wUfWZyj36cyc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DC1E4A0B2;
	Fri, 10 Apr 2026 01:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 31MiC5hU2GkUfgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 10 Apr 2026 01:38:32 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fix for 7.1
Date: Fri, 10 Apr 2026 03:38:25 +0200
Message-ID: <cover.1775783818.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Hi,

please pull an AFFS fix. There's a potential out-of-bounds read in the
directory hash table during readdir.

Thanks.

----------------------------------------------------------------
The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-7.1-tag

for you to fetch changes up to 6fa253b38b9b293a0de2a361de400557ca7666ca:

  affs: bound hash_pos before table lookup in affs_readdir (2026-04-10 02:51:05 +0200)

----------------------------------------------------------------
Hyungjung Joo (1):
      affs: bound hash_pos before table lookup in affs_readdir

 fs/affs/dir.c | 2 ++
 1 file changed, 2 insertions(+)
