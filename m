Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55E42AB7
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774821302; cv=none; b=BrXQEeJQQ7gCY6ltisfitPGM9SfJ4D1waZ4NnJ50SwxdBRSw0owdc6tDpSJsm6e5RfJ/EaDHXptAJwuZz4g/hv8BpIUEQFa7f0PV2jO3vPjxYKH1LAoMN+h3OaGtSRBo4+PetYwr8BNYZRTdJOImYeHgwq68TPVNjAT+HpJZWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774821302; c=relaxed/simple;
	bh=LHO1TR2xcnmWIcNhM84bhDm/t4t5MvsNThm8JOQeDgI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IIz3o1/njoL9AVlKRhI8ObRug506VRH6fLmHMgRt9Fl1F+a7SeY7YBC29oMpLupdjsJxKcPKHCg/gsuHdXFmJe29F6GGY8q7H6NsD6aF4AgCA83qWW+WflfVjQjnsuZVsWeWS9V3urEK4aOa+j0wIrxaeK5lAqYueIVWtVMfAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ah8JzTwR; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ah8JzTwR"
X-KPN-MessageId: e8c47d4b-2bb9-11f1-89dd-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e8c47d4b-2bb9-11f1-89dd-00505699b430;
	Sun, 29 Mar 2026 23:54:49 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e8c341c2-2bb9-11f1-99ca-0050569977a2;
	Sun, 29 Mar 2026 23:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=FsKooVkiaFVz4Cz6yaGntTsCBDu5BL3pi+bStmhcu3E=;
	b=ah8JzTwRZn0wuHCXnWYrCwWzE41XPazHzKF3YLZuVCHwii5fHhsMw2UupENN4flVg6QUmNkyWS/qo
	 btBcr+5R2NBUCbA5/29XSOqOPsn9/oHv1oyUEFqbo9mLNEpkHttowt7d/BYni09YLgkgkuFsT+2fml
	 xdjiRJ6foAspbfvHBXqilxDbstEcCHuLFN8WWtbHzI/8sSLKrQMdR6en0AJGrbaKGwHollHiALeMdc
	 YnvJEzp3zeT3PhnhADfD0SORdPTXKjL8TRE86dJckiB+nGbCuLVa7QLA9yU7uqdFdGROvRFXH+WdX7
	 d2hc7sYrl8R8wehD/Hu/Bcc8GXM+t8A==
X-KPN-MID: 33|Bj9jAuuYG4aDJ45geEUWq2PJ7OxeLFGEkrnBSgr36can2WAL1uduuIc3sKJ5+Dg
 /tdEKGO1jOJPWTGJ6/GB4c7IKz+gnwL3WtWeAArI0q9w=
X-CMASSUN: 33|atLb3qUibFKaVZ9eXnPdxGOvjuYbGYyYel218fl7jtaibM+hH1sWL52xryGiAGJ
 sJKwUidJU2Wc9IFcazvqw+g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e8b61333-2bb9-11f1-94b1-00505699eff2;
	Sun, 29 Mar 2026 23:54:49 +0200 (CEST)
Date: Sun, 29 Mar 2026 23:54:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, linux-kselftest@vger.kernel.org
Message-ID: <239317779.402843.1774821289835@kpc.webmail.kpnmail.nl>
In-Reply-To: <2026-03-27-tweed-frozen-omen-inventory-YVLIh6@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-3-jkoolstra@xs4all.nl>
 <2026-03-27-tweed-frozen-omen-inventory-YVLIh6@cyphar.com>
Subject: Re: [RFC PATCH v2 2/3] vfs: transitive upgrade restrictions for fds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hi Aleksa,

Thanks a lot for the detailed reply, it gives a lot of the background I was
missing. I really appreciate it, I have learned a lot as I wasn't aware of the
earlier work on this. Sorry for not getting back to you sooner, but I needed
a few days to absorb all the linked information.

> Op 27-03-2026 07:20 CET schreef Aleksa Sarai <cyphar@cyphar.com>:
> 
>  
> On 2026-03-26, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > Add upgrade restrictions to openat2(). Extend struct open_how to allow
> > setting transitive restrictions on using file descriptors to open other
> > files. A use case for this feature is to block services or containers
> > from re-opening/upgrading an O_PATH file descriptor through e.g.
> > /proc/<pid>/fd/<nr> as O_WRONLY.
> > 
> > The idea for this features comes form the UAPI group kernel feature idea
> > list [1].
> > 
> > [1] https://github.com/uapi-group/kernel-features?tab=readme-ov-file#upgrade-masks-in-openat2
> 
> I had a version of this in the original openat2(2) pull request many
> years ago[1].
> 
> Unfortunately there is a pretty big issue with doing it this way (which
> I mentioned in one of the changelogs back then[2]): There are lots of
> VFS operations that imply operations on a file (through a magic-link)
> that are not blocked. truncate(2) and mount(MS_BIND)/open_tree(2) are
> the most problematic examples, but this applies to basically any syscall
> that takes a path argument. If you don't block those then re-opening
> restrictions are functionally useless.

