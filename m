Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED133BED79;
	Tue, 11 Aug 2026 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481709; cv=none; b=otQ8fVC6Y2+a9BFH83BLq+AxMc6fv1ycyzZA6AVbBeqV4Pt3eR896gU9erFP0KWJUS0Bp2d0WyLY6hr9Jq5QNKr/1iQbRWZic0l9fkmVuNbAA9SkIY/SnNIPXl1CdDpbiK7PSG295IedhjFVBNpFwLaaQDHF3l28b8uHps06rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481709; c=relaxed/simple;
	bh=JNU6NKML9Hlqwjfne/ZO5VcHY63eTRd/wUqGZQvX3xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNBx07+pUQhxElkHbp3VVernWn/vbb0Z3Zi5OQFzIVzEMqBqS3jY7qxbntw464quxQb19s5QLh8nb93xJKd3QPETvDsuO7kIELYPJsEGG+kUhaiUKFTrbk7PqmugKpWku99G4S14vH7sM1IZc2eSs+nzv5UdyY/qiSapLmQt8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdcZNlmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdcZNlmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271731F000E9;
	Tue, 11 Aug 2026 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786481707;
	bh=aQNBClanQhcKXlEpeCTI+ghlkNL60DbeIDtW87Lh0Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OdcZNlmSpnlJRGeLjEVeUj5DvZ8Ix6Lhlzc13RQ+BvCLPnyAZpflaGcOjujFWkisL
	 zoSCGkfa1K+3RazlVtZqWkANfM+hjaYPMRfroV23KO9qxU8tdG6NyVAA/FLX2Htg1c
	 kpIkZ6v1obesytonpw9MzZuzGTIuMawmrYwgDOUdRlk8ReqflGiTBuK6WvzipLgt7o
	 r2dO61VSgFz9UyX1nykqqw4y88jjE9/PuCI9TWxLuaEtqaZiV3z6B00CDgmrtyLh8v
	 ZvsbRJgLYL+JdX3TvbThNDha88TlzzC8dT8bSG4FVOS77BTbsa8jYXW7mB2EQuTfu5
	 9PNssn489T28g==
Date: Tue, 11 Aug 2026 22:55:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] coredump: allow to create sparse coredumps on the
 coredump socket
Message-ID: <20260811-morastig-schadenfroh-kabine-e2ae880d038e@brauner>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
 <CAG48ez3QwUopEyfB0tEc84A57g3GZdnptazJW+htiTi2e0Gc=A@mail.gmail.com>
 <CAG48ez0Ty5GTR_vYazWsWOigWP2=8SYstw13zaiJB3auBi1bcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0Ty5GTR_vYazWsWOigWP2=8SYstw13zaiJB3auBi1bcw@mail.gmail.com>

On Tue, Aug 11, 2026 at 09:39:12PM +0200, Jann Horn wrote:
> On Tue, Aug 11, 2026 at 9:07 PM Jann Horn <jannh@google.com> wrote:
> > On Tue, Aug 11, 2026 at 5:27 PM Christian Brauner <brauner@kernel.org> wrote:
> > > A server that raises COREDUMP_HEADER in coredump_ack->mask doesn't get
> > > the coredump as a plain byte stream but as a sequence of frames. Each
> > > one a struct coredump_frame_header followed by what it describes. A data
> > > frame carries its bytes. If a server also raises COREDUMP_SPARSE, zero
> > > frames are sent for unpopulated mappings. They only indicate how many
> > > zero bytes need to be written and to not include data. Reassembling the
> > > frames gives back the same coredump. A debugger and everything else
> > > still see an ordinary core file and nothing outside the coredump server
> > > has to learn anything.
> >
> > Hmm...
> >
> > I think what you're doing is probably the easiest way to do this in
> > practice. I guess some design alternatives would be:
> >
> > 1. (overengineered, not generically useful enough): If the transport
> > was a pipe (which already has the concept of different types of pipe
> > buffers) instead of a unix domain socket, we could introduce a special
> > representation for zero-filled pipe buffers and some API for receiving
> > zeroed holes through lseek(pipefd, 0, SEEK_DATA), but that's probably
> > not sufficiently useful for stuff other than core dumping to be worth
> > the effort.
> > 2. (somewhat overengineered) With some refactoring, we could maybe do
> > something like /proc/kcore and create a seekable virtual coredump file
> > that we send over the socket via SCM_RIGHTS?
> > 3. We could leave the userspace memory dump out of the core dump data,
> > and let userspace take care of filling out the memory contents using
> > /proc/$pid/pagemap and /proc/$pid/mem? That would also avoid task
> > switches and SKB allocations, and probably reduce the number of data
> > copies involved in this by 1.
> 
> I also wonder what userspace actually does with this data - does
> userspace just want to write it to disk, potentially after compressing
> it? Or does userspace actually do some fancy parsing of the data

That would be the most straightforward use-case, yes.

> stream to extract stack memory or something like that? Or does
> userspace buffer the whole thing into RAM and then process it from
> there (it kinda looks like systemd tries to do that but I might be
> reading this wrong)?

I'm not sure about that. I think it's writing it to disk and then
parsing it. But it also wranges it into a socket to forward to
containers or services.

Note that systemd has a pull request for the coredump socket up:

https://github.com/systemd/systemd/pull/43330

This should kill the usermodehelper soon on kernels that support the
socket.

> Anyway, I've looked through your code and it does look fine to me.

Thanks.
