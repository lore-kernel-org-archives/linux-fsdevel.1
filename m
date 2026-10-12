Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE974570E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793464; cv=none; b=fnGoP0eXnVzgk1+0QuLiM05W3SnB2PBRFA2sMM94QkVZkNFAsEfVRQ7nvh4EohIeOyOVDf3q6iaACjppmqjqzt37gxNp4qJthXybexryze7T3Qzm3vz7QcAibDeLO26XGxDRP6ARCFpSKApJYTPH66f8u0y7A7rLxxVOE7kmGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793464; c=relaxed/simple;
	bh=V9oUBCPzZOaV8+MDpqgAOKQT4zKDxCe1JR3JQ7aAPKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6s6e5W5VvkOLDnCpKdztsz0Zc8RWFd3abEvq1SUjkdxzc2oY8bFU1jeXyrAEnaYX+vwT6zGGdAOaCQqAdCOuMXN8l4mVPrNVUxTppJeAWRd6CnOlyB6cBYep0k+OatsYSYZu7/10kTgIrcIf03S2IaykcCoJ+zT/a5imaGf710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3bpsPYVH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s4azxD88; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3bpsPYVH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s4azxD88; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3bpsPYVH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s4azxD88";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3bpsPYVH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s4azxD88"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 347041F78F;
	Mon, 12 Oct 2026 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QY1OoKKUzmo9MrxvOaP0qbVh/NTWNu6sX9Pwj1+pn9M=;
	b=3bpsPYVHYND8iw4gSY0WV3TxMtqRt0YOjE24ETsOpLe87j+GxvAhDNYLOrmwFx3OTWgJHA
	z40X+6h4App6mQ1FoY8wfk1Vqyin99fsaKK1ncmjRMU/8gl+4YkQqD9vaPEBuohSkehjFn
	S11BlAg80JHuJ/JwmtNesDJYAO7Nrlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QY1OoKKUzmo9MrxvOaP0qbVh/NTWNu6sX9Pwj1+pn9M=;
	b=s4azxD88H6pDNR8EDMWNvbtg/zxcvlRT7zHNhsvtxynGj1MPFXvBLu8ZSADN1NcZ+q+Ftp
	2HEqV6ruOq0wBnCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QY1OoKKUzmo9MrxvOaP0qbVh/NTWNu6sX9Pwj1+pn9M=;
	b=3bpsPYVHYND8iw4gSY0WV3TxMtqRt0YOjE24ETsOpLe87j+GxvAhDNYLOrmwFx3OTWgJHA
	z40X+6h4App6mQ1FoY8wfk1Vqyin99fsaKK1ncmjRMU/8gl+4YkQqD9vaPEBuohSkehjFn
	S11BlAg80JHuJ/JwmtNesDJYAO7Nrlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QY1OoKKUzmo9MrxvOaP0qbVh/NTWNu6sX9Pwj1+pn9M=;
	b=s4azxD88H6pDNR8EDMWNvbtg/zxcvlRT7zHNhsvtxynGj1MPFXvBLu8ZSADN1NcZ+q+Ftp
	2HEqV6ruOq0wBnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1629413408;
	Mon, 12 Oct 2026 08:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f1GIOi6ZzGomHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:24:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8DB8DA1403; Mon, 12 Oct 2026 10:24:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/7 v3] fs: Deferred inode reclaim
Date: Mon, 12 Oct 2026 10:23:38 +0200
Message-ID: <20261009133253.20102-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4377; i=jack@suse.cz; h=from:subject:message-id; bh=V9oUBCPzZOaV8+MDpqgAOKQT4zKDxCe1JR3JQ7aAPKE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqzJkJNG8Z/VSIn1YRqVysKcA+cKJjTnmEhvW+r +5nwH+mv+CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCasyZCQAKCRCcnaoHP2RA 2WzBB/9ma+bTApG9qKyDdh4FFzGal4LDCzodpeWUzNkdFicwTuyVPaxVeOGYW7e+8xrsniiiWS1 OZKCn2DbClxcwg01zyurbqqdoNubjTqGit43jpzBZRdasNgCLEbB1d5U65Fn3lBt0ZF70Cj1VxL Sa3P1XjM61CmOuvB7KXY2he/65uv6ADeYtWnMf26N/JlJF1AxXlv5WgnnMl8eea4LsI3hsYir4d DYNjprn3e96iHYsIcIhfMIGbC74QU68TYHJSFIsVS/Ort4yXxwA2lZpKqIF+/2jBz1kRsYY5RKL Ou5Y7WWhrbNIxSZBKTDQPy0NfBW7NEqO1FKJFDx7n0AojcRS
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

