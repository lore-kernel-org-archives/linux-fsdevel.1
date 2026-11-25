Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620779;
	b=0PeRaFTf8K5/Q7Js9qZTF9JoiqgVE++V6uDrGX4Dfz8UHj6vv5WmrboYLZvXvGMAvsTW
	 anrrf44SJI1bUeLaHWM7lauvazDFCYiYCp2GM1TdxTjqVv8zaUs1TpsgdxixQesJBsBYZ
	 CXY7JWpa4H6fqIBRu36drgX10ECmxJsNDoRUCEo2aK9uFJAXSbmFmKk1GYtp5GsGTBN0X
	 I9E21sZGUAarK+OCsSi+QpCRwBwDYlhMXq73hyMfTsRait5b8fqHt9IE3JstsqODMlmpv
	 KjdHIgQqZgYm2CgEe6sElVUJfqUtkVGRy7CyWq526Kyc1Ut/Hf+eB0b7f26qAGLUOWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620779;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P9ziKV8LpwywZ6keY4HAU4E3v0yjAaX5+ig0pbD9Vik=;
	b=TSZ/Dw0D3rzkvepq7xu4EBcHRPwlSIS8iuuOjBENxZtPETThel7egTQwrXYRNRYW9eX1
	 YzzQWCDec72jKS6V5lT6maqqyO703b9JUj/KzYtAu6wYR65lHZNyVJGr4cgS+aLAe5YQA
	 woV9i6JzrVKmY5dfMD9qw5Q9zR8kO9b7wBszm/Wtv6Y006ZpVoMHSTG8x07VwFROdhmJ9
	 3cK1Lk+QHPutQmt4Ah0qCovM/Cx0JOWedf0+3bRxqbdFZ+uRhWhqT8dpOG9Y1vYZCi8qB
	 ONyQtb7SxjnicITY2c588YYoyPzqz5oYi/wmeNWslel0ZwpCYP4iu/ZggcKi879b9xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILwnqsTJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A9606A31E;
	Wed, 25 Nov 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILwnqsTJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C791F000C4;
	Wed, 25 Nov 2026 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620779;
	bh=P9ziKV8LpwywZ6keY4HAU4E3v0yjAaX5+ig0pbD9Vik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ILwnqsTJoTAX2y6yreyBSv7Ug5yv859gbc5ivHDIVIiyndf4xWNa3m/VfGPI0DL99
	 6gFkrWdGw5l67ojlhP1I0mG6HuDXK7MYpGaXJ4/mhpgBzqcv9csTA63EjjPcJYp7VM
	 zd1bRMFUPXTBVD4WIF+ATgxG7wh6LebcmSAsIaw7wIlmAtpj0YB86daZiYYipg/xOf
	 9k3BQCDgFcoAvRsp1wiODXhIQ4a8wYfGFQB7msaKHKnYHfUnHEnKBdj4iMKDrRzyOG
	 ST7+BxK9KYa8YfKIMqlD1LZN6QfEoeOny+w0NBKTzGb5Z0EJ3B73Dp7xyuJ87OVw3t
	 IB5NC0uG0pr8g==
Date: Wed, 25 Nov 2026 15:32:57 +0000
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Quan Liu <qualiu@nvidia.com>, Lee Trager <ltrager@nvidia.com>, 
	Seth Forshee <sforshee@nvidia.com>, Gregory Price <gourry@gourry.net>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH] pipe: Prefer mempolicy node for metadata allocations
Message-ID: <awb8v4sLglHQyHQ2@thinkstation>
References: <20261110065219.894219-1-arighi@nvidia.com>
 <hbkxlhc5y2jkvuov5o2kjgpisx2pavuo3ad4c4ydixeic7vaq6@mpzzfmhjvtof>
 <avQP1aXhe7nQuzt9@gpd4>
 <3f761a27-74df-4e19-878b-323164da5a69@kernel.org>
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
In-Reply-To: <3f761a27-74df-4e19-878b-323164da5a69@kernel.org>

