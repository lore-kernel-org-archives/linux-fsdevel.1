Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628203264DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641708; cv=pass; b=gubUswwlv39axT67RUduzO/j6LBvGXkor4bMUPqfHRjGYWQDS0n/4+d3VsOCPb87NE/3CT0Rrm6MjIA+s08OfnZ1HzKvONxniI6r4HT0paI9ND8U5fFDvFLU1CO3rn1NizG6YXtbtgva7QHWCZJbZFyvlSCD2vHjCVSLjBj2c9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641708; c=relaxed/simple;
	bh=YLC6H3tBQW6nRRMf6LiPtQJuL1Ra+q2lA0+1KSYOB+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM3/sVhzQcMw5jcM02N6eaggpZfncgxIqQBgmwXTgjpTMIQ0H68StKV4IoulzLH49dxr38SSm1YRVBwXm5nKD8MC8ESaZZFJGc9tnILZdKWBiWCd6IFtRwqj8vgg8GNtDewudjc0E17FmeJlj1Js8LlgLuhpLHdNvLjPZvj1ReI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QDR9SP0L; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QDR9SP0L"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52cd38ddcdfso24992631cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 00:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787641705; cv=none;
        d=google.com; s=arc-20260327;
        b=cpz4mmsfLuLa+BuCpkw6nkWKI4G6svKANMq3HJ1auvDmeRPMEqRsM/zK4Ie9WNJUBb
         KVoHnM6gX23x2ksqquRV8D3KrQ4THqIyFv6z1rLueYgCflJINVP2W9U0kpyb6gvw7FM+
         NGaNNTdWBEaOGiqX8brhiWbLPas9q+oaIOqzFdcW0A0KnvD92kh6GdjYojNrBfvxXe3q
         wVJC4A4cuR6f4hMXJ8QDCBXVwatUrM1sfXDyCISlRLqyE8alufIn5tkT1sSeRJtx3pxs
         Ej9hXK5sdchVMOKVegqjpxLhMiZdUoNE2ch2x1v3FC7+/vixKuVJR/aDpuyE43KJWD2l
         nwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FUPUaRwtppzW7Cz0zNlhCOY1JMoitTGaOwtquxqzhgM=;
        fh=TE1xqE3nPFWmche505xr/x/r4xc8pw+yw4yRFupevVc=;
        b=EPQHYgW/gH6qj93RzVdZVEPb6NUmkzFQOzGw50EZTwVFu2lvp1o/OTZTYuF6EhFeCp
         1trM5VjtWHX4v0YjlYt7gRereAkVgBgTwXHr4FeqvOCujGcid/LDKWrGd1mFJgHt1HLs
         sG4Zg5md7eENWI/dbUfvLoj1vJUo1ma/h+bpUrYObknCKhs8rHS4D2lvg8x6JVEIDpBY
         4NLnYG/gD5zbJTeV52uR0jRkFSrh8XCzRxII2iibkadf0oDWhoivh9l5mR4YKQXpA+4e
         FS4zme8OzShlbeB/bTyrbuvthqTNs6Y5PBHl0ntYsupCavyBN/lNagZ9e7SwdQs0a1Cb
         Qsnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787641705; x=1788246505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUPUaRwtppzW7Cz0zNlhCOY1JMoitTGaOwtquxqzhgM=;
        b=QDR9SP0LBmea2rHSDTV0eo8peqwJDbaSjDSIZdSl90nnAHn/gJupLYGgdHr2FxtVq+
         SFDyJ7cJsc2jPxpn8+S470xOxvgH5AU7+nX9O3JJbgHdOwXUhvfjaj5Rr55JBmEDEWwU
         OsBctqdU+N528P/96TDw3jhV6lMu/TzDWDAr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787641705; x=1788246505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FUPUaRwtppzW7Cz0zNlhCOY1JMoitTGaOwtquxqzhgM=;
        b=DP7nAA0hPu2vSIKPaEd1BNlI1NIBW7p/S29PRZIU9773SZvCT6yz6UURyzS+jXd7YQ
         yphdqlQZueaN8gAtxkDrKh6A7Bdz8DmuQwAfEk8oCxINQ8d/x+KKS4YnFDAkKFTw1Da0
         ZpCu6657xGTFRrrlY9xqNULRPNeHQWcRujh0xeFFXYOhIUyex08VZbFzAS75oVhki04r
         xGjEkfnvOQXIXmIZyvlHjR9Nh4m+4BY+RF2v+dxirooGZkJ7O5bKkyfzMx0LIcb8PQeb
         EvosQigbidMW32PryZUySmfLBJPxp530yTi+fxF9eCsTLkfMS0VYM6o7kIdxr7LImgSQ
         ha2w==
