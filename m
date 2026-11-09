Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244631;
	b=abLAupImVN9gm6lRweX6pt88/y6x217iHcpkUEUIwIKjiqaJOzC7vqiYivKNf5QeSq2a
	 NrcVy+RoUosCxsAV1Ed627UnCIW3Az08PJAPed3P6vbEU9hNR7ryr/ZvrkkMAKaiUTCQO
	 ugrmHeVKfkTotqyS+M+lCKIPzYZ3pxZyxF0FuZT9y2pE2cfKWq8bLAFL44C2lpMyQUaQu
	 GcR6Hr9icMjCw7HQCFUihx+shwKBSod4dTcEux+HHauyGTSZrEoWT6lDqrDb0ARN68FEE
	 A9bLnWE4hHrLiG/7XEjgmp37IFjBk9DuiUg6VC7og4ir7YKKD0nR38yEMcoHIdLf6nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244631;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hikr3NdZOFIV97qGG552H/Op66kxtcpyq5g4qXWJP2g=;
	b=TCUOI1YTEVXYweAlLaTfp4uAlwT1zDYKS3jdaAt9JkDTf3Es9+UAYiBeZVZjFBIj2hCK
	 MPIk3n3AhvI4lIH+KmGnSGSNvuIYk2tehrlhN9SPVXF5vlKxDEs5l7ok5ce2j0uuaMN0D
	 JpOPKLFdh6onRQx9A32YAXzz/j8rs04DcAUUNcxuFGQRPIyxKB7HHjHWk78U51pPz7/wa
	 QgB6GKOUCKgLSRRU7dOJDtezB4baYDHsN0v9/Pba3F0KwLJeW1fLM6wIes/CmUjBidevT
	 zYYNrgZRoS53Biz54Af4u9k6Mc+V/DM82hxwbw1avtuibl/ntdewS0F3Dezi0aWE5hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3BQpc24;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A215606A330
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3BQpc24
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF931F0089F;
	Mon,  9 Nov 2026 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244631;
	bh=hikr3NdZOFIV97qGG552H/Op66kxtcpyq5g4qXWJP2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A3BQpc249JiAHGzDn/jKaB8/JdsBIQYKxlvcX8a0z19TzLiikm66XpXAZ538sdUcg
	 HOUH4neX3WFMPk7uZlcRp7Xnlv7xbTSepi4Ya3yUwuNLZ43f9LcP8gMgz+oWQOJEFe
	 GWxh9krtyQflCmZelNlaOIkpnwqIHSnI8/fTh0bgX3QgAFusG9UJzY1d/wJP2kxUsc
	 bBDk+RGGOVN4t5vWbIYF5DrL90v+ZwYvib0KfFU1w0BHjeIl/QvXKUUznqhrxjOjjm
	 kt7K0LOyNoHajLVVR6UWA5sovHFXE4bZzkG/AC7M96sG0Sb6a87ZZlQEYKPIH8ZIUH
	 HOzaAikrio9wA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id CBB7E1980050;
	Mon,  9 Nov 2026 12:17:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 12:17:08 -0500
X-ME-Sender: <xms:EQDyal_E3i3-JOyrXgAel3XmchxyRy6dJKHmn0RHn09DQU2qOx53hg>
    <xme:EQDyanWxemPQ8pkRZ3YIAgJXgCHOaoZyOyNuPrDU5zA2HaG5sWlsImUkQtTh6Bzdq
    K_oRDDnMt_Uvxe17C4ltpB7ARntMwEY0niGeDEOzmakFyjqhWkQTuCq>
X-ME-Received: <xmr:EQDyaqY-wXPnBLr-hCcdNW8K2xDebDgZ6hWdC4L97R30CLsRRXQaW2WkeWE>
X-ME-Proxy-Cause: dmFkZTElZQIW6SWcaw1iguscu2eY5QRPkCI+Zh7YF9LAIl6Q6UDTQUJwYU5pgh0mTZpmF5
    NxbI9uk32CzRVwmOylzVie+SWfDBrEYcRZ2p1j1AQ/MuQcSePoOec3dfy1ajnlOjYwO1hl
    Xbo5hNTGbMq0y+sDiK+aCg9uHGvxRy7N3Vq+rRj2PhA2LLezz9+bkjEBvK8ETAnlSc5TZR
    akrsVfCK2YDA101kRiLJ8f0MlU4hyylsv1fMuxTwHhQnwjjvVkpGCb5ees+82vtcTP3kO+
    WocAA+bVDijg7kHIjKZXEn2dV9MY1IjQ8Sm1IF6WYExkFItyIcDhe9h9bl4fPV9mWjJUnY
    DzCUMfJsGPdbDNKvpXAWZxzzlawuUdw6tZGAmgVqamoAzzCihQfFMmK/Zx8GOl68saGJIx
    6YlurgnnIRLoX1tHfkwEq8INt3eSuOAdIsI/iT3mhaKEXxVCKwX8NxZFuTwdXRxAaaZWJd
    Zo9dxHry3xUo1MsDZaFCB0yHpzXua+EIBPQ8zzN2OylaHG09yWtEzoLiEsGiz6/xOCNuqV
    5X6xF4+kz8U9F8mw5cDCkCSf+2seoPzNTK2phXDxtLlectgNneWxA6GmVuDi6QtYrci6H0
    UM1nBtG2OIZRUWr6iYNSsJ2OQk9fT/GmSreDs7XCkBonjX9IDZfzAYYaPTSQ
