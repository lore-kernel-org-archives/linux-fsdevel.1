Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC83314D2;
	Thu, 16 Apr 2026 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380080; cv=none; b=WMrf4ry9qyqafbKC9yznpjaAMESUAuENrjXgKSlx49kniNFnkW+yiqeWwu4sI1F/FrpLvn/URHlEsckfVR6i0wFEl1nbKyxPy+fYa4xm4ENOVNB/Wc4Ga7yqXZ+JIHkOJWAoVnLyvFay8cIS+aCTHXCF4ypE5aXelhRWTryXT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380080; c=relaxed/simple;
	bh=ATPXeRoAsRHIcIzvdbBRztN9Yhx18NZMiIEeYze8dVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0AgteL+5s5Y4agQ62YacN3SzuCO8dsj7nbwkyQdEvZstw8BhSvvvDP0v4HjCxgqpR0qPEtB1pqehWT0rKrTmjMOxetGI5ekI6DTMJulGbExzx2p2dd7DIDHSe7MQzLtOcfZ/Cm+lgb8iCnud+LcaOntqRaSPZnGOzCmurKZ61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j3KbGLLH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3KbGLLH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=70wXQYbhJM7AqOu9XvzWJyY5HOypR2Viawd2GTTE5dg=; b=j3KbGLLHk4Ls/BU1QHj7NpvII6
	tsTemh5kad0D9+C7shFGt7goWWuBK88Jw7XDnDR0dgotQaGLKxTj+o4cRh9Rz5uhFkraGLFkQ0L47
	I1wTLyFjmFZr7LdBm3rEizP/RHyZ9eTFWPQF4kLCbukzMd7eqfqezYzh4I8MkwUKgnmcXYEwOTp2f
	b0treebYcg1QiUSOSAw6K/+SkG5IV7N9K9fVFatyzenR0qHQIrBb5tYGP553KxkXC3PjcHHsR7RJu
	lqSgYreiM1PGErBsfBDsPi5wi7em9JyluzWrLi7VG7ya4ASfMiYuIgyqLih+NGQwrl+9gPFF14tT6
	d2cgBFuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDVbY-00000002Lys-0Xsb;
	Thu, 16 Apr 2026 22:54:36 +0000
Date: Thu, 16 Apr 2026 23:54:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Nikolay Amiantov <ab@fmap.me>, fuse-devel@lists.sourceforge.net,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
Message-ID: <aeFoqxAIaPtqGtmz@casper.infradead.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>

On Thu, Apr 16, 2026 at 02:12:37PM +0200, Miklos Szeredi wrote:
> On Thu, 16 Apr 2026 at 09:24, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > > I've recently encountered a weird issue with JuiceFS [1], a network FS
> > > which uses FUSE. tl;dr: when a file was being slowly appended, a reader
> > > of the same file on another host would periodically read a block of zero
> > > bytes instead of the actual data.
> 
> Thanks for the report.
> 
> I wonder if we could clear PG_uptodate on the page which had its zero
> bytes exposed by the i_size increase?
> 
> Willy?

I think every filesystem which clear PG_uptodate is doing it wrong.
I know we have ~30 places which do it, and I haven't audited them all, 
but clearing the uptodate bit can lead to the VM throwing an absolute
fit if any of the pages in that folio are mapped.

I don't think it'll make much difference whether it's cleared or
invalidated from the page cache.  Either way we're re-reading all
the data in it, which would dominate the time saved by not doing a trip
through the page allocator.
