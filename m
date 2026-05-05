Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F733A5455
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003309; cv=none; b=IgShGXx5JAbpYzncuV+Lx8t9HqUGWFG+hQDYe6JtbRJnnFSLXuubpFmBAJcLLt87bD85RC+n3uhBvriK4nOIyToPLGxn1nQG5eZBQKDK89QEjgMeZlftTVw6m4tTwwN4DO+C5NN2k9UPRwIfifECWAIFfvYCiJsDVwvz9h8uKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003309; c=relaxed/simple;
	bh=9E2p9gDY4bCM1MbON/0L4msH0QvFXWO4KLu/KngbEW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+sH9qF9EX/JD/vi7fDpikd4QJQsm7P+Rv8YZNeInUiKnrPwgEJi579Wihqxlc2r9NMydJe5aJ4td3iPKhiIS/7BGlTNajRsxDDQ8EX1qaY4/KNSAFz2h+I0akXzUJtsI/9mrEiia6BO2+wsGizHBnv4MCZ64CTcs9mtk8XnRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HjME3Grt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HjME3Grt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3182iYibxPw7gZw6GeJ+lurCuII/RNa4Aj/j21WqzRo=; b=HjME3Grt7kPI3ThTxH629lv5kT
	pTP8Rrys2+mWtYOsIqHSh49cvPw9cYbWAbfzlhytjns8H0WX2awFLrw93RyTGsPAR6qU5rInnPICX
	tafPNEPLJWv6jiJztyaxMhHVd7MXjizGmqdAGs9R1uPGQ/ea3BV+JZ3MQmiLwHd6O7pK5+Ghrr/f5
	KEEBvDhmGi1VMRjgCQwcxrg6VI4msEdKiDP1owm9fFc/98wG3dbPzhgVo0a8UFHqOgI1LDTnWucKX
	pZ831jWpOjQNKzUZc/ty2PsVYdbNYZlmiTQmaPyxOav7CdT0u04tFgJso5FO3UD8j55RUc6RW86i6
	6mJw35NA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKJsy-00000007I0c-0mdh;
	Tue, 05 May 2026 17:48:44 +0000
Date: Tue, 5 May 2026 18:48:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 02/25] alloc_path_pseudo(): make sure we don't end up
 with NORCU dentries for directories
Message-ID: <20260505174844.GE3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-3-viro@zeniv.linux.org.uk>
 <177796931573.1474915.17389032143652405017@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177796931573.1474915.17389032143652405017@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 06:21:55PM +1000, NeilBrown wrote:
> On Tue, 05 May 2026, Al Viro wrote:
> > A lot of places relies upon directories never having NORCU dentries;
> > currently that property holds, but the proof is not straightforward
> > and rather brittle.
> 
> This requirement is only indirectly documented in d_alloc_pseudo()
> where it says "the stuff that should never be anyone's children or
> parents", and they are for "lookup-less filesystems" wherein directories
> obviously cannot have a role.
> Would it be worth making it explicit? 
>   "A pseudo dentry must never be used for a directory"

The comment in d_alloc_pseudo() is going to be replaced; currently it's
flat-out inaccurate - memfd_create(2) will result in a NORCU dentry
on tmpfs, which is very definitely *NOT* a lookup-less filesystem.

I have a half-finished documentation on the rules for NORCU dentries -
adding that is in the "yet to be stabilized" local followups to this
series.  I hope to get that dealt with during this cycle - this is not
the final iteration of that patchset.