Hello,

here is the third revision of my patches implementing deferred inode reclaim to
deal with MM warnings due to GFP_NOFAIL allocations from reclaim paths. This
happens because to reclaim some inodes, filesystems have to do IO including
complex operations using journalling and forward progress of these depends on
successful memory allocations (which is impossible to guarantee from reclaim
context).

Since the last revision the most notable changes include addition of automatic
deferal of inode eviction from iput() when inode link-count is 0 and we are in
reclaim (PF_MEMALLOC flag set). This path gets triggered e.g. by overlayfs
whose inodes hold dentry references on upper filesystem and thus slab reclaim
of overlayfs inodes can trigger the last dput() (and thus iput()) of already
unlinked files. Since inode deletion is practically guaranteed to require IO
(and thus possibly e.g. loading allocation information into memory) I've
decided to unconditionally defer reclaim in this case instead of marking inodes
in each filesystem.

Another bigger change in this series is that we now protect deferred inode
reclaim from filesystem freezing. Otherwise inode eviction could block the
reclaim worker on frozen filesystem which could stall deferred inode reclaim on
the whole system. Deferred reclaim workers now skip reclaiming inodes on frozen
filesystem and we block filesystem freezing while the worker is evicting
current batch of its inodes.

The last bigger change is that mark_inode_reclaim_deferred() does not block
when the queue of deferred inodes grows over limit anymore. Instead it queues
task work to delay the task appropriately when returning to userspace. This
solves possible lockups when tasks would get throttled when calling
mark_inode_reclaim_deferred() with some locks or transaction started.

The patches have survived full fstests run on ext4 when marking all loaded ext4
inodes for deferred reclaim to stress the deferred reclaim paths. I have also
tested (when marking all inodes for deferred reclaim) the patches by creating a
memcg with 128m memory limit and then scanning from 10 processes 1m inodes in
total which heavily exercises deferred inode reclaim paths. This also verified
efficiency of throttling of marking of inodes for deferred reclaim. Basically
we cannot guarantee any particular limit on the number of inodes queued for
deferred reclaim as that is bound only by their number in memory and memory
pressure. But as the number of queued inodes grows, the tasks creating them get
slowed down so eventually some equilibrium is hit. In my VM this was at ~10k
inodes (only slightly above the 8k limit when throttling kicks in) but this all
very much depends on the reclaim pressure, speed of deferred reclaim etc. so I
don't think this is some representative number.

The first patch is a pure fix for a problem I've hit when running fstests.  The
second patch deals with lazy timestamp updates which I've decided to handle
better directly inside the writeback infrastructure instead of deferring
reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
deferred inode reclaim is there mostly as a demonstration. Other filesystems
need to determine which inodes need deferred reclaim and mark them as such
which generally requires good internal knowledge of the filesystem. I'm hoping
that once the infrastructure is there, fs developers prompted by MM warnings
will start using it :). I know for a fact that besides ext4 e.g. gfs2 wants
to use this infrastructure.

								Honza

Changes since v2:
* Some cleanups and simplifications from Andreas Grunbacher
* Fixed couple of bugs pointed out by Sashiko
* Added support for auto-deferring eviction from iput() when inode has 0 link
  count and we are in reclaim path
* Added protection of deferred reclaim from filesystem freezing
* Throttling now doesn't happen directly in mark_inode_reclaim_deferred() but
  on exit to userspace

Changes since v1:
* Multiple workers to reclaim deferred inodes, related to that I've
  moved lists of deferred inodes from per-sb to global ones
* Added missed lazytime sync fix

Previous versions:
Link: http://lore.kernel.org/r/20260429174850.18223-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20260911081309.14137-1-jack@suse.cz # v2
