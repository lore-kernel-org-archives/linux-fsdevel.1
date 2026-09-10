Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D7486E51
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044066; cv=pass; b=FhlekAL5Os3HYhRC8Y9wbIDnOJsFQrgdf9ID7EHLZ/V5s89urhM/bQUn6f1JihZ3bdvgyEWTik5ATJvMU+WhwNpsLPxCvQlzZd3pQz3NbUZH2gs70MIC1ywnOuu9+1VGiFwqiJEq/JYMCkGZwAiN28rBxU6uafYEj7d0c7Z42zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044066; c=relaxed/simple;
	bh=Z5kbWcBxRDjL5FcNtbwKUn7p6N3dVPM0eUf/Gam/hLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPBgJf9pvGeyiBICqKlZ62VFkBUZPiLSFazk8yU7hoZXw5J+lJNB5hn6tUaYaMDSkV7CIJRm0u/0gJc6l/XCTDWsp9zdEaHrQcqQrwOKG7UjjoAngNSEQj4JgLoCr7LFRu9jebhk/Cyu8u5ZbI1SeI8P7fhX5MIKAgbVwWETyoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC5c4zPS; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC5c4zPS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2940d16190so227924866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 05:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789044060; cv=none;
        d=google.com; s=arc-20260327;
        b=HT+vw92Uhd6cxSFaYXV7y4Lh0LUZKCyOHUs+pKK4VH7rj3D6fiRp4Ck+/8OaMEKBAF
         KrX6/Kdckcn7eiwAn92lGGpQugSb8J41QGZ6FLq/5NAx5ZMz0n38rkiHPkZLcXK1uFEX
         KWaFZe1gmPIdYipExRaEa0SqDUHoUJ3KEpj9kH5yS74A00V1n9n1ybosDm262rMLZNVw
         tRnwKtzDWFbLvx3hjFOQWBJ2jk1Mk09QdExGCgeny8MQKzKHCOjy2jRefe7DRiRUjImr
         rNKg+OjWA3riGz25AQg0gFwGKCYwKVcYnfXMECwAsi7kZW80vii9KnX8x8m2gCDOgvrh
         zsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7m3skM76LOwF2e+lSxBfD0S53mqoJYV0AyMNyGWWNXs=;
        fh=fzx41rlrWC+kzHMiNzEQ6n6RkbCRPP5HvUcE1FvaAI4=;
        b=oFUvU6i77rM/0xc9YcWBzVNLbWq/K8ILCMbo6bH+n4mRetDXT+MedWS807+/1XXh7a
         OS5AWqF9jDSeYSPN4kVRLebHjXj2f2vIx97Jo3++ATlRMaoV9pvqknBtvkoWiHmE/ACg
         YUwcbWKWMAhtDt8lXQplOwlz7ZjY5BZB0jYXNjvZsjkJbvGBWwoiSwfxKIaHzaksO0IN
         MACjnI+uHVJkHxdszhibSeLeyKq7YAl5MOo0ISjPgXSiEeGCQbVLNv2My/ilkKXisIr2
         H1Ttbvh2WTNfSOXXLG7j4e3FfDxoQnvWivU/ODrHvYEKCuaLdlYZ7I8bDXUHfZ3oQ2tO
         cTFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789044060; x=1789648860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7m3skM76LOwF2e+lSxBfD0S53mqoJYV0AyMNyGWWNXs=;
        b=NC5c4zPSTQY9Q6UprgEvPRE3QKvmn/9xsMNhE3VUf5CY9kFLsf8oZyecIPLtVvRbuj
         cVa3CJrQ2NtLaTibRvVq7Yp8qI1P98PWcJiUeKvaUMyOExyhZs4oHB+FjZjzccihxRxq
         IcZQZwH16qec92xeuVnMj83qKN9v0bg+iRmmn33oSLq8E1DudnQGm4BrL80zg+gCUxLb
         q5P6AUYVHKbMUEdlvWAXHdoi9QTHulwLp0MEBHhrtCtR52/hRWTNHSWTM79FZM9kjbuc
         T0tL/rhbHrKiDIAZlMg2RxJ3R39fOKx1i3JZMkD85lAOho380XfclWuddSairsRp84oX
         oX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789044060; x=1789648860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7m3skM76LOwF2e+lSxBfD0S53mqoJYV0AyMNyGWWNXs=;
        b=E1U3lzGzv1hwM/4giSS0U3KMoaGsIoVrUfuijlN42cC9fjBgMVYnHM8zVOchwEEKah
         xXJ6TPRQLO9hGwhLzXeVoLYzApZXAbu58KcsbUEoTEZBEwZmpwpQI7g/CXWgfbSRCGGu
         uV6aLIAl+YcU1tRUJjXs6P5Qtend/GKtBIF4SbhQIna4ZDgg+SVVkOKY2r4h/Inn/I4H
         XbfBkH/mtA0loJUepQTOQe7nF4zeeAn1bKheBGm424EKau6gg8AAoALTBOJyUMSWrlkC
         c5lCTrWpAS+qPJ2D0syRgaDPkrV0fD8BT1lXzCJjV8WFFH9YD1+2Kqj61fqi+oKk7Vh8
         nTfA==
