Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316722;
	b=q2ytW7cve9XlblR6+u5txl/g5G/V0U0vhF1rtsrHqMwAhARZkMCULBUz0DXdd3fyBZ9y
	 /A4Y2PMX+5ITbTm/09jgDjuR3sVzup8IrPa2SU1cuJdlX4Np3dHo6/ZLbgaYhAAvlC+2K
	 hwk53g7Z82Na8btxZ50LUP6FWP/mH+1SHdVwbmNJWp5lJizJ0VAzo3+ayAXHqCDZPAcvW
	 8fzgyp1ta6NUXTSl+tO+O6qwY+sMGXcyjguEktC8DEZVD+HGNaGqUwOMbNewOhRv4Lmgv
	 ykkQiorRcp2RWxW3JXmCkrJWhC/FxSybf7dZL5qdPnV1BW8/hAYoqCxWcd+iTEoHFLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316722;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=oAbAW3qeJZAP6QskNB7tR3/qa91VOiDZlVSFyr4yqgI=;
	b=b8V1QvRtgWuNKxRCZgtUjvUjaPopb48ih81EHSskoUHs2gky2m2pKl/K2FwQVIMetaxI
	 /nhWKEYJifYZL7C5zD5qiM8fQ00ucf6OGE0G1jqLUA0yPERIifiCBwLnKAtlEkdwg4CSR
	 sz6aisCq5jLF0eSA2/Lj0nugDkCUtswuLb31aw1jHqNUVqLe7maQMSU+5toILi905/sCf
	 tkG4OsNUe3VRNM9LZfjLa+I5L6La3etoT40JBRBDsNUz5NHQO3HrdNvKugqH1FtOXzIt+
	 UmCCHyQStMSUFYpyVetqDtKxdKONlRCfvsEK/TGHjpafPMAyyXBEH/92LDctb4X5DTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QdRavS5x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="6O67/YbB";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QdRavS5x;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="6O67/YbB";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CF606E461;
	Tue, 10 Nov 2026 13:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906CF606E461
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QdRavS5x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6O67/YbB;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QdRavS5x;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6O67/YbB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEF5F21E6E;
	Tue, 10 Nov 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794316719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAbAW3qeJZAP6QskNB7tR3/qa91VOiDZlVSFyr4yqgI=;
	b=QdRavS5xqlATb1s+sVg6bj292V3RFDt0Gmp1SVZq/3eZeH2qP7esKRlzGkd8vQ2TjtN19i
	IRRJ+QEwh0VMmLp6MmXOOqisKyZeceiLrvnPqxt4LgK1CE1ieBtwHYmdGI89MeEDKRUb1g
	8fPaKk1lk5duRm0PiqZwyw/l+YJAros=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794316719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAbAW3qeJZAP6QskNB7tR3/qa91VOiDZlVSFyr4yqgI=;
	b=6O67/YbBFDLVhjNO4m09jeWOXXEfdkpjfEyLrzm5X1SDuZdG52rcOFI7TbsrOXg87es4bA
	72GVCG9/XJspWoAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794316719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAbAW3qeJZAP6QskNB7tR3/qa91VOiDZlVSFyr4yqgI=;
	b=QdRavS5xqlATb1s+sVg6bj292V3RFDt0Gmp1SVZq/3eZeH2qP7esKRlzGkd8vQ2TjtN19i
	IRRJ+QEwh0VMmLp6MmXOOqisKyZeceiLrvnPqxt4LgK1CE1ieBtwHYmdGI89MeEDKRUb1g
	8fPaKk1lk5duRm0PiqZwyw/l+YJAros=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794316719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAbAW3qeJZAP6QskNB7tR3/qa91VOiDZlVSFyr4yqgI=;
	b=6O67/YbBFDLVhjNO4m09jeWOXXEfdkpjfEyLrzm5X1SDuZdG52rcOFI7TbsrOXg87es4bA
	72GVCG9/XJspWoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9362E1339F;
	Tue, 10 Nov 2026 13:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SgLYG68Z82rLWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 13:18:39 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 2263622503; Tue, 10 Nov 2026 14:18:39 +0100 (CET)
Date: Tue, 10 Nov 2026 14:18:39 +0100
From: Jan Kara <jack@suse.cz>
To: n3rd <18670333770@163.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"ljs@kernel.org" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, "security@kernel.org" <security@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [SECURITY] mm: mremap/remap_file_pages skip fsnotify pre-content
 hook
Message-ID: <obonr46juxfewuiymsoujvc5bppqhcwawuoj3ftmkey5xbniug@hlaentzdza7k>
References: <4f296d67.bbe3e.1a1c54655f8.Coremail.18670333770@163.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f296d67.bbe3e.1a1c54655f8.Coremail.18670333770@163.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,linux-foundation.org,kernel.org,infradead.org,suse.cz,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

Hello!

On Tue 10-11-26 19:44:43, n3rd wrote:
> 2. Problem description
> The pre-content (HSM) event contract, as stated when the feature was
> introduced, is that for every accessed file range an event covering at
> least this range is generated at least once before the file data is
> accessed. The only hook that emits that event before a mapping is
> established is fsnotify_mmap_perm() in include/linux/fsnotify.h, and its
> only caller in the whole tree is vm_mmap_pgoff() in mm/util.c, i.e. the
> mmap(2) syscall entry. The page-fault level pre-content hook was reverted
> upstream, so the syscall entry hook is the only remaining gate.
> 
> Two paths turn new file ranges into accessible mappings without ever
> reaching that gate. First, the mremap(2) EXPAND path: in-place growth
> goes through expand_vma() and expand_vma_in_place() in mm/mremap.c, and
> move growth through move_vma() and copy_vma() in mm/vma.c; neither
> mm/mremap.c nor mm/vma.c contains any fsnotify_mmap_perm() or
> security_mmap_file() call. Second, the remap_file_pages(2) emulation in
> mm/mmap.c calls security_mmap_file() and then do_mmap(MAP_POPULATE)
> directly, without fsnotify_mmap_perm().

So this is about the useful content of the email. Five pages of text is
really too much noise for this amount of useful information.

Also what you report is indeed a bug but not really a serious security
issue => let's deal with that in a public list.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
