Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCE24BBF0
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447650; cv=pass; b=hckSsXT9kV/0xG3WeG+rpsZO3ravj+2WAI7ooXudnsZDaXhrQH1DAHOdPQy5lCu0R82cjN3jA/gDdClpfDDB81AEkiBhu2dLNB+1Fhnxx5A66qTlYzkDdS8TKS6jB8HDI4dYCyVmeTXzOls7Exb5Hqd0nOkcsRFxm8bg2n1ygOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447650; c=relaxed/simple;
	bh=I9yxjz5EA2+2LzdylAXhIBx1lfLeFDL4GhJ0ksAQ5MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhW8mYka8O64Jio4TR1ZTFwNfsAS5/rQKbEGYDOelg5vBDIKoag9ZoNR4AipCvP/KxqMtolfeHFeiAMX2gTlG+HmDKxCMN2FTTeO+W2QnyaSfPSYkxGGqGp54H2+WOsPxqPEQcbxrUQDB9rvNzIW8i3HccjToiTFiQDi+83NvI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DIoVJeCh; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DIoVJeCh"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d65f4073bfso1638697185a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 00:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777447646; cv=none;
        d=google.com; s=arc-20240605;
        b=Vft4pDE6F/gOVAAFzsOqOJoW2YuNjOzMYHPUDyk77WIr7DBrB+mQKdxHmF8TDJjpLP
         3IeWc+ptAUgy/maH1eRiF4s5hn6r3Qq3L31aeHL7S5d5qcMNPVTQOyYMORCI664H5BJk
         70QxzmXzHkqeVhyegJrDJ/vxlfNhvnq0zvDn9oMBt10Y+gw5ahqFqiEw6MMXjVAPdZXm
         ALJ+e0CpeXAhi282zh9/NsRmFwdnhjULvJo65dN5Mflx7Q1BNg0B72/+qNaFthcaxZe5
         LXyAHinHZvMQn2UGn0xW+Sb+YNOmJMmhMTTFmPo8LYUUTCEYhXl+Huh7NDgMt8XNd756
         kKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zjZAo2H2gnaKRVUEpnIpgaPkSazjT3Yfs/xvpbfpUOg=;
        fh=YxMbWlrEvNK1G7fPcZq83v/RmNJwYDvKszLgdwxAIX8=;
        b=HUyKnx1J04RJqYtuqFbqDwzzEDdZWr4F6hGMLAprwqJRvEsKVPhHdP3FZkZXAI8zoS
         75bqjLemd03SaL7+wpu/HNarEhT0yyh4Ra7KsKbf29wAv1tfLCaON3AjX45I1zOELtEd
         egJsiRmhSJ8s7p0szVxFOlrLfOPeNa0atsqpBRb3yPdBILeWY5JPkEs3jQft6StEZ0eJ
         jyY1h4JM2JVBKdQJEwFgSDLf+REFi1GZabBf9xDzmNhFqA3Vl4yFyNx/+fD6TP1fpYC4
         WuMjvy235aJNs3z665jTfIvpEUxyLJ34Xk4/Br1az4Fjqdaf+vv+XBYZp9pIhKTGv4vb
         XdrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1777447646; x=1778052446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zjZAo2H2gnaKRVUEpnIpgaPkSazjT3Yfs/xvpbfpUOg=;
        b=DIoVJeChh7EAUu5tgyExvjB38YbUTY6jVqyRMhsEzOVPWj5fYUWzce2elxpdRLxtaE
         oIbzuHWP+SBoyHIVFq8Bc2z/NJpV7Y/2KVc9efHoU4ELCYAlx0KPtm+p+ryAkbmg/VnD
         4Laydi6cgHZZzWx0Xoa8x0+ORjzyHGp6ZZor0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777447646; x=1778052446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjZAo2H2gnaKRVUEpnIpgaPkSazjT3Yfs/xvpbfpUOg=;
        b=Xquik9Iiry72JFwcJ6cf2Qd7kQsZnKeQkZKVk29ReVm+6kC82PXu5y30vEtczDQfgE
         3yNlXRbnuvc3nO7gieoteBA/hMfEikiUb1kRHE1IigApq1gfOBwPNi1NJM3252hB5LVB
         ORhPO5o4psRKDjFcCNkQG1rCokyq8OrXpkrKvNvkvnmUI5Egnmjxi96vL9TuCYI5Zl1K
         15dX4DXZkOOrwhR7ttXhS669OHvI2H6GqDwLBBCfE3FtBch4qybsNnxHwePpgvjPLVSR
         VGvrsLrKTr3qbWeLzCM6piPnPce47/v+HKH3VDRlvyjX6A3GC0u2nnLs06heVt45+C7J
         e3Xg==
X-Forwarded-Encrypted: i=1; AFNElJ9+CgqHmbaPdKjnwpBxEt+FoDUpkuM3zPcj0aipVVZDNv7rimQgxg9HPIShq/QzcncF6AZ9bKhy2hQMMVbX@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAqlyl9JnfQIhsa9ecPP0Tb2Tw1DT4wPJn3V4V0kjCmgDUAeA
	Ab8OZE/4Q+iajgdm2Oka2Z36K/1sVkQsOKXqKsCZNKCQ60dzWDTlo+0h0nTndjMSH9/FvpcM4eE
	RtVTI/fq51QQoSqiimpFfixU7bPAq/YfMpMYpNqS8IaQi8D7+fW7v55U=
