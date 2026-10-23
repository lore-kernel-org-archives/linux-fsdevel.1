Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747071;
	b=0xcaSPOS8dSjFxDy5XN59169BsU1XDLhf2WYzoWcRxdwLGU98vtZcrZviJXqd3FN82UO
	 E+bKzMiAbiQcKSNpKJAIaxKF59bF8W0ugVthoomr46DNdB0vkMr5ekfYBmTzbcSBLJF3z
	 l2lHRlCNt6YXKNqxH/llgCrsXV3GiPebxEVYG1CBAfWlKF+1R2n44dPq+r66psu+uwQcB
	 k5v8C5s/KwtoC1EfS00C1mrbMa7PxszXI1jDsgzg7fAl12BkO690li6TYQF8owg99n3hh
	 DBUMcZK0nxUDuBfOjqdndDWSaUbujB+te21D9i9jItpQrzgeAoKCBFWaeGBfAJKDN9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747071;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G9hhphCfXkWd1gXgevV297lbX/bMFLQG58MmKTmaWao=;
	b=kYrPS8Wq16Rk0QXEcNYnZRcDaGr1rE+qIFanglfDLERrw59465yf3L/i+gLe5R17u2UT
	 fAQZNH1nzBf9jbrHrQc5hktyO5N4o+/8tEsMQyUTmMp9vERIxcgRCNpAqebgPpPJHQf2z
	 3sMdo8gv1GtkbPW+TraG3NrOryHDjTcQjAiwRW6MTsx285W64+Pt1fwrPHu4skxEKrcij
	 DvmxOiteKfLFRQHZALTMYZLnnZH8FRjdtaxEOzhqlOBrJNLRRcpeRqqNyqjKwJxxxWzDo
	 mLIojuCGeGdFgZ1PFdq+pNk6iIS08ET3vzgbU3O4zMKzlhdj0LE7u3Ln5TJNnOF6LCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaKroY9Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D3606A31A;
	Fri, 23 Oct 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaKroY9Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE271F01825;
	Fri, 23 Oct 2026 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747071;
	bh=G9hhphCfXkWd1gXgevV297lbX/bMFLQG58MmKTmaWao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GaKroY9QzHsWaUe/EZC3VG9JBoYLi/XSpfpnK7nFGGJYGwPlAT/lyJleZ9II1JCEJ
	 o0sIgPQT3AUXy7APbcUMIvYBRUBjm6Vec5PIECcwHyxMX9R7aBCTOvCabrXt+5sHnY
	 r2K0AfemTVNGjECZ3QrGBuq3O45Ck2LArpozXHL8DspxtbIlWCXE8bHXeBtSuLQfma
	 hsUUlj57mOdi8XpIbbrKBGfbhjTnRDG+o9GT6G46vGqZ3WBq8ik7XrTY4T8jgSxr1t
	 LQN5YQ6Hu7wn0B9uYwMqwNTXUZKxNrAtwkHD6CmSXr6uXXtSdYC3SdeYL2sVU4vfP/
	 3gCMRbqL1aCVw==
Date: Fri, 23 Oct 2026 11:17:44 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sysctl: add typed field descriptors
Message-ID: <atsmOMeBfkMQgzQV@example.org>
References: <cover.1789987960.git.legion@kernel.org>
 <cover.1790439358.git.legion@kernel.org>
 <aszj54qPIdorUTO8@example.org>
 <atoDngZsxy3TWmO_@hobbes>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atoDngZsxy3TWmO_@hobbes>

