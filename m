Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E428F5;
	Sun, 21 Jun 2026 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782076415; cv=none; b=K4XL6BMzDe0QWcMgCGkbl9V3+jSd4EEXGCjyKbRDyWnYb7uNHEgwHsWploimADw/9eS6bc1lHWcaq1aNT6wy+9YbxKEOB7t5hoNz8H6whJMzi/zaGs0ehqxqJb1zI/gg0Yi92I0QLDD8hHclaJGthPsH36HO6rTKt+m2ZBldU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782076415; c=relaxed/simple;
	bh=DvZQ4aOf0WytUYCaR7czpwKvUFwcfB00kQWSexcDK+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7pquLOvsshs8HbiqiKmf1pyjwjRTmGtrTfhyP0KUZvBRzN4PWtoxyYjwx4Pk+v8pe3T+G+KmMbrIUyBS0RoA0Gaj/OF704CQl8N9i/mn+0i7IVL5acVlMhlYE+AeEpUYw1FjAbS+/1J8wZ2gI+XKOy3PrgmcRHbPQzJ1Ns84HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RTwWS40d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTwWS40d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DvZQ4aOf0WytUYCaR7czpwKvUFwcfB00kQWSexcDK+k=; b=RTwWS40ddPLCHPeg3jW5yv0qi6
	+Z9LZBDaKSsRuPHm8OyxH/NFX7wszNsioOxTLHMsYoHPw+ZydhpDj8CGhrTbVlKf0PR6AZzEfV3Kp
	OhDuxep2+Y0RMEpxxO+dF2ubXWpVdsYnpBSQYrlvwSxnSnpgQBuCeOXkOkks/iEL7/B0ngIrkXPXx
	BU3crXSYdIHGm3e7c6W2ed09CTE2AAibDmPg+kc6vNzk7RChe+BM/o+oDiZKsGpfWxFocYSnudFWC
	d07+8hC5UrCBY+3kBqN36SmovPj/eQPhWpgULtxuiQwSLD4m5IHnNkB2LYh1QEg9t1kAGDESGSWnw
	pJ/YWVsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbPTv-000000030YF-0RXX;
	Sun, 21 Jun 2026 21:13:31 +0000
Date: Sun, 21 Jun 2026 22:13:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <ajhT-rHpo-r1k-Li@casper.infradead.org>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org>
 <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042112.GA6060@frogsfrogsfrogs>
 <20260610-chaoten-ringen-bauer-516e17aff523@brauner>
 <CAKqfh0GqLNmui=BU1Xw7Xk0StWGueq=k5KN9uN0v6Y-DMWAwYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKqfh0GqLNmui=BU1Xw7Xk0StWGueq=k5KN9uN0v6Y-DMWAwYg@mail.gmail.com>

On Sun, Jun 21, 2026 at 03:50:07PM -0500, Maxwell Doose wrote:
> Well it seems that the general consensus is to remove it and at this
> point, I agree (I suppose I was a bit ignorant :( ). Should we send
> the patch now or give it some time?

https://lore.kernel.org/linux-fsdevel/20260618211822.3599089-1-willy@infradead.org/
