Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CF1F12FB
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610472; cv=pass; b=ER2A9vbjwSZDHCKcNAQcI8snMQB/GJ14wXkiiDjXMMOObnXqG0SVIuvTyCjGW3dZOe2GOuKUE51DcJC1Ubdav+8S8sjUmQLQ9/J6mC6L47y1yuE0mkvtHvasy9R94AFJxmAuG+qtSAkU4L/ZNBPNDhGgozuOCsaOE9nMATZg0Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610472; c=relaxed/simple;
	bh=s5Gfpg0zgBC841yiwSBnIRqhIhRvVPkWqEeOCqHbcEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DJJff5R6fYDAcM/1bGVzfLs/d/h5o1030H0x98VjVd362PHfAxpt4cWuXJbvNVTSYTP5Z2lxfe3n5RQQC/lgYWe09sg1e8thHRWLkKsrQaP3WjkYhkqwW5JE0WsX0zni8bNSpyOmHB2dJ/kKtfWqJvu3mRYCqLH1/b1cxbuMJIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+kHRWES; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+kHRWES"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so3634383a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 11:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785610469; cv=none;
        d=google.com; s=arc-20260327;
        b=dnCgVAITon70RpqAd2Hu1ECaDqRCLrHwssPdY3CkrPiasGcek3lUBh4oTxJ78jRCSZ
         SfW0gJylQx10QSKOjL1dckQ/fHJxJHfOIQeDyFqbFMG+ib3cR03Kt/4MLHFtJ2ncUCG5
         4aKgDWEIXFr+OdKyr3qumiwrFF3WvkqmhD2aAafTutR+mxTAXIgC6RZj0uaaKPm+72Zy
         e5qhokiMneGQD9krjmym3PBkl+2ZJVb/Ha2aA6PKcYP98yeqmw8oYgubLF1e64cDb6ME
         HG2JrDCi5b3wqKmYhTuW6UnCdN3lZSbiwYWNvMSBCYK8MuIIvNgceB0y0QMG3irwWL5k
         JH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=72LrGKvsXvQhEBxFk1sMzgi9EvOeboavfgQ4tZHipRM=;
        fh=s75CVXMQfVuy+4x8rM3GBvU7iOd+JUAboq0wdeFh2Eo=;
        b=V2KzPY4bMPjd11C5hB5Y7RRAl6utTCRFI4UpOyIIJGmQFbAwKgyhg/ngZlfxmSHl5v
         AZBYr7HdOvegFzyiZQF4ONN58hh91BUx/c5ruIAAD3EGod5s8hhRVysDofEy7ckem16h
         78ql0ALaIVOS1Jyfibdjuz8TdS18kj4GKsfKaahD0AEFj422+VIIohrkyiDaR+PZ/eA+
         F8cWjqBTnlyCuVKzPASqBsiPbpt0E40nQVH4uNTsaxEastjEo/qXByYEI34j0xDNmY7T
         DuYi7SV7ukXGM4yBYD8rVUedCNpKY0BBcDhlZ/IqoI6R4CuWSHjkZqNry20/5rrV8l9s
         okgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785610469; x=1786215269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72LrGKvsXvQhEBxFk1sMzgi9EvOeboavfgQ4tZHipRM=;
        b=Q+kHRWESE+/mDhPdNUEaTBiI0dlSMlGRS9I+KEQcijy7NatsihntEg8uxW2LNdePLu
         iOYY3eLTxM2xfGqsBSRRhZzGsboAiQ6zIiX5VQ+0C6yBy0EiJVFUSjtiAzH+NP093fby
         JQRGgB9sTlGQtIcCPfQtt9QLBxfNoH+pdRM/xUY7bz28Cf/27PFw5DCdpc75zy0rdj6c
         yc0N0WZTj/wh+NVsVUd4ZpODTGSJpbNJmP+KpO2OJz6xYYNjmZ8EzEdW3VgDrMvXVixY
         FOLVs9+xwo1dsmgbD3ypIyt/6Ku36WLWj57eePHrUMbRNtB/JzAz9GzYbpISOJkbjIvW
         h1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785610469; x=1786215269;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=72LrGKvsXvQhEBxFk1sMzgi9EvOeboavfgQ4tZHipRM=;
        b=DL31H9s6gSQAXrGXbWqvp8hFMbcuK056ua+hgSmHizYNZwDDSVs+cSxIzSSN/zreaa
         HbZcrAhpN/cPWX+2OwHW/4UB8gvc7NB5Cwxa2p76ZvjREKZyfJxqchSFoEv+ykia8GOO
         11QqPGlQYj8JGqcid81E0WJh+HsZYW6+73XigBPqHkmNL8llKZZqC+A94HWV9yA9br/O
         IyEq/Zl0yfSmeoiVRtbUXkHXbSQZxN8ZZXV+UvHew7uFSHPfYx6PazmyhsO5+Xh/4IZM
         wTXm+ZhpgfD/1/j2aIvE9ZroGWiPQOPHZAGNMOUoQrXFf4aYhKaUUhSkFAPtp+lF+/Pw
         b9tw==
