Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795583803DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294120; cv=pass; b=YyBxUO/WhKL9HdQK3K/hx3gEfZ4ZNPOqRwaDFYO+aCLtyc7mK9O1YXmsbE6O1MLgNKx2enUc1jgh1HJOgGqx5ciWXfiwCd0KctX6FwoaCZMiwaKq9cM6hW3lSV6vXw94eKul7V6UtyxI7QMPBVCv5J65b0iXxSjM6Wxmqi1MhOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294120; c=relaxed/simple;
	bh=b0Icckm+Plk021xclbvKmb7LSU2YUWfD7jrM6zKcdnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElQu1DNwgj9KPbDDBbFn7O2zdC+24eMtOs2YmgdrwEevBSogr7s2rckTCfskRRba0VX140PlsBaUU+4RuHExM40j3WzcGr0f3sP+IQGmgKvqI4Yk0tdMjDKzUQtkd3wldRe/pHkr4HG3Lmjz+j6wRaczgWmdJG5Oyj8SH6mqf/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS8cMseG; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS8cMseG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43eada6d900so10048012f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777294115; cv=none;
        d=google.com; s=arc-20240605;
        b=eO1fMXZT9+44UEP2G9uSecplE692nJVwvpThJNaFm9R/dR0PGbcVbeVuGiJI/EIg5R
         D2fQDyAsCgWjXPdmU+8PlnrPjCa+jKIdq3iz8cUrD0OA2yZdx5kpcBYV7z/7dLtiBpOj
         y9nd4FLdWZbmr/9mO+mKzcf0Mu4aQmLoDJRBPJNMn6Kfc5SPoN8vJn5ucWcFG7K4sxcc
         yGaCmkhC5eDKEjSDN1+FgOElw1DeMhF5H0Jne04Z1b/yHdwvioOyqAaaEEG2KXF4zL2o
         ySkQ5MxWHJnMUMJ2fAkzMzwihOKTYMM/Q9Sk0WubR5v6MbdKhwYq3PzEQSdeiei0wiru
         vATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wWMmBdrmkGuOGSH1/NGgSO4BjSYy8FKRbM9YyJi/QYE=;
        fh=lvEuGgtL5pHFgOnzSbKpiGYkGjaHbW9Sc71h/445v6k=;
        b=CjH6I17baKEQxdrxVlvzI/EGCzlHLBzbWXXONswzvf+UiR0PyQ0R0tRawT5dk6pMmR
         ZNhT6p15XJyNeXGijW5QwFHgVanxUqfoil8jweBHUohdh/qLU95pIu2sPj7kA7uwB/n1
         brEWiFfcTBAB0SKx5c3u5wWwRyGhY3qK/X0Qjz1AD997hLWyU2LVI7slHaTrznltOWxE
         /wXqTA3GW1ZT0DdoWs2+mcw5oySnBHTV7uBWxBH4gjKDISzUmAR+/Re9aPTZ9/zVfDkS
         Wx2oESSUxnG1INZaa0k2WKJR7kEs9PAQ4pSggIpvkvQik1RATs87lhOQKWPLkkKaKvrq
         axDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777294115; x=1777898915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWMmBdrmkGuOGSH1/NGgSO4BjSYy8FKRbM9YyJi/QYE=;
        b=fS8cMseGhTD+deA0WKJglLpxR9+ZM/tzarI8q3Em1X04cGaJWPwwsL/8ib/TWcXz+W
         T2IyB2EuCIhYfgdqjYt732uKuB8JbBbSYYI8s40WwuyYBMtg7Walt6k8t+bMr4Slhrl+
         iGgcwZkPeYd4PHg98a8DPf0IKrQ+sAIVnutQPY1zpQQ6dOm2G4RVHPTnJjK4JSrtfrf0
         pabCaR9GWi9H9sC/zf+r1Y4GUXGBjcQU0nmKq9BAy6jCqZFj3Q2v9YafbK9DdtRIgIRd
         30oxdth4sNAPwy34XTkWrALRkTirimcUXOdBid7OC5HKU97cpph0evoRBv3To16Gnxvj
         CQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294115; x=1777898915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wWMmBdrmkGuOGSH1/NGgSO4BjSYy8FKRbM9YyJi/QYE=;
        b=X4/zi2r4ja4qi31z5RvXV0MW5Ft3mHmFoLY82ls1GrZ2k+SZuKGoPchmfwwCW/vq7s
         gd/ahByXBTkHjciLQwZyyysdDaDKJlfSS/G0JkF/gSnwCvnA9kznthQdgiCQ2l5xv1r4
         r6ReLZ6B/BMoxWXG4bLovQWIuv+yCrRminj77+KByCArL8l1jmrJ5fJ0ABqYt4JET07d
         fXjmwqAhIwMFb6yEO0jWzJyBvOvNidMFX+slwf/jlz5Pg3yEb7tUkskgtsTKIkHgButb
         zBHfs6qfyU/L7hNgb5xZXjdAxV5t78XIOYJ386qcnmygApJIlpRnbUzSBF5IJtITQ1uA
         xSNw==
