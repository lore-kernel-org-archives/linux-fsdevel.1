Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794748846;
	b=yCDsXY8uM+73Hwfo0sruOaFq6tQk84Clg+DO71LBBQ/n4r+3F7DQW9qBh4Eo+Dgt8I9P
	 8fzmH1EDtdOUCtjX7zqbqcQzKIDXPNZRF5dT/2spdW9uqQ2+jngxnbizvoXEZ+qWy/CvC
	 EGuLlRtfvPi+bk8lVQaOp7GImkSqVxFUZ+6lGQ0SkVgg+ykUkxJbR5BrvRC94JwkMz9EU
	 strfznZPNFRWWLIP9UoGXaRj8kdYIiVhNL3znBvwJ+YFXj3xngFZpU/E0nUYuGI63CsbJ
	 Ad2R8PaOvqwrPRoyYIBesheOn+b+jqEZEYwmk4zdBWKkUoNzz9soeW/zOW9aCYYicEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794748846;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3HSpYZj6YASoJA+imXKaJoXcMOdYb9Ti1RP9kq2Y2hg=;
	b=mW1IhsgH+dEI0c+81V7XTgHXJbGCP4IMootAISrPvwwbEZOYzGfUAZ84DEumMmFu6rKE
	 PmstZse2sjp8o25xeGLvVXMiGBZVVdB0UPMuBFw+QF/deygS9WqT211wJXApHBLBF0P6p
	 L9Vq8DQXEg5bewXzKh3DsDk5EXRsf/m++E7iiOBvgNAHGmlejHoSvmIFpeTvPVjVjObks
	 +KROkg9zyWVigfl525HtqMqycqzHL+CtRFSrVvIzx3ktrGHn3/y0JZoneEB0gshEX4g1k
	 nlUyzg9WcZo8BeY9dSCBz9wxFqz7Cevxe3mgur+ccBBWYmY2YXdSsvJVaEHCc+gk/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRjjD37o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012D606A31A;
	Sun, 15 Nov 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRjjD37o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70FA1F000C5;
	Sun, 15 Nov 2026 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794748846;
	bh=3HSpYZj6YASoJA+imXKaJoXcMOdYb9Ti1RP9kq2Y2hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DRjjD37o9epMl9rk++f6bxSbCSOylmn8X7S+JIBOaotMK/yq/ad86XJXU6Tx889av
	 7JFOn/doiAJ1dCfAxgMQoi6QHqXNO3KHdQYaCTvDEwU3QHe67DCPbcHpd01kUOeZAQ
	 2dhgQfZLgdawl5jkYieWz/gj+I3Vg2u7DFBu1mkQ9UU27HcpoJnCJDTM8o67T+4glw
	 G5KqZsTL2Rdkjp17sKIxEHEolEcG6sTtZ66w4TI6zWkMBiVtfK1t0kCaEOtpse0CnB
	 Y20RM1wwrg1TVRpjG16LjHhUHSt8f6X7EaQ5q6W6RiH6Y6QEDGhzY7Ux26AGrwho7X
	 /vBXHf7wO+6kA==
Date: Sun, 15 Nov 2026 13:20:33 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 11/13] percpu: fix contig hints that are too low
Message-ID: <avmpMjM-nrzifxYP@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-11-50a2ed382b61@kernel.org>
 <20261114115708.18fff016c293a57b@chrisdown.name>
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
In-Reply-To: <20261114115708.18fff016c293a57b@chrisdown.name>

Chris - a lot of your replies here seem LLM-generated, and this one in
particular seems especially so.

I've been working evenings and weekends to help with the workload doing
_human_ passes over already AI-generated fixes, so please have a little
consideration for that + keep replies to technical points and as succinct
as possible, thanks.

On Sat, Nov 14, 2026 at 11:57:08AM -0800, Chris Down wrote:
> Hi Lorenzo,
>
> Lorenzo Stoakes (ARM) writes:
> > Secondly, when a free stays within one block,
> > pcpu_block_update_hint_free() passes the end of the free area to the
> > chunk hints as a block offset rather than a chunk offset, so in any block
> > but the first the chunk hints are not updated at all.
>
> Joonwon Kang sent this part earlier this year as "percpu: Fix wrong chunk
> hints update" [1]. It has Dennis' Reviewed-by, but as far as I can tell it
> was never picked up. The rest of that series goes after the scan_hint
> problems by fixing how pcpu_block_update() maintains scan_hint, rather
> than by dropping the promotion, and Dennis was still reviewing that in
> May [2]. It touches the same code as the first case here, so the two won't
> apply on top of each other. It's probably worth adding Joonwon to Cc and
> working out between you which one goes in first.

I'm sorry this is (AI-generated?) nonsense, that's not at all how kernel
development works.

This is a series that got stalled 6 months ago and does things other than
this fix. That doesn't put an indefinite hold on future work in the area,
nor does it give the submitter a veto or say on future work.

So the submitter is welcome to resend and rebase on the fix.

In general, given that this is a drive-by review, with respect, please try
to stick to technical issues, thanks.

>
> > Thirdly, that free area stops at the block boundary, even if the free
> > bits continue into a neighbouring block.
>
> Wasn't this one deliberate? The comment this patch removes says that
> chunk_md->contig_hint may be off by up to a page, as a tradeoff to avoid
> iterating over the block metadata on every free. I don't mind changing
> that, but it'd be good for the changelog to say so, because any free
> whose area reaches a block boundary now ends up in
> pcpu_chunk_refresh_hint().

'I don't mind' :)) for some reason you (or rather persumably your LLM) has
adopted the tone of a component owner which isn't quite appropriate here,
let's maybe try to avoid that in future thanks.

The changelog already covers this, it states that a contig_hint must never be
smaller than the largest free area, and lists this as the third way in
which that is violated.

That it was done on purpose doesn't make it less of a bug - the hint being
too low is what causes pcpu_find_block_fit() to reject a chunk that fits.

>
> > Fix these by always rescanning when a contig_hint is broken, passing the
> > correct offset, and refreshing the chunk hints whenever a free area
> > reaches a block boundary.
>
> Similarly, da3afdd5bb54 ("percpu: use block scan_hint to only scan
> forward") and d33d9f3dd96b ("percpu: use chunk scan_hint to skip some
> scanning") added the scan_hint promotion to avoid exactly these rescans,
> so do you have any numbers for what always rescanning from first_free
> costs on the allocation path?

Nope, I am reworking AI-generated fix patches and this is currently broken,
it doesn't require perf numbers. It needs to be made right first.

In any case the block rescan is bounded at PCPU_BITMAP_BLOCK_BITS and this
issue only happens if a contig_hint is broken.

>
> The result does look right to me, though. From a quick check with the
> hint code lifted into a userspace harness and random allocations and
> frees thrown at it, contig_hint regularly ends up below the largest free
> area before this patch (for both blocks and the chunk) but is fine after
> this patch is applied.

OK thanks.

>
> [1] https://lore.kernel.org/r/20260513085117.1024175-1-joonwonkang@google.com
> [2] https://lore.kernel.org/r/ahVWu38ymnSeLnv3@palisades.local
>
> Thanks!
>
> Chris

--
Cheers, Lorenzo
