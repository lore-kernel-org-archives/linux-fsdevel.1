Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580318;
	b=tCXIEGxfvJbMSuAyt2ELSbZBe7DiZQ7Q9x574G0yPqFq8frMuWumNOmFQ0NOAfx4xqQo
	 211YeyTGfzXxB0jksI47MlqceVTbabnLT06BXUx6voh44lkVdrwVIkj7EyB1m0luzAAMF
	 SHVF4jshXhgPxF00oZKMLPiosSo/yYki8hzFxO+ETius1rqr+em+TL0jADw9S2ZB3COtH
	 e5xkiXeAIQNgXNK1EhGgB7XFuNJT8vMC7qn7R7KqKZIcINYBHLwzSBeRWNLcA/K9Xkh4/
	 8DuV+xFFNDCp/iV8NJxIQWMhp+pQIGEciYMLBLvD+alp3s1jILGF1UgYAfeaV2UssdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
	b=F2P3EQVjiI59UIXhJzKra9sZClEexRDvGtmy+BdHymlucYjI2j4EV9w+sMwhRGpW5VJh
	 zrXcTZL99FL9t2hYhwpjvmLvhLLnfot/2Isx5ZbwpCNAz8L1a92/JHM+bpmA6OpHVD6j3
	 iX7sApqJjQ1DSRFFyq810ne+tNS+YBPnAo9INxdGSvJu8bII4WCX9EYRnVnXFXkQ8YBLN
	 EJfGiawaxOQa45nAMwcFw3+M6/ETFr2ylfVCL+XIz4s0vRVs2Xenf7RADHedw6xUHFcL+
	 lsCBdmscS3Y46AJbMhzAYUTflsjFDQyl167hvrf+3Gn35qMooeK9wXIS2UXRssePbGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=HHNDkB5Z;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0F606A322
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D0F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=HHNDkB5Z
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070781f63so246490b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792580317; x=1793185117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
        b=HHNDkB5ZzLBhcoftqluBfZzfk4FH8wqvFihietVucu3AcUZ2N8eU/TTlxfrIw6DLfj
         1a8W/7mx/j8/kp4xIxcA21hhjb0fB9pr5EZZX7iBMO/KKIP/GGfzgLjAt2gZalRQcKM7
         AnH11A5NWmfD7vXByk1SGh2GmRnXVcG5XI9Rza+srIZzailb/5tz+lK6qrKO+NUYDLT4
         JHFj3HB9npVsefJH3zwmWSvy+HReCVoSn7l9cR04PABVYFzHOxZy5OpxGRdN37QaJ8oD
         N84LLbssL3LEgR7A0kyTlogxWFxWLY4kLkv9wkhzmI1PFjr84+c2+MTuIPc+Rjz9oO/v
         Jc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580317; x=1793185117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
        b=ql5h9TSXSDbGBO2ZsXrGdQV+m6OWL0j8iWLCUdKAbHAQsMLcNqUqp37tOrW2Wjk1bR
         HTzg3Ygsr61SwvgW42ezorB5Yk1DJklZKQtmea/YxFRd1oYdgtEav/Dtj3KMXHfsL0/G
         dYWSkR5y8FFPu0LL7lHVTLlOBn9Qrx+FjX1V21DaIdzGPL2rm9rAEQ38AeQLbhaKqC/Z
         BhuqBcy/46D0giOyLtKcp9zN1GRiJEUCAVw1PD5wyijSc4FFv6EFv7zy4KqcR+NdwWOQ
         N3CWrWMVmn8+7cgP8v+6ykikrjreqsdtLnc8HxziOh3PVlILmlazp5ZwesZRgZWSltp+
         iPPg==
X-Forwarded-Encrypted: i=1; AKwUvBwqMjY3f3otzhGe9fMa/LdHTGmBmlqXU+A5b+7XPhGMwaJJ9BPTYMi4mB/0vixziZY2d8q2Xd4AJ202vHlS@vger.kernel.org
X-Gm-Message-State: AFq9FYKI6DGYLK89T3/H19Q56V4XsvKmwAGHnD1bnYM7kIWA/hiHX3t6
	T9jd6KRfTnz64EIGUbIktwQFgmskd+PTe3dKNZSViqZEnWJ80wUq9NklJfKIIQMcYXrf