X-Forwarded-Encrypted: i=1; AFNElJ+13H1J8BPuwmt4QM8Dtj4fB0fcAJ01bRgTHR1PT9qvGdX11lzHBNx9LZwodNCkUAu/D6JXFiSHMssFtp3J@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYyRoKa4FpJp8+zdiZB7E73czT5ZWfSHG+RE8n8/O1AznshUv
	IcJrGhYarcEgfJY95XBSptsTtpr3wgYuyvzltrVm4srTf7xJQGRdE2sEUBe/2od4dspiTUjS+BZ
	0WW1AKC4cWjPgFWCPBlyOqcsLGA2jXHs=
X-Gm-Gg: AeBDievRq+hZrxUKRngawVJtphUuvNdOEMZJNcz1Snkz8xYC70XoiCxvn1S+vfbEZBn
	2IdjA7/JYCJ41N6wCSGRMjb5vmRdkT7PksseyFCEiqA8gXNKGo8KGvE/68c2dU0jfc5u9ehw2R2
	+0CCK2SV5m2lDAY5FSM3ARZ76p2aMyQtZtMbtPdYgr5vCiaDMzCVV6HsEzArPWF/tmJGgrKA97B
	UL/CfLs1Wc24gLy0JAiRGocjf9t+pC4jRP7hrXs0Tfddksi3kinnmwodZNWJxL17lloh+8dk2hs
	khR9SUYsZCosBiyjwxhQcHDTcgceSfHyMg==
X-Received: by 2002:a05:6000:18a3:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-43fe3dd4b7dmr66564872f8f.21.1777294114923; Mon, 27 Apr 2026
 05:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424134935.16161-1-luis@igalia.com> <CAJnrk1bv4NK7MF4msYMAmbS=+vL=k8NLoLiNyM4QB+amccpOww@mail.gmail.com>
 <87mryokb89.fsf@igalia.com>
In-Reply-To: <87mryokb89.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 13:48:19 +0100
X-Gm-Features: AVHnY4I2KC03jSnyEaPe91Ov5H2L0IAjkV2v1_J9s7LaLGq7nbWyDrYCpJ4nnL0
Message-ID: <CAJnrk1ZCyHtL6NEaSuww+RQvNNfAW8NkvRA=+=HXQwdG_4aE_Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix race between inode/dentry invalidation and readdir
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:23=E2=80=AFAM Luis Henriques <luis@igalia.com> w=
rote:
>
> Hi Joanne!
>
> On Fri, Apr 24 2026, Joanne Koong wrote:
>
> > On Fri, Apr 24, 2026 at 6:53=E2=80=AFAM Luis Henriques <luis@igalia.com=
> wrote:
> >>
> >> When there's a readdir in progress, doing a FUSE_NOTIFY_INVAL_{INODE,E=
NTRY}
> >> on an inode or dentry may result in stale directory info being cached.=
  This
