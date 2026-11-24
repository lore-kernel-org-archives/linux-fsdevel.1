Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521549;
	b=F0mlmkeBf6cxbDd2RqASm9ax4jFVZEdHE+0c721XvitrlNz2mEqSw2kfnyMJguFb0xCg
	 lY4E7lnh8fq0rx7EJCo/n6FmmGb0TUClslA9bHJpvfq4aX48zxUSPcYVdkQHzl5wN+gk5
	 +1Yd0hrCy6Pp/1Z7mtPppm/xBP5srYQCxgWvOkeTusGUFH5XfIG9j3OmnF3fPec1PKRqH
	 eZIbOkMLW3BdDo4dpcjFoHDSjdj4KUvuGZ0T8EmSdipkwhcLqT7H05L8Ra2FT7y8DV0+F
	 MW9unwSOm2PsHl6ZEB1p0kJP3Yaonjh11AyjqFkzgZZkLfq2ubk3kwWRcioYBFo2mqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521549;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=A5M/4CSKr8nGu+5ll03h6CgMljX0Z2g/Au5Ni+hqHnw=;
	b=08Rjr6DpCXifqL4DuYDLcf4k3a0/Ue1lNinmMludx27eJqjxoFGWsCddyvK8/EyT/Eso
	 c+M8JFG14L8yLNU3YdK265MxvOTlb5HNxoMxGwJuAz/SA3rbN4zUTbOK2UXtQ1z+9LcEJ
	 eR14eIAFiAmz3BiBdBC3giTpgcZIYj+7wlMjpUgL2+enhEKoUT6QgfagShMUf2ZG8xiYA
	 cbAJAuRqfOtXWx2ucNkQ9Q8OROESe9v++qiSKr1ACkdX9CA+pvXHYdiJDBGiZIvVHG7oS
	 Sw6L/6Xaf5ZCcqn7Qgr9M25jzwNGSwgQIuT0UscMBi465NieYuYXMuapWnLmEp8xx1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JdBKj2Pv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xRer9G1j;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JdBKj2Pv;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xRer9G1j;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABD606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AABD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JdBKj2Pv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xRer9G1j;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JdBKj2Pv;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xRer9G1j
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 779351F461;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A5M/4CSKr8nGu+5ll03h6CgMljX0Z2g/Au5Ni+hqHnw=;
	b=JdBKj2PvvIFiJtcB0+f3uOz3KNZq/jMavvFFBrWS88l9zObHP/XJ6RPAdksxV1uT8kClRo
	jonXN3tT47IGw6SU2v6Kw95eTUQOSMFw5Het7MTs5V+qY8ZpoZWii7h4uEdzx+t6HZfQyn
	6DYrbyNjFHrXA/cZyIfEnBaDZUJiZV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A5M/4CSKr8nGu+5ll03h6CgMljX0Z2g/Au5Ni+hqHnw=;
	b=xRer9G1jIXuMJTrfH1aOvDFt5r+PR+ul+5agZIznkavZVrNmDD+ubXuLSSelXqonKX9Lsb
	zXG/gBpK5xMr/aBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JdBKj2Pv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xRer9G1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A5M/4CSKr8nGu+5ll03h6CgMljX0Z2g/Au5Ni+hqHnw=;
	b=JdBKj2PvvIFiJtcB0+f3uOz3KNZq/jMavvFFBrWS88l9zObHP/XJ6RPAdksxV1uT8kClRo
	jonXN3tT47IGw6SU2v6Kw95eTUQOSMFw5Het7MTs5V+qY8ZpoZWii7h4uEdzx+t6HZfQyn
	6DYrbyNjFHrXA/cZyIfEnBaDZUJiZV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A5M/4CSKr8nGu+5ll03h6CgMljX0Z2g/Au5Ni+hqHnw=;
	b=xRer9G1jIXuMJTrfH1aOvDFt5r+PR+ul+5agZIznkavZVrNmDD+ubXuLSSelXqonKX9Lsb
	zXG/gBpK5xMr/aBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F21E13735;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NUC+Jwp8BWtIZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CD14927845; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v4] fs: Deferred inode reclaim
Date: Tue, 24 Nov 2026 12:58:44 +0100
Message-ID: <20261124113450.3451-1-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3928; i=jack@suse.cz; h=from:subject:message-id; bh=vFlN+gOu+lwPK4zJC6DbpUxA92Homwwvyd6ieE8f8ak=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXvzR/XHjfH8JoZew1OdN4cZLQj37dsmNL8sv lX+JQ4zqiGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV78wAKCRCcnaoHP2RA 2ZX4CACjsD8u1El38f2w21opVlI43GwddTRfb2MkTqx5hyR8oJrg4MS7AIMMWU5LDBaqyvsrBws sRFdvtYhyPB3yBnFo5ts+lxOhYmcf28J3I8IszDof0lZjRCOxCSkYpu9Ckd6wXEjK7tgAbPzWzY 3mGf+PQg9oVWWEn83GgwWWDXb2B3iTWy84Ap83lsAEbWEL3X0pG+MooC8M4t08F0TAAz4YUY299 l3+0O+06x8fjjlkb0Iu2IlVHiurELCO24g3/QLEBHjfkq3YsfeOh1/oNYqDU2Kk794IkxvN5sd5 i/5jiiucQXyDBWlZnFHL48QCXGex5mWhxIlDAkXUk7iu5lql
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 779351F461

Hello,

here is the fourth revision of my patches implementing deferred inode reclaim
to deal with MM warnings due to GFP_NOFAIL allocations from reclaim paths. This
happens because to reclaim some inodes, filesystems have to do IO including
complex operations using journalling and forward progress of these depends on
successful memory allocations (which is impossible to guarantee from reclaim
context).

There are two notable changes since v3 and that is tweaking of the logic
expediting writeback of B_DIRTY_TIME inodes on last iput() so that it works
more reliably (even if the inode happens to be currently under writeback). This
led to occasional generic/622 failures before. Also we now automatically defer
reclaim of inodes with I_METADATA_WRITEBACK bit as Christian suggested.
Otherwise there are couple smaller issues fixed that were spotted by Sashiko.

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

Changes since v3:
* Improve logic to expedite writeback of I_DIRTY_TIME inodes to handle also
  the case when inode is dirty or under writeback
* Defer reclaim of I_METADATA_WRITEBACK inodes
* Handle kernel workers when throttling deferred inode reclaim
* Fix memory leak in throttling code
* Fix synchronization between superblock teardown and deferred inode reclaim
* Fix synchronization between superblock freezing and deferred inode reclaim

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
Link: http://lore.kernel.org/r/20261009133253.20102-1-jack@suse.cz # v3
