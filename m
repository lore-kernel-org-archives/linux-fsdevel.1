Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6094854FB
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350318; cv=pass; b=V9ZQIIDOoMKBYERSqWX1rwgZnz2fpIz/x/Wk+f2/6oIkxGZk9Q+pcb4CILubGgjlNIOCYY9/7lYrF4gaXVToK2elTfNgNrNMB93eShC0DZQcpgRK1CO0KnTpDjXLoLWRMoDJCAqa2yhcdm8oD0AK+el2vTXAUb9XfSGKh/63EEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350318; c=relaxed/simple;
	bh=Q3WRkEIRsQGKNmeJ3t08s2z47JCptiTtM8V0Rb1M9co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzVB1I/DzAEI8uHv9IkHLnWYfsokVh9jAPZIfKryl7FkUZq0z9sah1alHVoliUWG7ocTZtnvLGysFtWTeqqp7bPI3oFb0gICzb54ecxWQ3kfg2A3gwjgY2JSYUgZBd/a/jtZ8Jv0be9w70VUxoo+XhoRdTK/nRzXcNGdgDjJ3hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.b=MerJS05z; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.b="MerJS05z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d7200b2e15so10465945ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 04:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788350307; cv=none;
        d=google.com; s=arc-20260327;
        b=Qk+EP07rj7fr5x0lEOndpTtbvyWIaGQ439nAjSv1SzoSOy5pixUiQ3Q74isu4kXhws
         UMenUa2Uhq9ARj3wRKLWKGnoMQL8i54nrDF6AaoajEBRaiTj6Z6hhFQzQTyBCGjl/n0s
         80x/utmEtjcIqgW2bqHeU69fgyBIdTdG+1WMLndikx2lK4M5ycShMrUKQkmCta9F3DLZ
         SZ+zWb/E0hVElqwoBoO121mw8R3sLvTBr5rS6f65DIuVQiWs2ivYz6kZGy1BwzqWw8Yf
         RRwzlZiV6nErj2mBQWgiWu4LKAgedpVg+CcA4uIsxns05kR6UZu0V4p1ailZXP9uqFhF
         qeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jeFcjEieTQ8IE+RzCj+l0OCk5m37YH2HX3j6DbGQ7A0=;
        fh=MeTGhMU4f58SUASBh4BV1cHLlz+57PZE9yuk6IuW8do=;
        b=leOJDNT06vly35PawHaRRwipUrG12ckP88954SOiRLyeHi/7AzJy3Heu1Q6F2+yR35
         pgdv/JOs/ubWBsxNEjYocestcIijEKUsN0B3QhfPMYTdzg0lYQd6yDm4JOFbziYKkAUi
         GzzB/xKQAGP6ZroGG21Kbo8hLIZAyvBgEyI6QCCB4l6nYAT0M+HLb1O5ba45JqdHVTri
         HGjnYKbzDwCdRk0+I3SW+eqpBVHP4Np32+Ucf6HWWZVTviKUICTxEKHu+r3dnEpsaHhW
         TA2/oi7VJebxH5Ki/CbPE6oNZ2BrSTN3SX5cS6H2dzQWAn1MAqe02bXRm7EVCscezpkx
         qq5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond.com; s=google; t=1788350307; x=1788955107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jeFcjEieTQ8IE+RzCj+l0OCk5m37YH2HX3j6DbGQ7A0=;
        b=MerJS05zocgnnINefaUROQtJVzHGcBmLw1DIG7+ah5/WWIzmA2aAfAw1r1SKjahU0M
         wnt7Mp8HpIHSajMSW7YNrTnUo/xG/3+yUudkc9Vuj5lA/RQ39nKh1vTUzj71tq8pzq/d
         6kCgtCZbPnmzHHjvdK6HmVFJtoUgeiJqUKM6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350307; x=1788955107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeFcjEieTQ8IE+RzCj+l0OCk5m37YH2HX3j6DbGQ7A0=;
        b=WEyjVO7UkW5tMzSBRBT8Vhu0kr7uv+pM2+A+iHE8KQAI2BcRIMPzO6gNV7QvWvi6vK
         lRZaPlLxOqwddx9y3mXMAo2360ncq+DhYVmO1fbEm+xc2kcRnAIDiLUrYDU6NQJBFIFE
         2oM+HBWAfQYr9cOKHEvxO5tlTUvWJ6p4Tx2vPFNepV8QZb7U77cymrhCsRpJN5taY1Mi
         OjSqoA5EW3WYyhBMe4L4lNi/CPMOcCbyPR1D4DncUFDfcDFm7k5YG8zfULje21zlzl9A
         AUzo7ZpFd8pM120RNzm5hnbz32DJpbwCp6dqj/xj9xLIOdtlxDHfjzbGwKDHVwlZ6CBK
         AWqA==
