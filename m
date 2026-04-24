Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E7324B1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059327; cv=pass; b=ukO/NRnKaJhrR4y3c3+f+FgP6Ls88ndJrwkfXb9M59icHtiXxM9A8fe5gvVDG+tt/oODrGbDvFiggorF/GegI+MdsXJTBP3wWMbMQ90KUkOjDcPWsr0evgkISIW3oHwXX0WMX5uWBMYcbQ4fJI0/NTD8q+SxOiDEAtVcIL82FVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059327; c=relaxed/simple;
	bh=XElxRcerJmnCKIblVnqHS44guv+hwYgsYsWQaeadyj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQyYhnmwgS9agS5IQxswIpRVWjW1MA4EKzRDXLYFmyyvSPxMwng7N3doxUUzs/Ru1p4wLFyOtgcTsdLORJyvJNO50zKSagbRoPOHW6xIbB4r8SST13P0hSF7wn3g6GVW+MqQj7o+v1l8BfxoaAmb80oqrWjQHKS9u5d6R64mLxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2sBM4np; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2sBM4np"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f60944so6323406f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 12:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777059324; cv=none;
        d=google.com; s=arc-20240605;
        b=TZLPsjraSP9EQjirJtWWH+JfOt3arzEqVeL9ZBwtzamaenhpa5nCvcyILKcXcI0kms
         s7/9lOY0DyKL02NDgfP7MJzVUkTo4Q849k8cvcGumcRsPm54JUqQMlfCW64XAm3HDyjd
         S6+O3hC3uX7ReFW11aa2X7xkqAPJV1KHqvrczherQ2xuQy2cUtwlIH42CXldm8IVY8pr
         p3M84cUYwTJEZI10+HbmSvuuSTeMBKVUnC7zvgSWZRRCee0puJGpk6KhDfC9uM4X9Mls
         ITRAK6/wOYH2YjIgg/H9aWVXf64LmfEgKmbvjxxNimmwdgICtW/YWnfvxuzw9BBZWmzt
         8qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yxEqdpB/RW+s8Eu203oUw9sq4uNdIu3N2g0iYn9nQ8c=;
        fh=aDwzz02DKZ2SUGqxFtvwJ6PB366EDURdszkdlv/uhW0=;
        b=ldVMpqFncl0U/OU+p8zJgpeERlF2dgUmfjmjmKpA2SifiG9+cCfZsc3JPXFavHFuvG
         g5WqEztVv0MrpMFoOnxUnYAqSK0b5gy+UOiJLtUhxNRqIi2sfHToulgNMQT3/unRLfTs
         d1uoa2HrKFhGCRUXZ3I/37l0XZ/AFrwu3J5TUUdH+vZFQMDaPCucC2bTzTfGJ2xXLj6W
         iQrXsk9ENyPsU1SyxrxL2Yjns2QlbgagyFB9qtU86Y1/4Ve4hRSAk9z9lh49/xIsOgyX
         8/Ns4P9krYARPr8sPgbJhJc863+xYIxHthrLMKUEPrpSLLaSrVh+h+82Z3G+SN8HOkYE
         rSFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777059324; x=1777664124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxEqdpB/RW+s8Eu203oUw9sq4uNdIu3N2g0iYn9nQ8c=;
        b=O2sBM4npEVrZnbbACWUSGpytJw7re5Lw8XBr03xRsYnKeHw4QGzx8QjSmOVpPileY8
         RQbkngi9Eze/2Cllw+FJzmUEd+0Xn4WgrUGFNSRMuTKjvBVY5uTTP0dbz7iwWm5a7+0t
         WooUGEvZ5APBkooqLoL3f5x0COac+VYdft5Qswrxcx8vOmFyi99PzRGqns8YGLkeJoVM
         pGLLSOldo4oFFnEtxBms1Nli8O3Pp9i++gXZ4oxZDPFYjK3YwpEwMU/yAbi5DfOcLoZQ
         QynmhgS91S/JQvAKSan6D9lZSqLUfNFD7u/AVurCUaaSKUNUexdjUkICKmLYtiyk+fsE
         qWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777059324; x=1777664124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yxEqdpB/RW+s8Eu203oUw9sq4uNdIu3N2g0iYn9nQ8c=;
        b=TS3uUJOoeExIAIbNBOn8PnjiY3ByUDPzK1VNwuXpJ5g2sJDqMH2P95GJF3hqAjBOLc
         Okkz+TTPlijNIsZRbBtAh+YFt4ep0AAjQb3jk+v3n3v5RGXGEPvuaMaMxsKjQN4iMjiC
         d5UdbxAE3vW50Yy0iN46OCUrJVxoke+i5+NGz51sIxTA66AdhkaQxEpNVF5t69DGndGn
         4E9GrfNJKAmd8Xm+v0mvuju4YDzzXOxC2dRfIW5tqAmv6makd1iJLdPxnqn5snIinSmx
         LGRQ7gr1/pUt+GlacWfzMO8FvGTRU74BrHDJ9OhCfmTaduCcfqaFxqQQlPoQ5Yb1BhAU
         LfXA==
X-Forwarded-Encrypted: i=1; AFNElJ+PNRkpyY9bQVyHoW0uVFkcStr1XFmCG3QF56K8ifZHTffzN1GIv0yaWe/cHHRHphXvCQvP4XR/6fpQZXBn@vger.kernel.org
X-Gm-Message-State: AOJu0YzjyRG4Exqgz5sHv7fkBFBDkVVrCKjC+q0xtlMBKMbVRW1kqmAD
	d7BJdVoQIEilv4PlpTLXt+ZVxvoY9MO/OU1doyEqjnVJx0LtFnriaulrHJ6t6DKIXTyasbN8FlW
	9uWYetphufLzdqxBQmT7aq+UsfZvyAnY=
