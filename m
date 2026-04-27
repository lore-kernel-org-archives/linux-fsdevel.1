Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8A3A0E8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304934; cv=none; b=P7MMQ8KQ8CPvpNKxtdMt/tmTTfvaaq9uJ4K3AT8tZrEZkF8T04ps2oMWtrZSOydVG67S+NCY+rUHiEDzS8uSIiH7NCoaxdlGhdUskBRyyV/EgOLeWec25PeO77EMckjB8BAmbb3Dqe8WizwKmXAQyJ78WMHgecmvSU+cQ3B+bjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304934; c=relaxed/simple;
	bh=lhnFbD125D2reDakn2eFfMkXdMsj9+IvMHimzDLmwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxAtefDSmQqZ2iCQdul+YIfLrLnxL+0cujxhomEbfhORp2UBBRCOoawbebOTu50pLbFoPZCpPBB6hkx/XXeibu2sL5/liLDso/RPwAfe0DFsACbFx+G5uJJzloIRYMuwrpikCWQ1+MBt2P/evTuXk8aCIoljX4UobPsseHMDKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdfCxdGe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4NWsmlg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdfCxdGe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4NWsmlg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdfCxdGe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4NWsmlg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdfCxdGe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4NWsmlg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B90EB5BCD3;
	Mon, 27 Apr 2026 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777304931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwIgqre0nNuSkcqjiOhDGxy5g/yN/3PgWU55rx1sZ9s=;
	b=qdfCxdGeEeT9YjaU224+6JN2zCF73PorLqXEtxnbYdTc5I+R7cL1oCZyMsCnVwIst5VLNs
	I4ZDFZSEnl1DvnyeMInpH+t5+Jd8j2JTmKFL4apqbRo95kaH6eqeWK6ODjQwZym2qqJUTO
	m/9Xurnha/o7ToPzjJvUg66wsZTpHAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777304931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwIgqre0nNuSkcqjiOhDGxy5g/yN/3PgWU55rx1sZ9s=;
	b=x4NWsmlgPPFrHUMRI6NSW0MfhoV81JbjqTNmQxfHcUmB9ndCgM32r2xYBfA7EXUUg4V5GH
	tyZMz46zJ0+R2+DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qdfCxdGe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x4NWsmlg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777304931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwIgqre0nNuSkcqjiOhDGxy5g/yN/3PgWU55rx1sZ9s=;
	b=qdfCxdGeEeT9YjaU224+6JN2zCF73PorLqXEtxnbYdTc5I+R7cL1oCZyMsCnVwIst5VLNs
	I4ZDFZSEnl1DvnyeMInpH+t5+Jd8j2JTmKFL4apqbRo95kaH6eqeWK6ODjQwZym2qqJUTO
	m/9Xurnha/o7ToPzjJvUg66wsZTpHAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777304931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwIgqre0nNuSkcqjiOhDGxy5g/yN/3PgWU55rx1sZ9s=;
	b=x4NWsmlgPPFrHUMRI6NSW0MfhoV81JbjqTNmQxfHcUmB9ndCgM32r2xYBfA7EXUUg4V5GH
	tyZMz46zJ0+R2+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8828593B0;
	Mon, 27 Apr 2026 15:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L/4dKWOF72kaaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 15:48:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B0EFA0B3C; Mon, 27 Apr 2026 17:48:51 +0200 (CEST)
Date: Mon, 27 Apr 2026 17:48:51 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Chao Shi <coshi036@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [RFC PATCH] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <kg3c4sksgnhhjk3wbag4qbsm6rxuxisbbhu6eqlynbmzknt4oo@tkdynt4h2bq2>
References: <20260426020137.1221985-1-coshi036@gmail.com>
 <ae17nszpQA7Eqbc6@casper.infradead.org>
 <mxlij3dhmnqnile7hm2t4ixomaumibooydo6puym3edt2o2zyg@toyj4j5yid2e>
 <ae9owdaK6f-wFgom@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9owdaK6f-wFgom@casper.infradead.org>
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
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org,sung-woo.kim,purdue.edu,fiu.edu];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B90EB5BCD3

