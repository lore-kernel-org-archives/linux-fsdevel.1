Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A934B437
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484199; cv=none; b=dZCRvsB14fJXchKFX16JfNUiJkZc9mPiJYmjqQcLK2As2kchw2SXX02V9Dkx0Vj89Wwew4wPmia2/YjRB7uEC57MsuFC3gv21kVosf5MjmA8sxoCVPeiLtof3l9vserp7xQKS5jur/zf2ZRkC/clTxCQP3HdMCy5fy6kKfBQuE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484199; c=relaxed/simple;
	bh=YFS8Q2LQ2vQkHvp4TjXG3POWOYMQj1Oms+u+aF7EE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEQ1rjgzU+tDRbFZYv+Apg3J5HVnGV0frLlwH7OGEpcJeORw7SgbuZFte26v/KeKtYpLsBXoHo/hz48JkiIAFgxmJoPsRsIUgKuvwTFjZCtnKvcbIqeqd+OC5WkO6HUhbATBEn3wuwlNLUN14ZQD9qzLCdqoVBHoz1X9Bysxb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf40v70l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf40v70l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3351F000E9;
	Fri, 22 May 2026 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779484197;
	bh=3CBQc/NNGcZh45uWBZuxyVBDacJtEW2keqfWeLE0WrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kf40v70lZr0HhMrlT1U+T4mkJ+EE78e5NPB+Z5BjGcwC0Z5f5DxD+iKxmLZu+JTLy
	 hzISx2ScNPx+lV/VvvWBftJFiQ5vTPGicdvVBUsLbhECQxuGUhxji84AkG0ip8o5s2
	 EvzBkmVoFKXgYadFygNxZe/1LU1L2dHr4uTmalcDGO7hg7RQKxQ4+QoWHx0Z6/Zzxe
	 oetb4OfKhYCiUvNs7yjqWoNbzEcQQ9ZN6JgvSEuQWX4WMKM4S+7M2+DFTw5V5qRd0L
	 KGMWBoiGYMrC3CmietTy9A4+Ym2IY5802LCiZcUA/r6s8KmjqSBOZRbAMRc9SvVjry
	 SVng1//GHLC3A==
Date: Fri, 22 May 2026 23:09:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] exec: free the old mm outside the exec locks
Message-ID: <20260522-bezog-kupfer-gruppe-e2ba3adfa44a@brauner>
References: <20260522-work-exit_mm-v1-1-bd32d5a560bb@kernel.org>
 <CAHk-=wgJRmdjDQExRP67GprmG7VLopuuaWMyZr4YNp2NvdNbKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJRmdjDQExRP67GprmG7VLopuuaWMyZr4YNp2NvdNbKw@mail.gmail.com>

On Fri, May 22, 2026 at 07:24:09AM -0700, Linus Torvalds wrote:
> On Fri, 22 May 2026 at 07:03, Christian Brauner <brauner@kernel.org> wrote:
> >
> > If exec swaps the mm but fails before setup_new_exec() runs the old mm
> > would leak, so add a backstop in free_bprm().
> 
> This looks odd.
> 
> Why is the free_brpm() the backstop? Why isn't it the *only* stop?
> 
> free_bprm() is already where we clean up the new mm if it wasn't used,
> I feel like it should be where we clean up the old mm too.
> 
> IOW, why not remove that whole thing in setup_new_exec() entirely, and
> let free_brpm() deal with it?

I was undecided. Both work. Ultimately I went with the split to get rid
of the old mm as soon as possible. There's no actual work happening
between begin_new_exec() and setup_new_exec(). So the old mm is really
just pinned for a short time.

Moving it to free_bprm() has the consequence that we pin it across a
whole bunch of work. For example, for binfmt_elf:

* setup_arg_pages()
* mmaping the elf image
* the whole elf table setup

So it felt odd to keep the old mm around for all of that. But if it's
clearer to keep it until free_binprm() we can do that.
