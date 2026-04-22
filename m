Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0232D2483;
	Wed, 22 Apr 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872236; cv=none; b=O38yNtB0Udtr4wSBcq00T0TgJ+hBrPF01fZ4T0NOqeCV1EUxQ74riCaqnAkhfTDuhoO4XreyWNj1AkXN8C1ZQ9DhqYYxB8VXPGc0CAg1hK6ImfEcAD9UfRgLyzidy3VAQetTg/He0trudISXV65C87BcV9xKjY5oyAej7N14Ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872236; c=relaxed/simple;
	bh=/0wyBpUEBBh2p2qkATVS0PbriGNmv5fYWRKZAXfD8MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK7HK2915ffyeMZgoSGeDlhFWwXZKI4tuFoWXIXZOxGgQVzX02KRrP+/zp4dSWQkWg8btj+sGcjqJmvnqGsnyTSag92a88AL3ZXMcTW19M45vydF//de1rfeP1vKU+exZ3sIhZViET3/LSxNcgP5joa2TqYRz8ryPQ7aATP2NnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q/BP5LzK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q/BP5LzK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMwGOpg2qFivUbvbsyYkOBdD4gVWL+AYmW30nprkaQg=; b=q/BP5LzK66l7izIicvhvAyM/tP
	Rb+kvhTV2VdgnXRFGJAp/BK9h4RBPCn9X47mZtyD8utcmKcbHsXMPWCFWbO4J1mGNGjjD7Z1sQdJK
	gHg30yOV/Qv06Ti4dql0qm+SdHCD6tnlN0Duuaw/Z4G5s7no9HgbtkfPwLmrGFsHEngVCInOe1n9q
	aWpN+NYqcZjbJfx40DhsN1MKW1E7MuwJdYUgkHJ7Lrg6R+UD3M9m7r/Pg1Yddp3X+HI8eNSGV8QoE
	AHxN7S6LXsvT81BSgmRRrLWA7VplDlCcRQEsBnObR1IsWHRH2+946RiH5mrqvw6I4y9zYvmcn2Y7x
	qrg/ExxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFZhZ-00000006Mhy-1tsJ;
	Wed, 22 Apr 2026 15:41:21 +0000
Date: Wed, 22 Apr 2026 16:41:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use QSTR() instead of QSTR_INIT()
Message-ID: <20260422154121.GL3518998@ZenIV>
References: <20260422123345.100436-2-thorsten.blum@linux.dev>
 <20260422143437.GI3518998@ZenIV>
 <6kjrb7mchttfnh6cx2av3aqk3y24346rrl462psfrhjwgle7n3@l77coamhara6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6kjrb7mchttfnh6cx2av3aqk3y24346rrl462psfrhjwgle7n3@l77coamhara6>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 22, 2026 at 05:04:54PM +0200, Jan Kara wrote:
> On Wed 22-04-26 15:34:37, Al Viro wrote:
> > On Wed, Apr 22, 2026 at 02:33:46PM +0200, Thorsten Blum wrote:
> > > Drop the hard-coded length arguments and use the simpler QSTR().
> > 
> > ... which is not a constant expression.  NAK.
> > 
> > QSTR_INIT() is an initializer list for struct qstr; QSTR() is a
> > compound literal for the same.  IOW, its value is an anonymous
> > local variable with given contents.
> > 
> > C grammar allows both
> > 	struct foo x = {.bar = y};
> > and
> > 	struct foo x = (struct foo){.bar = y};
> > for auto variables, and compiler is able to figure out that they
> > are equivalent.  But the second form is not legal for the static-duration
> > variables.
> 
> Hum, I understand your reasoning but if it isn't legal, I'd expect the
> compiler to complain. Which it doesn't and the generated binary of a sample
> test program with both constructs is exactly the same...

gcc is treating that as an extension, without having clearly documented it.  

Again, compound literal is *not* a fancier way to spell the initializer list;
it's equivalent to having an anonymous local variable with initializer list.
It's an l-value, which quite a few uses of QSTR rely upon (and which the
same patch series misses in several places, keeping useless named locals
for no reason).

It really makes no sense for static storage-duration objects; optimization
I've mentioned above is basically a compiler seeing that
	struct foo anon = <initializer>
	struct foo x = anon;
with no uses of anon anywhere else and figuring out that anon can be eliminated.
Doing something similar for global variables is insane - would you expect

static int __x = 1;
int x = __x;
<no other uses of __x>

to be valid C?  Sure, you can prove that the value of __x will be 1 all along -
no stores to it anywhere, so the value of expression used to initialize x could
be deduced at compile time.  Currently gcc doesn't have that (that's *not*
a suggestion for another extension), but if that changed I'd still recommend
not to make use of such.
