Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051768;
	b=XgEF9h4yQXTWFl6VMymTFUTz9DfrUwKOJfCpeiqEtasp2KDxTdxDMqZj4Jq83v+NNFYs
	 s/h6WKkqhPGadwLJt5tO3RvwWMhF72oK/E88UFPVxnfs5H+DxlsT8gJ5Z24/IuAGWTpF+
	 N0bAXtbq9FE1arHMkSkv/W5B5ZjzQX1/ej1mAS+3iHZZG3Gued50Fo9YttLZuRcGXPHk2
	 s6HSe3+cB7MfKXGH6okq6RpiWHkYEIWJO8TWEtlR7vDVvD6NeDFO7X0G7PC0TQVav61BT
	 qEThBw2vEZBJAqWOEAd1wXRqdJVk0UUgVQdoS31yrv4tbSMGWZ8bC+rMQnLHxqcabmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MCaOqkvghFdjPjEBy1YWJcxG17ikaMSWnkn1If8Ln38=;
	b=bT5B4fJHcdhkjE4pbGARfT6i/5m7o0cRkLf0y7p72evVKVd2MXETUXwcTX/jDutCYrOI
	 8jDOO+r4OeoxmkhW6fNJp8mI6vUrLzZ44MqXz0euT8TySUhh/l9kTsPKWbSJH6q/Wm5db
	 dPV7Vr8Qsp6sqZcdAZFnRNPj++RwBhWYXOSiUebm2KPOTEoB9ewm9QA7z2aW7j/GXv0lZ
	 tF9nPc8f7nnseL4J8f9jy56mGq5EX3hwFSce+Ux853LmvfWJSMX5f3ovdyAZm1g2nRAuE
	 bJotQ9T9gU6lpp6Qi6e5I5mJcybz08r7pR1UDAOQ+sHGglKOzn9RuMWnkR/31qBbCKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=r6qzBHbJ;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B728606A31B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B728606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=r6qzBHbJ
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e95bd1c14cso30959765ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1793051767; x=1793656567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCaOqkvghFdjPjEBy1YWJcxG17ikaMSWnkn1If8Ln38=;
        b=r6qzBHbJ+Y6VySD4piiJQaxG3nmkcim5EedbVvJDLrFKh/z/zfWGVfhzESZgtJcOTT
         mOo5hPQeKtOllDCqHQ+bRmmdG88imPwjlx7DaOoM0KaMz1KXsKT7apGPB22NyoerYTZQ
         /4vIHuibqhucsMEMxk6fldlNHvt+fNxp1ovjKGI/eW/I63Ib5IBoE4CjQEJudyO76Wtf
         1D4vXfgdUVq64lyBYfYwd63VG89p4VOSXiOVGnpeaDouPGJAbGZiYCtI1VTyrXIr7v33
         A771pKw10Qc39HU/IR1PbeHnB+RlD52C7qD/1DVFZS4Ju3IhXtUDcV290iNJz9ZhBNR4
         wpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051767; x=1793656567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCaOqkvghFdjPjEBy1YWJcxG17ikaMSWnkn1If8Ln38=;
        b=zEML+0sAMAPASx4vW+4JrCKhXNZ0rtzq3kp8eqHl8xTO1DLwstkO3esyrED9RXCcEb
         Inq5fcgka6kf9SOmSLrHLonGtx2N54Dob5PQ5B2zWyEqp94uCf0WySIpSfzCSiLGuqHZ
         f3OKlyrnL1dgYu67j3XHVf5hlYD/VC0koF++IxKsc+MqsObTN2znkGRpv9ThP3Uiifpc
         e8XLWYN7xNuKkpJojc9t7lu07uVjI0oactcSFl8o+ztrmCgK/MGQAA5PX9pkLXq+X/3E
         eaO17Ra1cAbMVZ03UWAd3Ix7Nue8Og2E1N1VZDZvcH8tRP0ORUPI//VWlHDPk0SToRGX
         u8lQ==
X-Forwarded-Encrypted: i=1; AKwUvBygLbRp4rMssOzV15qzWMtyZCoRtHfB4QJYyoxJ3cNSGQfk4PwfeE+RRXR0P34BjcVY6edHq/3inUePGj3g@vger.kernel.org
X-Gm-Message-State: AFq9FYJwiasg308bUtDW9l+USU3afzAHx9bmwFD/6/GmYWRZvnmtKiTC
	fx6JaZlqSiemk7qSxUxpClTyiyxqfWh64FLpHMn9lseUlSrshUSwlaOrNCUaa4BeIwDq