X-Forwarded-Encrypted: i=1; AKwUvBz4qgJDsoOb7Vty2VwapZD5gavjalofDfZeD4ax93eDKIGohIhHlwSfYdUwq2ye7fKjGksJEXj5LATu1H6p@vger.kernel.org
X-Gm-Message-State: AFuF++ky/vhizxF71DVNrsUegWxQXj4AmKt9iz/qh9as6BeBkcorDmXc
	0Yvz3kvSlJhMAIJuIuqWU9yzdHAxu2w4NAnRDhbnhC+E+hHccDOUiPU8yg7dimWm9GXAm98Orew
	+i765Gvk/3GdJ/RVAHItPt+oOALLtHGk=
X-Gm-Gg: AYBFou3sRoloukUHvtA0AIs2fbfceBZwd5zMV6xIHSXV8awOV9tqq9f+lkQEH2ULFmE
	kNTpVHfIALZL75UhxrL091YqRTkGPISLdLW8omaVfY1CVamJkiSVxJbjrwxvy0YsNJnymIsIw5h
	ddQF5REFCG0c1WFIiI8UK9Nxt+nYEkrJXPxlruPYWoptduSduR0qPuWfq6muEgUM7tc3Hx9SI8q
	AgY3jcfUuDIMM8fIZwX5xVwP4nuRckvX218HbTzA9swFKskJNyCNiPFGp7JfJfKJFEzL6DzjnsH
	IDD6yUZbLDjhQQBr5ejRG/zD4GKR6jY2Sb9fIqADiM54GmtoPCq9aNR3szjluz2xC54=
X-Received: by 2002:a17:906:ef0a:b0:c20:21be:ea75 with SMTP id
 a640c23a62f3a-c260c7b6576mr1728189066b.8.1789044059669; Thu, 10 Sep 2026
 05:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909232351.1533034-1-shayba@google.com>
In-Reply-To: <20260909232351.1533034-1-shayba@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Sep 2026 14:40:47 +0200
X-Gm-Features: AcwNN1UPmN16B7TZMWvy5EWYc28BaZE6GbQQ41HWEcsZyRy4y67tvLVqGD6zkYE
Message-ID: <CAOQ4uxjwOHV0bMh21_WuSzMP_BBQrx59-jP8Ef0cnmW2kh54aA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Forward vfs_fadvise to backing_file in passthrough mode
To: Shai Barack <shayba@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Sandeep Dhavale <dhavale@google.com>, Akilesh Kailash <akailash@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 1:23=E2=80=AFAM Shai Barack <shayba@google.com> wro=
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
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Hi Shai,

This makes sense.

Please CC fuse-devel with future posting.

See some nits below...

>  fs/fuse/file.c        | 11 +++++++++++
>  fs/fuse/fuse_i.h      |  7 +++++++
>  fs/fuse/passthrough.c | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+)
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
> index 939553b34..50073e070 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1545,6 +1545,12 @@ static inline struct fuse_backing *fuse_backing_ge=
t(struct fuse_backing *fb)
>  static inline void fuse_backing_put(struct fuse_backing *fb)
>  {
>  }
> +
> +static inline int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t =
offset,
> +                                          loff_t len, int advice)
> +{
> +       return -EOPNOTSUPP;
> +}

Not needed, the same as fuse_passthrough_mmap stub is not needed because
if (fuse_file_passthrough()) branch is optimized out.

>  #endif
>
>  void fuse_backing_files_init(struct fuse_conn *fc);
> @@ -1575,6 +1581,7 @@ ssize_t fuse_passthrough_splice_write(struct pipe_i=
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
> index 059e57969..8062110dd 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -382,3 +382,19 @@ void fuse_passthrough_release(struct fuse_file *ff, =
struct fuse_backing *fb)
>         put_cred(ff->cred);
>         ff->cred =3D NULL;
>  }
> +
> +int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t=
 len, int advice)
> +{
> +       struct file *backing_file =3D fuse_file_passthrough(ff);
> +       const struct cred *old_cred;
> +       int ret;
> +
> +       if (!backing_file)
> +               return -EINVAL;

Not needed. already checked.

> +
> +       old_cred =3D override_creds(ff->cred);
> +       ret =3D vfs_fadvise(backing_file, offset, len, advice);
> +       revert_creds(old_cred);
> +
> +       return ret;
> +}

Please reorder this above fuse_passthrough_open() along with the
other passthrough ops. open and release are special.

</nits>

This got me thinking - do we have any other purely page cache operations
that should be executed on the passthrough file?

There is one pattern that stands out: fuse_fsync()/fuse_flush() in case
server does not implement those ops.

Currently, they are mostly a noop for fuse passthrough files, but it
could make sense to passthrough these two ops on the backing file
same as overlayfs does.

This has implications on the use case that you described.
If an application wants to synchronically evict page cache of large file
that was recently written, POSIX_FADV_DONTNEED alone is not enough.

Some would claim that passthtough of fallocate() to backing file in case
server does not implement FUSE_FALLCOATE also makes sense,
but that will be a visible change of behavior from current -EOPNOTSUPP,
so I think this is better to do with an opt-in "passthrough ops mask".

Thanks,
Amir.
