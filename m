Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0C58E2C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066272; cv=pass; b=RfETAo1cTsLPnX9Rmx8Ax2PNrMJhACnjLkEYWOTUQweFzl73yqyoiRtQR0sGt9gRpx2JYyQ/gFa95jW1OFNtTf4waGUk7xaNrZVWb3o+PXEV6Escg7VWDMR+5orWar50s6go3FuszW2ulVHGyF8RCWazpf7bIm67u1pusaFGzE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066272; c=relaxed/simple;
	bh=E8ECUTSxkYxtjfffY1EweDG3Ov8lBYCUxzc2AoG7F7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrQuJTR0zDPraO6GA6X4u2IjE8guY8tq/j/LjfavQ1LTw2PIH5Bzo5u1oE5IBK0wqbGhBzaNXdxdOldKCD+hsEYngxmSbRxwZ2Y6OUTtT+tLmMb/Xd7cbxMtKUOKHQIXMhJK8593Opdn4nnXrbNNMy6tuBRxle6dPULi7+0yRII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKIvkO4s; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKIvkO4s"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso23266066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 11:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789066263; cv=none;
        d=google.com; s=arc-20260327;
        b=RKCPGN2FSkW4NlwjYY9dCSFrzVJE9zsT54DF2kna1UxoXMM3j48WVm5GyGSWWmk/gs
         IDGHuZOMiRVbSz0lYr0/bieAerN+TiYLNz0J9ewHUdqrlsZvxd4d1pM603ODwspTs/LF
         ojKYWpGZX6namxeFdzCdgJbDXlcQSGKFDOEjQzIu2PYc/AzuSkbsszN8CYPLjpPC309T
         nhWwNG3OC/RlMy3mrbUb4I+XYZ9okltpznAtfL7baf5q1m7Q9KM+WlnPbcTvWM7duWxY
         LPwwnoqXVv5/RWmL3jg2VyaFbsHaLEwbn36IoGAuLthqTwr+qdtq89UUAxOCbiDJFmrh
         8RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GHbrPCsfNB2NLhSOQejnkC4BucMxa/AsAEAIxOLb+IA=;
        fh=uxtNvqfqPUwt51i3StiELCjqpo3kBoWyErcdVJ1OCik=;
        b=e9I0rcfUmjTFy71Qr8U3RVnkWdKy8oeTvAwu5GVxyXobfWe94rx933XeKxDxmoxxzy
         zJ23vqpPqMEBpZ17NrDLaXi5z19rGHT0iv4pHqMiiFNB3/jCH+QygV2cZXtibj60rYBs
         GpZrm7C7ejhu7KxUyWPmkivj7KT8oAGJmvcVJyFckvJvoy2KHwMQVU+8SOoCTJG4pvq3
         P2qwPhTVJvIJIpPXnXkphzXjiFk3lQwAq7vq9ALP0j32qt2joeICW4VVNBxz0tH7+weZ
         FwQac1DTZcg83S1+nZ38kPOwzl7EoOk3ZT80eU8YuUCWDqu1V3Kflw5zXq2cWAKWM13C
         DK9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066263; x=1789671063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GHbrPCsfNB2NLhSOQejnkC4BucMxa/AsAEAIxOLb+IA=;
        b=tKIvkO4s5pB1utomlABuEHgX6//OXrZhf0Rh1ivNtUr8dE2KKRRJfWjaJZtaLvTHkj
         cS3mvxn8xqWAaLDYZlyL5t3XsNA0jXXzzBeDJOmHkyeJsjZGmcg9d+Xpm8t7/nGxrjT+
         v+8xu4oOHSrpJxtABfKX1e6Z+AUZybHvWpMB+MZccDg878KnlyD7gz0MlS8xVmgBOh36
         WqNzlLwm8yd55rcKuT/jqqA3+9yvo1jkw8xo3qu4KVV10BvEpmJpUbasogNDpyIAO4Uy
         kGtEXwztJuBzWg+BtaFkJooXyOeT8n6374RUwgaefKRlOTAA0n2PPaYHkzjlX6orSsnd
         jDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066263; x=1789671063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHbrPCsfNB2NLhSOQejnkC4BucMxa/AsAEAIxOLb+IA=;
        b=B7J/OgGs/n6lCm4q5bJuiG4nXSEtA0w8xQYef1iRCYcPu5SSH/vqfpva8IEp20zVYB
         6XGnZeHKdIiFoCyDuzFk4iDBlQ3T8XSvoTGS/D3tWF2CL0vC4m24DenmpPucqVgxbc/u
         36DKq+164foJ/h0qzpJlkiQGxB8Ti6i7LuFd/+i2TEh8XgMSQ+PQSxdv0r1eaK/Io6Ql
         Gy+KGEca1MZgxEvlFhChDHBFCQRkRNMHnHcgRHS6DfOgkcfomk6zVcRhaVRv/mMlZ6ZX
         gdRFboZ8bgvLrAkSCojzIEYPKxtky/4A7YWpu3dExXsWxDsxbMEdfvlYkBTvdtFjKk50
         bMFw==
