Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52779346E46
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773304; cv=none; b=THivh0TwnFR050wQtKPAciLqTAPP6AjFRy9njdsivteIAIC1Lxi9zWuaxSxXW+iIWNB2tVYBxwQ69vLlJKws74M/UHKrqknKgwtUYfZip8tRcA+wmj/FZMUC3AjGF5fT8+DINTRbrfJPDNU6engVJUPMEdR03hzkP2D9CYQbaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773304; c=relaxed/simple;
	bh=eGEQRv+/QX+ysm/YxEjInQa7Qyp0V80s/mrF6Nm3CJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7yXhR/5Mf9cQayTAeRq9L2GgTBNC5mnshPK77vwPRQgamOICwzt9BMDiii+3UxJH8K2hud4O+paFQsbxpxuBs5tq4rA38snreCzpjPTP24AUfxydVNrhLyzzgXfpnoOVjo/IKvSzFG0E9un4BfM0xRuaJUCJxxpBNkkaPQnaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vcIc1q3h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7bRFtGJt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vcIc1q3h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7bRFtGJt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vcIc1q3h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7bRFtGJt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vcIc1q3h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7bRFtGJt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67F436A856;
	Tue, 21 Apr 2026 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776773301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yMxLBaOga7g7HLsT7YiFc7j1uBKf4AofNjGYGINGqA=;
	b=vcIc1q3hQG1qlEJdYBTs1vkiJKqUHT6ziXFvRBhwVIfDOe5QHjFSC3m6PZZ8NeA3G7c67O
	nfQt/kn1ToTOnF32dbhh2sZzfYEazSD2L53PVMcgFgsNkst9R3zF4ZIqTW1vIjkOtKoL6x
	+WeUP/xFrCMGC2WXUOAlHJa7hb+g/Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776773301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yMxLBaOga7g7HLsT7YiFc7j1uBKf4AofNjGYGINGqA=;
	b=7bRFtGJtxg9BAqG6SylI9GpPZpAwdOF2Xx14L4q2PIs1SrSqpWuGnSEm21yRnhnq83HCu5
	Ekpf0YcrFREkN1Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vcIc1q3h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7bRFtGJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776773301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yMxLBaOga7g7HLsT7YiFc7j1uBKf4AofNjGYGINGqA=;
	b=vcIc1q3hQG1qlEJdYBTs1vkiJKqUHT6ziXFvRBhwVIfDOe5QHjFSC3m6PZZ8NeA3G7c67O
	nfQt/kn1ToTOnF32dbhh2sZzfYEazSD2L53PVMcgFgsNkst9R3zF4ZIqTW1vIjkOtKoL6x
	+WeUP/xFrCMGC2WXUOAlHJa7hb+g/Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776773301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yMxLBaOga7g7HLsT7YiFc7j1uBKf4AofNjGYGINGqA=;
	b=7bRFtGJtxg9BAqG6SylI9GpPZpAwdOF2Xx14L4q2PIs1SrSqpWuGnSEm21yRnhnq83HCu5
	Ekpf0YcrFREkN1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DD94593AF;
	Tue, 21 Apr 2026 12:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZBXnFrVo52mbPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Apr 2026 12:08:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1984BA0AE1; Tue, 21 Apr 2026 14:08:13 +0200 (CEST)
Date: Tue, 21 Apr 2026 14:08:13 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 67F436A856

On Tue 21-04-26 13:17:34, Amir Goldstein wrote:
> On Tue, Apr 21, 2026 at 12:16 PM Jan Kara <jack@suse.cz> wrote:
> > I definitely want to keep a clause like this. Maybe I'd just reformulate it
> > like:
> >
> >   - Handle security issues promptly.  Both those reported by ordinary users
> >     as well as those reported by fuzzing tools. Expect that your filesystem
> >     will be subject to syscall fuzzing as well as filesystem image fuzzing.
> >     Dealing with maliciously corrupted filesystem images is not generally
> >     considered a high severity security issue but still it is considered a
> >     quality-of-implementation issue that should be fixed.
> >
> 
> I can take this version, but tbh feels like debating this clause misses
> the main goal of the doc, so I'd rather go with something a lot shorter:
> 
> - Handle security issues and regression promptly.  Both those reported
>   by ordinary users as well as those reported by test bots.
> 
> IMO, getting into more details doesn't really add much value to the
> prospect reader of the doc before submitting a new filesystem nor to
> the filesystem reviewer.

Agreed. Your shorter version conveys the idea and the details aren't that
useful. So the short version is fine.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
