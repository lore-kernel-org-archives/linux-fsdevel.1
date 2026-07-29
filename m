Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FE46983B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344013; cv=pass; b=N3Dp8SQqJ9jjTgdcJyb9vSx3lWNxsWLgRjQ2ftLa9DdNeeAfisbvWkxoREado34uB8QFJCVyX7MZzCvI47mz48OrsLYDyEzi3gQ9YCzsCIHi11A/Lr5ST16q1ctJD3Iorvjb+1g4s55j/fWp5T3z/k+R09zD/mFjxSK0oePm8K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344013; c=relaxed/simple;
	bh=/YYV8EJ3uAY8vVlHWLu4xPFSaaoxJidP5IaWXw3aYyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPK/ede2tgN+1tuX+5oa+I7nF5UvTSn7RtKGSLv80gx5Cw+klC8wmgOF8LRmGyKU6xkkgCAOBBvpCH0Fjy41rixy3k10JSnjfSLGv7alu2240KN7gJy+Y4BBY+KXj2Q1tgXukB+JeoE/3PnQCx1pR/4g0MtPF5qL9WsNSgO5sjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZnLVGTN; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZnLVGTN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1789421a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344010; cv=none;
        d=google.com; s=arc-20260327;
        b=sOt8TXUpedy9pV/ji4gbE1X4StwEx66DbT3BvrYpNCNGbTT4t4F32rsg22dfdYlLZt
         UBpogGV3oAbufRxfZxhl0ILIGBMn4/9Q5MulBFCip0crJULtmGuvV1+OsLz1or5XciRs
         HhnmZyLQAgYAe4G7qmyFUUitOGe/4htuZn3sUdIfnWenYv1gBARDo6ypSeRAk6nBZ3W6
         qK9JmaOfQljK11dgfLUFgCbZnIAg8RxwJ0pgK5qUP19jZXCa7md+h39rRKKJb9h5aRwt
         YlNmmSVECVycUPKCeH/FC3MnhxGMZc8/8M4/H8j7HvLei1z5qJCv28TaGl4bxyQl2owH
         Ktww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        fh=Kao+pHCc5BxGtCB9GJKPj8RW+HBgn5Hh7ablIYTKfNg=;
        b=MS9XFvWft7dhITg4F7dlhlS0P38ap4L9OCU+7FnLjBeF/rYJHNb5f3eJdDEEyiyhNJ
         eo+3X/q6sTT5l+cUXygpxfMeb6O9rHeLoJlM9gGcTYWYwqLsd3rU8Ycmv/xOPDuXSe+M
         yO7kZw8ChHRmtTFjdMPQv7Wq5AxTGOYGpf9S6OyBYAw0LUtKFAc3CBcMxTIPZJYmcvbt
         YgH7ZAX5/thhAo86waAT7wsr6yB7TPBp0WONa2xfb++mEskz6A96DEJKuW+I/2XkMOed
         vATxjmKjNFDhmn++NDtxQvY1lPQ9TtVx7YCAppriUJDoOmdQUlijyJwukeewD1ftuIxH
         I4Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344010; x=1785948810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        b=bZnLVGTN71+6rOGUEDOF2KKfsBoVzgPc+6KjOtUaxwoQVgAQmK+bgtKyqFpFZyFtJq
         nJFEqB8j7YlMnW8bUNEzJRfJdekDJcM3xXyXgWJfL8WDAjIA3f+W8yZPcnNdDQX6YYPs
         zt8TRyVY0NOcpOxJVRgxQ3PtjdnE21ULXhmra/XwVXzB7WWEeWKmgccKwMgl8IfnmX9e
         NcmoVChs0wbWpUsGydeoisKkkxMd3DGcCAK/J5JcBvgO1tu0OLStdS8VZccIfwTe6wFB
         My0l1BLssPp/A1RJ4FF3WmwVQ3SdB6FnYUo9UJmt9ZOwzK9HEYfhV0xxZNVb2TFtv0WA
         WvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344010; x=1785948810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        b=d3GKwpZHkh7zKT8vuCLGdRZp6L+vnyTM906gRDlJnno4fhRCcEtc9Fbn+x4MQTPXj1
         WwFfQRgU8Rx57cGrgNffndfhy3JpjlGeTEuTmwgRAzeVwDisogHmBTWofxalZIQ/lZ6N
         2loyvaKTjz+TSBxfDaYJzTyuYjfxduZrSv2evXK5fG5mK8safjhy9xG1tQjWccQKS+Np
         8dDPBsEnJ0cF2gNB5joZdx4p9Vn3tgxkDx37WJJ0R4jpMzb/CypKvpvKccoYtAtgs1YE
         2QPfygvKJVPE1wfIre0A2LxRxxJ9uNbGEzaWipt/WX1OdVIqyMR1zoZ3304Qx2uPNz15
         TExg==