X-Forwarded-Encrypted: i=1; AKwUvByGGuIAP/E3GF2yKl6CFm4mrBgGkVycNOcEly3p20vOHt2aYj8J8MpJt+1OfyW3a/ROUti955ssU/Ar/cdS@vger.kernel.org
X-Gm-Message-State: AFuF++mf7cgKSjTKPU95d6+HUlZgWMrROU90faPN/2rMPQmtKheid7W9
	Iv7lE3O5Qr36OUSBPbFPtly992nI7+XX4AW8agoMkN3WzetrH2m8Z3jnebnxQqWnWVX1qWPNiaH
	3E1k7RXh+mbqVRKTfPiJH2GvGZiBLTkQ=
X-Gm-Gg: AYBFou33SVMoZnCikXfB/tF3e/0LoDfajCbIuv1xDH0TfRAL2hhEwMAmvCfycYqRbvu
	p2UHYkit6cL5djn6+mG4pG7DDQXCqTCKdrykMGjLd3feSQoIkX8BmFskItpCI1c1SmBigX361ET
	DGdJngK5AhxqbzUipK1yUi+EItO5R4fGFFs2d8EmskZZlPr3AqYoMF7AeoZ+xDOg9JAkBTFVmhC
	mqHxwyRqo50Quz3Joja+kQOVdu88yJ2tIacdOJiIiSwPSM2p2SYZdqq1W2ozf0Q+iK54wtnPxKr
	foMt7q3xHraQdUlDLWs8GIODTUSXlymmliN673DZ9sEDXTYYKP144+k9sDk/lJ9nuhEM
X-Received: by 2002:a17:907:7203:b0:c12:5a0e:3e0 with SMTP id
 a640c23a62f3a-c29665586bdmr1293366b.19.1789066263344; Thu, 10 Sep 2026
 11:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909232351.1533034-1-shayba@google.com> <20260910184424.156341-1-shayba@google.com>
In-Reply-To: <20260910184424.156341-1-shayba@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Sep 2026 20:50:51 +0200
X-Gm-Features: AcwNN1XzPl6sCfEfyGDUtYT_TA2joRNYoLDO4R22DRWhcKPdZPzJ_hcvSfmgiWQ
Message-ID: <CAOQ4uxigJO7Zi2U7WRJh9UNs5-WYDv5wHrZxohSJJOp6_j1=7Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Forward vfs_fadvise to backing_file in
 passthrough mode
