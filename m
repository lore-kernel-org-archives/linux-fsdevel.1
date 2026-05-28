Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DC34C130
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971657; cv=none; b=b+qGWIJZh7SirKfQOS8L530FDw2g5zG+ojNGTqVK/Fcp3xIo4lJpeTGhwjj1GL+yy4Cw1+aijSadflDVxsaM+XNxFHL1BzY30B2f+62z+ViX1GW0XxE71Gzfwl9JZN9wDco4H2WalV3Ri25aImx+WHR4o+Sz3f052hoST8Kx6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971657; c=relaxed/simple;
	bh=0z/F5RLLwyVnDIQFf/pSd+XpiijbeX1C97qlAC7dfRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Pn51l2COd3rWR9SGBK+rVWCh9w07lOq6Y0509kRqqUrJ+WpwWVXXQkkrh6/3Ek1q2OsRy1GGAUGSixj/PtBjL4JVXCAJIWB/HBpyAh/Wu1BRvHxAdPqVlc5r9bk93qKkD5fUtD5j+MlmitGAph4odCzXjJgqXv6nyxAIz1Jis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LhcvX9WR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DNtwAHbH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bAPA6Q7v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jemp1fb3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LhcvX9WR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DNtwAHbH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bAPA6Q7v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jemp1fb3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B38E66DBF;
	Thu, 28 May 2026 12:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779971654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqVhsaYLjaDcp2Jhh1B5++vesMbYMTp4DxuNEfsGW4o=;
	b=LhcvX9WRXbI4M77aLs5KJdTJVMwy85AFt+38C/HB9DNmKsvmgWc4b3Tn+vmcvIHDPq8zPK
	eeVcYMb6a5RRyJO6fmpgVAHvc4h7dP2uV0WLkWOQk3OfHb3SZvWZHsMNznCHL+1Y/Rajl9
	Be7uowquPJH/kt4bqygLf4olr+elSro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779971654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqVhsaYLjaDcp2Jhh1B5++vesMbYMTp4DxuNEfsGW4o=;
	b=DNtwAHbHjPtMipG5oMDTxfuVO/atF1pDE6nc3UFNz3LlJGZak+chznl5hNzvtY/VBca4ru
	iAvoZvfzx8QuEIAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bAPA6Q7v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jemp1fb3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779971650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqVhsaYLjaDcp2Jhh1B5++vesMbYMTp4DxuNEfsGW4o=;
	b=bAPA6Q7vn/iNwcHmMGmAYA/jDmMBq8XDlE4FUQSIP54uy/ZWKdZqmruuX9EeDTPOZMDeSD
	BKix1X4seEnp20TRIgKj+dOeTCPsCNIuxNltJ/aazNV9U0mJif13BWxBYyjtSnu7pshVrb
	kOzv4wv4v1JRBPkw89j9Ltp+s716ddM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779971650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqVhsaYLjaDcp2Jhh1B5++vesMbYMTp4DxuNEfsGW4o=;
	b=Jemp1fb3K9xUAMIqNGd9IJeQxDIbY5i1kcaPbcGqWDy93w9N34PPprdtR9Z6yS/hKuxhA0
	jjIS/j67TG5CgaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F9155ADB1;
	Thu, 28 May 2026 12:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jxaYC0I2GGqWBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 May 2026 12:34:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CBFB4A0905; Thu, 28 May 2026 14:34:09 +0200 (CEST)
Date: Thu, 28 May 2026 14:34:09 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3B38E66DBF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,szeredi.hu:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 26-05-26 18:42:35, Joanne Koong wrote:
> On Tue, May 12, 2026 at 1:56 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Fri, May 8, 2026 at 2:42 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > Miklos, could you share your thoughts on this? Are you in favor of
> > > > disabling default strictlimiting? Or do you prefer to have it kept
> > > > enabled by default, with some mount option or sysctl added for
> > > > privileged servers to be able to disable strictlimiting + enable large
> > > > folios if they use the writeback cache?
> > >
> > > So what I think we should do is implement some sort of slow writer
> > > test, and see what happens with and without strictlimit.
> > >
> > > Tried to ask claude to do this for me, but not getting very far.
> > >
> > > So if I take this maintainership role seriously and not let myself
> > > drown in the details, then the logical thing to do is to delegate ;)
> > > Which is hard (for me at least) but I'll give it a try...
> > >
> > > Could you please check how things change if there's limited writeback
> > > rate and we disable strictlimit?  And what happens if there are
> > > several such instances running in parallel?
> >
> > I think for unprivileged fuse servers, strictlimting will always need
> > to be enabled or else a malicious user can launch tons of unprivileged
> > servers and eat up the global dirty page budget / starve writeback for
> > the rest of the system. Similarly for privileged servers, it could be
> > unintentionally slow or buggy and eat up the dirty page budget. I'll
> > read through the writeback throttling code to verify this and run some
> > local tests.
> 
> I read through the writeback throttling code and re-read Jan's very
> helpful comments from this thread last year [1]. So for unprivileged
> servers, I think we definitely cannot remove strictlimiting. If the
> fuse server is slow or unresponsive with writing back the pages, it
> will take up too much of the global dirty budget which will degrade
> write throughput for other filesystems (their throttling will be
> computed against the global dirty page count, eg the freerunning check
> in balance_dirty_pages() and the pos_ratio calculation "pos_ratio =
> pos_ratio_polynom(setpoint, dtc->dirty, limit)" (dtc->dirty is the
> global dirty page count)) and any fuse stuck dirty pages are
> essentially unreclaimable. Without strictlimiting, there will be no
> hard cap on how many dirty pages a misbehaving server can accumulate.

