Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D642047A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888426; cv=none; b=Cga2WTLenNHxyA0nOvL9U/gd/4A071jczgZdbi6VbQnIaSXj8QigtNxmIvls25x0eTZnmsp9NlxRej8Sm3Fd3W7Qjm4J1wTjYSuW44Dv+WqdFJbU6yi+msHVJbdgyLZl8UUgIUMv+BDWR1v9WuSg36qk6ogZ6it9Dd4x75NqwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888426; c=relaxed/simple;
	bh=zU3+cOAsYjtax2E7U8DPHK8cGBVSJ4hl2lQJYoXgqm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7q/BxVSgNPHa6qkKDidvQL37hEXjNcnXXjklG4ZvUWGWgiam+mXJzIp8cZxrD+9vUx967vkWucQiOm6zgbCK39Wa99wWsYGBvl0UbUYwM9AUPEInKHJR8bvbJRpJs1EFNzHFOLCsnjiMQMo/lc40ab4j8AqW8RAQZcq9v/PtSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VDT9W77a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bn2TWpyR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VDT9W77a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bn2TWpyR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VDT9W77a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bn2TWpyR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VDT9W77a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bn2TWpyR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5047B3E84;
	Fri, 24 Jul 2026 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=VDT9W77aoBJtno7DnLsVeBLRgtj2LXvFKwTE0PXCYEdHHfO91QqREBPGaLCIhTGHDFNntC
	AiWg4dDHFY6+8unZqaryY3sp2ZEzsVaeyRKvQeyjkdTU3XMYZyz4UYgSLyTJ+7b3zMxUl0
	mY2USsenCuGvMW3sy4pS2u2oFzaGYYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=bn2TWpyRVadTfHe1fCfM1+C+Z0Xe/9VGdfB1U9tnLWA+i0QkT9sJ6DMME1JIwKJpQvjKX1
	0vPiy8tbTwcCApAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VDT9W77a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bn2TWpyR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=VDT9W77aoBJtno7DnLsVeBLRgtj2LXvFKwTE0PXCYEdHHfO91QqREBPGaLCIhTGHDFNntC
	AiWg4dDHFY6+8unZqaryY3sp2ZEzsVaeyRKvQeyjkdTU3XMYZyz4UYgSLyTJ+7b3zMxUl0
	mY2USsenCuGvMW3sy4pS2u2oFzaGYYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SePwpieQyuy4I1jGDOGIB8gwV902Jt9JP/rZL79vbug=;
	b=bn2TWpyRVadTfHe1fCfM1+C+Z0Xe/9VGdfB1U9tnLWA+i0QkT9sJ6DMME1JIwKJpQvjKX1
	0vPiy8tbTwcCApAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C0E0779BA;
	Fri, 24 Jul 2026 10:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJmVOWM8Y2oSaQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Jul 2026 10:20:19 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] mm: add basic PTE const type-safety
Date: Fri, 24 Jul 2026 11:20:12 +0100
Message-ID: <20260724102017.141532-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5047B3E84
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Since forever, MM code has thrown pte_t * around with no concern for const
safety, or typesafety of any kind. This is confusing. Attempt to address it
by:
1) Making sure pte_get*() helpers can cope with const pte_t * arguments
2) Constifying the pte_offset_map_ro_nolock() return type, which by definition
already pledges that users will not write to it.

These two simple steps were already able to uncover code smell from
khugepaged + do_swap_page().

Separate steps could include introducing pte_offset_map_ro_lock() for more
widespread usage of this.

Benefits of this include less confusion and better type-safety. It could also
futurely aid in efforts such as [0] which may want semantic annotation of these
accesses.

Based on mm-unstable and compile-tested on a handful of architectures.

No functional changes intended.

[CC list editorially trimmed for brevity reasons; apologies if you're not on it]

Link: https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-0-eaaacdacc67c@arm.com/#t [0]
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org

Pedro Falcato (5):
  mm: constify generic pte_get*()
  mm/arm64: constify pte_get*() and contpte get logic
  mm/parisc: constify ptep_get() argument
  mm/powerpc/8xx: constify ptep_get() argument
  mm: constify the pte_offset_map_ro_nolock() return value

 arch/arm64/include/asm/pgtable.h             | 10 +++++-----
 arch/arm64/mm/contpte.c                      |  4 ++--
 arch/parisc/include/asm/pgtable.h            |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
 arch/powerpc/mm/pgtable.c                    |  2 +-
 include/linux/mm.h                           |  4 ++--
 include/linux/pgtable.h                      |  8 ++++----
 mm/filemap.c                                 |  2 +-
 mm/khugepaged.c                              |  2 +-
 mm/pgtable-generic.c                         |  4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.55.0

