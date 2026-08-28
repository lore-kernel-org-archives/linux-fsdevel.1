Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170102EA749;
	Fri, 28 Aug 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938425; cv=none; b=G+pW2fotMitWiKJ4hCHPxtKGLoX9nN7fZBq4HwZcMBvYgVg4mYyRbOJUUi6EztULXYgBW6Bamih8Od0/hrLv7vrsSMqtcRdXlj+vFLssXeS+7Y2Rt1YRC58rgRd09hLbrZg/wjqosYndbnLX0eMyOT8b+dlzJz7LjrYZrf3IH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938425; c=relaxed/simple;
	bh=6IjQESuhLKpJIc8OBUzMTYR5SjB/W9wzOPcfg1o3YGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH06K1B6NzNTSPKmXK6SV7q5My9ZcbB0llPfnlc4f8NQ2UoUNsZeWlCFn3S0o5lVE1vRHzXk3FgCUcf2MNurLJ4xar4am8Hx4wAlZbJFrKj1bRqVqa6Cm7ISTPs//kqezluUtrX6zORfIC4L/1PcanlJz5Z7lyep1HSBVzowxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u9ixxADc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u9ixxADc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=58TB90gDtoT2gCyKPtI+Xjejo2Or6qNX4AWmOIe3p68=; b=u9ixxADcNWpqoL4CR2/w+LNb+R
	+cvHoDegJXc6lRPO3kBcHeSxLnxVkLHrFS7bLL/OmweNL+9uEt/FGYcgsDVnL1e+44wf8F2tx41FO
	n0YVV0X1LVTVTVs7UqmhWUw85xGqcttKdCtAwRk2d/in2UBfQTr0fDhxqeZjsUVJS+MvG9MtTFYHR
	QgOJcczEgZz2N1GEQkbWst9H0wkKQQTwkhD0pN/GO7u2pANMUFqY3tM0rTquSjNjc64GQfWIfUpS2
	6nxaZaCeJorCE+J1zK1HMGkX2IoqSt0RCP76pFtluaMTndWJvJUALrBCL1XrV6jAyOLTNi+nFU8Oa
	GC2UFNQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x00ST-0000000FB16-28m8;
	Fri, 28 Aug 2026 17:33:41 +0000
Date: Fri, 28 Aug 2026 18:33:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [GIT PULL] Remove dependencies on pagemap.h
Message-ID: <apHGdfwY67YZ4sEr@casper.infradead.org>
References: <apG8g-5krNRUFUuD@casper.infradead.org>
 <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>
 <apHC_mHJ3wsJPEgy@casper.infradead.org>
 <CAHk-=wimz+APb9hGEry+vHDLB5D7WZvNGWU89HjGw7wH15KGHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimz+APb9hGEry+vHDLB5D7WZvNGWU89HjGw7wH15KGHg@mail.gmail.com>

On Fri, Aug 28, 2026 at 10:26:22AM -0700, Linus Torvalds wrote:
> On Fri, 28 Aug 2026 at 10:18, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > OK.  I thought you liked this kind of churn stuff at the end of the window,
> > rather than having it create random unnecesary conflicts throughout the
> > development cycle.  Have you changed your mind on that?
> 
> I like things like automated churn at the end - IF I HAVE BEEN TOLD
> ABOUT AHEAD OF TIME and know to expect it, and people have said "this
> is scripted stuff that can cause conflicts, so I'd suggest we do it
> just after rc1 when all the big stuff is merged".
> 
> But I absolutely do *NOT* want to see a random pull that is broken in
> other ways popping up on the Friday before the merge window closes
> that has never been in linux-next and has never been explicitly talked
> about with me beforehand.

How far in advance do you want to know about it?  Because I did send you
email about it a few days ago; must've got lost.  It has been in
linux-next for a few days (would have been longer, but the Intel test
robot kept finding random drivers and configs that had build problems).
It's already generating conflicts with other header file changes, and
that's just going to be amplified throughout a whole development cycle.

I'd love to script this, but I just don't think that's possible.
