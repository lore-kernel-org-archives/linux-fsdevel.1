Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890524;
	b=5cSopjrmk715f2L1Ogf1zr7LfD+7ij0lhvNmGB+2a/XBU/Eydut8RE97dYY4u3HKFy77
	 Z2rt5bmqj78qYfB70II9L1Ev7/2XrbSdSt21ymdaUX7GPUy0Yh6VmY5nlKSyOazdRXolA
	 PRD6nCoyXVMEC9Pmxl7g87euarqm6KzjgykuLk45hMo1s2ucBbpb0oondOoA44dlIpP53
	 G9wbqhgX/M7Sg2Ofd2zPWuhBxfF7++6lxeNNHF+orSBVyslKsj4e3ueFDjvgz13QuuUlN
	 4fe/EzfdJwaiLLWoMYUfEIk+/SsK5tfV8A9vcEV2ycpbcJfeukfMYbeEiGewA5tAfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890524;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nrSUhArM/zHEjchVrw9NyJq5VRSjmNtY2/0KcQpTHjQ=;
	b=HNWFK9J7YDNzyLo/vXuR6gyuNH/HbaFKirzUsaeOoJl5kw3a53yMT/qPLs9X3v2Ualuf
	 3b9NVRPypOh7N1UoMckaVtNdUCrYfKT/R3el/9gPP+Mzs/teMkcQiQjLvwxtHaAI9h2qB
	 cB2y+5Cu2wf5mQgSptOpYgRq88+eMo0LyNEySiyoi7RCAyBlAJQEA1wvZ1/iyigSIkMRZ
	 i6no7/HRSbbdWevWiqvR8W6LKTtA5wc7DMKLnNWKnxCo/H2dWn0Bg+AXGa/5nW9/eFYT6
	 0gv65y9RpzfE5Fw6XiSKiUcWuEx4GXZtjPuMCq7EEYx+XrVRvaAdLQK0DS4vgnSBlYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnMpGD3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31C606A326;
	Thu,  5 Nov 2026 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnMpGD3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A721F00919;
	Thu,  5 Nov 2026 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890523;
	bh=nrSUhArM/zHEjchVrw9NyJq5VRSjmNtY2/0KcQpTHjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HnMpGD3enRBqaeLM0xOBVlGPC6ENy8qFZ/LxACoukGORjw+noHpWsUVwyyt3vKXEH
	 By0v72rigo8lVnWymIOfs1QOwKv50FFAIAKxyKJL17MfWiPJ/Vy35JK8Ql+YfjL0FB
	 Shg9UmeEPJMHdtI2ECL96FpIDq5r0/GDPdFdqFaSCnztQ9iQ3lkOtn8iY2Wd3JIT47
	 P/h/C2EK3IVX+2AEWzGbxi4NkIV4TVRz/zEY+bQit8tS39LnBhFHwQ2XW3GWonJTDs
	 rFfg66mdXs9uPiwJiexv+DKfyi6kHfQoAngU7MxqY8/lWUeV7xZVykWfFm0p22nuYI
	 2i6PlwsonzI3Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id EF5311980047;
	Thu,  5 Nov 2026 09:55:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 09:55:19 -0500
X-ME-Sender: <xms:z5jsatHDs0jNWwmLwh1eHUQzs5ENE53hTkhR5YncedsWz6WN4SAU4A>
    <xme:z5jsarQxquV60pzGc1qwR66ozvTxn76QXXpZ1UCUQJCNDYR0LEzaq1GL3Nf2vFLUp
    SaSst8kp_FQ5FecIOtJUchklOadeTPlvOY54HDB4x_i9c07O-FVGbJZBQ>