X-Forwarded-Encrypted: i=1; AHgh+RqJ46hOs5v7A2i/4u0sb1BFf4TQx0bF4JB7EdXw8TmEGNxOzUrpdYPUctItI6ZopY+HSvTpfWml8M/4N/Vi@vger.kernel.org
X-Gm-Message-State: AFuF++mJPswu8yra8UUTpy/zl8d2Om83cMuyJkkTWkOaa4bH5MKhsV4P
	XfYxWFWxj5zoiT/6PReiAucLDnNl/VezRL8xEFEOQL6hH3Qnfqvb5bsAGwSQKSCcx2LnVedZqJf
	nJXNu6s1cpYpEDnxFrfLcG2oujCPEHdjgZItcLlHIHA==
X-Gm-Gg: AR+sD10vPPUbayua077zEPzjnbrNBZ3U5J3UjQ0a4qc64Raq2p052fmPl/iwX3U4JQQ
	WrMO/ekKYtXT2Weiy7EdQJAYC5mydHMVRo7L+l5LYE05OAVjNzXln3v+f5BAbEJeznFQ8U/jnRw
	l4Lx9acXiq535px55U7oBEQOgrDh5P/g5U1+X7nytGzvf5jkI8cIZ2UiGh80EvYy5LvyT0lWr2X
	gCSca5eojbQAU7QSKO8rBwMX+VUc6pymyuRZlrKYd1INjvBdKKwkEkyUwPQzUSG0VhF3QXsYRY5
	Hj+ngOw1s/FjytroBmsugEn3ajE6zD1UanXuV2iwqzf3ION2VT55hCPORmbvr+fLNVlqUxIlrGx
	1sLM=
X-Received: by 2002:ac8:5f53:0:b0:52d:6afd:7db5 with SMTP id
 d75a77b69052e-52df59ec0d3mr342600351cf.25.1787641705339; Tue, 25 Aug 2026
 00:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
 <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com>
 <aoxHOSC9kTPbKeNq@casper.infradead.org> <CAJfpegv3Ak+qNLb=fTSCSz7-taQ3Ui-Hkmqgn4PaGPe=CR4cbQ@mail.gmail.com>
 <aoyKxvdQdeJQfPHj@casper.infradead.org> <CAJfpegtgenUaudDcvecJuV2_WkkVw=gdcB0Eqg=UFKPMZP1uKQ@mail.gmail.com>
 <aoyt5pL7mXYwSqsG@casper.infradead.org>
In-Reply-To: <aoyt5pL7mXYwSqsG@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Aug 2026 09:08:13 +0200
X-Gm-Features: AcwNN1VLOxg4TFDsQzXPHVySuwqrEIZSjxOFz1CuAgo80c2cUSWOrt0F79eOWzI
Message-ID: <CAJfpegv_SKhArUNBFUtsmkXSn+JzYgOjhFOqVf-Yd9MnsjBY_w@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 24, 2026 at 09:33:03PM +0200, Miklos Szeredi wrote:

> > In the second case filemap_write_and_wait_range() won't write protect
> > or unmap the page, so it may become dirty after the writeback.
>
> But that can also happen in the first case.  page_mkwrite() can be called
> immediately after the folio is unlocked, for example.  Or the folio can
> be evicted and replaced with a different folio which is then dirtied.

Let me try to make up a very concrete example.  It's not realistic and
very unlikely to exist, yet something more subtle might be relying on
this behavior.  I don't know.   At this point I'm just trying to show
you that the two are really not equivalent, not that this has any
practical significance.

Let's imagine a distributed filesystem based on fuse.  It wants to
serialize accesses to a file to avoid sub page writes reverting to
stale data on cached writeback.  Cached writeback is unavoidable in
case of writable mmap, so it tries to handle this case correctly by
totally excluding cached aliases existing on different nodes.   If one
node reads a range of pages, that range is invalidated on all other
nodes.

The below example show store to a single page on node A and B with and
without launder_page, starting with both having the page mmapped but
not yet in cache.

1) with launder_page

store on A
  - send READ
  - server checks that no aliases exists
  - returns page
  - page is mapped in address space and dirtied

store on B
  - send READ
  - server sees alias on A, sends INVALIDATE
  - INVALIDATE is processed on A:
     + page is locked,
     + unmapped
     + data written to server via launder_page
     + unlocked
  - returns updated page
  - page is mapped in address space and dirtied

 store on A concurrently with previous store on B
   a) happens before page is unmapped:
      - change is written by launder_page together with previous store
   b) happens after page is unmapped:
      -  page lock waits for writeback to finish
      -  sends READ
      - server sees in progress READ on B
      - wait until READ on B is finished
      - sends INVALIDATE to B
      - ...

2) without launder_page

store on A: same as above

store on B
  - send READ
  - server sees alias on A, sends INVALIDATE
  - INVALIDATE is processed on A:
     + page is written back
     + unmapped
  - returns updated page
  - page is mapped in address space and dirtied

 store on A concurrently with previous store on B
   a) happens before page writeback:
      - change is written together with previous store
   b) happens after page writeback but before unmap:
      - since page is still mapped, store succeeds, page becomes dirty
      - at this point we have differing cache contents on A and B

Thanks,
Miklos
