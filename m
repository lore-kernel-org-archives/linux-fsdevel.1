Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0931354C;
	Fri,  5 Jun 2026 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630060; cv=none; b=R8UlGdusM/zdRHQfNgZ2XMTiAbnrQpMEJ8oz40WOQaWLUKSXPHMIsA5kpHmZYh+3cKPZfRdng9w+NRj9O2hLPUR4hN12xZlxkyoosUXcHpqdRZze/bGQNbvS5B5YPOn+gLYccs/loBG3dpnqPCR6tTWhnlrHWZU23cZe2qlOUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630060; c=relaxed/simple;
	bh=WGhzWgVkkTxobqUNfhIPWile5eCI0snVZHEMLoyrp5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN7eEb5ZRo50wDLxHvuXSvK0lsAsV89iZ8/Sge41vKA2AviFaEq2RRmyvBE8lQWmbfnbY1cUVjFcg5UZz+UO+RfB8UPxqnGm8XBLo3LhPmPZQrV4D/EFqrDLglVM5Xke0itbcY/dRbN9OzQgoBBA60qmI93Byq07skhvGQhIzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wnsz2eda; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wnsz2eda"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lv9eA+Le5kexy7LczFjsOeDKMMN9eLnzmeSeRxgUy/M=; b=Wnsz2edaq3xpE0b82VOfeQp0kh
	qgqP76V0CRDlwLILlrRcVOryGXPmVCwzTXAuJgPUFytjn72eZnQner/tQ6ZmbFYBRBt7zrZXs54du
	biZv69YiSy2bYIb9WeyNUDoao4QA1Aw5uud5L6Z5nhNBLp80LQhGO1PyK134tMZR7UW2aDAJVAjHP
	vbt5PUxhf9yWiV0/058j0gC2+2Iq9fXb7Lz7NyqceLXZ5ME0MDd2JH1FxSNrNuScDN7YEulhGidfo
	t8u1DS9o7j8EZj9C+IZCnTMaY1pA0cq/APFGf+BaNz5l09PxuNQaznIWHSxJ0cR+RY0H9cRPvuoMT
	FAsFs4jg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLDY-00000007E6o-34mL;
	Fri, 05 Jun 2026 03:27:32 +0000
Date: Fri, 5 Jun 2026 04:27:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Fabian Frederick <fabf@skynet.be>,
	open list <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
Message-ID: <aiJCJNgm6pYKgqbn@casper.infradead.org>
References: <20260604202441.65226-1-m32285159@gmail.com>
 <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
 <CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com>
 <20260604195355.c2446336f3f8cdefabadc697@linux-foundation.org>
 <CAKqfh0GR1EbuxTcuTnUUS34QLiinkD7TPCCEqpd-8oS3S824ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKqfh0GR1EbuxTcuTnUUS34QLiinkD7TPCCEqpd-8oS3S824ow@mail.gmail.com>

On Thu, Jun 04, 2026 at 10:16:44PM -0500, Maxwell Doose wrote:
> ps: I noticed this was listed as an orphan in MAINTAINERS. I'd be
> happy to step up and maintain this, I've got a bit of experience
> maintaining stuff in iio. Hopefully this isn't too far-fetched!

I'd be just as happy to see it deleted.  efs was succeeded by XFS in
the mid-90s.  The last efs filesystem I personally saw was in 1999 (an
SGI Freeware CD).  If there's any filesystem crying out to be converted
to FUSE and removed from the kernel, this is it.
