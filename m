Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697843E0251
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771323; cv=pass; b=qt9f8MzNv/zztQy1zoTMrcFIzY+xwz6hPUtD812UAuT+XK1/LgQKFzbXIcbgVlhTkPHa2qieRfy8jKSntwSvhOMWj4JnGrElbRpQR+pqiZ8zf3PwwywuPAWg0VwpC+jI18edTXLvZrBfokDVm+ULO9yV6Hl7EWOBE6Gdz9GWsqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771323; c=relaxed/simple;
	bh=Oqw0NDluenc4M9KSxSuO4kI1l37w9GHWqNHYO2kNx68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OINDSYEo4rmRkvVwlR9okOlMojjG1i6oS10aVU5Wltlzsm40cfD5QAUgdgi1MezKh7kMwO5qZjJ256RL5RED82QBeedaQAdcLZ76Lo7BpOCWYGNrRz3D5k+K/YPuN2xsgyhuMSRDzKUWJL7Bpd/BjEL5++vPGIPV579rFNiHky8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFPFUZyG; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFPFUZyG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44c350a5b87so5032941f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 08:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778771314; cv=none;
        d=google.com; s=arc-20240605;
        b=dShNsF/qK94q0czwBPdFHkVREAJxtsVpLYCMzduWLIXTzciCirh1/ixJae/NzNibIY
         A0TgWCeaegVF0ULIg2BJt5IFVpYqj3Y0JPO5lD6NnIDXZSM9sH1t0r3AOPGWdEp2pAuc
         +PJ4vg825qdoV0wKaUn6RbaGHHbCdc42DIKWNS7FJCHOim/ZbXC6theITGmm89vS2CN8
         D31wNSbZcBS1poEmP/6NXrgurH5RuSV24PgvKmUZZEbKeBUzWNOm3w9S0rlHcevUjfrG
         IPAwoydKCQNgL9/9jDb20fAc/YWA59pjk3WCLLALUtdP9qu6ibtanKPLryIfCrSNzgSa
         wYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bdgZnAoM28ZGhdZNKKk0p4fIizw0yp98Oy054cZAiQ=;
        fh=eCeO4M8zAu/UcelLyMyohtWAeIIW0CxDnKeNlbHeLvg=;
        b=QN0gb0ZCUaDlX0ae/+oQuQ2B25KhxAlZVuS+xSXhcEuLOyQK1dmiKxt6O/UHYFSnie
         GEGdN68IgOT00YKOuj/xfoKjvvC9gWg1swLJPLH9Z+cdVTHigXTw61DgXGjVcMhpxPgV
         gaIeTFuTqG1D/Lxps70jTia5e2O4QPxA8zQlhXtFgpngnOGu//hhSD1g0hH2iy/BMjlu
         VD0HPHwpJ3eV+j3vaOD7pTxt7lsBaX7kmv/xyWz+/KWtzKCeZpcqYXtEcrqE15yMazxb
         ud9Zjm1maZs3be5N0AALdQ+bbEielAvufMIq7N4qlTt5RJN8M6KqaFEARWht7gIgyawh
         EgCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771314; x=1779376114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bdgZnAoM28ZGhdZNKKk0p4fIizw0yp98Oy054cZAiQ=;
        b=jFPFUZyGbul8cFDW3q1P3p8RLFHIlj1m8F/jtBNQTuTemT8CbQcyZBT8xxrwEoNmdx
         dvoD/B1XdCHqWwexSKNL3GiAmxfVL27b9xO8VLbakoMzQCIlWUsOfnwuogxd2hefNitU
         EA/47XveoOX3bQebaE5Bn7Ib1z0EBA9QLxXTki+3y3j/Ix1432ha4YtONJr2yrwRUiEJ
         Ln2BI2WkrizjK6YQ5oQ7r21y+2JS2T8GcBqe1dKf/TMkqN3KHUqQuNnMrqOzpOgz+0Dg
         uvbu+oXzpm0FA7jHZYsRB7qlCYMB+jrUo9yjOLaEjPixn52lGmzHwMM99fy2pZE3AbJU
         BVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771314; x=1779376114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bdgZnAoM28ZGhdZNKKk0p4fIizw0yp98Oy054cZAiQ=;
        b=jMxQaUwRbUcS7GZygNpKjW0E9Dzlv6SU8qeyPgQCPgGEtr4jRWJ7vBaDJdnowvr5yd
         Omo85pJZDVbOyOJd7iwzejK05345ZTaxyLaJjIN3fo+YJNsLli0zjRqx0yZDs0Ax9h4E
         BTq+Pnf9W2nm/C8mZ79/+oHkGgK90wufFN53Hsbj/Go6DTlye3lSFzeA5dKafB+sYRbb
         Fs+ZFFf4S7AKaDCE0M9EW8B4Q6sVDHioEUJk1mMG5EsP/r8CgDACgWL3xrndKE9GBOjE
         dXDjDfYAM5pcZgWsBCk79DR6GddAU98QhcXlhYWLjmjMws1h8jGP/kDeD829gRC79tFC
         wZug==