X-ME-Proxy: <xmx:EQDyahqdwG4SwoeTcbhVCpgeaBptrobVJSl3lwLMRXXr7y3al7i06A>
    <xmx:EQDyah74B5-hdy-JkxViNftHu2_nEgrX-ElvPBIxzsPbXPhDCq3aJA>
    <xmx:EQDyarUZh4JrJRfeBxK_Z2rVLGPtiG7EZ0I-MBGqFaJZ79tOt2Cu5g>
    <xmx:EQDyavvaWKiEUsAYuDF_q8xdT0s-OFkyeTI9FYlZDwxqsvbSi05JsQ>
    <xmx:EQDyagrbS8mKwXtaEumhHAY747RpoQ1KmHErQTqj7u4kdzLNTLdfiGFe>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 12:17:04 -0500 (EST)
Date: Mon, 9 Nov 2026 17:17:03 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after
 ->page_mkwrite()
Message-ID: <avH3L4ZbQC6fIt5s@thinkstation>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
 <avHWhZzXE-ge6nU6@gremlin>
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
In-Reply-To: <avHWhZzXE-ge6nU6@gremlin>

On Mon, Nov 09, 2026 at 04:11:40PM +0000, Lorenzo Stoakes (ARM) wrote:
> On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> > do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> > can lock it in that window, fail, and clear PG_uptodate with the folio
> > left in the page cache. ecryptfs_writepages() does this when encryption
> > fails. filemap_page_mkwrite() relocks the folio and checks only
> > ->mapping, so the fault maps a folio that is not uptodate:
> >
> >     CPU0                            CPU1
> >     do_shared_fault()
> >       folio_unlock()
> >                                     ecryptfs_writepages()
> >                                       folio_clear_uptodate()
> >       filemap_page_mkwrite()
> >         folio_lock()
> >       finish_fault()
> >
> > The next read(2) or fault on the folio reads it in again from the file,
> > over anything stored through the mapping in the meantime. Those stores
> > are lost.
> >
> > Recheck PG_uptodate once ->page_mkwrite() returns with the folio locked,
> > and retry the fault if it is clear, the same way filemap_fault() retries
> > on a cached folio that lost PG_uptodate. Skip folios outside the page
> > cache: driver pages from ->fault() never get PG_uptodate and would
> > retry forever.
> >
> > The check stays out of do_page_mkwrite(): wp_page_shared() calls it on
> > a folio that is still mapped, and a retry there would fault on the same
> > PTE forever.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/sashiko-outbox-202966@kernel.org/
> 
> No Fixes? Sorry I may have missed context from v1 here :)

The window is from 2007, when __do_fault() started to drop the folio
lock around ->page_mkwrite():

Fixes: 6967614761fd ("ocfs2: release page lock before calling ->page_mkwrite")

Not sure how useful such Fixes is. It predates any possible stable tree.

> > ---
> >  mm/memory.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index fe72e66c9c2e..cc1d0b7d15c7 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5613,6 +5613,18 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  	return VM_FAULT_OOM;
> >  }
> >
> > +/*
> > + * A page cache folio that is not uptodate holds data that was never read in
> > + * or cleared, and mapping it leaks stale memory to userspace.
> > + */
> > +static bool file_folio_not_uptodate(struct folio *folio)
> > +{
> > +	if (likely(folio_test_uptodate(folio)))
> > +		return false;
> > +	/* Driver pages from ->fault() never get PG_uptodate */
> 
> I guess you mean drivers that return non-page cache folios from ->fault()?

Yes. How about:

        /*
         * ->fault() can also return driver memory that is not in the page
         * cache. It never gets PG_uptodate.
         */

I would rather avoid "rmappable". These folios do get
folio_add_file_rmap_ptes() in set_pte_range(), and the word reads like
PG_large_rmappable. As you said, DAX never reaches the check, so "page
cache" is accurate.

> > +	return !folio_test_anon(folio) && folio->mapping;
> 
> Technically folio_test_anon() can never return true based on where this is
> called from right? Could this just be a:
> 
> 	VM_WARN_ON_ONCE(folio_test_anon(folio));
> 	/* ... comment */
> 	return folio->mapping;
> 
> Instead?

Right, all callers pass a file folio.

I will make it an assert, but at the top of the helper, so it checks
every call and not only the rare !uptodate one.

> > @@ -6163,6 +6175,16 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
> >  			folio_put(folio);
> >  			return tmp;
> >  		}
> > +
> > +		/*
> > +		 * The folio was unlocked for ->page_mkwrite(). If it lost
> > +		 * PG_uptodate meanwhile, retry the fault to read it in again.
> > +		 */
> > +		if (unlikely(file_folio_not_uptodate(folio))) {
> 
> As Pedro said, I think this unlikely() is probably unnecessary given the true
> return case is implicitly unlikely.

As I told Pedro, I prefer it at the call site. That is where the reader
needs to see that the retry is the rare path. But if you insist...

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
