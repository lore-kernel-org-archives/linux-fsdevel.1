Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69130566B;
	Mon, 21 Sep 2026 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973413; cv=none; b=elPD+S5z5w3l8Zh0wFlsPrS4bT2LLhx4E2q09rJAYHdwe3qpuAM9oxB+AfZhmXjknVOq/FiM1+M69AA6FLZwhFpr5nHkgjO6D70N6ViSi4x6QrXBvMCJfcwku0aeoHYgEtMJvwmjewuR0bosGLyNSWejSLCxfbOB1OsuY14xgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973413; c=relaxed/simple;
	bh=q51AK/Lc/hX9X0Z1EINHLTJQrj7k3dDpc0fhP1dzZA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0KUsibKNpe/48/ESQYSrj1NdOvJVUFAi3EfiygtMr31D4H7UivsMAWd5t1h0HSPquTwuF7LV514ddk/S6a5wJN7F5F+rN6n7BbI7n1BYnhNPTbOCeAwq5BD7/V6NaP9E4qOXgiyFudLKFwzq75jiAxYmD7JQYoxdFRL3w1lMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QfUOxR48; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QfUOxR48"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F9tFljIe5F2jT9DGsbXjRKKiG/p5HJJkbKxnQ2MIpwA=; b=QfUOxR48yb8sHs6Y3HD7wmLeSJ
	LTe58fT7wZFwujLVqEfKJBmwPwA4Hdwywg+PzDESPHGyje+mYKOrSB5eMzaKRRNKBAle4Du5nPCVH
	x90p0DkGtP0rtueQ0kx+diHcj2vpQudkOQSWPBwZvL6IlEVUYVs38HD0ywLm6D/jREcy7rt6A32Oy
	zjvdh5nz9WhFIDCaXji+KG75c7TF1r/TjiXWKSVZgazsRPOJ/pMBLyIIflszB6gi20nMm9SJA3iai
	3UbsCw4X4sYFyuO5WBrQuT58Wc4G+W+G3gkpmeO62WiCHM17LJxq+6H/q/gHBB1jDKDotGPBXwKLd
	nFqK1v6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Xqo-000000017Fa-2T1U;
	Mon, 21 Sep 2026 06:50:06 +0000
Date: Sun, 20 Sep 2026 23:50:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, brauner@kernel.org,
	jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/3] minix: add iomap functions and definitions
Message-ID: <arDTnjK84EGsIeYE@infradead.org>
References: <cover.1787770110.git.jbingham@gmail.com>
 <e7ab836149f814b04017905dca2e07a4c94078db.1787770110.git.jbingham@gmail.com>
 <aq1GsO6dkS747OEb@infradead.org>
 <CAMyBmMA5bOaGK0TfPMGpmfR6oD0k9EdS4_R3RoJ7d5QTjm0bqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyBmMA5bOaGK0TfPMGpmfR6oD0k9EdS4_R3RoJ7d5QTjm0bqg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 19, 2026 at 10:51:32AM -0700, Jeremy Bingham wrote:
> On Fri, Sep 18, 2026 at 7:12 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Aug 26, 2026 at 02:41:56PM -0700, Jeremy Bingham wrote:
> > > This patch also wires iomap.c into itree_v1.c and itree_v2.c, similarly
> > > to how itree_common.c is included in those files, and exports version
> > > specific versions of minix_iomap_begin and iomap_ops.
> >
> > Can we keep the iomap code out of this double build mess?  Just define
> > some low-level helper in it, but keep everything else in an only
> > once build iomap.c
> 
> OK. I went back and forth a bunch on how to best do this, because it's *such* a mess.

Agreed.

> I had a lot of reservations about the way I had done it, but
> it's so all around
> messy I ended up there. When I refactor it I'll either move that function to
> itree_common.c or craft a way to get that depth information out.

It might be worthwhile to kill this mess off first.  AFAICS it was
written at a time when branch predictors where much worse than
today.  So having a branch for te two cases much lower down in the code
should be just fine with modern CPUs. 

> 
> > > Also updates 'unsigned' to 'unsigned int' a few places that got picked
> > > up by checkpatch.pl.
> >
> > If you want to do these cleanups please split them into a separate
> > patch.
> 
> Noted. I did submit a patch like that back in I think late June or
> early July, but got
> told (politely) to knock it off. I had kept these cleanups because of
> checkpatch.pl
> griping, but as you said below there's no technical downside to leaving it.

checkpatch.pl is a little weird sometimes unfortunately.