X-Gm-Message-State: AOJu0YwhyxNSy8TAhsA1UzHHMw5+mAe1JV80wnEb7xacu1NxLmzswg9X
	9ALJkwlcWkhTKacc3wEb3qJyEGIwvCVfk4Wdyu2re3CiAp48ECMLSxRdpgzQxiaHSCFShJ8h0fa
	Lr7vFrxgBm5Bbt2pDN2Nm+IS3Xb6+7jtmz4/IOIM=
X-Gm-Gg: Acq92OHfkic0miyDhrHIz084IcCnUN90n0DcO6S3aJub9q55HADsw9dctdeRZIUWckE
	zK4b+jA0XW7P97ZzZVmbkqeQdRkhipFC1uLB/9IRtlEVRm39ifhpQS+I6lyA8nh/Ocw3IRxP0SE
	2Fjy3Jf8EyztctJCxty9GAdWR2jf/6hpOPe8xc6aRg/CWzc8eeBQXXyPTNCo1efFx91Cpl1MR2g
	9c9k2IG/ZvkbpGJVeZH6GRVg5UVLK3w8Gqui5OyUMk+Ke+yfTu/OClPZBXIZHnZQIvriN3QOmVc
	BhT3tw==
X-Received: by 2002:a05:6000:24c3:b0:448:8db5:410b with SMTP id
 ffacd0b85a97d-45c599ebcc5mr13067532f8f.20.1778771314283; Thu, 14 May 2026
 08:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514062955.1183976-1-yi.zhang@huaweicloud.com> <20260514062955.1183976-5-yi.zhang@huaweicloud.com>
In-Reply-To: <20260514062955.1183976-5-yi.zhang@huaweicloud.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 14 May 2026 08:08:21 -0700
X-Gm-Features: AVHnY4JGAYta6lc0ZFFwSJBwWzibm6rBu2Rx6wdCCAM4bkR5PfJiohRCslD9kBQ
Message-ID: <CAJnrk1bHM9aGXbk+LJYJZrfbtLvbwsqwrJgY2KkT5AyVfBjdrg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iomap: fix out-of-bounds bitmap_set() with
 zero-length range
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, yi.zhang@huawei.com, yizhang089@gmail.com, 
	yangerkun@huawei.com, yukuai@fnnas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 11:35=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com=
> wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> ifs_set_range_dirty() and ifs_set_range_uptodate() compute last_blk
> as (off + len - 1) >> i_blkbits.  When off is 0 and len is 0, the
> unsigned subtraction underflows to SIZE_MAX, producing a huge
> last_blk and nr_blks value that causes bitmap_set() to write far
> beyond the ifs->state allocation.
>
> Regarding ifs_set_range_uptodate(), it is temporarily safe because len
> cannot be passed in as 0. However, for ifs_set_range_dirty() this is
> reachable from __iomap_write_end(): when copy_folio_from_iter_atomic()
> returns 0 (e.g. user buffer fault) and the folio is already uptodate,
> the guard at the top of __iomap_write_end() does not trigger because
> !folio_test_uptodate() is false, and iomap_set_range_dirty() is called
> with copied =3D=3D 0.

Is the Fixes: 4ce02c679722  ("iomap: Add per-block dirty state
tracking to improve performance") tag needed for this?

>
> Add a !len guard to both functions before the computation, so that a
> zero-length range is a no-op.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 27ab33edbdee..6fe5f7e998fd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -67,11 +67,14 @@ static bool ifs_set_range_uptodate(struct folio *foli=
o,
>                 struct iomap_folio_state *ifs, size_t off, size_t len)
>  {
>         struct inode *inode =3D folio->mapping->host;
> -       unsigned int first_blk =3D off >> inode->i_blkbits;
> -       unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
> -       unsigned int nr_blks =3D last_blk - first_blk + 1;
> +       unsigned int first_blk, last_blk;
>
> -       bitmap_set(ifs->state, first_blk, nr_blks);
> +       if (!len)
> +               return true;

I think both callers of ifs_set_range_uptodate() use the return value
to decide whether to mark the folio uptodate or not - does this still
need to return ifs_is_fully_uptodate(folio, ifs) instead of always
true?

Thanks,
Joanne

> +
> +       first_blk =3D off >> inode->i_blkbits;
> +       last_blk =3D (off + len - 1) >> inode->i_blkbits;
> +       bitmap_set(ifs->state, first_blk, last_blk - first_blk + 1);
>         return ifs_is_fully_uptodate(folio, ifs);
>  }