On Mon 27-04-26 14:46:41, Matthew Wilcox wrote:
> On Mon, Apr 27, 2026 at 01:24:45PM +0200, Jan Kara wrote:
> > On Sun 26-04-26 03:42:38, Matthew Wilcox wrote:
> > > Why are we calling clear_buffer_uptodate() in end_buffer_async_read()?
> > > If the buffer is uptodate, we shouldn't be reading into it.  If it's
> > > not uptodate, we don't need to clear the uptodate flag because it's
> > > already clear.
> > > 
> > > I've been deleting calls to ClearPageUptodate and folio_clear_uptodate()
> > > from filesystems; it's almost always the wrong thing to do.  But the
> > > buffer cache does have slightly different rules from the page cache,
> > > so this may not translate well.
> > 
> > Right, I think the clear_buffer_uptodate() call in end_buffer_async_read()
> > is indeed superfluous and we can just remove it - possibly replace with
> > WARN_ON_ONCE(buffer_uptodate(bh)) - to deal with this race.
> > 
> > That being said block_commit_write() could possibly race with
> > end_buffer_write_sync() as well and there the clear_buffer_uptodate()
> > should stay (well, unless we want to do a serious rework of IO error bh
> > handling). So the changes to block_commit_write() might still be needed.
> 
> Well, I don't want to do a serious rework of io error bh handling, but
> I do have questions!  Let's say we take this patch, so we do:
> 
> 	lock_buffer(bh);
> 	set_buffer_uptodate(bh);
> 	mark_buffer_dirty(bh);
> 	unlock_buffer(bh);
> 
> That means we don't hit the warning, but we do hit an error in
> end_buffer_write_sync() anyway:
> 
> 	mark_buffer_write_io_error(bh);
> 	clear_buffer_uptodate(bh);
> 	unlock_buffer(bh);
> 
> We now have a buffer which is marked as write_io_error, dirty and
> !uptodate.  That's a logically incoherent state -- dirty means "is
> newer than what is on disc" and !uptodate means "on disc is newer
> than this buffer".  I don't know if we have any assertions that
> check for this, but we probably should?

So I tend to agree with you that clearing buffer_uptodate bit on write IO
error (as much as it goes back many many years) is wrong. When I tried to
fix that some 20 years ago, Linus was against it arguing that uptodate
means "it matches the on-disk content unless dirty is set" so we just
worked-around it in ext3 / ext4. Fixing this was the "serious rework" I was
alluding to but these days we probably have less code depending on uptodate
bit getting cleared on write IO error than back then. So maybe it will be
mostly smooth.

> So I think what we need here is (in addition to this patch):
> 
> +++ b/fs/buffer.c
> @@ -169,7 +169,8 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>         } else {
>                 buffer_io_error(bh, ", lost sync page write");
>                 mark_buffer_write_io_error(bh);
> -               clear_buffer_uptodate(bh);
> +               if (!buffer_dirty(bh)
> +                       clear_buffer_uptodate(bh);

Well, if we touch this code, I'd just remove the clearing altogether.

>         }
>         unlock_buffer(bh);
>         put_bh(bh);
> 
> This makes sense to me since we need to retry the write anyway.
> 
> And of course, now I'm looking at buffer.c, I found another whoopsie.
> Remember 7375f22495e7 where we called put_bh() on a stack buffer
> after unlocking it?  Don't we have the same problem in
> end_buffer_write_sync()?  I can't find anyone calling it with a
> BH that's on the stack, but it's a bit of a nasty footgun.

Yes, I'm not aware of any such place either. Culprit of this is that struct
buffer_head is used both as a structure attached to a folio caching mapping
information (perfectly fine to submit for IO) and structure to pass around
mapping information which gets sometimes also abused to submit IO and then
there are issues. We are getting rid of this second use but it's slow.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