X-Gm-Gg: AYBFou29ew+2tWpCJxTK1Ji1T+HUYZQ4uWdUN8WR09quTVcTB1nK0AspG6pRHPO+xce
	cIhB7yUENThMpD7Zwggy/6sKbWRMUNDWmSdQfQ1lT3RzJQVKSECX0WKo6LV9Hd/U35lO+UMyDWi
	Le2VB5UAqgxpV9YVQAQSaECJRCKPL9bJzJYNVIrxqBnwRx1HEn+Rgaj4lA+RK9HsesIPNPVQgvH
	LmGA1rO2agloMLsGQr5dCt6XmINceTAWgJY3ekwdVqlvSiUJ2Y01JhhR4hrCJP3wVeSsgJ/NZxF
	ew3dNiDc+eCqZK2FjCwC3YWNVGCMTUdPIk9ZObDPli7hLuwfiLAnfRlVzEa9dC3cKBrKGnnLYad
	0FB8shBQ+8wBaiqsKsRcW2qB/lnFmkgwi7UhfF63wx1UHmg7vsENgFiHkQ/+5gkYciGkqqAmDec
	OkBD1C++rJu01ZzEJg5uEqIqOJ5HgIC0m59D8AT5qAq1szfUgH2mKWLxD/eP5u/6rJah75abtLK
	6e7BXqTcECLw6jIOqkfUziVgsJuFVv3n3SrGFH02I9Xjj1KQDny/in/bU92IJrOXEDYflKefuXQ
	x1u2hO6xvofdGOyUhDcjRrcqmZdMhTQ0Vg==
X-Received: by 2002:a17:902:db0f:b0:2df:9a7e:d41f with SMTP id d9443c01a7336-2ea9c8740edmr75437265ad.41.1793051767231;
        Mon, 26 Oct 2026 14:56:07 -0700 (PDT)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6455a00sm1186455ad.2.2026.10.26.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:56:06 -0700 (PDT)
Date: Tue, 27 Oct 2026 08:55:57 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <at_MbcW0OlciNLrE@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
 <atiawbBo6WRPA6QA@lima-development>
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
In-Reply-To: <atiawbBo6WRPA6QA@lima-development>

On Wed, Oct 21, 2026 at 09:58:09PM +1100, Matt Bobrowski wrote:
> On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> > On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > > cannot race with that.
> > 
> > The crash is gone, but so is the path. file_release progs will get
> > -EINVAL for every file that a task still has open when it exits.
> > 
> > It also breaks what works today. The d_dname branch in d_path() returns
> > before it looks at current->fs, so at task exit a pipe or a socket
> > resolves to "pipe:[123]" now and to -EINVAL with this patch.
> > 
> > And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> > that current->fs == NULL in do_exit() breaks d_path() called from ext4
> > open.
> > 
> > can we fix it in d_path() instead ?
> > With an empty root prepend_path() goes up to the global root, the same
> > way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> > needed and the selftest can expect the path. A chrooted task gets the
> > path from the global root, but it doesn't have a root anymore.
> > 
> > Something like this (compile tested only):
> 
> Prior to sending out the fix, I also considered addressing this directly
> within d_path(), much like you've proposed here, but decided against
> it. d_path()'s contract is to build a pathname relative to the current
> root. It does fall back to a root-independent name when the path isn't
> reachable from that root, but that fallback still presupposes the caller
> has a root to measure against. An exiting task past exit_fs() has no
> root, so d_path() has no correct answer to give in that state, and I'm
> not convinced we should invent one for it.  That's what
> d_absolute_path() is for.
> 
> You're right that my patch regresses the d_dname case though, since
> pipes and sockets resolve today without ever looking at current->fs.
> Rather than replicating the d_dname check in bpf_path_d_path(), which
> would mean duplicating VFS logic such as the mounted pseudo-inode
> special case, I think the cleaner fix is to move the "no root, no
> answer" check into d_path() itself, after the d_dname branch:
> 
> 	if (unlikely(!current->fs))
> 		return ERR_PTR(-ENOENT);
> 
> That keeps d_path()'s semantics intact, keeps pipe:[N] and socket:[N]
> working at exit, and turns the oops into an error for every caller,
> including the ext4 open path you mentioned. Nothing that works today
> changes behaviour; only calls that currently oops are affected.  Callers
> that want a name in that state then have to choose one explicitly, which
> I take to be Al's point.
> 
> For BPF, that choice could be a new BPF kfunc wrapping
> d_absolute_path(), so programs can pick whichever semantics they actually
> want, and file_release programs that need a name at exit get one whose
> format doesn't depend on how far the task got through do_exit(). I'd
> prefer that over silently falling back to d_absolute_path() inside
> bpf_path_d_path(), which would return chroot-relative names before
> exit_fs() and absolute ones after, and still wouldn't help pipes and
> sockets since d_absolute_path() rejects internal mounts.
> 
> Al, would a check like the above in d_path() be acceptable to you?

Al, what do you think about what I've proposed above?

> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index c253090..ea49d33 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
> >  char *d_path(const struct path *path, char *buf, int buflen)
> >  {
> >  	DECLARE_BUFFER(b, buf, buflen);
> > -	struct path root;
> > +	struct path root = {};
> > 
> >  	/*
> >  	 * We have various synthetic filesystems that never get mounted.  On
> > @@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
> >  		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);
> > 
> >  	rcu_read_lock();
> > -	get_fs_root_rcu(current->fs, &root);
> > +	/* Past exit_fs() there is no root to stop at, go up to the global one. */
> > +	if (current->fs)
> > +		get_fs_root_rcu(current->fs, &root);
> >  	if (unlikely(d_unlinked(path->dentry)))
> >  		prepend(&b, " (deleted)", 11);
> >  	else
> > 
> > pw-bot: cr