X-Forwarded-Encrypted: i=1; AHgh+RqN8gjGvpg6vEKmKGrWozjt/ZFjVZU9c2Ohq+42KOT2yipi1qVMc8jWiucblKkAHb79rWvLSK+XLO32bOxa@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYavHBKxRZeVwcVMghTS7CqyGNKLCEzPP8ZmSiqwDBWQZbgtX
	lXxg3BgwJXsDZNpa1rGpGBM8gkbxhlovis44qpSzQJHrjNx1R0y/ps9jtSItKAi+cVOngl8bnE6
	pgyh6PZtLPJSmxNzGxfqOFujA1bbuTQ==
X-Gm-Gg: AR+sD11yZ6CbBwTCYcizWwiwzY41UO51/gMn0rkQDYxQ4w/HAsgu1Q/pwcLgTsCmz2O
	JhWPj9KrVLsNhGLnSmN2FOYCRhP+FYDzqzZ72CCZcJDBPQurc8v94nGdUKe81QUUQYEQzinv53N
	Xb/ENCwTFTcFtVEokeo1N/r+q+C6YEXckk8AvNr2TsnP70HnZfvPd4lzbU1p2M3DOTW3vTprQcB
	BQKiwkbp0B/hM64ejIqa86/MOj2PQi3KCTyNnuwJxEGrT1ia0NdIfsRJcxRQlLn9+5cfsTVjAgD
	+usofqx79k6W0umjBuXfmlMR8STr/bfV7g+uh40ctG/0dLGcu8dpuFW8JsLbuiWqrh1XnAfeNMs
	eieA5YyDWzZvyiImP6A==
X-Received: by 2002:a05:6402:5018:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a0349ec697mr4404066a12.16.1785344009469; Wed, 29 Jul 2026
 09:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com> <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
In-Reply-To: <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 29 Jul 2026 22:22:50 +0530
X-Gm-Features: AUfX_mw2n1ETd8ASN5Vcu4oMSqcqp6oKyV0zFdoD8l7zvxibNrqO80gPOx-5lV8
Message-ID: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered buffers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 7:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
> >> +static int io_import_dmabuf(struct io_kiocb *req,
> >> +                       int ddir, struct iov_iter *iter,
> >> +                       struct io_mapped_ubuf *imu,
> >> +                       size_t len, size_t offset,
> >> +                       unsigned issue_flags)
> >> +{
> >> +    struct io_regbuf_dma *db =3D imu->priv;
> >> +    struct dma_buf_io_map *map;
> >> +
> >> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> >> +            return -EOPNOTSUPP;
> >> +    if (!len)
> >> +            return -EFAULT;
> >> +    if (req->file !=3D db->target_file)
> >> +            return -EBADF;
> >> +
> >> +    if (req->flags & REQ_F_DROP_DMABUF) {
> >> +            map =3D req->dmabuf_map;
> >> +            goto init_iter;
> >> +    }
> >
> > O_DIRECT is checked only during registration; we should recheck
> > (file->f_flags & O_DIRECT) per request.
>
> Nobody should be able to clear O_DIRECT, unless I missed something?
> And fwiw, io_uring wouldn't be the right place to do it.
>

fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
open fd succeeds. The consequence is that subsequent I/Os switch to
buffered I/O and cause silent data loss. Something on this path needs
to reject this combination.

> --
> Pavel Begunkov
>
>