On Thu, Oct 22, 2026 at 04:04:39PM +0200, Joel Granados wrote:
> On Mon, Oct 12, 2026 at 03:43:03PM +0200, Alexey Gladkov wrote:
> > On Sat, Sep 26, 2026 at 06:22:07PM +0200, Alexey Gladkov wrote:
> > > Hi,
> > > 
> > > Some sysctl users copy an otherwise static ctl_table for each namespace or
> > > device, then replace data and limit pointers before registration. Besides
> > > the per-instance allocation, these fixups often depend on table indices:
> > > reordering an entry without updating the fixup can silently bind it to the
> > > wrong data or limits.
> > > 
> > > This series lets such users describe a table once with static, read-only
> > > sysctl_field entries. Each field names a data type and an offset into an
> > > object selected by a sysctl_context at registration time. The offset
> > > helpers check the member type at build time. Limits and custom handlers
> > > remain optional properties of a field; the field type does not encode a
> > > choice of handler or whether limits are present. A subsystem that needs
> > > more than a namespace can embed sysctl_context in its own registration
> > > context.
> > > 
> > > The sysctl core keeps the context with the table header and materializes
> > > a ctl_table entry when an existing handler, permission check or BPF hook
> > > needs one. Legacy ctl_table registrations retain their own path, and
> > > subsystems can convert tables independently. The IPC, mqueue and ucount
> > > conversions here remove table copies without changing their backing data.
> > > 
> > > Changes since v2:
> > > 
> > > - Drop sysctl_uint_vals, as requested by Joel. Existing limit constants
> > >   suffice for these conversions.
> > > - Drop the *_MINMAX field types. A field's type now describes its data,
> > >   while optional min/max pointers supply bounds to the selected handler.
> > > - Keep __register_sysctl_table() and __register_sysctl_fields() as separate
> > >   registration paths, sharing only allocation and tree insertion helpers.
> > > - Address the sashiko findings: avoid calling mode_fn under sysctl_lock,
> > >   validate the effective maxlen against the context object, and reject
> > >   NO_DATA fields paired with standard handlers that require data.
> > > 
> > > This is the first part of the conversion. Network sysctls and other
> > > subsystem-specific users will follow in separate series for review by
> > > their maintainers.
> > > 
> > > 
> > > Alexey Gladkov (5):
> > >   proc: sysctl: address table entries by index
> > >   sysctl: add typed field descriptors
> > >   sysctl: ipc: use typed fields for IPC namespace sysctls
> > >   sysctl: mq: use typed fields for IPC namespace sysctls
> > >   sysctl: use typed fields for ucount limits
> > 
> > Gentle reminder about the patchset.
> Thx for persisting and sorry for the late reply.
> 
> The more I look at this, the more I am convinced that the first problem
> that we should address is having a .data, .extra1 and .extra2 as void
> pointers. Once that is out of the way, then we can focus on getting rid
> of the kmemdup of the ctl_tables.
> 
> Motivation
> ==========
> 
> Here are the motivational points for this series:
> 1. Remove the per-instance allocation thereby reducing the memory
>    footprint
>   * This one is relevant for instances with lots of NSs.
> 
> 2. Remove the possibility of mistakenly associating one variable with a
>    different sysctl name (because of un-synced changes)
>   * This one is the least important for me. Keeping it synced is a
>     little scary but something that I would be willing to live with.
> 
> 3. Type checking .data, .extra1 and .extra2. "unambiguous pointer" that
>    answers what it is.
>   * I think if we are serious about type checking, we need to fix the
>     existing (potentially uneeded) void pointers (.data, extra{1,2}).
>     Which is not an easy as there are callers that (mis)use these in
>     different ways. This has been discussed before (in [1,2,3] among
>     others)
> 
> 4. Don't bleed caller structs/types/logic into sysctl.
>   * This one is mine and is the reason I really don't want it done in
>     the manner that you propose. IMO, having network (or other callers
>     logic) inside sysctl makes no sense.
> 
> I'll come back to these series after having yet another look at the void
> pointers in ctl_table.

In that case, I'll step back with my patches for now.

Thanks for review.

> Best
> 
> [1] https://lore.kernel.org/all/87zgpte9o4.fsf@email.froward.int.ebiederm.org
> [2] https://lore.kernel.org/all/875xyczpzm.fsf@email.froward.int.ebiederm.org
> [3] https://lore.kernel.org/all/cover.1739115369.git.wen.yang@linux.dev
> 
> 



-- 
Rgrds, legion

