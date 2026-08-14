Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B235E94E;
	Fri, 14 Aug 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721313; cv=none; b=pG9IdEYmZYtk/n6B4MkeCsfPl23I3BZhYoTbSEO6G7zHRKnhIVC5dClepAZqrrlevzRa7ivhFDKgFoRp0oyhpNnBOaPziH1U4N90d1LawhRvcBSnz1oyvxKMWKLfFbYvOaqAV0FLI7CXQPv9yLyVquWFLYv1MaklAWGYge1lftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721313; c=relaxed/simple;
	bh=iwwl7tA9ewbSGRP4ccZNGQKabPl8czDoTI/an99LtVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcVL6DhDNHcGyp6gyIijAixtgzzbxwNIjyVhEqj/BWpzzkyxpbhA5VRdOQZjHW9feTAcWguRZbRaaVfFem/0V+wA0XsaFGIpuJzgbfZeKkrxT9JLZPNQz2Gi2TumpFxjuzN8xTU/xvl8i82AVo58qV/VuAun9r6OvRO/b1yZvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOgTfaKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOgTfaKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7390C1F000E9;
	Fri, 14 Aug 2026 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721311;
	bh=hfnvBXRVOTB7UT8A93hr18ROs6Wwefr9xY+1heqpBJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IOgTfaKexlHmfyEydeEBLUvjl60WHSEyWt/VjxtmEpyqay1FoofA6G96R9QKQ8mf3
	 8kMNHXq52CPyXTyTdBL15v6jkqdIjLybowkEjHtwArjmH1fYuVIA5ZZJIf4A/DHJTQ
	 THmH6zUE04N2SSf0uSd+wrINct/KBc3GsJfcYPxJW8Xz2nIkcQDhU3rSiLYX0xc6aN
	 Yzd4mlrzNf3DOziy1xWuTFsSq2U7IBUBqHnT/DhEPn/8m6Y88Hm1EQwTDi0NfUPfXT
	 4qWMr36pZYY2UcuRNXsNajrV5nZCtQ3dWD4Dbw21ErQUxNezHa7XrHSPXFoBLqsHxL
	 pMAmycp/38pcQ==
Date: Fri, 14 Aug 2026 17:28:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jacob Lalonde <jalalonde@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] coredump: allow to create sparse coredumps on the
 coredump socket
Message-ID: <20260814-geflecht-sachdienlich-ergibt-c736999f80ff@brauner>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
 <an36FFL9ALwCPhEe@telecaster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an36FFL9ALwCPhEe@telecaster>

On Thu, Aug 13, 2026 at 10:08:36AM -0700, Omar Sandoval wrote:
> On Tue, Aug 11, 2026 at 05:27:21PM +0200, Christian Brauner wrote:
> > A coredump generated via the coredump socket ends up transferring
> > zeroed data when a mapping contains holes. For a large process that
> > maps a bunch of data that's wasting a ton of work.
> > 
> > Jacob ran into this and Josef has bitched^wcomplained about this to me
> > before. I dislike the coredump_filter bit solution in [1] which stops
> > each PT_LOAD at the last populated page.
> > 
> > The problem is real though. I don't think coredump_filter is where we
> > need to solve this. That mask says which kinds of memory to include and
> > it propagates across fork and exec, whereas what is being selected here
> > is an encoding mechanism.
> > 
> > I also think that the usermodehelper - may it swiftly die - isn't really
> > salvagable for this and it's not the future anyway. The coredump socket
> > already has a handshake for stuff like this.
> > 
> > I always had an idea how this would look like but punted on it back
> > then. So here it is.
> > 
> > A server that raises COREDUMP_HEADER in coredump_ack->mask doesn't get
> > the coredump as a plain byte stream but as a sequence of frames. Each
> > one a struct coredump_frame_header followed by what it describes. A data
> > frame carries its bytes. If a server also raises COREDUMP_SPARSE, zero
> > frames are sent for unpopulated mappings. They only indicate how many
> > zero bytes need to be written and to not include data. Reassembling the
> > frames gives back the same coredump. A debugger and everything else
> > still see an ordinary core file and nothing outside the coredump server
> > has to learn anything.
> 
> Hey, Christian,
> 
> I proposed pretty much this exact solution to Jacob, so thank you for
> writing it :)
> 
> There are a couple of reasons we still wanted to explore the
> coredump_filter solution:
> 
> 1. Our core dumper application is not really prepared to run as a daemon
>    that listens on a socket, having been written to be a transient
>    usermode helper. But thinking about it more, maybe that's something
>    we could paper over with systemd socket activation?
> 2. More importantly, we sometimes write core dumps to disk and sometimes
>    upload them to blob storage. For the former, this approach of sending
>    holes over the socket is great. For the latter, we'd now need to wrap
>    the dump in some sort of container supporting sparseness that all
>    consumers then need to reassemble. The coredump_filter approach
>    doesn't require any changes in that pipeline.
> 
> To be transparent, I still prefer the sparse socket approach, but Jacob
> has different contraints that I'd love to have addressed: it's a
> trade-off of more work on the core dump server side and all of its
> consumers vs. in the debug tooling side, which is mostly already there.

Hey Omar,

Good to hear from you.

I think the coredump_filter solution is just the wrong approach. It is
a hack and in a part of coredumping that is riddled with bolted on hacks
already.

And I don't think the argument that changing this in userspace is
somehow not possible holds. It not being wanted is another thing.

This is a new feature and as such it is our responsibility to expose it
in a way that is correct, maintainable, and clean. I don't think that
this is possible in the usermodehelper case without doing really hacky
things.

Plus, I really want usermodehelpers to go away. It really is a CVE
machine. Most of the ~40 CVEs in the last 10+ years have been in the
handlers. Mainly because the interface is really not nice and prone to
security issues. They are spawned from a kthread with kernel level
privileges that userspace then needs to drop. So really, changing
userspace is a long-term self-service. :)

And yes, there doesn't have to be anything long-running. They can just
be socket activated.

The pull request that's up against systemd splits this out into
systemd-coredump though. So PID 1 itself can also be coredumped. That
daemon is long-running but it's only job is to spawn workers on incoming
connections and maintain backpressure. The listen fd is in the fdstore
and so survives restarts.

>    consumers then need to reassemble. The coredump_filter approach
>    doesn't require any changes in that pipeline.

We could add COREDUMP_TRAILING_ZERO or whatever so you get that
truncated behavior over the socket from the earlier patch. While that
will get rid of smuggling non-memory type bits into the filter and
won't have the fork/exec inheritance bugs that the other patch has it
still has other issues.

It will always have to accept an O(hole / PAGE_SIZE) walk under the mmap
write lock before ever writing a coredump. So a JVM starting with a 64
gb heap reservation or a go program with a large reservation means
millions of probes before the dump even starts. The selftest in this
series dumpds with 256 MB. That amounts to 65536 probes. This seems just
wrong when we know the holes when we emit the dump.

For default 8 mb pthread stacks that are in a single anon vma 4 × 8 mb =
32 mb == 8196 pages only 8 of the 8196 pages are resident. Most stacks
grow down and glibc parks the tcb at the top. That in turn means every
hole in a stack is a leading hole. The trailing zero hack cannot handle
that at all wasting a bunch of space.

For the blob storage thing you can just upload the header last. So
stream the data as the records arrive and compute the corrected phdr
table at the end. If you're using a temporary file or whatever it
becomes even easier to rewrite the header.
