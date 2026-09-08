Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420F3F9A04;
	Tue,  8 Sep 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857799; cv=none; b=S9dwP4P8SKC1S5DLL/YD3KCKYYxbIlzFuHM8t6OODBrnTIZefDkji6jiH1ISgoELr6WTgILFb0zMz2xrX/z6yyfDDMsQ+TnYOtjJ1qje05n4JaG1mwDvy//k44bngmUP/svRPibOJ5jmfC1KGazeXHyP6FHqt10h1JqlT4SKZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857799; c=relaxed/simple;
	bh=fCVqIxDRV9LfquW63mZtbLxHFF3Bgw1t4t+NoPTxuGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnwhqND4aAY96/EBe5D0qYujqb7HRIGfWzMOPbLiaK9kxytejGBZqBNDENUJyHvWW7zvynO5/17uS8sPxLwGwUE3eGEq9V9Buo3fCnnOiQRZF3gFw5OoqEEn/BsVeAjtB2rSj8Vw5CW2cPCsQsSLTovbPHDHoxemSX6/qITxEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ79rwIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ79rwIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050E91F00A3A;
	Tue,  8 Sep 2026 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857789;
	bh=7GtzElf9EKxZso4ToovIvNR7XDQENlazd7Q/RdkJzdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQ79rwIbEigj2HF6YhUhvrVFLJQeX0d2CLSQ363xGAnSZG2MkP+aC/cHWxuxjEigT
	 Q9iKlYIucsWreXv/r0AS/DJao72+AhIM4G4qUqH3eICYNbwVtWIk4f8PxitVXtpKGu
	 bQDXJT6FWnwWbGoUpuJU2jtftDZrQZUMM9CBy9SMtVmtkPrRmZw9B3tv9063UbazD2
	 3o8ai0gV0j06rkFLJInDR37/FfUAx5ohLnkb3QqIXt7ISK9IaAd7pRr6sHFGUgBe2v
	 Chk6IuG/lChHjaK5tYzvDsc0Nv1SDd3plshDkUuSuKk2kX/09RUfnf8/bWmcYikXNP
	 NWR2zFpjg6ZTg==
Date: Tue, 8 Sep 2026 09:56:22 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/6] tools/testing/selftests/mm: add
 MAP_PRIVATE-/dev/zero merge tests
Message-ID: <ap_LyUQNjxyytDue@gremlin>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-6-a578c730cec7@kernel.org>
 <42c1b1be-d176-45fd-b467-464b5b87e116@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c1b1be-d176-45fd-b467-464b5b87e116@kernel.org>

On Mon, Sep 07, 2026 at 07:08:48PM +0200, David Hildenbrand (Arm) wrote:
> On 9/2/26 20:00, Lorenzo Stoakes (ARM) wrote:
> > Assert that MAP_PRIVATE-mapped /dev/zero mappings behave like they are
> > anonymous.
> >
> > We test both unfaulted and faulted/unfaulted merges - each with the regions
> > having page offset of 0, which would not merge if the mappings were treated
> > as if they were file-backed.
> >
> > With the recent change that makes them behave as pure anonymous mappings,
> > the merges should succeed as their page offsets are equal to their
> > anonymous page offsets.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  tools/testing/selftests/mm/merge.c | 104 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> > index 52b8727b6628..7c528d470404 100644
> > --- a/tools/testing/selftests/mm/merge.c
> > +++ b/tools/testing/selftests/mm/merge.c
> > @@ -1362,6 +1362,110 @@ TEST_F(merge, anon_and_page_offset_mismatch_memfd)
> >  	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 5 * page_size);
> >  }
> >
> > +TEST_F(merge, merge_map_private_dev_zero_unfaulted)
> > +{
> > +	struct procmap_fd *procmap = &self->procmap;
> > +	unsigned int page_size = self->page_size;
> > +	char *carveout = self->carveout;
> > +	char *ptr, *ptr2;
> > +	int fd_zero;
> > +
> > +	if (access("/dev/zero", F_OK))
> > +		SKIP(return, "No /dev/zero.");
> > +	fd_zero = open("/dev/zero", O_RDWR);
> > +	ASSERT_NE(fd_zero, -1);
> > +
> > +	/*
> > +	 * Map two MAP_PRIVATE-/dev/zero VMAs next to one another with offset 0
> > +	 * each.
> > +	 *
> > +	 * With these being made truly anonymous upon mapping, they will
> > +	 * merge. If they were file-backed VMAs the page offsets would prevent
> > +	 * merge:
>
> Nit: "the" merge? You're the native speaker, so I don't know if what you have is
> just correct :)

You're right ;) native speakers are not immune from messing up grammar, as my
copy editor will tell you :P

Will fix up on respin.

>
> > +	 *
> > +	 * |-----||------|    |-------------|
> > +	 * | ptr || ptr2 | -> |     ptr     |
> > +	 * |-----||------|    |-------------|
> > +	 */
> > +	ptr = mmap(carveout, 5 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
> > +	if (ptr == MAP_FAILED) {
> > +		close(fd_zero);
> > +		ASSERT_TRUE(false);
> > +	}
> > +	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
> > +		   PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
> > +	if (ptr2 == MAP_FAILED) {
> > +		close(fd_zero);
>
> Is the close() really required before the ASSERT?  After all, you're also not
> munmap'ing, so I wonder to which degree we have to clean up.
>
> So maybe this could just become a
>
> 	ASSERT_NE(ptr2, MAP_FAILED);
>
> Same for ptr above.
>
> You could likely also do
>
> ptr = mmap()
> ptr2 = mmap()
> close(fd_zero);
>
> ASSERT_NE(ptr, MAP_FAILED);
> ASSERT_NE(ptr2, MAP_FAILED);

Yeah that's easiest I think! Will fixup on respin.

>
> > +		ASSERT_TRUE(false);
> > +	}
> > +	close(fd_zero);
> > +
> > +	/* Assert that they merged. */
> > +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> > +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> > +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
> > +}
> > +
> > +TEST_F(merge, merge_map_private_dev_zero_faulted_unfaulted)
> > +{
> > +	struct procmap_fd *procmap = &self->procmap;
> > +	unsigned int page_size = self->page_size;
> > +	char *carveout = self->carveout;
> > +	char *ptr, *ptr2;
> > +	int fd_zero;
> > +
> > +	if (access("/dev/zero", F_OK))
> > +		SKIP(return, "No /dev/zero.");
> > +	fd_zero = open("/dev/zero", O_RDWR);
> > +	ASSERT_NE(fd_zero, -1);
> > +
> > +	/*
> > +	 * Map a MAP_PRIVATE mapping of /dev/zero with page offset 0, then fault
> > +	 * it in:
> > +	 *
> > +	 * |-------------------------------|
> > +	 * |           faulted             |
> > +	 * |-------------------------------|
> > +	 */
> > +	ptr = mmap(carveout, 15 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
> > +	if (ptr == MAP_FAILED) {
> > +		close(fd_zero);
> > +		ASSERT_TRUE(false);
>
> Same question regarding cleanup requirements. The ASSERT_TRUE(false) looks a bit
> odd.

Yeah it does. This case is trickier as you then do a memset(), so maybe just
live with the 'leaked' fd in this case (the tests fail so it aborts the run at
that point anyway and tears down).

Fixed and will send respin!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