X-Gm-Gg: AeBDieugsosN2k0gzW4WsOeIgVzruGl7tc7nipAFHd9F4hg4YuAFfN8NmJNH55+wtu2
	4XWqKOYCo/u0hI6lQSfQA4PHQvgPCAXc2qgA2PoD/pQ/kmrOUkbatUIDepWV8uoGaC4T/Ej7N8a
	RgKkMPyr9RkUpUiRAMX8Bzlim23UdhwnSWQxCBbTjZ4E1nfCREtUwA5HPL4Y+YBSsdNIS6Hn8oi
	spm6dnyFzud9FWnVE8Q0CfV3Phvpr67XzEfYp6g9b8rtqKTDRCYebOO1LqHfElVbXdp54UU8cL7
	OXP+DBrXa47dDoGPDEuTBTG5fXzAbPn69b/gm+1c0ign2YKJOZY=
X-Received: by 2002:ac8:5746:0:b0:50f:b260:cad7 with SMTP id
 d75a77b69052e-5100e1d5bf8mr90582411cf.41.1777447646107; Wed, 29 Apr 2026
 00:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428233028.2747981-1-mochs@nvidia.com>
In-Reply-To: <20260428233028.2747981-1-mochs@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Apr 2026 09:27:15 +0200
X-Gm-Features: AVHnY4I3QW1CAjzLgRHJJLPJQPsy_EcsVHDunpzv0WqVqqXA8tiohM6F_PivtGY
Message-ID: <CAJfpegtcsWnXh-uDh1Qu83dFF9nJji1gytk2y9Wk5p9+JDTZ+w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: back uncached readdir buffers with pages
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 01:30, Matthew R. Ochs <mochs@nvidia.com> wrote:

> The larger buffer is also currently supplied as a kvec output argument.
> For virtiofs, kvec arguments are copied through req->argbuf, which is
> allocated with kmalloc(..., GFP_ATOMIC). A large readdir buffer can
> therefore require a multi-megabyte contiguous atomic allocation and fail
> with -ENOMEM.

Shouldn't this be max_read?  Here "read" and "write" refer to
direction of I/O on the filesystem, not on the fuse device (see
fuse/file.c)

> @@ -343,17 +344,45 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>         struct fuse_mount *fm = get_fuse_mount(inode);
>         struct fuse_conn *fc = fm->fc;
>         struct fuse_io_args ia = {};
> -       struct fuse_args *args = &ia.ap.args;
> +       struct fuse_args_pages *ap = &ia.ap;
> +       struct fuse_args *args = &ap->args;
> +       struct page **pages;
>         void *buf;
> -       size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
> +       size_t max_bufsize = min_t(size_t, (size_t)fc->max_pages << PAGE_SHIFT,

No need to cast if using the min_t variant.

> +                                  fc->max_write);
> +       size_t count = ctx->count > 0 ? ctx->count : PAGE_SIZE;

This is open coding the max_t(size_t, count, PAGE_SIZE) in the next
line.  Just delete.

> +       size_t bufsize = min_t(size_t, max_t(size_t, count, PAGE_SIZE),
> +                              max_bufsize);

What's wrong with the clamp() construct used originally?

> +       unsigned int nr_pages = DIV_ROUND_UP(bufsize, PAGE_SIZE);
>         u64 attr_version = 0, evict_ctr = 0;
>         bool locked;
> +       unsigned int nr_alloc = 0;
> +       unsigned int i;
>
> -       buf = kvmalloc(bufsize, GFP_KERNEL);
> -       if (!buf)
> +       pages = kvcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);

 struct page **pages __free(kvfree) = kvcalloc(nr_pages,
sizeof(*pages), GFP_KERNEL);


> +       if (!pages)
>                 return -ENOMEM;
>
> -       args->out_args[0].value = buf;
> +       while (nr_alloc < nr_pages) {
> +               unsigned int last = nr_alloc;
> +
> +               nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> +               if (nr_alloc == last)
> +                       goto nomem;
> +       }

I'd try this without the loop for less complexity.  Falling back to a
shorter read shouldn't be a problem, as long as this doesn't happen
very often.

> +
> +       ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->descs);
> +       if (!ap->folios)
> +               goto nomem;
> +
> +       for (i = 0; i < nr_pages; i++) {
> +               ap->folios[i] = page_folio(pages[i]);
> +               ap->descs[i].length = min_t(size_t,
> +                                           bufsize - (size_t)i * PAGE_SIZE,
> +                                           PAGE_SIZE);
> +       }
> +       ap->num_folios = nr_pages;
> +       args->out_pages = true;
>
>         plus = fuse_use_readdirplus(inode, ctx);
>         if (plus) {
> @@ -372,17 +401,35 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>
>                         if (ff->open_flags & FOPEN_CACHE_DIR)
>                                 fuse_readdir_cache_end(file, ctx->pos);
> -               } else if (plus) {
> -                       res = parse_dirplusfile(buf, res, file, ctx, attr_version,
> -                                               evict_ctr);
>                 } else {
> -                       res = parse_dirfile(buf, res, file, ctx);
> +                       buf = vm_map_ram(pages, nr_pages, -1);
> +                       if (!buf) {
> +                               res = -ENOMEM;
> +                       } else {
> +                               if (plus)
> +                                       res = parse_dirplusfile(buf, res, file, ctx,
> +                                                               attr_version,
> +                                                               evict_ctr);
> +                               else
> +                                       res = parse_dirfile(buf, res, file, ctx);
> +
> +                               vm_unmap_ram(buf, nr_pages);
> +                       }
>                 }
>         }
>
> -       kvfree(buf);
>         fuse_invalidate_atime(inode);
> +
> +out:
> +       kfree(ap->folios);
> +       for (i = 0; i < nr_alloc; i++)
> +               __free_page(pages[i]);

release_pages()

> +       kvfree(pages);
>         return res;
> +
> +nomem:
> +       res = -ENOMEM;
> +       goto out;

Usual pattern is to just do res = -ENOMEM before each goto out (or
just the first if nothing else modifies res), so no double jump unless
absolutely necessary.

Thanks,
Miklos