To: Shai Barack <shayba@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Sandeep Dhavale <dhavale@google.com>, Akilesh Kailash <akailash@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 8:44=E2=80=AFPM Shai Barack <shayba@google.com> wro=
te:
>
> When an application invokes posix_fadvise(..., POSIX_FADV_DONTNEED) or
> other fadvise advice on a FUSE passthrough file descriptor, the VFS
> currently only executes generic_fadvise() on the upper FUSE inode
> mapping.
>
> Because FUSE passthrough does not forward fadvise operations to the
> underlying backing file, pages residing in the lower filesystem's
> pagecache remain resident in memory.
>
> During media-heavy workloads (such as image thumbnail generation or
> streaming), single-access file data accumulates in the inactive pagecache
> of the lower filesystem. Under memory pressure, the kernel retains these
> stale media pages and instead evicts active executable pages from
> running processes, leading to severe direct reclaim latency spikes.
>
> Architecturally, Linux VFS supports filesystem-specific fadvise
> delegation via the .fadvise hook in struct file_operations. Implement
> fuse_file_fadvise() in fs/fuse/file.c and register it in
> fuse_file_operations. When passthrough is active on a fuse_file,
> fuse_file_fadvise() forwards the vfs_fadvise() call to the lower
> backing_file under the opened credentials, allowing POSIX_FADV_DONTNEED
> to cleanly invalidate the physical backing filesystem pagecache.
>
> Signed-off-by: Shai Barack <shayba@google.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bschubert@ddn.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Akilesh Kailash <akailash@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: fuse-devel@lists.linux.dev
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
> v2:
> - Remove redundant !backing_file check in fuse_passthrough_fadvise() (Ami=
r Goldstein)
> - Remove unused fuse_passthrough_fadvise() stub under #ifndef CONFIG_FUSE=
_PASSTHROUGH (Amir Goldstein)
> - Reorder fuse_passthrough_fadvise() above fuse_passthrough_open() alongs=
ide other passthrough ops (Amir Goldstein)
> - Add fuse-devel@lists.linux.dev to CC list (Amir Goldstein, TJ Mercier)
>
>  fs/fuse/file.c        | 11 +++++++++++
>  fs/fuse/fuse_i.h      |  1 +
>  fs/fuse/passthrough.c | 13 +++++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a4d736945..81709ab82 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3537,6 +3537,16 @@ static ssize_t fuse_copy_file_range(struct file *s=
rc_file, loff_t src_off,
>         return ret;
>  }
>
> +static int fuse_file_fadvise(struct file *file, loff_t offset, loff_t le=
n, int advice)
> +{
> +       struct fuse_file *ff =3D file->private_data;
> +
> +       if (fuse_file_passthrough(ff))
> +               return fuse_passthrough_fadvise(ff, offset, len, advice);
> +
> +       return generic_fadvise(file, offset, len, advice);
> +}
> +
>  static const struct file_operations fuse_file_operations =3D {
>         .llseek         =3D fuse_file_llseek,
>         .read_iter      =3D fuse_file_read_iter,
> @@ -3557,6 +3567,7 @@ static const struct file_operations fuse_file_opera=
tions =3D {
>         .fallocate      =3D fuse_file_fallocate,
>         .copy_file_range =3D fuse_copy_file_range,
>         .fop_flags      =3D FOP_DONTCACHE,
> +       .fadvise        =3D fuse_file_fadvise,
>  };
>
>  static const struct address_space_operations fuse_file_aops  =3D {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 939553b34..6c60716e7 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1581,6 +1581,7 @@ ssize_t fuse_passthrough_splice_write(struct pipe_i=
node_info *pipe,
>                                       struct file *out, loff_t *ppos,
>                                       size_t len, unsigned int flags);
>  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *=
vma);
> +int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t=
 len, int advice);
>
>  /* backing.c */
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 059e57969..8a8fa6b8c 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -160,6 +160,19 @@ ssize_t fuse_passthrough_mmap(struct file *file, str=
uct vm_area_struct *vma)
>         return backing_file_mmap(backing_file, vma, &ctx);
>  }
>
> +int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t=
 len, int advice)
> +{
> +       struct file *backing_file =3D fuse_file_passthrough(ff);
> +       const struct cred *old_cred;
> +       int ret;
> +
> +       old_cred =3D override_creds(ff->cred);
> +       ret =3D vfs_fadvise(backing_file, offset, len, advice);
> +       revert_creds(old_cred);
> +
> +       return ret;
> +}
> +
>  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
>  {
>         if (fb && refcount_inc_not_zero(&fb->count))
> --
> 2.43.0
