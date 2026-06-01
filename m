Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9A38B131;
	Mon,  1 Jun 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326845; cv=none; b=o0qoEEpLPEvCYsBfTTlPPISv9Vq+4Re6gq8hz7yAsnCSP2ZrSaQpxZENLHKTZd6Dz8fIYqQ62NI2ZnNaCN8kLxxf74xxYYv+rTvldwy+n6lwyAL9aOTYZKX0zp7ZpdIlg6sUPk0g87iU5H8yonHAnjump62+/8hIqUGGVmHwPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326845; c=relaxed/simple;
	bh=5zr5DNvnBbmEdacNZ7FYHg/lhR8EqDT+TTSQ3haB8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts3jRNI2jHuGbJ90brDSNwckLphYRdtQu5J42Jy79Wx3QSjNCXxV2fJCTlMlDAWbjsBgcKiZ2Zas38ZZGtxhQNC7wvzYP5fyQDGKwcjMWJ4LEs3f1jt78Ek7DcjqOfLutiKjb8qysRNQ0F5dZR8PA30+ZNGoiQTpYHYt5wvqhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gt9J7KBN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gt9J7KBN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5PFuOZ0nHYsOGtAGAucIBVF6IBxl0A7E4f4zZcHnKtM=; b=gt9J7KBN8uCLra7cPlyaaNn7dO
	5KjLBx6RNNUabFS4dvt0VbO3rRq8EtoV6V46oEZMC+JnhGjPs/nwl4nRDAEwQN1y0ky9gsl5B6zWv
	WShYUMekK8/Wdh1KhR1P+Chgg5xe62c/u+Ic1Mz/mPk9IoZ7aYJzHfGKWDEiffgG+cKs8H7eC6P6P
	p0NE2DzNRHPkWwguwF3EHM4ov3lSUGqtty3e84zyqagyxgP1AiL+dJCUx9MydcCMFdZERVFKRFL+R
	Ow4dFouqOUPiv7WqdGIuoNrWIVsdUelwUGR5tAVY82QRHVZupxRmbbQnzeWFyKQ3Bg4bESuLi48ri
	6s8Ejb3w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4Ky-00000000IdF-0Q3h;
	Mon, 01 Jun 2026 15:13:56 +0000
Date: Mon, 1 Jun 2026 16:13:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large
 zeroing
Message-ID: <ah2hszECv05z_Dt7@casper.infradead.org>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-4-chizhiling@163.com>
 <ah2HfH3jJZDiNAQc@casper.infradead.org>
 <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>

On Mon, Jun 01, 2026 at 05:02:01PM +0200, Mateusz Guzik wrote:
> On Mon, Jun 01, 2026 at 02:22:04PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 01, 2026 at 01:57:02PM +0800, Chi Zhiling wrote:
> > > Currently, holes larger than PAGE_SIZE cannot be handled because
> > > ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
> > > wrapper to support copying larger zero ranges to the iterator.
> > 
> > I think Hugh put this optimisation in the wrong place, and you're
> > perpetuating that ;-)
> > 
> > So perhaps we can start by moving this optimisation to lib/iov_iter.c?
> > And then you can redo your optimisation on top of that.
> 
> This is a rather suspicious claim. If clear_user is indeed so terrible
> that it is faster to copy, the routine needs to get unfucked instead of
> the problem being worked around.

Oh, I agree.  Putting it in lib/iov_iter.c means more people will see it
than if it's hidden in shmem.c.

> I can't speak for arm64 or other non-amd64 archs, maybe these are
> horrendeously broken.
> 
> On amd64 some archeology shows the following:
> 1. 0db7058e8e23e6bb ("x86/clear_user: Make it faster")
> 
> 2022 vintage, replaces thoroughly terrible 8-byte per-iteration write
> with rep stos usage

That's a good candidate for fixing this problem.  56a8c8eb1eaf is from
March 2022 and mentions the slowness of clear_user() on x86.  So a
commit from May 2022 might have fixed the problem without anyone going
back to measure and remove the workaround.

> 2. 8c9b6a88b7e2f33c ("x86: improve on the non-rep 'clear_user' function")
> 
> inlines rep stosb at the callsite if the CPU has FSRS, otherwise
> fallsback to a new routine which does 64-byte writes per loop iteration.
> 
> FSRS is reasonably popular by now and chances are decent the test jig
> used by Chi has it.
> 
> For a size like 4096 bytes, the 64-byte loop will be slower than rep
> movsb and even rep stosq. This needs to be patched and maybe I'll get
> around to doing the needful(tm) in few days (it's not hard to write, but
> some care with testing is needed).
> 
> I could not be bothered to check how the workaround showed up, but it
> definitely needs to be removed as opposed to being perpetuated.

I'd be delighted if somebody tested just this patch.  I'm not really set
up for performance testing here.

diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..112cae9f9e4f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3427,19 +3427,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			else
 				ret = copy_page_to_iter(page, offset, nr, to);
 			folio_put(folio);
-		} else if (user_backed_iter(to)) {
-			/*
-			 * Copy to user tends to be so well optimized, but
-			 * clear_user() not so much, that it is noticeably
-			 * faster to copy the zero page instead of clearing.
-			 */
-			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
 		} else {
-			/*
-			 * But submitting the same page twice in a row to
-			 * splice() - or others? - can result in confusion:
-			 * so don't attempt that optimization on pipes etc.
-			 */
 			ret = iov_iter_zero(nr, to);
 		}
 