On Wed, Nov 11, 2026 at 09:12:44AM +0100, Vlastimil Babka (SUSE) wrote:
> On 11/11/26 07:48, Andrea Righi wrote:
> > Hi Jan,
> > 
> > On Tue, Nov 10, 2026 at 01:27:53PM +0100, Jan Kara wrote:
> >> On Tue 10-11-26 07:52:19, Andrea Righi wrote:
> >> > Generic slab allocations can reuse partial slabs from another NUMA node,
> >> > even when a pipe workload is bound to one node. Pipe metadata is shared
> >> > between senders and receivers and accessed throughout the pipe lifetime.
> >> > Reusing remote metadata can therefore make an IPC workload pay remote
> >> > access and coherence costs on every exchange.
> >> > 
> >> > The target use case is a workload that binds its workers and memory to
> >> > one NUMA node with numactl. The policy node is then a useful placement
> >> > hint for shared pipe metadata.
> >> > 
> >> > Allocate pipe_inode_info and its descriptor array on the node selected
> >> > by the caller's memory policy. Apply the same preference when replacing
> >> > slab-sized descriptor arrays during ring resizing. An explicit node lets
> >> > SLUB try local allocations before reusing remote partial slabs.
> >> > 
> >> > For descriptor arrays larger than KMALLOC_MAX_CACHE_SIZE, pass
> >> > NUMA_NO_NODE to keep the policy-aware page allocation path. An explicit
> >> > node would otherwise lose the MPOL_BIND nodemask on fallback. Select the
> >> > policy node only for slab-sized arrays, avoiding an extra advance of an
> >> > interleave policy for large allocations.
> >> > 
> >> > Moving a pipe's users to another node doesn't migrate its existing
> >> > metadata, so migration can still result in remote accesses regardless of
> >> > this change. Generic allocations may reuse remote partial slabs, making
> >> > initial placement dependent on allocator state. In contrast, preferring
> >> > the policy node leverages the workload's placement hint to improve
> >> > locality when users remain on the intended node.
> >> > 
> >> > Testing has been performed on a dual-socket NVIDIA Vera system, covering
> >> > hackbench, pipe transfers, pipe creation and resizing, pipe_bench, and
> >> > targeted stress tests.
> >> > 
> >> > The primary hackbench reproducer is:
> >> > 
> >> >   $ numactl --physcpubind=0-87 --membind=0 \
> >> >       hackbench -P -p -g 10 -f 20 -s 100 -l 100000
> >> > 
> >> > Results (over 10 measured runs per case):
> >> > 
> >> >               avg       stdev
> >> >    before     9.811s    0.130s
> >> >    after      5.770s    0.058s
> >> > 
> >> > Before this change, allocations could reuse remote pipe metadata. With
> >> > this change, both pipe objects and descriptor arrays are allocated on
> >> > the requested node, improving locality and reducing hackbench runtime by
> >> > approximately 41%.
> >> > 
> >> > Reported-by: Quan Liu <qualiu@nvidia.com>
> >> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> >> 
> >> To me this makes sense so feel free to add:
> >> 
> >> Acked-by: Jan Kara <jack@suse.cz>
> >> 
> >> But IMHO it deserves a look from MM guys since this is more of an MM thing
> >> than a filesystem one... Added to CC.
> > 
> > Thanks for taking a look, and good point about getting MM feedback.
> > 
> > Vlastimil, Gregory, do you think this SLUB locality and mempolicy
> > aspects makes sense here? In particular, does preferring the policy node
> > for slab-sized pipe metadata, while retaining the policy-aware path for
> > larger arrays, look reasonable?
> 
> It's not wrong, but feels a bit ad-hoc. If it's pipe metadata now, what's next?

Good point.

> Slab will generally return objects from the cpu's local node even if it's
> not specified. It's not guaranteed, but it's not guaranteed also when it's
> specified by kmalloc_node() (unless __GFP_THISNODE forces it).
> 
> So the results above are surprising to me. Are they on recent kernels? Are
> cpus 0-87 all local to node 0, or is membind 0 there to force a node that's
> not local to some of them? If they are all local, I would expect the objects
> to be from node 0 even without kmalloc_node(). So maybe we have some unknown
> deficiency that should be investigated.

This is the default behaviour of remote_node_defrag_ratio = 1000.
When there's no slabs left on the local node, most likely it grabs
objects from remote node before allocating slabs from the local node.

This means quite some of allocations would have to be served from the
remote nodes before the slab memory on the local node grows.

-- 
Cheers,
Harry / Hyeonggon
