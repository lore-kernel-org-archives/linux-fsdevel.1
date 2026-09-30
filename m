Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B34CDDD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770120; cv=none; b=rJqVCnPdv83q1LkbQHf+5QslQ7l0uWkSf/d9SkUt1+3G8uehONY6q3zhpKrJMlxLoErg5n1bXponxCgCw0SRbuNgPOw32Y2aJ/reBQs1/ll3Ql0ev45YqBtrL/m7EXU0clmeerAEVgLPSfUYU0LmGAfk+qH7I+sdmHRVQOkz0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770120; c=relaxed/simple;
	bh=TcPo3OnPL6RO7WwH35+drtHu3m/6Ime40gJXU1+/524=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4ccA3LyZWsdnFMuYGFnqrgfFq4Ccqgp+CEeRH9fqXcIhJBW7LJq6BTskYliog9KQz9zqiRVMTLFHqBOd3RcSSlsh9b2rIdc1KNK+yZ3Kd1Mm5/6Fv8WLqNi2/l7NHQHaifFRlm1uH5BjS+D5ss2se3i29ggLPfs9VRuYF8CVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5ufWsKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5ufWsKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743031F00893;
	Wed, 30 Sep 2026 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770118;
	bh=TcPo3OnPL6RO7WwH35+drtHu3m/6Ime40gJXU1+/524=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a5ufWsKrcz4aVVeiS2LCppb3IIMjw1/skgfG51rMMiuR1Cwsaqgwk5mBKeB7BU7sn
	 efotMRaP2USZwSZxh4AvS3COM1aJMENH8ObZc/PcRWd44rW3MGcTSsu67+WWqASVZI
	 IkfgiZYJc89rCjz7ReygeiX/oIO5DurXn8JyRfh2oMw345y83H0tfgjrdsYdTGvpIR
	 Dxi6fZmytbZzlR6eiTMKDEabXT4REPyJlqYkwTbZyY+ymKqMrkxaHpEI/FS+7Zvjlq
	 8P5+Z21mddvvuiul9gM6O0XF5NLZqmCc+OBmtwllbUnjvUCiAzXkzd1YGscHYljHQo
	 YaO/H9TXZJbfg==
Date: Wed, 30 Sep 2026 13:08:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <arz0auULA33fqoWu@gremlin>
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
 <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>

On Wed, Sep 30, 2026 at 06:27:14PM +0800, 天狼 wrote:

> > You really need an actual file on disk. Shared memory / shmem / memfd is
> > not sufficient?
>
> Yes, an ordinary disk-backed file is the intended output, and subsequent
> consumers access it through mmap.
>
> Shared memory can preserve state across a process crash if the shared
> object remains alive. However, using shmem/memfd would introduce a separate
> staging and transfer step to put the data into the final file. Building
> directly in a file-backed MAP_SHARED mapping lets us preserve the latest
> userspace writes across process crashes and retain the same file-cache
> pages for subsequent consumers.

In general, writing to files through MAP_SHARED mappings is discouraged.

>
> > I also assume MAP_PRIVATE mapping the file so it's anon CoW'd is not
> > sufficient either?
>
> Correct. With MAP_PRIVATE, modifications remain private and are not carried
> through to the underlying file. If the constructing process crashes before
> transferring those modifications to the file, another process reopening the
> file cannot access them. That would lose the process-crash survival
> property we obtain from MAP_SHARED.

But you can solve that with a memfd?

>
> > It'd be problematic to effectively corrupt the page cache by saying "hey
> > this is dirty but just clear dirty state and pretend this is what the
> > disk has".
>
> To clarify, the proposal does not involve clearing dirty state or
> pretending that memory and disk contents match. The pages would remain
> dirty and continue to count toward the existing dirty-page limits.
>
> The requested hint only expresses that the application expects to modify
> the data again soon and would prefer background writeback to happen later.

But that's the same as saying 'don't writeback'?

When there's a lot of dirtied pages on disk writes are delayed in proportion to
how dirtied with various other heuristics taken into account.

I don't see how this requested feature wouldn't just give programs a way to work
around that, meanwhile everything else doing dirty writeback are _impacted by
the dirtying that the requesting process has done_.

That seems really problematic.

>
> > Delaying writeback could interfere with the writeback balancing logic.
>
> I understand that concern. The hint should not exempt the application from
> dirty-page limits or throttling. If writeback is needed for balancing,
> memory pressure, or explicit synchronization, the kernel should override
> the hint.

Hmm.

The delay before background writeback happens is, by default, quite long,
until you have a lot of dirtied pages.

dirty_expire_centisecs defaults to 3000, i.e. 30s before it is considered
for writeback.

And then that only happens every dirty_writeback_centisecs, defaults to
500, i.e. every 5 seconds.

If you're not writing to the mapping within 5 seconds even, let alone 30
seconds then that seems like an issue with your program.

I guess you are re-dirtying again with later changes, but the _triggering_
of writeback is at an inode granularity on dirtying - so you want to delay
writing back some pages because later pages are not meaningful?

All the while you are adding to the total dirty pages but not paying the
price anywhere, nor allowing the dirty page count to reduce.

Unfortunately there's no real way to avoid the per-inode thing, and
delaying valid writeback there because SOME of it isn't 'valid' is not
really sensible.

Either that, or you are actually concerned when there are enough
dirty pages to trigger background writeback i.e. dirty_background_ratio is
exceeded (where the above limits don't apply).

But later you say you don't want the proposed change to impact how that
behaves (the balance_dirty_pages() logic), which contradicts that.

So are you taking ~35s to actually write to this properly?

And is it that you're wanting the _triggering_ of writeback to be
per-folio? That isn't really sensible.

And nor is it really to delay writeback for dirty folios because later ones
are 'invalid'.
>
> The intended benefit is to avoid writing intermediate versions when the
> kernel has room to defer that work. There is no requirement to prevent
> writeback until construction finishes.
>
> madvise is not the only option, deferring writeback for the entire file
> would also be acceptable.
>
> Could such an advisory preference be accommodated within the existing
> writeback balancing policy while retaining its limits and fairness?

I think the fundamental friction here is that you're charging a cost to a
global limit then doing something that prevents that cost being paid (you
can't writeback), and meanwhile the process can wait for arbitrary time
before having to write to it.

And the fact that it is taking you so long to actually write what is
intended there that this matters suggests to me there's something wrong
with what you're doing here.

I'd say in general the shape of the solution would be something
cgroups-ish, but since all of this is global stuff and the knobs are all
global I think you need to think about your design a little more.

Having a process that is kept around maybe with an appropriate OOM score
that issues a memfd would get you the sharing even if process dies stuff,
and then it can periodically write to a file when necessary.

I think that'd work a lot better, and I don't really see a kernel change
here that would make sense.

All in all my intuition is that you're looking for a kernel solution to
something that should be implemented differently in userland.

And in general we've seen a pattern of 'writes to MAP_SHARED, experiences
problems' before.

And the solution is generally - use something like memfd, have a process
that does writebacks manually for you as you need.

So I strongly suggest you do that! :)

--
Cheers, Lorenzo
