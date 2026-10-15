Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960556C62F;
	Thu, 15 Oct 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087580; cv=none; b=aroGj2oGgAFLW4qnJ4WgxtElpNOR1ZFog6ooUpJ/pYkrjUC8hnCfUOSanAnP5B/al8Yu21sYKkDGyL7IDIsnE9GdbqXx3a3AQ9OhJLFX3nEPqIk8eSNAEjtj0VJf3H6iAxqyaeK7YJtOUyZLTe9DVq9h2tY+PCXNgPwEt1MoHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087580; c=relaxed/simple;
	bh=sd0elu+AqgXbxT6VyYiGezb4Op8DzoVvmozYz77XSk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sP5X08YujPVH9zev6bdGpd3UHpFaUjwv3qvO3nByVRJvI4XwOj4byek5t8up4ndv1OpJYyMY0uvPE0jVx185YwYIiTrPv+0ucJUoHCtpuCANP7D4bBwOVhpfyRaGrCKRMTk9oBtQ+j0ZrgSJnPamPssvcBWIyHXDCJrAYXm/F44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fh6dGgQw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fh6dGgQw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fh6dGgQw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fh6dGgQw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65826223AC;
	Thu, 15 Oct 2026 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1792087569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JtgEMPOhi43iEZON1OLeSjQ9KNIH6C29RtPkGE/gdNA=;
	b=Fh6dGgQwGfnjEoWcJjIBEUe6n5qE7AdQkaVbYrvxWg7oddNzLuWB85qroyb0rurg63lxkw
	XrXeesf3uQv2MI51DhW0yRoXTlLbAujiSdrZU9Gc+fyOA6OCdkK7FXJ15dA+RDkiFvwky+
	1jTwMPT+n/bxxKei7xOQn7L+l4ibY8k=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Fh6dGgQw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1792087569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JtgEMPOhi43iEZON1OLeSjQ9KNIH6C29RtPkGE/gdNA=;
	b=Fh6dGgQwGfnjEoWcJjIBEUe6n5qE7AdQkaVbYrvxWg7oddNzLuWB85qroyb0rurg63lxkw
	XrXeesf3uQv2MI51DhW0yRoXTlLbAujiSdrZU9Gc+fyOA6OCdkK7FXJ15dA+RDkiFvwky+
	1jTwMPT+n/bxxKei7xOQn7L+l4ibY8k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C4B91321C;
	Thu, 15 Oct 2026 18:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XXPbKxAW0WpUbQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 15 Oct 2026 18:06:09 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fixes for 7.4
Date: Thu, 15 Oct 2026 20:06:06 +0200
Message-ID: <20261015180607.1012034-1-dsterba@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 65826223AC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi,

AFFS has attracted the AI security scanners but there's probably little real
impact.  Please pull a few fixes, more will come in the future, but it's low
priority.

Thanks.

----------------------------------------------------------------
The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-7.4

for you to fetch changes up to 78ea2058abf3ee053c0bd9c1b9a77304cb4ae58b:

  affs: validate blocks before freeing them (2026-09-14 13:58:29 +0200)

----------------------------------------------------------------
Farhad Alemi (2):
      affs: don't instantiate dentry if affs_insert_hash failed
      affs: split hash-lock subclass and reject self-referencing dir entry

Kyle Zeng (1):
      affs: validate blocks before freeing them

 fs/affs/affs.h     | 5 +++++
 fs/affs/amigaffs.c | 6 +++++-
 fs/affs/bitmap.c   | 2 +-
 fs/affs/inode.c    | 3 ++-
 4 files changed, 13 insertions(+), 3 deletions(-)