Ah yes. If I am correct, it would block all the fXXX syscalls from doing
harm (at least w.r.t. read/write operations) because they use the fmode for
rights checking on the fd, and this cannot be changed without going through
an open() variant.

Hence the issue is the case when we pass a magic path to e.g. truncate()
as it does no upgrade restriction check right now on the struct file. So
we hade to do this for every relevant syscall. And the question is... where.

> 
> It also would be really nice if you could block more than just trailing
> component operations -- having a directory file descriptor that blocks
> lookups could be quite handy for a bunch of reasons.
> 

Yes, so (at the very least) we also want RESTRICT_LOOKUP for directory fds.

> I think the only workable solution to block all of these issue entirely
> and in a comprehensive way is to have something akin to capsicum
> capabilities[3] tied to file descriptors and have all of the VFS
> operations check them (though I think that the way this was attempted in
> the past[4] was far from ideal).
> 

I went through Drysdale's implementation a bit. He links the capability check
to the translation of an fd to a struct file. I agree this is a bit invasive
(as he writes himself), and perhaps we can do better. Is this what you mean
by "far from ideal"?

> I have tried my hand at a few lighter-weight prototypes over the years
> (mainly trying to add the necessary checks to every generic_permission()
> call, and adding some more generic_permission() calls as well...). My
> last prototype was adding the restriction information to "struct path"
> but that would bloat too many structures to be merge-able. I was
> planning on looking at this again later this year, but if you can come
> up with a nice way of getting a minimal version of capsicum working,
> that'd be amazing. :D

I would really like to try; it is a very nice problem for me to tackle;
you need to gain experience somehow :)

I wonder how checking all this in generic_permission() would work. The
access to the fd that the procfs magic link provides is essentially an
issue of path traversal, and in generic_permission() you just have the
inode in question. Ah but of course, you can use the mode bits of the
magic link to encode the information, as you suggest. What downside did
you encounter using this idea?

One thing I can think of is that if we want more than rwx upgrade control
(more capsicum style control), this is not going to be sufficient. If you
want to restrict fchown on an fd, there is no way to encode this in the
magic link mode. Maybe we should determine first the minimum capability
support that we want to make the feature useful (and extendable)?

> 
> That being said, while my view at the time of openat2(2) was that we
> need to do this at the same time as O_EMPTYPATH (and my tests showed
> that this was a backwards-compatible change -- on modern desktops at
> least), at this point I think it'd be better to just merge O_EMPTYPATH
> by itself and we can work on this hardening separately and make it an
> opt-in sysctl (with individual file descriptors being opt-in-able as
> well).

Not a version of the cap syscalls?

> 
> > diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> > index c34f32e6fa96..fc1147e6ce41 100644
> > --- a/include/uapi/linux/openat2.h
> > +++ b/include/uapi/linux/openat2.h
> > @@ -20,8 +20,14 @@ struct open_how {
> >  	__u64 flags;
> >  	__u64 mode;
> >  	__u64 resolve;
> > +	__u64 allowed_upgrades;
> >  };
> >  
> > +/* how->allowed_upgrades flags for openat2(2). */
> > +#define DENY_UPGRADES		0x01
> > +#define READ_UPGRADABLE		(0x02 | DENY_UPGRADES)
> > +#define WRITE_UPGRADABLE	(0x04 | DENY_UPGRADES)
> 
> I'm not a huge fan of how this bitmask is set up, to be honest. I get
> that you did it this way to make it disable-by-default but given that we
> probably will want to add restrictions in the future that would break
> backward compatibility (imagine an execute restriction that blocks
> execve(2) -- adding the feature would break all existing programs if you
> follow this scheme).

Ah, I wanted to have the upgradable options as white list, because with a
blacklist approach you have the issue that if there is ever a restriction
added that has overlap with an existing restriction, it would disable part
of a restriction you thought you had set. But maybe we just need to prevent
such a scenario, and I agree the whitelist option is even worse.

> 
> -- 
> Aleksa Sarai
> https://www.cyphar.com/

Btw, I just saw you gave a cool talk at FOSDEM this year, and I missed it,
even though I was there! Thanks for linking the cve-2019-5736, was really
interesting to read.

Thanks,
Jori.