X-Gm-Gg: AYBFou1jef+NJz8cs0+xOvHKUlUA0KtpdeK9s9/S3keGSRcySueNLeu5uxntWGF5oto
	19Z+qPmESlAvE6hMp8PtFOjyk5y7j7B7eV2GEl/6xO9YN05kt6Cjk3w22Gxk1WWWgAksWnccgp8
	Afnp4vF2Z1Iq4laSzu2ZoNr3eHI5j+aHSLjfRrnHZ6Z7FX7EqjJWXqKQHy+O2T1tNvE+nBPmysY
	uj8D5o9AW8S8/hPNYg3oX8Q0KMBhPw+NRHZ/XTHkzXABxw97PdG7iN0umt8kVKld7DKHkSdtRkH
	i99HD5HBrkeykPMD3J9fTrQNVvIzaqvGQd2O5Tem+6ZyddqgeXVnkS6NLPjEsssvbfgt1tXuuOv
	JwwVTt5IawtiSZPvhYXD0fE/15L6I4Bm/UvBNB9JMorUZzaSHL+jR0ALq83ApC9s7qNqwjFhzYr
	uJ/T3dISY+5KIcw4fPerAYbmpLbxnu95XBupRnd6AlxvJxbBNrxA2lx4DkoMoV6qeMZQv7xw1By
	MKP8kRsjWHkbSiXYWhBDZ1yR87g3G46gHaTHzx3JeJ2wL9IGz2rSGDCHNJVmIVEKY0UbVs8u64R
	h2e3B/+mcNVCSvvqTpkauxG4DsEYDXg=
X-Received: by 2002:a05:6a00:3d11:b0:89e:9c7e:fd51 with SMTP id d2e1a72fcca58-8a089d0783dmr1174185b3a.10.1792580315723;
        Wed, 21 Oct 2026 03:58:35 -0700 (PDT)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49dcsm730783b3a.16.2026.10.21.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:58:35 -0700 (PDT)
Date: Wed, 21 Oct 2026 21:58:09 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <atiawbBo6WRPA6QA@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
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
In-Reply-To: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>

On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > cannot race with that.
> 
> The crash is gone, but so is the path. file_release progs will get
> -EINVAL for every file that a task still has open when it exits.
> 
> It also breaks what works today. The d_dname branch in d_path() returns
> before it looks at current->fs, so at task exit a pipe or a socket
> resolves to "pipe:[123]" now and to -EINVAL with this patch.
> 
> And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> that current->fs == NULL in do_exit() breaks d_path() called from ext4
> open.
> 
> can we fix it in d_path() instead ?
> With an empty root prepend_path() goes up to the global root, the same
> way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> needed and the selftest can expect the path. A chrooted task gets the
> path from the global root, but it doesn't have a root anymore.
> 
> Something like this (compile tested only):

Prior to sending out the fix, I also considered addressing this directly
within d_path(), much like you've proposed here, but decided against
it. d_path()'s contract is to build a pathname relative to the current
root. It does fall back to a root-independent name when the path isn't
reachable from that root, but that fallback still presupposes the caller
has a root to measure against. An exiting task past exit_fs() has no
root, so d_path() has no correct answer to give in that state, and I'm
not convinced we should invent one for it.  That's what
d_absolute_path() is for.

You're right that my patch regresses the d_dname case though, since
pipes and sockets resolve today without ever looking at current->fs.
Rather than replicating the d_dname check in bpf_path_d_path(), which
would mean duplicating VFS logic such as the mounted pseudo-inode
special case, I think the cleaner fix is to move the "no root, no
answer" check into d_path() itself, after the d_dname branch:

	if (unlikely(!current->fs))
		return ERR_PTR(-ENOENT);

That keeps d_path()'s semantics intact, keeps pipe:[N] and socket:[N]
working at exit, and turns the oops into an error for every caller,
including the ext4 open path you mentioned. Nothing that works today
changes behaviour; only calls that currently oops are affected.  Callers
that want a name in that state then have to choose one explicitly, which
I take to be Al's point.

For BPF, that choice could be a new BPF kfunc wrapping
d_absolute_path(), so programs can pick whichever semantics they actually
want, and file_release programs that need a name at exit get one whose
format doesn't depend on how far the task got through do_exit(). I'd
prefer that over silently falling back to d_absolute_path() inside
bpf_path_d_path(), which would return chroot-relative names before
exit_fs() and absolute ones after, and still wouldn't help pipes and
sockets since d_absolute_path() rejects internal mounts.

Al, would a check like the above in d_path() be acceptable to you?

> diff --git a/fs/d_path.c b/fs/d_path.c
> index c253090..ea49d33 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
>  char *d_path(const struct path *path, char *buf, int buflen)
>  {
>  	DECLARE_BUFFER(b, buf, buflen);
> -	struct path root;
> +	struct path root = {};
> 
>  	/*
>  	 * We have various synthetic filesystems that never get mounted.  On
> @@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
>  		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);
> 
>  	rcu_read_lock();
> -	get_fs_root_rcu(current->fs, &root);
> +	/* Past exit_fs() there is no root to stop at, go up to the global one. */
> +	if (current->fs)
> +		get_fs_root_rcu(current->fs, &root);
>  	if (unlikely(d_unlinked(path->dentry)))
>  		prepend(&b, " (deleted)", 11);
>  	else
> 
> pw-bot: cr
