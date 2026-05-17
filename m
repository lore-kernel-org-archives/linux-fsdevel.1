Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30981724;
	Sun, 17 May 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057029; cv=none; b=d8CBTHDiceJwTtym5teDKNGdYSrIBiSbA5TlqXIyU+bHLdrH4tR8H0iw+ZDMoEzo4fXikT9LVX61oHFkElEVomBWWWZ0bxPZwT/XfPVXkb2zKZyQP+oSjCEcVDdfj/A6acTITv+8hKMYMQjfHczC2pcYCagb7rDDvTmTU9PsNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057029; c=relaxed/simple;
	bh=m2h0LBIOHNh5aa9WxzrmOqSSYlcEBzRHVOWAbr2ntYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2ueSLdzDeH7o/MDk7Fz8/HInlJtMdhUGJNGMdNq44r9r6B8U20YfO4qKxqohwb0MiMu4PuUGz53fNtvqHxQg1cRNfua+XF2IF2B7plgK4dM0ejSOdtGdUpsRyXh8lhyVLWPA1MY0GS0Ly8L3LxxDQUF4z9YwGtwJyz79J3vlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j1EPakP1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j1EPakP1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MBu08lIsgmM685ISDCEKZMZU6xFJCxfmHVVSJI5JqnU=; b=j1EPakP1qWP2IxoHgVAwV6M4ql
	sackarG/GlT0nhdIaXPn2GZW0sblIGscHQUK10dmNNYLg5gPaBYhatjRqOdr4B0rxauH8CM7NKBGj
	rkLQ3d9+lj5cezLOZVwELqt5r13C0NUKyjdKZXRC8EAPGTAcsecjexigXkyHXMVvAVFd6c6El1Ra5
	Nl4UyUEoQ01QSibignO00IqNAEr31X9NnybmQi6KfaJ5UIHzCZxw7MXtlluGIcb+1SJ2Pqc4QzHI0
	az/RfSy9utL3Ctr+nBvooc4GRcuImM5tkNQiFoTTkFRVGqu7pPlZW33/rqJQoV1LcSALWAb7MxuI9
	eHbOwY+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOk08-000000049kn-0K52;
	Sun, 17 May 2026 22:30:24 +0000
Date: Sun, 17 May 2026 23:30:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agpBf3PUA3fW5Nv5@casper.infradead.org>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <agj4mXKRVW44ZJ18@casper.infradead.org>
 <agkRpj4oU8TPgmTS@pedro-suse.lan>
 <agkXHu_ON_KyWtvP@casper.infradead.org>
 <agmDiAY-mmlvjX0m@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agmDiAY-mmlvjX0m@pedro-suse.lan>

On Sun, May 17, 2026 at 10:01:30AM +0100, Pedro Falcato wrote:
> On Sun, May 17, 2026 at 02:17:18AM +0100, Matthew Wilcox wrote:
> > If we have a buggy user which
> > can write to read-only file pages, then it should also be prevented from
> > writing to KSM pages.
> 
> Hmm, I see. Are you suggesting we unshare KSM pages here? Or just straight
> up reject them?
> 
> Rejecting would be relatively sane if only we had access to the VMA here
> (in normal GUP), testing on folio_test_ksm() is less robust :/

I think we have to unshare?  As I understand KSM, it's done to a task,
so it wouldn't be aware that it's done something potentially dangerous
(unlike mapping a read-only file then splicing from it).  Also, it'll be
non-deterministic whether any given splice might fail.

Bleh.  Maybe just declare KSM to be vulnerable.
