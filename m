Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596D426D22
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888448; cv=none; b=mw+wRgU2OYj9JPNajbtZEAD3Bc5kzFNOqQyZmPIcJGVQTbbxn7D8aBehkIZFAS4jguWNbGMSOtejpYY0Ano3gyrnYK/UkLpu+mdwTkkhXWXDGQAJAu2YDMp6mq0NqHM4LFC1pfdhT3B0ONfMv8Y7hi3a+uBmCQJY1QYy8P8zIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888448; c=relaxed/simple;
	bh=xGN1RAT4du1REGykNfBn4dfol+Rq7QDD1YUdajg6qJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ckk9+fp+f6/LgcmhkpGStRqVR3ykxJWDY4dVmWLu4/ancc7W1nxMRg9lFVB/DATB4hGtIm1PkMBChJ1O45roLErHOHgC4vzpIvi09Ofii0R9H5d4pQqAwoh8OCJEWTf05DQDXPdAXMIuxs44MoFVEWyv67IS8RnZMOFCCF7uxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vs+kw9XE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lmEz/+Om; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vs+kw9XE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lmEz/+Om; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vs+kw9XE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lmEz/+Om";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vs+kw9XE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lmEz/+Om"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A46FB7B6BF;
	Fri, 24 Jul 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqYKL1KgQiaZNKY91FKHugSBLG6nF0qcbOPSXZEuCiI=;
	b=Vs+kw9XEp0WIG1GplyD6wndNLF7JOao5sUI9f2Aknt9wvbPAnmHbgRtvf4y/Cl/cbqjvo1
	pSp8MsYB9TK4AQRP4vovt7vf9LWqjAJvJkNdoZpA36jwN6/x6ZHiXfbKUM8arLNd4jAW5d
	75G8R9dVlLWjfsQAO1SwJwEs1KFisYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqYKL1KgQiaZNKY91FKHugSBLG6nF0qcbOPSXZEuCiI=;
	b=lmEz/+OmSqB7GttsygQFgnq9zXB5TFHFXyPu+rHe2bVlCCkLgZnVDL0JonV6nnpIQAkYuo
	STPU2rfco6AuepDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vs+kw9XE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="lmEz/+Om"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqYKL1KgQiaZNKY91FKHugSBLG6nF0qcbOPSXZEuCiI=;
	b=Vs+kw9XEp0WIG1GplyD6wndNLF7JOao5sUI9f2Aknt9wvbPAnmHbgRtvf4y/Cl/cbqjvo1
	pSp8MsYB9TK4AQRP4vovt7vf9LWqjAJvJkNdoZpA36jwN6/x6ZHiXfbKUM8arLNd4jAW5d
	75G8R9dVlLWjfsQAO1SwJwEs1KFisYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqYKL1KgQiaZNKY91FKHugSBLG6nF0qcbOPSXZEuCiI=;
	b=lmEz/+OmSqB7GttsygQFgnq9zXB5TFHFXyPu+rHe2bVlCCkLgZnVDL0JonV6nnpIQAkYuo
	STPU2rfco6AuepDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CAC6779BA;
	Fri, 24 Jul 2026 10:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gNvcEms8Y2oSaQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Jul 2026 10:20:27 +0000
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
Subject: [PATCH 3/5] mm/parisc: constify ptep_get() argument
Date: Fri, 24 Jul 2026 11:20:15 +0100
Message-ID: <20260724102017.141532-4-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724102017.141532-1-pfalcato@suse.de>
References: <20260724102017.141532-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Queue-Id: A46FB7B6BF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

ptep_get() does not need write access to the PTE.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 arch/parisc/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 467b8547ac8b..83f8333ad099 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -432,7 +432,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t ptep_get(const pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
-- 
2.55.0

