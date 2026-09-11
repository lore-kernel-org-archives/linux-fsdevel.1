Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C446A603
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116730; cv=none; b=oSaC5mgLGBX3IVUEM5oBFuHQyGVKh3y0lT7MCNnauR092aDa1oMrjJsWHzv95m7SIMB8Hkimk/UTtAbV1MYJummLLeQW6Kdk4NiD+c8IRMagWg57f1HqsfaGF2nuqIpwIFyGEcTHGf9I9q2djUf43f7yCy0NKG6sbeKPPlWAYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116730; c=relaxed/simple;
	bh=qb2MBAqTLT1go2FYYfHVi1Q5zbydQPdUbAmNs4JQD1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HX3gyNJYRc6XwOLe1/qbhd2Dfx3JN7dwk9pU+xwJbsx9m7VEOkjBAtXcVJl1X1qpVj7/QQyv6wXPzuAWd3bVuSKWRPAK1ePSa6mESgPmmuAweRps80y7TrytdstnYlBYG6K9NHDFpfAha+l/SdtvW70s0NdKMlHly/W9xh4+RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kXPTGl5e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHmQSVr/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=evBWxFs1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rvWH5mkw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kXPTGl5e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHmQSVr/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="evBWxFs1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rvWH5mkw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7501FA79;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z/fxdm5G9XKt+9Xe5B66an5zv6QkeOhmXsJC5MEhbuw=;
	b=kXPTGl5e+rYlxHfO0P9FQozWKELvV0LwD+8X2jT7frkWrqIM209HQW9rPQauE9P271cEaT
	Wq7LbstPEoKMqgY2dkUshCEwNPfBs4v7kcFcs3bQCTDuY+ZPBXKysYLWYVPdzV556BqzFP
	p72anasTR/gWYUqBmmRMzSa6wki7DOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z/fxdm5G9XKt+9Xe5B66an5zv6QkeOhmXsJC5MEhbuw=;
	b=xHmQSVr/TeosCGnXYpwj0W5uOB97er5y8BmxqFjw/NvnaaJJ1vxG11hHdeEaS3fwSevCMS
	z0x/bD7/GmB4bmDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=evBWxFs1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rvWH5mkw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z/fxdm5G9XKt+9Xe5B66an5zv6QkeOhmXsJC5MEhbuw=;
	b=evBWxFs1LnY87IdpSVJgOaS/D8Phaa7+eUx7GiEj5bpxhfWRkkSdgM6YNz5f098TJ+R/yO
	ILaPlIEhUXt8Ow3ryNJS5+bbvRzb6U38SZGU1kniGVs2BVrPAjLK4XhGosqP7Uf9NU1HX7
	hnekQJo8Vs5pY8MkC1Uk8sKMIXwzb5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z/fxdm5G9XKt+9Xe5B66an5zv6QkeOhmXsJC5MEhbuw=;
	b=rvWH5mkwo67z+qAwNpiJ+H5kRi+SPhPSj45nS2zLF/+6XqlJUl0tZafjnNTbPPii6BYrnc
	gx+k9j2lr8h2UNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47BB413715;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQVyES7Bo2quHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF509A1342; Fri, 11 Sep 2026 10:51:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v2] fs: Deferred inode reclaim
Date: Fri, 11 Sep 2026 10:51:36 +0200
Message-ID: <20260911081309.14137-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=jack@suse.cz; h=from:subject:message-id; bh=qb2MBAqTLT1go2FYYfHVi1Q5zbydQPdUbAmNs4JQD1w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqo8EYxl9zKGYzitP7Znr2SZL1VlrMOl8wBQxgu rW64pldoMiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaqPBGAAKCRCcnaoHP2RA 2behB/9mDlFKMai+yJJQedPJanFbltFjkJM6Op6ouyQEjMT2YYFuz6FT81zQOTPZ7/JZYdLtpOr R1YlWV91z9LkSS9kOI7nF4zBGqhSnyelaJ7F2dmv6KCzM/K10mLWymCwjcJtuRHKBx9NnAp3Rkp zKfs7+Vtruv0tOERt3oezMvsYE2xIj5NogYyeOuwDC+TexDzVyKnlUuknWM6lUzGLKAoJs3IoZY qdokUf3VlOiT/Do8B19eF8M+7MJmKTBUAv/+9s75EDfN+DPq8r/RvX2akoeByfVGRwwEie6knkY AhfQyviILiSkggdja1Kw1lJT6sji9vNXEP8xQ0/JYaUCO52D
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 7E7501FA79
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

Hello,

after a long pause here is a second revision of my patches implementing
deferred inode reclaim to deal with MM warnings due to GFP_NOFAIL allocations
from reclaim paths. This happens because to reclaim some inodes, filesystems
have to do IO including complex operations using journalling and forward
progress of these depends on successful memory allocations (which is impossible
to guarantee from reclaim context).

This time I have fully tested the patch set. In particular it survives full
fstests run on ext4 both as is as well as when marking all loaded ext4 inodes
for deferred reclaim to stress the deferred reclaim paths. I have also tested
(when marking all inodes for deferred reclaim) the patches by creating a memcg
with 128m memory limit and then scanning from 10 processes 600k inodes in total
which heavily exercises deferred inode reclaim paths. This also verified
efficiency of throttling of marking of inodes for deferred reclaim. Basically
we cannot guarantee any particular limit on the number of inodes queued for
deferred reclaim as that is bound only by their number in memory and memory
pressure. But as the number of queued inodes grows, the tasks creating them
get slowed down so eventually some equilibrium is hit. In my VM this was
at ~10k inodes (only slightly above the 8k limit when throttling kicks in)
but this all very much depends on the reclaim pressure, speed of deferred
reclaim etc. so I don't think this is some representative number.

The first patch is a pure fix for a problem I've hit when running fstests.  The
second patch deals with lazy timestamp updates which I've decided to handle
better directly inside the writeback infrastructure instead of deferring
reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
deferred inode reclaim is there mostly as a demonstration. Other filesystems
need to determine which inodes need deferred reclaim and mark them as such
which generally requires good internal knowledge of the filesystem. I'm hoping
that once the infrastructure is there, fs developers prompted by MM warnings
will start using it :). I know for a fact that besides ext4 e.g. btrfs is
hitting MM warnings in inode reclaim as well.

								Honza

Changes since v1:
* Multiple workers to reclaim deferred inodes, related to that I've
  moved lists of deferred inodes from per-sb to global ones
* Added missed lazytime sync fix

Previous versions:
Link: http://lore.kernel.org/r/20260429174850.18223-1-jack@suse.cz # v1