X-ME-Received: <xmr:z5jsajixFkwCb1otqZx09UkN074IrZFBOKGXtb3saIoCTNKx9B1LRS9yeqM>
X-ME-Proxy-Cause: dmFkZTEfNv8KAoa9rNZKyCWbiBmL2n4Bk7MXZQMFpHT3IZCghURgydMkmL8v4sTbbWh2OF
    o7xxu2zDC7APT+fDNYq70qrN3HlCZ8JAIeVGogmdUAHgru+GtiC1OI8114Wu3Rk+xIjxxh
    cVsRuecuAGBuzau6soxBesvdI5sFcias6CB1X9p6F/vSuFPNFtDwf4qra3lHUbKPTkqDGO
    Y6rwt0KLp5W30A7QcwUEn/6koJCm0irKqEBq5nWqV+9FLrPejZigfr6eDzWWE5ydeQHXTY
    ffqQhUaRv2p1f6YTvdhmsalDlTQXPfgvekWlclWqq/6/5rek0k1/utIJ/reiUQWczHw9HO
    YRc2uvruhJNUSyM9Jnh/abZo9DaZ4YO/dkhnTu25kCEN7rKnZQM4/pxmgUBgZkmr0G0RIX
    RzitBrGcFgbWWmosvzONvgf8fSQvmyfiio8a8d1SHYX+LnMt6U+l/HcrCHkGherw1UqYze
    EK2r7hSXcoGoaNm09DFgsNz1kProsKnBQALlANmKd60rwQNrd0JH5doX8LtR9QFnLFGo7k
    Jke/VX4B/ZNV/d8AV0kg2YcfIy5bA8sONZAh2Ng8L9iXuTvrQvtuh1xW1x45BCkWBiYNf2
    5awshSKvvMDEj+81wsaHWQsdSlOzUEC74y/g8yhE8YC4nChbmdqe1XOfBt3w
X-ME-Proxy: <xmx:z5jsaoUeU4tGCAFg7BPREqNNQC5ETkzv5QV364lTKDEA8dejX3C30g>
    <xmx:z5jsapMgTuMdmmt4_iDbWJHZB_c6xMSRJwlrUGMQUj_x9SYjlsIAMA>
    <xmx:z5jsatYaXFzeoCbneowS0FNTZxRKMHCwI9CwYmBB6ERrvqLmNBVxqA>
    <xmx:z5jsajT4DjSW9tnGMYeVh0JMi1w9Ez918dF3gtLKD9CkX6rFIbu4mA>
    <xmx:z5jsaqOr-VgrFiM_ZBe50Pjq3oUd5Oi436kgCg5c0wLu3EcL7Qv9Jpkq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 09:55:10 -0500 (EST)
Date: Thu, 5 Nov 2026 14:55:09 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Ilya Gladyshev <ilya.gladyshev@linux.dev>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 02/18] splice: don't steal page cache folios
Message-ID: <auyYdqQBxdnBuM0N@thinkstation>
References: <20261104130118.2507513-1-kas@kernel.org>
 <20261104130118.2507513-3-kas@kernel.org>
 <af2102a2-206d-4c5e-ba1d-1ef42b2b6338@kernel.org>
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
In-Reply-To: <af2102a2-206d-4c5e-ba1d-1ef42b2b6338@kernel.org>

On Wed, Nov 04, 2026 at 05:05:29PM +0100, David Hildenbrand (Arm) wrote:
> On 11/4/26 14:00, Kiryl Shutsemau (Meta) wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > 
> > PG_rcu_free holds back the reuse of a folio's memory until a grace
> > period after the folio is freed.  A stolen page cache pipe buffer is
> > reused without being freed: remove_mapping() takes the folio out of the
> > page cache and the caller keeps it.  fuse_try_move_folio() puts it into
> > a fuse file, where writes change it under a reader that found it before
> > the steal.
> > 
> > Drop ->try_steal from page_cache_pipe_buf_ops.  fuse_try_move_folio()
> > and virtio_console's pipe_to_sg() then copy, as they already do when
> > stealing fails.  SPLICE_F_MOVE from the page cache into a fuse file or
> > a virtio console now copies.
> > 
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > [kas: rewrote the changelog]
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> >  fs/splice.c | 51 ---------------------------------------------------
> 
> Removing code is always nice, even independent of the other changes :)
> 
> The description doesn't really describe the impact of this change. I assume a
> slowdown of certain workloads (does anybody really care?), and temporary
> increased memory consumption (as we keep the pagecache page).
> 
> No idea how often stealing actually succeeds ... a bit of history why it was
> added in the first place and why we no longer care now would be nice.

SPLICE_F_MOVE has not moved page cache folios between files since 2007.
See 485ddb4b9741 ("1/2 splice: dont steal").  The only users that still
steal from a pipe are fuse, when a server splices into /dev/fuse with
SPLICE_F_MOVE, and virtio_console's splice_write().  With this patch
both copy, and the source file keeps its folio cached.

Miklos, Bernd, Amit: do you know of users that depend on the move?  Would
the copy hurt them?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
