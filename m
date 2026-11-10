Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307122;
	b=YonzI7Ge1pHWOX+bOQgNtVRqKU4McVVOmzWbyHDCqZPx/Iu1pWmE5kHDCL0u//dM7QF4
	 zLkszsW9Ml8UNjipOJ6jhmWnbiIQbVpmaKCI1vGdOFPvIMXmnw0FBCTd6W5FGJZxHqcAm
	 UhnbiJ8MG5b4slUxB76Go7aFW7gvKcIxXpw2QkBKQiiHePa2HFFmcs2h9Fx1GRorpd62O
	 r8LvV7eIoQAnQF6dN6YX+6QiDfHr61UkfLqE8Hq0IOhZ7sTX2rtjv98Evf0Joco1X1OXQ
	 WO/ljRU8EZpW2icAwPcU8BhqJszy7Pk6RIxz+C/T2MwJXsi5KzdhPEr6k4C9k/cqCBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307122;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mQ0DS0Yy8VyjCq5n0JUyQOmDm0G3x8Yvcc3go50QGK4=;
	b=EQhmPoMHN2PGXdMZuN13xn2736RzCRkS8UAtlxPWCk33Vg/dsHXHSWJ/C3p27Udh3Zy4
	 mFDJJrtYhndeEeySGRScT9IGKc+iyIBnplxajSWmbLZ6vnTOMV6c6sckeI9QK7lq7lpsF
	 CbXn3Hc6Mro6a40F4XelT+Mi3p3LZJvxWq6w+msGG+3w1RTO9YQep/6fq16o45m/B74T2
	 DYlv2wejT2UE9WS5vw/EkjDBuntVJIbL0b9KBCCHhUsD2YWc76dZwT1QZTtbcC/foHjb8
	 OWhiZGnCy20jvZip7JgkuNdYcaB9evXchwgkDaXE9dSBuxqH18tsIW9/bik3tcmHEZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VA7vkIli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C8606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VA7vkIli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5C1F008A2;
	Tue, 10 Nov 2026 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307122;
	bh=mQ0DS0Yy8VyjCq5n0JUyQOmDm0G3x8Yvcc3go50QGK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VA7vkIliY0Ztaj06KemdysXY2ShPF36SA67qzn3Y7EspqalUShDr0Zvmwk4mUzgMz
	 D7C5Q/2Hy/c+aecN+TjWr5+tvgdeCtKR4ys31nRIpSBp00bi17SxrEzfvBg8t2+7Q5
	 37X1cKmCS7TZ1oJOe6dbRkV6LSoEQ+K3+rfepHMsoOn5C6awNp1BZgbnaR2VABySS7
	 Br6vIBJtDwr8oHfSFqioRNuZXZuXFB4mXtqvLeOvZpT3kUP1u+6/441mi5ksGqelmg
	 BD00h/t4pkYorNPjTOX6aHg5B+mNfAS1Dw7tlwhwH30rF6p9ndhRXd0IIDOyXupnIU
	 ub6rq0b8A892w==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id 380A4198003A;
	Tue, 10 Nov 2026 05:38:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Nov 2026 05:38:39 -0500
X-ME-Sender: <xms:LPTyatmUbxJgSZktfPqGS2Z6OsMjabocvOi8l0b0TClsHNG3DMGmYA>
    <xme:LPTyamcR6cxXfFpfEt2X7Qmm3WeRQTS79eyALv107GPdK16udKMpLVOisTtoDXKnG
    fgrAEJuEk8maJeyseaL3ruKOunQxBLaBd22hqHuHtMJx2PGqybxke5Y>
X-ME-Received: <xmr:LPTyarCEC9F6JjYHwRFja7vpGiEzFrIsJzAuuc11hODgCnkIIuBRW2fwqVk>
X-ME-Proxy-Cause: dmFkZTFs0g82Q615OOi52Z+HeqblqOjR9pJf46YJWaxBBkrTfmDH1DT3GRc2z52s85cgSQ
    zwotZW92pknBwJZYo59uM7Lq7grvAcP0knUyDQiaUeG4F2yDycT3TYzZqh907BB00Q3GpF
    iUjtDL+bPvAwKm3xC5c+XCLhrD9yIiHSOfYa8wOM08a4FZSeRJIvm7tryb7c4cHiIK1fuD
    5z/tOkoNNNU2nKYuj816Kcl05EInBe4GR3/eKR2nKwtS5zyPwBzF/qCV2q2+N4SqsZMSFD
    nKZ/v7wQdPVe+pqRKtQ4v+i48RG7x6CX+58Kew/ntsptS3134PWiry1EVOdsL/g72ZXOH+
    85xJfZu+wxE2a+dvxCZWU6D1nLtGUmSP0M0fOmJK7HC/a428CJ3H+dEPcUxpqqQqIeLMR4
    aasmt2Q5qr6Q++FK4iQ5tBab+65qdPwlRPjXUEEXhcJ+8ojPSTB8L+jeudNQUTOS89Xv9o
    9EbmfRW3KZa76ThHIFfso/Ixbkz+sfqZqDPKLjNoBnUhzGmAy0A5u378aHgLQ1XmWiXPrj
    mBuufjwXwHs1nyyDrKFm4dhqeXtWvUfdUvCsXl0bOxwgEWMbDiYWtGI1qfnimBVH0liYKU
    Th9Zi8y7s2yjZ7EgCBzW7fRZpOLu5356tvi18a+W9oz6a7fHm/hY64v5GbzA
X-ME-Proxy: <xmx:LPTyalxrhR-fExjznWXSF6EO7BmDkdL4ho0cSRMbZ-FizOgerDLdIg>
    <xmx:LPTyajgW-xR50qn9nZkd92gK80pksCNHnC_7D8b65n2C8y5_sfXYxQ>
    <xmx:LPTyasdGDnQHo4_Ls_X4HrGcakm1JH-G_HGTHooDdfjqW5m-FU2lWA>
    <xmx:LPTyaqU3_RlwvCph_hdTkvqLTVQvNNUfuaRDsQL3_LeJpdOpDSzv3A>
    <xmx:LPTyamwLQLAdRgsDYzfnyeLGGYoh2Xrvh1Pdkdg05erRA0MI13r004gI>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 05:38:35 -0500 (EST)
Date: Tue, 10 Nov 2026 10:38:34 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after
 ->page_mkwrite()
Message-ID: <avLzpIM1VdE31a-B@thinkstation>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
 <avItd6rDqP3GB6pL@casper.infradead.org>
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
In-Reply-To: <avItd6rDqP3GB6pL@casper.infradead.org>

On Mon, Nov 09, 2026 at 08:30:47PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> > do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> > can lock it in that window, fail, and clear PG_uptodate with the folio
> > left in the page cache. ecryptfs_writepages() does this when encryption
> > fails. filemap_page_mkwrite() relocks the folio and checks only
> > ->mapping, so the fault maps a folio that is not uptodate:
> 
> Filesystems that do this are buggy.  They shuld be fixed, not worked
> around like this.

Fair. What is your take on the way out?

Is there a timeline for the filesystem fixes?

Until they land, mm should still not map a folio that is not uptodate.

Would WARN_ON_ONCE() and SIGBUS, like the other checks in 2/2, work for
you? It flags the buggy filesystem instead of hiding it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
