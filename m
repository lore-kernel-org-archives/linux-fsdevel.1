Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8C381EB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599998; cv=pass; b=eEv7/HRfbD7nZF/3wYSam+QuPgRxOwFXCaOBSqAKk2hpsf06BnCoXR6pz11u2YRlxicDhb2c9qZMKQcyBi9xND/HIy0eiwK73t8+wxbY1UDGaaNcjBJWgrYMxacUNZkU3qFikIDmFrRSuSvKsL70OkAqHLWkFypwaigK1+rfIgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599998; c=relaxed/simple;
	bh=6nzgFXxKsg+JnpSIQP0/wxVzDkLsa2CzNa+jLf/mGAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgkWmaYUnLs2EOjdDogpXXgXYXehYBI1w7wX2BOX9J7qe1MmQbawJKb2ZVxusD1O+7oyVC6p4Ls0/pdbLHYzqmfY/WbYQWRJFmFrk3c7+u5TyTl5HvW3P+ScNuTrbwp65Y/NnIjx4s0oMQWI0V60m1ZE0z/YI9LKUq1yC62z+8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rWbvmCWm; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rWbvmCWm"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0c45c580so25210131cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 12:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787599996; cv=none;
        d=google.com; s=arc-20260327;
        b=Ts9wbOMbIWUNyy/L28e2hkTecjTKaeu/dl+RaxR67j6voIqKFUP9xsu6C3zikXhv6/
         3E2l+J4fZXSj7m6/10O/U8qaGiD5AbVJFVkUGA6HT0lNEArvtne/tSenfkh3ZntGAgw5
         8PYgs0OIep9yvtTOqIOndQxjGitbKNcUrNQfipxrOBlGNrXkV2c5jtd2B/YSVP7QksVR
         Dqse0GO+2KnJKBGefAOL9qcFefOKJLsbS9Zzn1+PG63mYFXYVTaUS2YitvhkdCxRfREA
         +ryVudmEfCakASS4B6a6sT8tWHnE5zqcAMnTcbpkYnNac04PM2qTHmzHDGCcvjhUwOCu
         /+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DK1kq+UORspwzlcL44O0F5OA7o6ZQNGRnMf+1R0tFOc=;
        fh=HCkU1rXo6AimMa9rG9fI3H6MewNzsXYXiOBip+XCuI4=;
        b=E3iPoI8dXSJR4VvtecwgezaY3CEQtAEpH+ptwmAONGT10zvwiyaUKX87wf60I1Kru7
         XMKoDN+8K5cHgI73u1153xnwhTsB6LY5YxVCNcCxFhKL+kcd0fC93QqJx4gliQGIr3Gr
         mWgBuOQtvF7079wEOmRg4Hl4LZK9sO5/vhn5I77nsoGpQzgiSHV+sJcmskQV37E8DKa0
         AP4XYpuUX9k/C5z3kMB2jPBzXg5FCjYwSRT2OVV2vCYkEUjov7hDZ1HOb4qf/7s9Ifw3
         s7PQfWPupPwGW6ZhYYMQxw4BcvzVZdhJ3CrW/rQY0WqpPOlQBZXBGiWRORscuYlgIZgn
         SRFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787599996; x=1788204796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK1kq+UORspwzlcL44O0F5OA7o6ZQNGRnMf+1R0tFOc=;
        b=rWbvmCWmjcCMV6cmRGcdr3+XqqhuMWDGjRX1T5jRxsvlEvHcuEqtIU8Ara72ZK/KBC
         Fo3btCJeMyC+8K71XbO+ycgkyzflH+/WAU7RjJ+jWdNq4ZIUVDtoY46nzEbAYFajZokv
         WbFxgJPYPnzHMK5AKBCgIKfsa0iEZf2co5VII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787599996; x=1788204796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DK1kq+UORspwzlcL44O0F5OA7o6ZQNGRnMf+1R0tFOc=;
        b=ghrPgriyF2egoX9V/Cr6H27uTS+mPEvFtO9QkcB5JyGo4p1Jv7zmIGZi94Vi5AIBVP
         6owavi/utVjieykigCNwS8LmcOtuLbTQSlbAs0pId0biiIIjjqNgCgfF+xMw+VMr4e6b
         ydCmDBSnXM5dFEXLys0MFtM2um5ai6P33qdR4tXyD4dbI+Mz1dOUMGQRRtQsYQYG2eME
         SXqfq8UlRn21aEhfqgBYoqbJOUHX6fngzRvwg/aRHoRu9sYgpRc1V5zOtpWqKYVY3gu8
         M6gWXkNAoDvVNM4meiAOtn4e4YUQw9OeczODyXziAJl5/53nUwqUHeOe7klrv1VyPJ03
         E5Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpTji4Jyy/XxyLkhDVz+gWcNtl6ggmCxCAknz5DT/8/nlyQe5zvasp4ZLi1oH53ss+loDU9fzvPGVxB/nBH@vger.kernel.org