X-Gm-Message-State: AFuF++nPnnluqa1DAb4BgNWhSieAEiYcvRfcBxYE/HlifyglQkLy7ajl
	fwOMgFwpK2lIdFbpHRMf2pnTVCzQWTOf+kXoreasEl9FjvKVB3C1hH3pKcO+/1uYuWJM/+OGtfZ
	9ArFerBI0EO0HsxcY2eUtbpXObizbu/+jp2W5KUAR
X-Gm-Gg: AR+sD106YVDmJpTcWGsXBHA/BOmVfakpYn5ViWobu/FcOmIYTt3HC41MPq4JyiVM4cH
	PL42zvkt6CXYYpzqB6fWLGIyi3BXb0B5uRtAO4M5+26/5qGaNfj30JJ09Jh+hldHhgBqqB7FYtV
	zODOc3yPxKLTV96tw3vDZhG7LT99oGmCJQ10nIzY+A4E2vLW/xXVpuPBey7NLR0icMfvGOpyMOP
	yYaCJ/i8rxhdEKPgnMzpsiT52lhJwvQca7xhhYWhemv0723lJMsWSwhRQ3Iop/18E6fYyOdjnd6
	puX4xL2J3LY260sZOUdouYrHjxw8XRosmaAdVKWFTTdae10uwiryktRrw1RL0NfDVi8=
X-Received: by 2002:a17:902:e545:b0:2d9:6db:9fc2 with SMTP id
 d9443c01a7336-2daec6240c7mr54462075ad.9.1788350307191; Wed, 02 Sep 2026
 04:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org>
In-Reply-To: <20260820193343.3852967-1-willy@infradead.org>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 2 Sep 2026 07:58:15 -0400
X-Gm-Features: AcwNN1UGPgR2OUXhzyUE75UUb0F_Z_-IfSeY5WyX8loXUw63t7Uhj3xYLr1qscs
Message-ID: <CAOg9mST9XS+UY_ZrRkvX29go_Pt9PXq_9YMe4NbQG9hFkFPzRw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Remove aops->launder_folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried to apply this to 7.3-rc1 but
Applying: filemap: Export filemap_invalidate_pages() to modules
error: patch failed: block/ioctl.c:908
error: block/ioctl.c: patch does not apply

-Mike

On Thu, Aug 20, 2026 at 3:33=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> There's really no reason to implement ->launder_folio.  Most filesystems
> don't.  The only problem is that some filesystems rely on dirty folios
> being written back this way, so we need to make sure that folios are
> written back before invalidating them.  filemap_invalidate_pages()
> works well for that, once we remove the 'nowait' parameter.
>
> Matthew Wilcox (Oracle) (7):
>   filemap: Export filemap_invalidate_pages() to modules
>   fuse: Use filemap_invalidate_pages()
>   btrfs: Use filemap_invalidate_pages()
>   nfs: Use filemap_invalidate_pages()
>   orangefs: Use filemap_invalidate_pages()
>   orangefs: Remove launder_folio implementation
>   Remove folio_launder()
>
>  Documentation/filesystems/locking.rst |  8 -----
>  Documentation/filesystems/vfs.rst     |  6 ----
>  block/ioctl.c                         | 14 +++++---
>  fs/btrfs/direct-io.c                  |  2 +-
>  fs/btrfs/disk-io.c                    | 11 ++++---
>  fs/btrfs/free-space-cache.c           |  4 +--
>  fs/btrfs/inode.c                      | 12 ++-----
>  fs/btrfs/volumes.c                    |  4 +--
>  fs/fuse/dax.c                         | 15 ++-------
>  fs/fuse/dir.c                         | 12 ++++---
>  fs/fuse/file.c                        | 46 ++++-----------------------
>  fs/fuse/inode.c                       | 17 +++-------
>  fs/nfs/dir.c                          |  7 ++--
>  fs/nfs/direct.c                       |  5 ++-
>  fs/nfs/file.c                         | 24 --------------
>  fs/nfs/inode.c                        |  5 +--
>  fs/nfs/nfs42proc.c                    |  3 +-
>  fs/nfs/nfstrace.h                     |  1 -
>  fs/orangefs/file.c                    |  4 +--
>  fs/orangefs/inode.c                   |  1 -
>  include/linux/fs.h                    |  1 -
>  include/linux/pagemap.h               |  2 +-
>  mm/filemap.c                          | 42 ++++++++++++++++--------
>  mm/truncate.c                         | 15 ++-------
>  24 files changed, 87 insertions(+), 174 deletions(-)
>
> --
> 2.47.3
>
