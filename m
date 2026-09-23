Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BA3D88F0;
	Wed, 23 Sep 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182884; cv=none; b=tMgUbVagyOYMZ8m6dy+s8M222g5c0OrA8wELoVhrE65xin4MTR/GYJdGKKmlPpw0SxwWuOMkkpWsTCeNwoWPlszkZp39DZut4iBncSWWIHM5fXcXjoceHutMb7ooaG1VaHrM1gM6laukedPiNbiB+RSNsrKWGl5PvkuzxOB2XXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182884; c=relaxed/simple;
	bh=xeMTr7FHWxTQKEmFXocacMxsw16R1A56jqYWQCev02A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKfWJZ/itbZ/ZBL6x7pXj9YpWCaR/j/nhp6C08rmCGZnT0Xy0Wkbnfd99TuSD9FLWL4G7OCll/OpCoHnv+1LlvEGJef9Bqd+xgbdabYWI9S5jsflD0If0p9cnrnkCpBAu2Oex/7aF4Sh1DUxpvBedEKIQ7LpjLmHTlC4OW8ImtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2p67D5x3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rGv17kwz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R72SSp6A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9RDoCKlY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2p67D5x3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rGv17kwz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R72SSp6A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9RDoCKlY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC3F71FFA7;
	Wed, 23 Sep 2026 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790182877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mVhvZAAHYS9wlUbQ2VrMKxLj7TWdtf0V2R4vD9mk8=;
	b=2p67D5x3mbus1Fjm6P3f+jZSu0MmM3DiM/6h90IZWGHc58Qk8LAUpao6ayX4ivS6DqSPv/
	31dyq7XRfB0Faw53JZkWOzNIoZYgK7RvA2YCqvy5nnkDJ+74rPVPuVQEn2XjN038Dzq3uf
	jbjgIi3gGPjwXl0q39jFAkOx6A+sczY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790182877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mVhvZAAHYS9wlUbQ2VrMKxLj7TWdtf0V2R4vD9mk8=;
	b=rGv17kwzUeWDVw4mgAN1JJ13c4T34A16XevvGUWqDBMvBkkHbctFhzcOM8J30IBqBEo7xg
	UeVH4DV4twq5dkDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R72SSp6A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9RDoCKlY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790182872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mVhvZAAHYS9wlUbQ2VrMKxLj7TWdtf0V2R4vD9mk8=;
	b=R72SSp6Afa8Lr2KCmy0jPQYEMYuF5JJmpF4AYZmI+7e+l0uIQB9J0pmTDw2vOzl5XowEac
	AXbnEOhN47m19hhMSBgQUFw7RCxu5JBt+PMSdiqXcMuGHdw9SPwX+t5CsFXyCwOJZkDFGe
	s+e40b9iYwahmbeXg+G6Wf1rhuC6k7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790182872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mVhvZAAHYS9wlUbQ2VrMKxLj7TWdtf0V2R4vD9mk8=;
	b=9RDoCKlYCtUHiixCIjf8TUNhoEcBLI4brkgm4736bUUrpscTG1d4LoSXE7FJdePzDqge/v
	DcaRixTmnwvft4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DA72134E8;
	Wed, 23 Sep 2026 17:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VI1tHdgFtGp7EAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 17:01:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20451A13D4; Wed, 23 Sep 2026 19:01:12 +0200 (CEST)
Date: Wed, 23 Sep 2026 19:01:12 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	chenyichong@uniontech.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] isofs: validate directory records in
 isofs_read_level3_size()
Message-ID: <kzvkhz7toryyklrio34flkc3xa3kiqumpdt5z2pwtsry566lgf@vdccrwpgaolz>
References: <20260922140137.1768064-1-matthias.goergens@gmail.com>
 <20260922140137.1768064-2-matthias.goergens@gmail.com>
 <cpadce3biub2f3lv5mnuegqpd5wwip3n67oe4xy3jujserdzfk@ynipz43pmoul>
 <20260923153217.777351-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923153217.777351-1-matthias.goergens@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC3F71FFA7
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Wed 23-09-26 23:32:17, Matthias Goergens wrote:
> Thanks for looking at it.
> 
> I don't see how it can trigger there, but I'm probably missing
> something, so here is my reasoning.  With 1/2 alone, offset is always
> below bufsize at the top of the loop: a record that ends exactly at the
> end of the block takes the existing "offset >= bufsize" branch further
> down, which leaves offset & (bufsize - 1) == 0 and bumps block, so the
> next iteration starts at offset 0 of the next block.  And
> isofs_dir_record_valid() accepts a record that ends exactly at bufsize:
> its test "len > bufsize - offset" is false when len equals the room
> left.

Doh, you're right. I got confused by the flow in the loop. Your patches are
correct.

> I also tried it, running fs/isofs in a userspace harness on level 3
> images where a record of a multi-extent file ends exactly at the end of
> a block, including xorrisofs -iso-level 3 output with a sparse 8 GiB
> file.  Neither 1/2 alone nor 1/2+2/2 rejects the directory, and the file
> sizes come out right; a record whose length runs past the block is
> rejected.
> 
> If you have a reproducer, or just a hint at the case you have in mind,
> I'd be really happy to look at it.
> 
> Even if the code might be technically correct, it's confusing.  1/2 only
> works because of a branch further down that 2/2 then deletes, so I'll
> send a v2 that squashes the two: move on to the next block first, then
> check the record, as you suggest, with the straddle code gone.  The end
> result is the same code as after 2/2.

Yeah, I was also wondering if squashing the two commits won't be less
confusing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