> >> is because the invalidation does not reset the readdir cache.
> >>
> >> This patch fixes this issue by adding a call to fuse_rdc_reset() (modi=
fied
> >> to include the required locking) to these two operations, allowing the
> >> readdir cache to be invalidated while it's being filled-in.
> >
> > Hi Luis,
> >
> > Just curious, are you hitting this issue in practice or is this mostly
> > theoretical?
> >
> > afaict for fuse_notify_inval_entry(), it calls into
> > fuse_reverse_inval_entry() -> fuse_dir_changed(parent), which calls
> > inode_maybe_inc_iversion(). afaict, this actually increments i_version
> > (since I_VERSION_QUERIED flag was set when the cache's iversion was
> > initialized with inode_query_iversion() in fuse_readdir_cached()),
> > which means the next readdir call will detect this version change and
> > call fuse_rdc_reset() (in fuse_readdir_cached()). I'm not sure I see
> > how this leads to stale directory info lingering in the cache after a
> > concurrent fuse_notify_inval_entry()?
> >
> > For teh fuse_notify_inval_inode() case, which I'm assuming is the case
> > you're running into where the directory is the inode being
> > invalidated, I see the call to fuse_reverse_inval_inode() which calls
> > invalidate_inode_pages2_range() if the offset was non-negative, which
> > will invalidate the readdir cache's pages, which means on the next
> > readdir call, will already call fuse_rdc_reset() when it detects the
> > missing page in the cache (in fuse_readdir_cached()). So I'm not
> > really seeing how this can happen either for the
> > fuse_notify_inval_inode() case? Unless you are passing a negative
> > offset, but as I understand it, passing a negative offset is used only
> > if the server wants attributes invalidated [1], not any data.
> >
> > afaics, the onlyy stale directory info returned would be for the case
> > for a concurrent readdir that has already passed the pos =3D=3D 0
> > iversion/mtime check when the invalidation arrives, but that seems
> > like a server synchronization issue, eg if the server wants uptodate
> > data when doing a concurrent readdir and invalidation, they have to
> > order that themselves. ANy fresh lookup after that though, I think
> > wouldalways return fresh/non-stale data for the reasons mentioned
> > above.
> >
> > Does this align with what you're seeing in the code or am I missing
> > something here?

Hi Luis,

>
> First of all, thanks a lot for looking into this and for doing such a
> great description of the issue.
>
> So, I did had a report regarding a possible race between a readdir and
> invalidation when using keep_cache and cache_readdir.  But, unfortunately=
,
> I don't have a lot of information regarding the actual issue, and it isn'=
t
> something reproducible.
>
> Then, looking at the code (and, for full-disclosure, I've also looked at =
a
> claude analysis that was handed over to me) I could see a race that I'm
> trying to fix with this patch.  But I believe it's the race that you clai=
m
> above that it's a server synchronisation problem.  For example, with a
> NOTIFY_INVAL_INODE operation, when fuse_reverse_inval_inode() is called
> while fuse_add_dirent_to_cache() is being executed in parallel, the
> iversion/mtime update could be missed.
>
> It is possible to hit this small race by instrumenting the code, and I
> could occasionally (and momentarily) see stale data while running readdir
> in such instrumented testing environment.  Do you think that's something
> inherent to the usage of the INVAL_INODE op, and this race will need to b=
e
> handled by user-space?

imo yes, that is not a bug in the kernel and userspace is responsible
for synchronizing/coordinating that. I think the kernel is just
responsible for ensuring that any subsequent readdirs are not stale,
but afaict the existing code handles that.

>
> In fact, the report I got seemed to indicate that the issue was not going
> away with a fresh lookup (though an 'echo 1 > /proc/sys/vm/drop_cache'
> would fix it).  But maybe that's another indication that this is a proble=
m
> in the user-space server.

that seems weird to me, maybe there's something else at play here in
addition to the concurrent race? Is there a repro for where the stale
data survives a fresh lookup?

Thanks,
Joanne

>
> Cheers,

> --
> Lu=C3=ADs
