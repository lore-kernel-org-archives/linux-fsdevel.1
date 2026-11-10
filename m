Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315598;
	b=WbHbPaT7+2UILpsHkLSbRRTgunrY8pBhqTKVPLxhwmC3GaFgRcT/gskrvhiSZeuI93Es
	 0mZyFJBgOHsp26KhYE7eXOfpXsR7TjFSO51OvK18CiyT2t9Ey4NcsPy/r/Ox2bY8aQhii
	 PszKytDTtmBkpKunsEgPw1UBeoBJ5XKkQg0a4jKuiHNJy36xaoWE51Qa36KlV+UDNM21v
	 6Tgaf2ueNVBE5mAb6OFxnTdG4nsLktV5IXkDsvk3PemnD3EmcqYBhxrWEXDD40n/e4K0y
	 /4AQQkbzcXcbLjdLKlHOeHz+YoEYb35oy/LL5oloyElQBcr/wP1if+VeYqY2B/+mjmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315598;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wnyy6heljadaRgfxt4wb4lOJGOZWSfcR9An36HYEP3o=;
	b=sWKrc1L2gXGafp73i3nYVnWPyXRVD3CRADweCmKQwnw6XufE2bkLDKhWc5r6pyf6rUWU
	 ZfndiIH6n2qax6z9xEHVXc41DR89+QLAkdT0dlzr+ACnObxu1OBftMdC4NyiDIODr+ddI
	 iLmcgj07bW+SASeO7VNW5dbJ//hbPnjpNLGfZjWUQpSsGcXmkUGtJvpsKvk29H0iTFdvQ
	 +DJi/fUVYKk5dL8DNaopXppEL6f4zl2c8zKULTzfpuN+BXgb9Xb0hrbrKhePyVzhNNTfB
	 Qv6Q5uo9LREFKdcRj4e4jqNzCx2Wi6VVzTIRMVTpC+zVSPPqTXHDs1Z8Ci9x/1vaLJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEWiJYgo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1219606D5D6;
	Tue, 10 Nov 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEWiJYgo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B218D1F0089F;
	Tue, 10 Nov 2026 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315597;
	bh=wnyy6heljadaRgfxt4wb4lOJGOZWSfcR9An36HYEP3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NEWiJYgoZ3M06iOwuPgwQNC6xnFZeGa8MtJTqrAh7BDOeh3ctwW7p34DOYRA52Lj9
	 KYLHjX3Xy4oCgODSgpfn+PM9Ul7YUdFwLrvJ6hH7IIwo5Rr+KID0ZTC5VYvpqJyCr/
	 DvjcGWIj3rlMcFBmeZSzhzlXDPfpT9U6z//Fw28JowMWY+8TT6nf6IDBCV13KEclgB
	 toyMCyhJVHOwm2ydP43nBNyV8BxJpn1LYc4bwBM69mWHIVxJlZtakBcxY7MZznfMO2
	 KIkWuxKYlIPOB6i37L5tkDWXMciTEa2O50u6im9c3uBicYDiGE6sUDfCQtnCXec2uj
	 oqdAR4Ap+LMiw==
Date: Tue, 10 Nov 2026 12:59:50 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Seunghyun An <san55@wisc.edu>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Suren Baghdasaryan <surenb@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/rmap: use vm_pgoff for anonymous VMAs in
 linear_anon_page_index()
Message-ID: <avMS8RyqNQ89a9hP@gremlin>
References: <20261110000002.1834454-1-san55@wisc.edu>
 <20261110000002.1834454-2-san55@wisc.edu>
 <avL5C_w-wo6bJJTj@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <avL5C_w-wo6bJJTj@pedro-suse.tail5790ac.ts.net>

On Tue, Nov 10, 2026 at 11:25:13AM +0000, Pedro Falcato wrote:
> I trust Lorenzo knows more about his plans to use anon_pgoff than I do,
> so I'll let him reply. A comment though:

Thanks.

I'm taking over the series rather than replying further, as is general practice
with this kind of submission.

Will post something in a little while.

>
> > Measured on an AMD EPYC 9634 (84 cores, 12 CCDs, CONFIG_DEBUG_VM=n), on
> > mainline after v7.4-rc1 (the base of this series). Threads share one
> > anonymous VMA, each faults its own slice and zaps it with MADV_DONTNEED;
> > faults/s, median of 3:
> >
> >   CPUs                      base      patched
> >   1 CCD,   7 threads        2.360M    2.369M   +0.4%
> >   7 CCDs,  1 thread each    1.738M    1.982M  +14.0%
>
> This is not particularly surprising. CCDs have their own L3 cache. I'm not
> surprised the coherency penalty is much higher cross-CCD.

Right. And a lot of these workloads seem to work backwards from the problem
'let's find the worst possible scenario for this, then microbenchmark it,
surprise it turns out it performs badly'.

Even the real-world usecase (no citation as to _actually_ encountering it) seems
to follow the same pattern.

I expect we'll continue to see more of this stuff over time, sigh.

In any case, the solution seems to be the same in general - don't do this check
in non-debug.

--
Cheers, Lorenzo
