Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A243DEA4
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672372; cv=none; b=rM2k+YKi+nYy6y2uWbhwe7WSzVKHWALRmh2A1TZxyf+Ef4OaYfelEyWaMRQh8UUwzaQN2HP9OY540Q0eF+Ket8r8oHnFujyycozI+VvdaPob765Ja/44jD+ccjMll1Xeu0C+MVXYfReUirziuCuTEfSc+P1bzCgzpd/k7KTPp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672372; c=relaxed/simple;
	bh=RH6NqdFwbzWFb6zeZpuetJKrjnA6GtjWSMB/X9fu530=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNxplnTp5WrcRoNl1McblraUidcG4rcmsmhysRq7/43OpG42DJeLQxhGPqteA1ubQq6GQORtSJXzpJk0ekkjxHxv4qcilXBnObcFw0GuSAVaOe7+bctNlxrubvGM0iov3SW+2BW8yKHA2WQd0hHD+EZIHcAotjHv+ZU5gVu7M3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sauccq4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sauccq4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6116E1F000FF;
	Tue, 29 Sep 2026 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672371;
	bh=RH6NqdFwbzWFb6zeZpuetJKrjnA6GtjWSMB/X9fu530=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sauccq4nD1vS3R16bUqBJT3/gYHACi8YrQHkU6oyBUDgw+nTiGTFSmsTM0HOTzFxw
	 Ax8SsGH4ZeXvg6DUNr6bvTghN232LZ1keVbNh57zCOyk+IS7ItPXBoJLUkd1L2eyoI
	 drv9e4bnoVjU9RaCLcKMXFuETAdWsBrDZwX3wTy0j5hQYwSdQ/rHdcxPv6oT/XP9l0
	 +ca/RwwEiP79iQR83eW1RLRsRJ4TBKAxdcSC6Cb0nebZX7iD4ow7QRJJDi/tG5PyIn
	 Z+2DfrFg1FiOTkMkTF9P7xVRwvmEuaXc2lUUkpM16GNnaMVS3COBblO36eYihk8yFi
	 oovdCF9gp7OkQ==
Date: Tue, 29 Sep 2026 09:59:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <art8EKRKMdwSDCkr@gremlin>
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
 <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>

On Tue, Sep 29, 2026 at 08:59:57AM +0200, David Hildenbrand (Arm) wrote:
> On 9/29/26 06:06, 天狼 wrote:
> > Hi David,
> >
>
> Hi,
>
> >> What is supposed to happen if the process crashes when updating the
> >> MAP_SHARED region halfway through?
> >
> > The data structure survives an interrupted update through its
> > application-level copy-on-write and lock-free concurrency design. A
> > file-backed MAP_SHARED mapping preserves the latest userspace writes after
> > the process dies, even if they have not yet reached disk, provided the
> > kernel remains running.
> >
> > This does not depend on preventing writeback. Deferring writeback is purely
> > a performance optimization, not a correctness requirement.
> >
> >> It would be helpful if the use case + data structure would be explained
> >> in a bit more detail.
> >
> > The data structure originally used uint32_t offsets instead of pointers to
> > reduce pointer overhead. On that basis, we implemented lock-free concurrent
> > reads and writes, obtaining crash safety for free at the same time. We use
> > a file-backed MAP_SHARED mapping to turn that capability into an actual
> > feature that survives process crashes.
>
> Ok, thanks. Just be sure: you really need an actual file on disk. Shared memory
> / shmem / memfd is not sufficient?
>

I also assume MAP_PRIVATE mapping the file so it's anon CoW'd is not sufficient
either?

> >> What exactly is the problem with writeback here? Unnecessary I/O? Is
> >> writeback the problem or actual reclaim after writeback?
> >
> > Unnecessary I/O. Reclaim after writeback is not the problem I am trying to
> > address.
>
> Ok.

I mean if you're mmap'ing it you're literally mapping the page cache folio and
dirtying that folio.

So the kernel really does have to do writeback and it might be quite problematic
trying to prevent the writeback algorithm from doing its work on a specific
range.

I think the shape of a viable solution really is either MAP_PRIVATE-mapping it
or using some anon shmem/memfd as David suggests.

I think it'd be problematic to effectively corrupt the page cache by saying 'hey
this is dirty but just clear dirty state and pretend this is what the disk has'
or something.


>
> >
> > During construction, background writeback can write intermediate contents
> > that the application will soon overwrite. Those repeated writes waste disk
> > bandwidth. Delaying writeback would avoid that waste where possible; it is
> > not required for correctness.
>
> Understood.

Yeah again delaying writeback could interfere with the writeback balancing logic
which tries to keep dirty page levels sane and is fair and balanced so processes
that writeback a lot get delayed in doing so under heavy dirtying.

I think anything like this would interfere with that.

>
> >
> >> In a fuse server you can in theory delay the writeback request.
> >
> > Thanks for the suggestion. That sounds like a possible way to experiment
> > with delayed writeback. The feature I am requesting would make this
> > advisory behavior available to applications using ordinary file-backed
> > shared mappings.
> >
> >> So fadvise would be an option. However, this "defer mode" is really odd.
> >> It sounds more like you would want to have a custom policy there [...]
> >
> > madvise is not the only option, deferring writeback for the entire file
> > would also be acceptable.
> >
> > The application only wants to indicate that it is still modifying the data
> > and would prefer background writeback to happen later. The kernel would
> > retain control over the actual timing. Memory pressure could override the
> > hint, and explicit synchronization would keep its normal semantics.
> >
> > The hint should also expire automatically when the owning mapping or handle
> > is released, including on process exit.
>
> Ok, so while you are updating the large mmap'ed file concurrently, you don't
> want writeback to go crazy, because you know that you will modify the memory
> immediately anyway.

Yeah see above, I really think the only sensible solution is a MAP_PRIVATE CoW'd
mapping or memfd etc.

>
> Let me CC some more people.

Christian and probably Willy also? But I'm not so sure there's anything sensible
to do here other than something-anon.

>
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
