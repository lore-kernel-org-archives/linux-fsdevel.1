Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.89.141.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490214;
	b=G40vX/fG50KxXqSD+YwSbZX9B3sdtpQL8HN4JaEMB3bDPDgrcV5/S4eSx9FZnM6YrZfA
	 24a9MYefy+2twVw1YMdLNDL348Fl3nEgPPi7jH0OjeP5iDyrEqdv4Xwu1YLkD8rBiEB5S
	 fHG42KkyiFb022dcEnBxBV6/MZzMhbNsdmaYdBdlk1B93NeHvXD8xHK1wiaqum156eB1n
	 vhsVwbkdcb/uI2lDMFUfRRhTJPjyT4z3ArOnKcqLnn3Vj7HSNOuwGqOkPM0ni7eVZj/fT
	 g0XZSwzyqvZEa49fc5rs5K42HDp2hSK0i2L6OBOW9TSnT0+b3/gYR9Pm4mnhCgGA8WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490214;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender;
	bh=Dz4LbNtgGKcxtF5enz9kPHKWrIwJ0qTuZTGd/H68bKo=;
	b=QPvM5o/7SLusJCsz/4BfpH4gJ5cos+p+i2aZzYj8WtwgG+MOcWeB75PooZsTvQMrXJ4C
	 bWFwNFzU6sfZCyJnivqorztU4rJeCOYMxvGlbt06BzZIj2P2LeeZwsCdXekWz2778AmuA
	 Cff+ZKlj8FxyGM5cAbSA8T7dlrcEMtoBmhWBstOHqK6QIt+XolAb7YYX89QrtpS0A8st1
	 urbV6G+cR1WiA0Es5FO6lEjRwmS2vhbLNrzJ6Q8n0u7ZFE5V5gnU/jjHFTCUjj20kpCOD
	 vgEPXZiuXxGA1GsN8o/lR982gvtx4MbYPtQOWpiIyH45bUBllqVlwFLI9oNeYMSoB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zeniv.linux.org.uk;
	spf=none smtp.mailfrom=ftp.linux.org.uk;
	dkim=pass header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=JzEF9o6+;
	arc=none smtp.remote-ip=62.89.141.173
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9011606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 03:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9011606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=JzEF9o6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dz4LbNtgGKcxtF5enz9kPHKWrIwJ0qTuZTGd/H68bKo=; b=JzEF9o6+XpTQKlypoaOWhUia1h
	8Bf0uXKq/y/FLW7al5d9PcXcWsoDO0K8LMJgAZ3Wo1oui56MktG6Z0Jxptx/qi5hdNU6K7aRa/eqb
	PQAqk8Zto/dBytxQR+Eb1SoYaulqByKy7EEBk81OzAuVlDaqH2LFtVH6gm4Uz2uP20aJ3nlvbugMz
	ZevRLZhQZWp+DPTJhIrbk2oIZWSPpwWONJrZlYz3l1cwYoBDWS47ooo0R54oZwnPN/F9dgShLPI1K
	rmI104gPj+aYQnJys92ieW2cGI/owT0zPjKL8mRoNfryhkSpmXrlQ5Bw70dFBttAy4GGQs/fAtoVH
	hkzXqcag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVh1V-000000034GB-2h4p;
	Tue, 24 Nov 2026 03:16:49 +0000
Date: Tue, 24 Nov 2026 03:16:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Michael Greenberg <michael@greenberg.science>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, mgreenbe@stevens.edu
Subject: Re: [PATCH] namei: don't count symlinks twice when a lookup restarts
Message-ID: <20261124031649.GW989762@ZenIV>
References: <87zeuz5o4j.fsf@hippogriff>
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
In-Reply-To: <87zeuz5o4j.fsf@hippogriff>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 23, 2026 at 02:44:28PM -0500, Michael Greenberg wrote:
> So a path that crosses n symlinks fails with -ELOOP if the RCU walk
> got through more than MAXSYMLINKS - n of them before giving up, which
> is possible for any n > MAXSYMLINKS / 2. A mount or umount anywhere
> on the system can make an RCU walk give up, since it changes
> mount_lock's sequence count, so whether such a lookup fails depends on
> unrelated activity. Opening the first link of a chain for 3 s, in a
> 4-CPU KVM guest, while another process mounted and unmounted a tmpfs
> in its own mount namespace:

You don't need mount to kick you out of RCU mode - just walk through
/proc/self/root/... at given step of the chain and you'll get deterministic
behaviour; no races needed at all.

Bug is real, but I'm not sure I like your solution - duplication
between path_init() and __set_nameidata() is confusing.  We can't
just drop that part of __set_nameidata() - it's possible to get
from set_nameidata() to restore_nameidata() without ever reaching
path_init(), e.g. in do_file_open() if alloc_empty_file() fails,
so it can't be dealt with that way, but...

Let me think a bit; if we go with your variant, we'll need a very clear
comment along the lines of "it's not really redundant - removing either
will break things" added in both places.