X-Gm-Gg: AeBDietPWvkQWc2O3iqek/Ob5M/J8w5Ko2A1lc+KiYLrqu/G53urmybaU/qbOQ0I7gO
	N0BpuNZn8rEg8w+YBVhLK06/UewU6c5bTj3ZEgSu60XcwDG/yDiQmVtrjM34wUC6Nhz9uAqHHmb
	4zXkNbxHSlR2SviMZJujt7Tjv3P7rG6IaVsr/v+gLkcFHWBWfFXjVLcySOkF1Nyr9bdnZdI6OCq
	esJ5f6zPObgkQNm9Fcma2hiNT3LbJUYBVIZE0iTWjnSYMZ7vCTvQHbXllWq1HHl5UA0i+l5x8c/
	aUwKs8iJU3luGsf+5h7nh6PTb9mXAWbzQFse8/ihC8wl
X-Received: by 2002:a05:6000:22c3:b0:43c:cf25:f29a with SMTP id
 ffacd0b85a97d-43fe3dc819amr52741755f8f.8.1777059323757; Fri, 24 Apr 2026
 12:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424134935.16161-1-luis@igalia.com>
In-Reply-To: <20260424134935.16161-1-luis@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Apr 2026 12:35:11 -0700
X-Gm-Features: AQROBzCQ83cKY4X4yuJlNSKnj6BsTQpURZVqjwRIosP6JkzbGG96ZJHWvJ1Jq8w
Message-ID: <CAJnrk1bv4NK7MF4msYMAmbS=+vL=k8NLoLiNyM4QB+amccpOww@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix race between inode/dentry invalidation and readdir
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 6:53=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> When there's a readdir in progress, doing a FUSE_NOTIFY_INVAL_{INODE,ENTR=
Y}
> on an inode or dentry may result in stale directory info being cached.  T=
his
> is because the invalidation does not reset the readdir cache.
>
> This patch fixes this issue by adding a call to fuse_rdc_reset() (modifie=
d
> to include the required locking) to these two operations, allowing the
> readdir cache to be invalidated while it's being filled-in.

Hi Luis,

Just curious, are you hitting this issue in practice or is this mostly
theoretical?

afaict for fuse_notify_inval_entry(), it calls into
fuse_reverse_inval_entry() -> fuse_dir_changed(parent), which calls
inode_maybe_inc_iversion(). afaict, this actually increments i_version
(since I_VERSION_QUERIED flag was set when the cache's iversion was
initialized with inode_query_iversion() in fuse_readdir_cached()),
which means the next readdir call will detect this version change and
call fuse_rdc_reset() (in fuse_readdir_cached()). I'm not sure I see
how this leads to stale directory info lingering in the cache after a
concurrent fuse_notify_inval_entry()?

For teh fuse_notify_inval_inode() case, which I'm assuming is the case
you're running into where the directory is the inode being
invalidated, I see the call to fuse_reverse_inval_inode() which calls
invalidate_inode_pages2_range() if the offset was non-negative, which
will invalidate the readdir cache's pages, which means on the next
readdir call, will already call fuse_rdc_reset() when it detects the
missing page in the cache (in fuse_readdir_cached()). So I'm not
really seeing how this can happen either for the
fuse_notify_inval_inode() case? Unless you are passing a negative
offset, but as I understand it, passing a negative offset is used only
if the server wants attributes invalidated [1], not any data.

afaics, the onlyy stale directory info returned would be for the case
for a concurrent readdir that has already passed the pos =3D=3D 0
iversion/mtime check when the invalidation arrives, but that seems
like a server synchronization issue, eg if the server wants uptodate
data when doing a concurrent readdir and invalidation, they have to
order that themselves. ANy fresh lookup after that though, I think
wouldalways return fresh/non-stale data for the reasons mentioned
above.

Does this align with what you're seeing in the code or am I missing
something here?

>
> Assisted-by: Claude:claude-opus-4-5
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dir.c     |  5 +++--
>  fs/fuse/fuse_i.h  | 13 +++++++++++++
>  fs/fuse/inode.c   |  1 +
>  fs/fuse/readdir.c |  6 +++---
>  4 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 7ac6b232ef12..6e5851de3613 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1615,6 +1615,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, =
u64 parent_nodeid,
>         if (!(flags & FUSE_EXPIRE_ONLY))
>                 d_invalidate(entry);
>         fuse_invalidate_entry_cache(entry);
> +       fuse_rdc_reset(entry->d_inode);

Hmm... I think this resets the child's readdir cache but it's the
parent's readdir cache that would have to be invalidated, so would
this have to be fuse_rdc_reset(parent)?

Thanks,
Joanne

[1] https://libfuse.github.io/doxygen/fuse__lowlevel_8h.html#a9cb974af97452=
94ff446d11cba2422f1

>
>         if (child_nodeid !=3D 0) {
>                 inode_lock(d_inode(entry));
> @@ -1637,7 +1638,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, =
u64 parent_nodeid,
>                 dont_mount(entry);
>                 clear_nlink(d_inode(entry));
>                 err =3D 0;
> - badentry:
> +badentry:
>                 inode_unlock(d_inode(entry));
>                 if (!err)
>                         d_delete(entry);