X-Forwarded-Encrypted: i=1; AHgh+RoCnF54SCyFsY50vFKyBeMG8149j/LMgcQHoOxIMudeo0TrxIFS5B33EAc/Fap1Tr/5lnnOHAA8flsoDfTB@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRuc/yMeeSf5g1DwWF6ugBIdXZBjK7s27iUZbzHydfUOY4Mhq
	tg/CpBGUeZQRfYv0nMSZCpvfAcpTXdOLdNYY3F/COyUZWtdk9Gi9nx/A42ROaj7XjqgMDb1nlow
	zwffF+k5kyRexvGbNnLN4RUUqB5gqXojwdp3DPCo=
X-Gm-Gg: AR+sD13Mpzg4UgGHomX3yj4ip4PCFD6+CU3gav518ZduGfSWqk+ShASGhGAN4SooKkD
	xVL/fEVvY/2X8lbqKfXWGAMD4RHABAWwLhZip35X3B+oxHR4ZaWjmQe92GmLYHTcW2lMJhiPbqO
	FNh8P4Q8Bb3uluVfHk5YPje9j2BgWs5nNQovGjX687hzdOkOIpLgPrsSelBw/pZEQCAhs3wDmrR
	B0Xtt2Y08xW8L9LmacDQ9BuW9dC4MlJG8OBr+7gAxX1YCZxr2nsNgzu+EV5LAx5QklNT52EwP0r
	99bv50zGk9QMzabrzY6vy12gzn2gZgU+98ABWjkWF4j6hQ==
X-Received: by 2002:a05:6402:52c9:b0:698:ac8a:9a21 with SMTP id
 4fb4d7f45d1cf-6a0a7c5e513mr2672190a12.8.1785610468878; Sat, 01 Aug 2026
 11:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723114848.1212429-1-amir73il@gmail.com> <amKjyp78ngW2Kmku@debian>
In-Reply-To: <amKjyp78ngW2Kmku@debian>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Aug 2026 20:54:17 +0200
X-Gm-Features: AUfX_mycy3CLDRPo1M1-mDD8CDdSTIfqZUV4MPkGVFCoOu90Y4JLcLs7KyDRwqw
Message-ID: <CAOQ4uxgcU1EzsOfWZRMzubso1bd-QfQ54w_TfBBCniQVSAHoiQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] Proposal for Cross-fs copy_file_range()
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:29=E2=80=AFAM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Amir,
>
> On Thu, Jul 23, 2026 at 01:48:43PM +0200, Amir Goldstein wrote:
> > Hi all,
> >
> > Daan De Meyer requested a way to do copy_file_range() from overlayfs
> > to/from another fs, where if that fs is the base fs of overlayfs layer
> > the copy could be an efficient clone.
> >
> > TBH, he also requested support also for cross-fs clone_file_range(),
> > but I am not happy about providing that.
> >
> > copy_file_range() already supports cross-sb efficient copy (e.g. with
> > NFS/SMB server-side copy).
>
> I once had a long-term goal of supporting copy_file_range() between
> overlayfs and EROFS

Between EROFS and overlayfs?
I think the proposed API is general enough to support this -
first the dest fs (overlayfs) copy method is called, which calls
vfs_copy_file_range() from erofs to (e.g.) the upper xfs and then
the erofs cross copy method is called to copy from backing file to upper fs=
.

> for file-backed mounts, as long as the EROFS inodes
> are plain (i.e. uncompressed). Such cross-fs copies could be decomposed
> into one or more sub-copies from the EROFS backing file to the
> overlayfs upper file, so the underlying backing filesystem can perform
> the actual data transfer. If the backing filesystem supports reflinks,
> those operations could even be implemented as efficient reflinks.
>
> This would greatly optimize overlayfs copy-up for file-backed EROFS
> mounts.

This optimized copy up does not require copy from EROFS to overlayfs,
only copy from from file backed EROFS to upper basefs:
- erofs should support for copy file range to another fs (similar to patch =
5)
- ovl_copy_up_file() should use vfs_copy_file_range() instead of
  vfs_clone_file_range() - or some variation of this

>
> I think this should be feasible, although I haven't had time to work
> on it yet. If clean interfaces in this area make that easier, I'd be
> very happy to make use of them and enable this later.

I think it should be pretty straightforward to implement this in erofs
however, calling vfs_copy_file_range() with the backing file would
populate its page cache, so maybe you would want to limit this to
when the destination file and backing file are on the same fs which
supports clone, perhap via a flag COPY_FILE_REMAP to
vfs_copy_file_range().

Thanks,
Amir.
