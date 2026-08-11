Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF782236F7;
	Tue, 11 Aug 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438281; cv=none; b=vCm7+lyYmX/1P50LNGkV5B0CUxSq1tWxpyJluhYfj+xxr9v4hjmALgJxxIxqmyJMRNwaHVA9r2V0zYbcUiwfNsfXRXTjF6IdGnheHbmSGIIfpGCmOfXSvCd81B0zGvlpcqD176yIvE68C+M5foPSOCC3urQNPtzutGGsj26LQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438281; c=relaxed/simple;
	bh=fHDfwfWOEIV3an+rXLr2UVCrctvpLCh+r+GjLNR75qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQiFa2lrGC50e1w1GymDRYEZANXNFeEwuk8NrgiU1ubzwTy1EIOdDOPDo30jMxqP6t2Va6ec9p2gI8itNFfqk5DuIRBuY+P+7H3SxivzYubtnC+0tMbiB68XXPqemXHrXgOH45hkjtMGRfnZR+iLMFyYJYt11G7KS1nAnZqDSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcZcRvus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcZcRvus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B661F000E9;
	Tue, 11 Aug 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438279;
	bh=WGix9+ChbUADTuxGGhQgnktQZ1ZRs7VSctwhrFpgqIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kcZcRvusAGp8SBxsLE/wDLrFd85OxjKoeJNy86QvtKCyBGD1cgyhzx3Mo+zhq7u84
	 yEZmU2BsoRT9wyCf19rypfWAmeEwPEbShEDqCyvC26uGPgHvv6/p3RvACw1zTXDx3L
	 c+ps32DuOjovUkUEdLYgRaOvrkTWrPf8bqSxarzJBEwurpOSXymS9dQzEtEm1utNZg
	 QSOee1kNV3l8wZ1yDB39yiHJCKQA/2K7P5nWoOct+7U7PMFg+Rn/PnIJeE+DrHvueG
	 93eq7u40jvWGmJgujAMuyQTVFshixMJ3r2xalBwT3uRAjxP8uqnmmS2/PHdrnZ4gLl
	 ixBVO13PGfhxw==
Date: Tue, 11 Aug 2026 10:51:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, 
	David Hildenbrand <david@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Omar Sandoval <osandov@osandov.com>, 
	Jacob Lalonde <jalalonde@fb.com>
Subject: Re: [PATCH] coredump: add filesz truncation and filter
Message-ID: <20260811-achtfach-backpulver-mundart-70a7e5a20ac6@brauner>
References: <20260731171336.2255844-1-jalalonde@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731171336.2255844-1-jalalonde@meta.com>

On Fri, Jul 31, 2026 at 10:13:36AM -0700, Jacob Lalonde wrote:
> From: Jacob Lalonde <jalalonde@fb.com>
> 
> This adds opt-in truncation of Coredump segments to
> `/proc/pid/coredump_filter`. The primary motivation here is to reduce the
> number of zero pages written via pipe to a user space coredump process. In
> my testing this reduces coredump size, and thus IO by ~40% at Meta. With
> some outliers such as PyTorch's TBE weights being loaded in right before a
> crash being closer to 99%.
> 
> We achieve this by having the Kernel not emit the trailing zeros of any
> VMA, resulting in a PT_LOAD with filesz < memsz. I verified that both GDB
> from v16 onward and trunk LLDB support loading cores with truncated
> sections, however LLDB won't report zeros for the truncated region

Hey!

So I remember having talked to Josef (Bacik) about this a few months
ago. He had a similar goal. I don't think this is the right place to fix
this, though.

coredump_filter allows exclusion/inclusion per-memory-type. So it says
which mappings will end up in the dump. And such filters are inherited
across fork.

The new bit isn't a memory type at all though. All it does is to change
the encoding of the data that's sent.

So the receiver has to understand the new bit and not the crashing
process. This scheme will only work with a subset of debuggers. That's
kinda annoying. Basically the tail of a mapping can show up as
unavailable memory rather than zeroes. And it's inherited across fork
and exec so some unsuspecting crashing process does start generating
such coredumps purely because its parent did opt in.

Some time ago I added the coredump socket. There's a simple protocol
built on top of it. See coredump_req and coredump_ack in
include/uapi/linux/coredump.h. The kernel advertises the features it
supports in coredump_req->mask. Userspace picks the ones it wants in
coredump_ack->mask. It's explicitly extensible. And it's per-coredump.

What you want to do can actually be achieved by just using the coredump
socket today:

Set coredump_filter to 0. The kernel now streams a complete skeleton:
ELF header, the full PT_LOAD table and every note. The dumping process
then blocks in coredump_sock_wait(). And now the coredump server in
userspace can fill in the memory from /proc/<pid>/mem driven by
PAGEMAP_SCAN and then writes the sparse file itself (also works with
threads as they're also parked and you can always trace threads within
your thread-group).

That obviously means you have to assemble the ELF in userspace. But you
get full control over what memory is collected and how.

I find that quite appealing but if you wanted kernel-based zero
filtering I have a proposal as well.

Right now the mask only carries COREDUMP_{KERNEL,USERSPACE,REJECT,WAIT}.
Adding memory options is simple enough. Extend the enum and raise the
bit in coredump_sock_request(). Add a new bit COREDUMP_SPARSE to the
protocol.

The coredump socket stops streaming raw core data and becomes a sequence
of records. The coredump server can reassemble the data as
needed/wanted.

So every__dump_emit() gets a data record and every __dump_skip() becomes
a zero record with no payload. That can live entirely fs/coredump.c
below binfmt. So it applies to every binfmt and needs no elf knowledge
at all.
