Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC72F25F5;
	Wed,  1 Apr 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045757; cv=none; b=Dxa3nQ6OMMEDoXFxeUk6n72YgMS+GRyAFPPxne7c20VRXpEW8dd3lpxPziYwENmdpi6JWUAMAuMLX6ulPmf0/Mevua7l9C23hQm55d6eUsJAixJ+7euWWzSnD4tUsVYL7kvR3oSBpBY6AI7ITVqiTguDcjqfgUblmxja/T1oPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045757; c=relaxed/simple;
	bh=YNL+ocXXshUAIo5niCxPbv1t3SHEDYoryDkMTNWbp10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVyV0ajFq4oQ34YtxrlektQspr5KCDVLt53IWEOzq1yIeVIBXt4CU+I2asOyko1ObJujbT09lw6NzrDKrg8arySenGx0hbBdpg4moYHMtMS3Uy/rGaEoyIjbBOKuV0lX/V5NvLAY3udxfVvqh9ZmMDylXIb6B6TRKEqyPGNLkgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=XkWH7QcF; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="XkWH7QcF"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fm3q90T4Wz9v57;
	Wed,  1 Apr 2026 14:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775045749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNL+ocXXshUAIo5niCxPbv1t3SHEDYoryDkMTNWbp10=;
	b=XkWH7QcFYTt9Qf9j59nFAFDjAeGdGd9PjhajJ99h4F0V7VGGGqZJSZSjcI4EcZzGdAK+1X
	6B/RuTkhLEIzC8RI8cGpkr4/h+OkQ1rt0OHGHJkGpwHSIAkGDFieHOD7MzceyA2BCekYhc
	g6S5OTgsbfYb1EBhrHIctMEVq6zyRF5eA0T42zY95g4saru+mLIa/AODvXraZc4tu0vUkR
	Br8MHNqd5ZDVsvEbg2Yt+mqG6rGgT1ApWu93Zq+hR14j8TGu6Zz+nt5MMF7EkOg8CyB14K
	J/XbhJB4vMqPaaURe/JIzaAFWldhYcPyn6k6TOWhh4IRWjyrrCMosvJtrYOEOA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 1 Apr 2026 23:15:18 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] vfs: transitive upgrade restrictions for fds
Message-ID: <2026-04-01-golden-sporty-skeptic-buns-V3CXZL@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-3-jkoolstra@xs4all.nl>
 <2026-03-27-tweed-frozen-omen-inventory-YVLIh6@cyphar.com>
 <239317779.402843.1774821289835@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tusure2o7tuxqco"
Content-Disposition: inline
In-Reply-To: <239317779.402843.1774821289835@kpc.webmail.kpnmail.nl>
X-Rspamd-Queue-Id: 4fm3q90T4Wz9v57


--3tusure2o7tuxqco
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 2/3] vfs: transitive upgrade restrictions for fds
MIME-Version: 1.0

On 2026-03-29, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > Unfortunately there is a pretty big issue with doing it this way (which
> > I mentioned in one of the changelogs back then[2]): There are lots of
> > VFS operations that imply operations on a file (through a magic-link)
> > that are not blocked. truncate(2) and mount(MS_BIND)/open_tree(2) are
> > the most problematic examples, but this applies to basically any syscall
> > that takes a path argument. If you don't block those then re-opening
> > restrictions are functionally useless.
>=20
> Ah yes. If I am correct, it would block all the fXXX syscalls from doing
> harm (at least w.r.t. read/write operations) because they use the fmode f=
or
> rights checking on the fd, and this cannot be changed without going throu=
gh
> an open() variant.
>=20
> Hence the issue is the case when we pass a magic path to e.g. truncate()
> as it does no upgrade restriction check right now on the struct file. So
> we hade to do this for every relevant syscall. And the question is... whe=
re.

They would also be bypassed by AT_EMPTY_PATH, so you don't even need
magic-links to cause the issue. This is why I considered doing it with
"struct path" and doing the blocking in *_permission() -- all of the
standard vfs operations already have .

