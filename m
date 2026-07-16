Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D633ACA4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214560; cv=none; b=NYeGDBgCHWdlpaZyLPEiMJmZ+0lwYcbf6qVVkMm5FzJPlz2rJ5pmsJehrUQ9vvTp2zgzCiU+xXJcMPbAiGsxqQakRvaCVzeXCIKKqGznRHEVYm4+50Sq9fjk1jK54COpYtRB8EUzXM5RWk2pFPOW27zjIfqXCmkyqU0Cnj5H+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214560; c=relaxed/simple;
	bh=tdIf+9zNI2RXdp7tPk+oLN8J20LNbPH/KDmscrAkTjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLSm2/lby6IgUoti0HA9BbXN7MngEeCjdnpQ7osyoU8xpl5CWI7gaTU+jxkAp7UvBIXhj+pINHw9HqGkKl1LbogzRY00Jtgy4qAFi4mOM4ynYv2vEHZ9kMAyGdGsIxIGMIT+8dphBY5QYFWhmHAJ22hjcZ41R4LDTXMftqBMM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CWeiiFMI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zvbFxaXh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CWeiiFMI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zvbFxaXh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CWeiiFMI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zvbFxaXh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CWeiiFMI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zvbFxaXh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 651E1789D7;
	Thu, 16 Jul 2026 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784214557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LfUgg0n19vDJax5C8zHGy4BuUGI2ivSxdihsCEdwu0=;
	b=CWeiiFMItu24NHY6UlKPgkkT4bPR2N4quhUDntE+t0iJrlrOMKtoeQwPtANLK9wo0QBsKL
	6yK45VjJGnklmtgc31GKaZjrW+0gzMDY2r4KNe5froByEl3xcXyYbREOIgBW0NVvf9NeRm
	/+fHly3XP+L4jooPNV8fpbwNbwG/EJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784214557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LfUgg0n19vDJax5C8zHGy4BuUGI2ivSxdihsCEdwu0=;
	b=zvbFxaXhKFbs/0ygiq7Pdb2TXfl1UTtOYI9Pzv5ApT9v8X8xsOEx6Whdno45jCERBzNDPQ
	x2L84CF32PBU1zCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784214557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LfUgg0n19vDJax5C8zHGy4BuUGI2ivSxdihsCEdwu0=;
	b=CWeiiFMItu24NHY6UlKPgkkT4bPR2N4quhUDntE+t0iJrlrOMKtoeQwPtANLK9wo0QBsKL
	6yK45VjJGnklmtgc31GKaZjrW+0gzMDY2r4KNe5froByEl3xcXyYbREOIgBW0NVvf9NeRm
	/+fHly3XP+L4jooPNV8fpbwNbwG/EJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784214557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LfUgg0n19vDJax5C8zHGy4BuUGI2ivSxdihsCEdwu0=;
	b=zvbFxaXhKFbs/0ygiq7Pdb2TXfl1UTtOYI9Pzv5ApT9v8X8xsOEx6Whdno45jCERBzNDPQ
	x2L84CF32PBU1zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C786779AD;
	Thu, 16 Jul 2026 15:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WG5JExz0WGo3awAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 16 Jul 2026 15:09:16 +0000
Date: Thu, 16 Jul 2026 16:09:14 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mseal: remove further superfluous comments,
 do_mseal()
Message-ID: <aljzdCwWzyvTDgmv@pedro-suse.lan>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 

On Thu, Jul 16, 2026 at 02:43:11PM +0100, Lorenzo Stoakes (ARM) wrote:
> There's no need to abstract do_mseal() any longer so put the system call
> implementation in the system call declaration.

This looks great!

> 
> The comment around do_mseal() is strangely formatted, overly long and adds
> a lot of superfluous information that the code already provides, so boil it
> down to the essentials.

But I would much rather we delete the whole comment (like Leon's patch did,
per my request). Do you disagree?

> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Anyway,

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
