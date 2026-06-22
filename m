Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7233B3BF2;
	Mon, 22 Jun 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136521; cv=none; b=GLqbW8BpGf+X+3KxgMDf/2Ltsa4N5qYAs2TQicMOGjOYW7tM4Xa97DtoBwY9i7Bp3nwCzCtz7AP9WJ2emkI9d5yKRjYGGrQ0mJWUzaseJM8Mvuvze4DkaSVl9RVMy026gfaqS5rXtCttAsxXmhcsLyZtrv5FkhAYx4lWt9LqJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136521; c=relaxed/simple;
	bh=WR8JaOyvOHAgMGRMKwcmZNAzbrMi4mXCubOn7cewWUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFUIJ45QwyaUzv8RAxshn9/9MDPYFdLfuIumf7OV+wFN4ltl1CAza862AfGdCLLzEcRV2kq6RSFiXNubyYIYuCnQwffEqrWkTjlyDhDGj8l2uhz7sQTTPUt+X9y4evT4o/aI7Lex2FB+WrIq77DOjiuGzHqcEkqHMBbqNtlwy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ6z0MOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ6z0MOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39FF1F000E9;
	Mon, 22 Jun 2026 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136520;
	bh=lSv61ssW4qc4Rb4nc4Phm6/rZ5E/q8Nhnm6lGxqv4Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJ6z0MOip6YxUE4QsGFzORnLmafH/OnigpV21qukMVYRjfSY7Tsrjc92QtgKm5w4I
	 3imxnlKh9MwMmv3DxMMiqLKWXDM1/BXGwXmyVv3Zer8gkU1QXWiT9QvM+1ryxggTe0
	 6E+aPbM6i2QcA4XQew8aC4ekzIRtinhc67pYlJ9Lp1/qqT1JmOYHB22HNMFHStC1PJ
	 lkZrJb6Dt5cHfxO2BjWOtnubPFQgteMBHeWVUzg4sp5h4F8sCkxHxsUyqVNdTXbqoT
	 OLM8CXWX6wn0RynGvsgsfobUxn7jMkNeYTAdUhSlN1h8JqnYDPzS17ujkxcs3/+5hJ
	 v1+pLsnAMIvTw==
Date: Mon, 22 Jun 2026 14:55:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajk-NMghY50F6Sli@lucifer>
References: <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
 <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse>
 <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org>
 <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan>
 <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
 <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>

On Mon, Jun 22, 2026 at 11:26:18AM +0200, Jan Kara wrote:
> On Fri 19-06-26 12:33:43, Suren Baghdasaryan wrote:
> > On Fri, Jun 19, 2026 at 12:26 PM Pedro Falcato <pfalcato@suse.de> wrote:
> > >
> > > On Fri, Jun 19, 2026 at 10:52:07AM -0700, Suren Baghdasaryan wrote:
> > > > On Fri, Jun 19, 2026 at 10:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Fri, Jun 19, 2026 at 10:43:06AM -0700, Suren Baghdasaryan wrote:
> > > > > > > Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess the
> > > > > > > pattern may come up time and time again for people doing chunked mmap
> > > > > > > reads. I think we need to take a closer look at this change.
> > > > > >
> > > > > > Frame-by-frame mmapping for a streaming workoad is quite questionable
> > > > > > IMHO and I don't think we should be optimizing or encouraging such
> > > > > > usage, but I understand the reasoning for the revert.
> > > > >
> > > > > If userspace is properly tuned, it doesn't need automatic readahead
> > > > > at all; it can disable it and issue manual readaheads.  The point of
> > > > > automatic readahead is to cope with userspace which is doing stupid
> > > > > things like calling read() for a single byte at a time.
> > > > >
> > > > > Could it have better defaults?  Maybe!  It's worth a try.  But those
> > > > > attempts need to have a very low bar for reversion when it turns out
> > > > > they affect other workloads.
> > > >
> > > > That what I meant in the last part of my reply :)
> > > >
> > > > But in general, I think that benchmark measuring "how many frames per
> > > > second a CPU can encode" should be revised so it doesn't depend on
> > > > file prefetching mechanisms. Otherwise it's measuring something else.
> > >
> > > To be clear, that's not (necessarily) a benchmark, the code we were
> > > looking at is their encoder app.
> >
> > Ack.
> >
> > > (it's also generally not possible to prefetch the whole thing into RAM
> > > because, well, raw video files are quite large)
> >
> > For such streaminig workload I think read() would be more appropriate,
> > and the change limiting read-ahead by VMA size would not affect it.
>
> In fact if you look at that app, it has three different methods of reading
> the input frames (mmap, normal read, fully buffered file in memory) and one
> is chosen based on config option. So the benchmark apparently configures
> the mmap method of accessing the input file.
>
> Anyway I agree with you using mmap-frame-by-frame approach for this usecase
> is kind of odd but not completely insane and it does demostrate people do
> odd things like this. For others the usecase of Android doing tons of small
> sparse mmaps into executable might look odd as well :) So this seems to be
> one of the cases where it's difficult to please everybody with the same
> behavior and we usually stick to the legacy behavior in cases like that (as
> much as I personally find restricting mmap readahead to a VMA a sensible
> thing to do). We just need to figure out how to improve the Android
> usecase.

Reading the thread, I think we're all in agreement that this is a workload
that exists and we are regressing it here, thus the revert is the right
course of action.

Andrew - could we move this to the hotfixes branch please?

>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thanks, Lorenzo
