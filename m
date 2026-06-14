Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F62E0B71
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781477526; cv=none; b=LeKYTjJXT11FurX7MOY4yAZ/muYrb4YeWs/ABdyLaoWVSIoPgFKaUIhSoW7OdAM1uN4JsgssyTQ2migwkxua7ByhN3RI+NWrIeh+tvIEo0WTZVKeKTZ1FtC8qSXQt4LA03wHXjYH2nSD7jZef0itBe5ZliqMAiTWje64PCEhekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781477526; c=relaxed/simple;
	bh=k8eBUiTze58ni8CnYz9AdDQ0dEz/rKEti1xPtmKZXwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOZOI0grhaqUS4B67ZTzcqCfrQjmAKNGUHuhjNo9wdQQ1pFrwD4obsTlZRWOATVZj/pxN4fgt9cUpGT1abXQkGlcDD0Fpo2I1ybhhpbZ3VtYwUHE4FXW9/OSvNS8ydKUszeBNCvwp96s5DtpAfAP2Ex8rkU+LLZVEjGPUCgbCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MZRbIpcb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MZRbIpcb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jy3rFqRgN3quuPbL4GwuT2XKTGtxiQx63qCkcCl+tY4=; b=MZRbIpcboyuKQiQwcRCdNAwDqy
	AOIwBq2wA92Ql6aQQxSwcGifY+5KEQQn78Nj5orzFxhkax2HDwnjLxsfzqeEXniAwV8n+tb62Xifm
	O68DKwfAiOn7ReCUmImJywijgukZ8yyRY3nvIfDDVs5gXFA6wyCKzKgsIdWeUi/+LUW1riQJ7AtrZ
	R1I0N7aQQiz5qCwk+4O5ehO4I23P1O48remEz3i19R90LatQPi8dSxH3Ea/8ugC9qLUz1Lh9AlhCa
	zlAs4mHqogAxnTMnjAWY7JA/y4jYWONdVBNwOzZqZUsggeVzb8MeFEi5nd5WKvk+Dmrcud80LN1G5
	zCIBkZ/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYtgQ-00000006ntn-1kvA;
	Sun, 14 Jun 2026 22:52:02 +0000
Date: Sun, 14 Jun 2026 23:52:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] configfs cleanups and fixes
Message-ID: <20260614225202.GU2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260614223625.GR2636677@ZenIV>
 <20260614223951.GS2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614223951.GS2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jun 14, 2026 at 11:39:51PM +0100, Al Viro wrote:
> On Sun, Jun 14, 2026 at 11:36:25PM +0100, Al Viro wrote:
> > The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:
> > 
> >   Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs
> > 
> > for you to fetch changes up to 45a62661733904e09b55afd078c815aed6f159a6:
> 
> Arrrghh....  Wrong branch tagged.  My apologies - will tag the right one
> and resend the right pull request in a few

Corrected and sent; FWIW, the difference between these branches is that the
one I (mis)tagged first contains the followup stuff that fully builds new
subtrees before making them reachable from root, which simplifies the hell
out of locking in there (#more.configfs).  That stuff is for the next merge
window, though - not for this one.  My apologies...