X-Gm-Message-State: AFuF++kfDs2uG+lB7SYblR72TEZPaOK9WNUu+wWJRj8nKdRqYVV/267a
	hc3OFedV1SCPeMLbdQvYbouK4PstK4+Igi/ZuqrT7Hq/CgP4tNGlziFCTsmrbWEH87Yg40JaanT
	GLFjfyLwAA3pt2yy109ljjedeQTcUNaD1pANRUoYojg==
X-Gm-Gg: AR+sD135F1hUQYj4V6U+VnrI4v6oFUuED/Os0ElMBjUSc36zvnlp/tUPM3ikgxVK1y0
	fJa/Frk2bfJBd44THczxWj+j3JlztBZvd+dKB7SE2uVlvwGUpaIUYYB+MtzMoC+h65G+nDjxZWZ
	qm/pTq4V8jnL3o1FxA/9+TT4S7usBZQPdrWf+0KpQFeeokwXzrRrZHtGYFGEbnJ5uZMe0VyfD4c
	0Jnhhd0QcpvyxNQDT715mhcNMPGXvWXeKRWkJrpwtYkBcgwOA+g7/9EIS5/NqRKIX45OycmpgBf
	PwD4BTLeQMka+8trSkRs6VfPPuJ2yHFNaQZY+wdl1qcsMtd+fE6+8cLFXjG163WC8/3ejoHGovP
	XKoM=
X-Received: by 2002:a05:622a:411b:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52df57324bamr286714031cf.16.1787599995881; Mon, 24 Aug 2026
 12:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
 <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com>
 <aoxHOSC9kTPbKeNq@casper.infradead.org> <CAJfpegv3Ak+qNLb=fTSCSz7-taQ3Ui-Hkmqgn4PaGPe=CR4cbQ@mail.gmail.com>
 <aoyKxvdQdeJQfPHj@casper.infradead.org>
In-Reply-To: <aoyKxvdQdeJQfPHj@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 21:33:03 +0200
X-Gm-Features: AcwNN1WHKWPg-gulrL_ybc1YuKIIGquGv3tDzpc2zs94XwMFk4U-dS3q1iLbtfs
Message-ID: <CAJfpegtgenUaudDcvecJuV2_WkkVw=gdcB0Eqg=UFKPMZP1uKQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 20:17, Matthew Wilcox <willy@infradead.org> wrote:

> Before:
>
> fuse_open()
>         invalidate_inode_pages2()
>                 folio_lock()
>                 folio_unmap_invalidate()
>                         folio_launder()
>                 folio_unlock()
>
> After:
>
> fuse_open()
>         filemap_invalidate_pages()
>                 filemap_write_and_wait_range()
>                 invalidate_inode_pages2_range()
>                         folio_lock()
>                         folio_unmap_invalidate()
>                                 folio_test_dirty()
>                         folio_unlock()
>
> so what's the serialisation that the filesystem can perform in the first
> case that it can't perform in the second case?

In the second case filemap_write_and_wait_range() won't write protect
or unmap the page, so it may become dirty after the writeback.

That can't happen in the first case, since the page is written and
unmapped while under page lock.

> or alternatively, what's the serialisation that would be useful by
> adding a lock/unlock of the invalidate_lock inside
> filemap_invalidate_pages()?

Nothing.

What would prevent this if we'd have writeback + unmap + writeback.

Thanks,
Miklos