Yes.

> With strictlimiting on and large folios enabled, the problem is that
> the large folio size can potentially dwarf the server's dirty budget,
> which can lead to excessive throttling. When I ran my benchmarks last
> year, I and independently Jingbo saw severe performance regressions
> for buffered writes with large folios (eg 2 GB/s BW w/o, and 200 MB/s
> BW w/) [2] but I think that might have been because the machines had
> limited RAM, resulting in a very small dirty budget. Fuse sets the max
> ratio of the bdi to 1% of the global dirty threshold, so running
> through some napkin math:
> 
> On a 64 GB machine:
>   - DirtyThresh = 20% of 64 GB = 12.8 GB
>   - BdiDirtyThresh = 12.8 GB / 100 = 128 MB
>   - 128 MB / 2 MB folio = 64 dirty folios
> 
> On a 32 GB machine:
>   - BdiDirtyThresh = 64 MB
>   - 32 dirty folios
> 
> On an 8 GB machine:
>   - BdiDirtyThresh = 16 MB
>   - 8 dirty folios
> 
> On a 8GB machine (with assuming vm.dirty_ratio=20% and
> vm.dirty_background_ratio=10%), we get 12 MB of freerun, 4 MB of
> proportional throttling, and then full throtttling starts at 16 MB.
> With 2MB folios, the 4MB zone between freerun and f ull throttling
> doesn't leave that much room for the balance_dirty_pages() logic to
> adjust the dirtier's speed, which I think causes the writes to
> oscillate between freerunning and then being fully (overly) throttled.

Thanks for spelling this out. Even with 64 dirty folios effective limit I
think the throttling code will be too unstable. In general I think we
should aim at having at least ~512 (gut feeling estimate ;) folios in a
dirty limit to have a decent wiggle room for the throttling algorithm.

> I think this is also going to be a problem for cgroups with large
> folios since they also, as I understand it, are constrained with a
> limited / tight dirty budget. I ran some initial benchmarks with
> cgroup memory constraints on NVMe and saw similar instability (a
> single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> 15 ms without the cgroup, with the balance_dirty_pages() throttling
> oscillating rather than settling near the set point).

Ok, so this is more folios (819) than my 512 gut feeling estimate :) What
was the write throughput of the NVMe drive? The high drive throughput also
requires more dirty data to keep the drive saturated so that writeback
throughput doesn't oscilate too much.

> I think this problem gets untenable for random writes with large
> folios, since dirtying just a few bytes will charge the whole folio
> size to the dirty budget. I have a patchset from last year for adding
> more granular dirty/writeback tracking [3], I'm going to pick this
> series back up. I think it will be useful generically, not just for
> fuse.
> 
> For getting this to work on fuse servers with strictlimiting, I think
> the next steps are to
> a) as Jan had suggested in [1], come up with some heuristic to
> constrain the max order supported for large folios for these fuse
> servers if they're running with the writeback cache enabled
> b) benchmark ^ and if there are still regressions, then we should
> probably just turn large folios off for these servers

Yes, as we briefly discussed at LSF, picking proper max folio order is
useful not only for dirty throttling but also for memory reclaim in
general in memory-constrained environments. Strictlimit is just one of the
cases where the limit is very small and so the problems with the memory
overhead of larger folios become very apparent.

So although we may decide for a FUSE specific heuristic setting the maximum
folio order, you properly point out memory limited memcgs will see similar
issues so I think a more general solution for selecting sensible max order
would be better.

> c) add the granular writeback/dirty accounting for large folios

As Miklos pointed out and I think we've discussed that also last year since
the full folio is pinned in memory by a single dirty fs block (or whatever
is going to be your unit), finer grained accounting alone doesn't help you
with the narrow limits. We'd also have to add logic to decide about
splitting large folios.

> d) look into improving the balance_dirty_pages() throttling logic to
> handle narrow gaps between the freerun and full throttling zones
> better and reduce over-throttling

Sure, this is always a possibility but this is easier said than done :) If
you get very coarse-grained signals, there's only so much you can do to
smooth out the behavior for the application. But the erratic behavior with
8GB memcg is certainly something I'd expect to work reasonably smoothly so
starting with investigating that case might be a good start.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
