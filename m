Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD614357A4A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981868; cv=none; b=FeqibLw4REy/45gpnmtF/kuxQQHHE7dKA8+1na6J5NX9M6cmR+YVDlmLNXslXx8p33l3WIQ/+KpKgf6eW1qFamGHWGmFMHhj2L0J7Io1AAbBRVeSVNACJaY25jyAFYDgTqyLML8wl/CVwR7vu82g9Vq62uRf7SMvnDVl5qa4wIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981868; c=relaxed/simple;
	bh=TYR+8dZXTzrw8m1w1rB9OtXKQvWChhqEyNi7H4FtDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAYHD4CaGEUI9ahzZPAS3wMZnBpm19iVBiAbwa1vbugvCqP3TujmtzNOAoQC60jh/NyxVKkqVIkXEl7MvDQ0nMQmxBPlWxVDXfXcreih37pMvAlZ6hbuCjJP/L7ASENTrbf0wHA31B6tAhjaLlIDz3jeA85dKvC2ZBFkTWvqnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xxCp3BXe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wK78ZNOK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pR64zW3U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qw0/m4Oi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xxCp3BXe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wK78ZNOK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pR64zW3U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qw0/m4Oi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D464B7409F;
	Thu,  2 Jul 2026 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782981859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKaN98ekHhxICHbJBLOiwZ8M71xzi/RjkPfDxOdzME=;
	b=xxCp3BXeR8qF17+utXGHalnTa8XGeWgtr6e7SLNYDne+FejTVVOgtK8ySmHgEAAdi1doXi
	FAaCpEhZz0SafTegTyd+9kUc5+ZqZ070l57f8fJYrGhrU+1NedgoY6cfVU3mXcLP/zwdzM
	Tl3ZGo0DwwnzHnr8kFLINDI+pT2pMGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782981859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKaN98ekHhxICHbJBLOiwZ8M71xzi/RjkPfDxOdzME=;
	b=wK78ZNOKZaVO8IVxzfIRW36VTsO9WgLMNEqfQhFpa6ta9Xd0Jiw/TNqH5UuNm2USmat6Si
	KbQqBCOzLRivqPDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782981858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKaN98ekHhxICHbJBLOiwZ8M71xzi/RjkPfDxOdzME=;
	b=pR64zW3UJWikcxjqPs6DpyNCJAUQvxRpgtBowP7uMUeBmvs325/1pgSBGNpZCfQdzG0Cj1
	cY63FgumlWWxkVYBvLfeu1hPvCadn1BXvduVqd4IuxK8ramwMx9NtVavvJrXiffl0vTvof
	WdLO0zr08x/Gv59cUHHiv82iEC9Ix3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782981858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKaN98ekHhxICHbJBLOiwZ8M71xzi/RjkPfDxOdzME=;
	b=qw0/m4OiQI1vH7CMOQtcck98MJE1GHz6hmMXA2zXE9ZJ7s5mlHUlp6OlJ6fJ5vKs0MSAQX
	NyDWjEKqDffaNZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2307779AA;
	Thu,  2 Jul 2026 08:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkuMK+IkRmpbTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Jul 2026 08:44:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E88CA12AD; Thu, 02 Jul 2026 10:44:14 +0200 (CEST)
Date: Thu, 2 Jul 2026 10:44:14 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Zhen Yan <yanzhen20011121@163.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: fix mapping_seek_hole_data() overflow on last page
Message-ID: <fdqwxurm3efl2c2zsfb4bmrhodg7jais6cjhtwyj572mmnvbb6@efkmdh5bamxc>
References: <tikbuxxazkmz5obcf6llp342vn7bi5tlgbbnuliw4jlwndj63e@jkp5g5oj6ug7>
 <20260630125047.703170-1-yanzhen20011121@163.com>
 <hhrt7iy4rgv33wxghhhwryiw3jjgorvmbw4tvxenhmin7z52z2@njm2bn273f26>
 <20260701173210.a7e74a41a8d6f8e97b2b379c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701173210.a7e74a41a8d6f8e97b2b379c@linux-foundation.org>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,163.com,vger.kernel.org,kvack.org,infradead.org,kernel.org,google.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 01-07-26 17:32:10, Andrew Morton wrote:
> On Tue, 30 Jun 2026 15:27:25 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > On Tue 30-06-26 20:50:47, Zhen Yan wrote:
> > > A local unprivileged process can create a shmem/tmpfs file with
> > > i_size == LLONG_MAX using memfd_create() and fallocate().  If the last
> > > page is present in the page cache, lseek(SEEK_HOLE) on that page
> > > returns 0x8000000000000000 as a successful offset, which is LLONG_MIN
> > > when stored in loff_t.
> > > 
> > > The same file has readable data at the last byte, but SEEK_DATA from
> > > that offset returns ENXIO.
> > > 
> > > The overflow is in mapping_seek_hole_data():
> > > 
> > >   pos = round_up((u64)pos + 1, seek_size);
> > > 
> > > For the final page below LLONG_MAX, the next page boundary is
> > > 0x8000000000000000, which is then used as a signed file offset.
> > > When assigned to the loff_t pos, this overflows to LLONG_MIN, so
> > > a subsequent "pos > end" comparison does not catch it.
> > > 
> > > Keep mapping_seek_hole_data() inside its documented [start, end)
> > > search range: compute round_up() into a u64 variable and compare
> > > against (u64)end so the overflow is detected, then clamp pos to
> > > end when the rounded-up value goes past the search limit.
> > > 
> > > Signed-off-by: Zhen Yan <yanzhen20011121@163.com>
> > 
> > Thanks for the patch! It looks good. Feel free to add:
> > 
> 
> Thanks.  I'll queue this for 7.3-rc1 with a cc:stable - no rush, as the
> issue is presumably very old.  
> 
> (Do we think the cc:stable is even needed?  It's very obscure and the
> effects aren't very harmful).

Frankly, I don't think it's needed. It isn't like people are using
LLONG_MIN sized files unless they are trying to exploit some bug :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
