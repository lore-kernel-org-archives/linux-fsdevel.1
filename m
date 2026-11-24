Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.89.141.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795492369;
	b=0PK+l0zYq9AUeCWXz6j1J85fm6UTa99sI29vIljS+pu5Xmgt+fQg3OPM81BI+1Qm6Pr6
	 c+dI6Tbv39YyyVtN97nLpmTjgs9uy7IAp7RkELydcgn3vF4rgIlmAVpzn8mIFwwFd9ONa
	 sC7JUb+kguzyGNChTUqnH/NKk2wIVpAJh05J0BZq5fp6lYWxUsa/g2MWnqwEXODl5W4lR
	 8xhaYMXLC5iGTcHp5G6pSyoyQ4k+Qx/vHDj/0QJTYSQuOLemmpiUNSY+yKgvP1np3dHd9
	 vZ6MqUd460PG4Dz/oJGINTwPuy/RhZ2IqQzZRwWBYwdXVt5F/HWbrdhAv2SlpPtNU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492369;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender;
	bh=ukq1/pNouezx781e4Vayre+orG6ZLyEsiFMusQAb+L8=;
	b=aEFJOV5v+++m+WzcrXa0r1FnRlvyClPLgcqACuRWafd+7q7dqbjdKZnmzq6rQxy9WMtQ
	 arQCZeYXeg8z8HbX0sWLzwufzUtkRPRxtSBZC0V9KkY3OoKX9nUexRvhaMCiv2eO4S8Np
	 IllPNh5SIz39G6m02ZPwJprpucSzqgI4tL3t1srhGzmSBWMTDdXyTGPBlLbiQCekPVeQk
	 r3ELt9ZFcQycg0FF5WutUygEF4G6y/ADPZ+jwaLfwNLqTRw5C1agp2ENKTlxT+ToZ/Ply
	 7P+68dq2Yc9q2PcT/Gk+k88JMReDpEeh4go3e9CNkr/hHuaBP1s6DFQuuE0m2LFstTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zeniv.linux.org.uk;
	spf=none smtp.mailfrom=ftp.linux.org.uk;
	dkim=pass header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=mDlb1ecd;
	arc=none smtp.remote-ip=62.89.141.173
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF89606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 03:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EF89606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=mDlb1ecd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ukq1/pNouezx781e4Vayre+orG6ZLyEsiFMusQAb+L8=; b=mDlb1ecdB8fEVmYGMJnl/wTh1y
	r3S3Rag4fAa6RQfAnQKQZ/amVaU5HDBiDci/D+/4DAUdQbVcVWPTFBElk7L2UolG7MuKknPw2mTz3
	mdXP0+IfoBW/Mko+4djRTk/VnRaZ4fmjpdgHPAYZhf+7XUf8P13o6HSS8ao72Diy1Ocm3kxwI026v
	Gc7kjQmnDoc6FI+2dQ7FlMebBkgujhtY4gb20YcTptsaSVGKvSLkq28t2dYJD8sBTXyYCWpq4R7Y8
	cXrYDnw7K4xdWDU5bl5aUr3NOBwDlg31mCaNTprUIrX+Qt2JngXhrB6l4UHwV5FauFtiRGtP35Soa
	spNIoMgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVhaH-00000003dRT-3Okn;
	Tue, 24 Nov 2026 03:52:45 +0000
Date: Tue, 24 Nov 2026 03:52:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Michael Greenberg <michael@greenberg.science>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, mgreenbe@stevens.edu
Subject: Re: [PATCH] namei: don't count symlinks twice when a lookup restarts
Message-ID: <20261124035245.GX989762@ZenIV>
References: <87zeuz5o4j.fsf@hippogriff>
 <20261124031649.GW989762@ZenIV>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124031649.GW989762@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 24, 2026 at 03:16:49AM +0000, Al Viro wrote:
> On Mon, Nov 23, 2026 at 02:44:28PM -0500, Michael Greenberg wrote:
> > So a path that crosses n symlinks fails with -ELOOP if the RCU walk
> > got through more than MAXSYMLINKS - n of them before giving up, which
> > is possible for any n > MAXSYMLINKS / 2. A mount or umount anywhere
> > on the system can make an RCU walk give up, since it changes
> > mount_lock's sequence count, so whether such a lookup fails depends on
> > unrelated activity. Opening the first link of a chain for 3 s, in a
> > 4-CPU KVM guest, while another process mounted and unmounted a tmpfs
> > in its own mount namespace:
> 
> You don't need mount to kick you out of RCU mode - just walk through
> /proc/self/root/... at given step of the chain and you'll get deterministic
> behaviour; no races needed at all.
> 
> Bug is real, but I'm not sure I like your solution - duplication
> between path_init() and __set_nameidata() is confusing.  We can't
> just drop that part of __set_nameidata() - it's possible to get
> from set_nameidata() to restore_nameidata() without ever reaching
> path_init(), e.g. in do_file_open() if alloc_empty_file() fails,
> so it can't be dealt with that way, but...
> 
> Let me think a bit; if we go with your variant, we'll need a very clear
> comment along the lines of "it's not really redundant - removing either
> will break things" added in both places.

One possibility would be
	p->total_link_count = -1;
in __set_nameidata(), same change as in your variant in path_init()
and
	if (unlikely(old) && now->total_link_count > 0)
		old->total_link_count = now->total_link_count;
in restore_nameidata().  Not sure I like that variant, though...

One thing to keep in mind is that reserve_stack() is not the only
place where we bump that thing - follow_automount() is another and
there we don't have nameidata on hand...