> > It also would be really nice if you could block more than just trailing
> > component operations -- having a directory file descriptor that blocks
> > lookups could be quite handy for a bunch of reasons.
>=20
> Yes, so (at the very least) we also want RESTRICT_LOOKUP for directory fd=
s.

Well, definitely not initially. You also don't really need to call it
RESTRICT_LOOKUP, blocking exec would be the "unixy" thing to do (and it
would be nice to have that to block fexecveat(2) too, but that is a
_VERY_ deep rabbithole).

> > I think the only workable solution to block all of these issue entirely
> > and in a comprehensive way is to have something akin to capsicum
> > capabilities[3] tied to file descriptors and have all of the VFS
> > operations check them (though I think that the way this was attempted in
> > the past[4] was far from ideal).
> >=20
>=20
> I went through Drysdale's implementation a bit. He links the capability c=
heck
> to the translation of an fd to a struct file. I agree this is a bit invas=
ive
> (as he writes himself), and perhaps we can do better. Is this what you me=
an
> by "far from ideal"?

There were quite a few other issues with it, but that is one of them.

> > I have tried my hand at a few lighter-weight prototypes over the years
> > (mainly trying to add the necessary checks to every generic_permission()
> > call, and adding some more generic_permission() calls as well...). My
> > last prototype was adding the restriction information to "struct path"
> > but that would bloat too many structures to be merge-able. I was
> > planning on looking at this again later this year, but if you can come
> > up with a nice way of getting a minimal version of capsicum working,
> > that'd be amazing. :D
>=20
> I would really like to try; it is a very nice problem for me to tackle;
> you need to gain experience somehow :)

Sorry, I probably should've couched my reply with a bit more caution --
I really appreciate the enthusiasm, but this is quite a hairy topic for
quite a number of reasons. It will involve touching everything
fd-related in the kernel, it touches on an already-rejected patchset,
and is a topic that can get very heated easily. I would not rate the
chance of getting something merged very highly, and I think there are
more fruitful things for you to tackle and get your hands dirty.

Honestly, I think most people will be more than happy with just getting
the O_EMPTYPATH part merged -- looking back, I really should've just
done that back in 2019. :/

> I wonder how checking all this in generic_permission() would work. The
> access to the fd that the procfs magic link provides is essentially an
> issue of path traversal, and in generic_permission() you just have the
> inode in question. Ah but of course, you can use the mode bits of the
> magic link to encode the information, as you suggest. What downside did
> you encounter using this idea?

It wasn't based on the magic-link mode, I added a capability set to
"struct path" and then went and adjusted all generic_permission()s to
take the new capability mask. For stuff that did file_permission() or
path_permission(), no code change was needed.

Unfortunately this ran into quite a few hairy issues that made it
basically unmergeable (bloating "struct path" is very bad as it is
embedded everywhere, the whole model is kind of questionable because it
makes "struct path" have state about the lookup that produced it, some
VFS APIs deal with inodes or dentries directly and thus would need more
tree-wide fixes, and most importantly it just felt really ugly).

The open_tree(2) / mount(MS_BIND) issue is particularly problematic --
ideally you would want to block a RW bind-mount for a read-only file,
but there isn't really an obvious mechanism for passing down those kinds
of restrictions. Actually, fsconfig() arguments like "upperdir" to
overlayfs (or even "source") are likely even worse -- now you need
per-filesystem-option handling.

I don't think these issues are insurmountable, it's just that the
problem is much harder than it looks at first glance and I would humbly
suggest that working on reviving a very dead patchset is not the best
use of your time. Container runtimes really *really* want this, which is
the main reason I keep coming back to it (and we ended up with it in the
UAPI group proposal page) but I think it's a very niche thing that has a
big risk of being a lot of wasted effort.

--=20
Aleksa Sarai
https://www.cyphar.com/

--3tusure2o7tuxqco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCac0MVhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG/VOAEAog7YvkUTCpKlJkrQ+FJd
ITNPzE8g0xQwiihZz48JhscA/2a5boZz1I98vR2v4I5a1TEw5HrRrAxuwqf4H/1B
7rgP
=s1NS
-----END PGP SIGNATURE-----

--3tusure2o7tuxqco--
