Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9736E467
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210565; cv=pass; b=FdC8bHSQ2bX6AZKJeQdZE/gzQt5GNAVrSYQWQrbD4UAgCBABBRv1Ww2+C5BSA+vSJJSjRbRClgIbQauZkJGnLgLYkgxsmg7bQbQbzZ2LEQ2G0dUmasa3zb7R4Tf/VOgcCKQ8oGpqnAgPiKwsZfQm0eYPwRvQqr0rQcABOZzsz6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210565; c=relaxed/simple;
	bh=dujJLBIcIKS5PN8KWDYWAqd56jSfY4IpNR+KbOL5HrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBno/kql+i/Fpzy82Bdf/uOgdUkpTQPYlGvGSe+PGRCAeekFAEtQ1xo6R6PE8ibC5PjQUrHQJBKIWKmxV2unmhnVEzm5Znqd6Puu1nFnvABnZUD8fV44XbWCjbz+uAqfkUYHQVCclo/WHAjWu5kl/0xliKQQx9TED3wOh4jnMb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2PpyzP3; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2PpyzP3"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b01910b499so499403e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785210562; cv=none;
        d=google.com; s=arc-20260327;
        b=EPKnTUIMqiLCCUqVlTzbd0x7U5rbawlMF61cxhHu2YKG+gx90HlGRuLsXswv85puss
         yC8Vz39W0ZxXCTHc/TGLMN6ePyRrpHbLCyNZQBs4zRLoyGJQEsL2nh8esPw2nQm2AVpE
         /M7pWsEZQdJvuBtjXjkpnBYUMAqHfcePmKapH3aPF+H/ezwXUdERgbBnQCdJ5rb9DNOg
         20jkQ0tk8e05koxMwZ1Kg63AXsvzHT0+ggCo0euBvQhoTWggSki1gW3jn7EQ85lQcaif
         tOPA1YmVhwS8sp+LqWlS0VgsR93M9RllqCj2gR99+ng5qdV2O6r7JaD8hOSMofCkqVJ4
         Mm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dujJLBIcIKS5PN8KWDYWAqd56jSfY4IpNR+KbOL5HrU=;
        fh=bmhjpUlJn7ovm9aYQ3YNKUgKfCB7iA+TfiXI02XaRAY=;
        b=NM+vTnd313hL9m/yiC6jSO9MC/PYYdy94fPt1AMgdrRf24sPMWcTevsaCPrpOR8bej
         Jxten9UvTBdZV+xHwb06VupSkpvxbOP6G7IR+qsalbeAgkDnmGCGDk2x9hgJmD8x6PDM
         tu7mSz890EPwRB8kx8fSexs+eu4kgvBZL1rSliobUeAGR7ASYS8PlyVK0OhIrHxO5seI
         juVJ3m8aJNAs9sTQZsotg1kEByNp5jANeoK2BpHuqs9EoX7OLaHBgwIiy/YYDBn2/Yvb
         iRUKOxWHVEicgiZrcF/2QC5xdpxb+MK43yKrBMXcd7lDtc9fNvGCITyWm/rx3rH9fTD6
         N9kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785210562; x=1785815362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dujJLBIcIKS5PN8KWDYWAqd56jSfY4IpNR+KbOL5HrU=;
        b=W2PpyzP3nerpMNgI3agITjQtpgUm28lRy8UptjwF0gIBgQEkIWQ7yv5UVCorCYQk4Q
         SYb0uPf0OpDHggX+Il4KfQkllulrkBSgiWFU9u7AhLrQ8f25v8kwl9dWLblcHf7aCJmC
         aHfm0iy+LjiyrnDB5FY165NpYoj1JeMCRX/avCSGw24lyFjIQ7gRdZg38/LSnOfrxfYZ
         s6yxdI7fIJ42Ix7ZdubHsn7n8SIoaDAtXSh+nu1C5jNh0q2JohtrqFr5P5yKk437W67P
         9n0M8IvvWQ53kdwT0iKGqQGRhljgXibmmBt3eE1en4/v1Qx4BarvAV+dWHBZQ/WQ6nAG
         buUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785210562; x=1785815362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dujJLBIcIKS5PN8KWDYWAqd56jSfY4IpNR+KbOL5HrU=;
        b=YPrjMYZM7gF3gWSsqvDh5HSOl/e0lyS7j/cIfCVUULLFzXoTV3Z85uGwGixljhOkBm
         4tZGx5WwVFgEUFGZbU4t3khut3cg9UqZivZ9NIV4CADSwi+FseYVBzP6he36T7U9fq2H
         BgFuCsPBtE6au20qaOUKCVnFg8hTu/W1imQu3jMxQkG60H5E798gx7Zir3/IPhlkzzqt
         trFhPY59Jkk7wGkY3+aYNh3yPdVo+2pG+TNobyub4jS+zRtoDiZEinTUxT17dxRuw5ny
         h9Oobl+jgqrBKOCi2c9B9KTyh+qg7lQkSpORePoVYMnEMAyL5ddZ76gFqLABLaNOMCzj
         mx7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpNAYNiOs3ALpRKcOKGYNwkvgqOnZNuEP7Y6N3IJWCZfVz2nJA2QJmmoP7h0AkSCOv5v44JAhSCAWTssLT4@vger.kernel.org
X-Gm-Message-State: AOJu0YzILJYN7gY1f2lBoqMcGUDjp54QgE6QivbKCYZI5MAgfVBoP4qj
	Tq62FjhYgDtJgUz2iScdUAR45tXvGUFHQ5GnQqyDskNsgMcav810zxsiiIa8e1Q4wgYDwAA0RTG
	6BL9Jscely+ezSPUnIaPCbbtHShGMYOo=
X-Gm-Gg: AR+sD11zwtliG2b+IIrQs4h2wLbCRtAUMrekl1+gf0dT6l8bXy9WqVGYol6VeLRgW/q
	6nJjpThNfCjJVk+4keIIFHxGp7Q+O9XMFgDuuo8Spbc5iqAHnTT/KRGPDWr5YZfdh2AMPmtIDPe
	HKSogoX3mUjmnYAafzxcYiwLhYVmP18ivmjIMgGzNnOfYx4MogeD82ngLxIfj17SQHZ2upmUthO
	sbRe+8ZJWrCLtxOEqd2WXKxet597BH9ShKdAiDy+OxzqIVMR09ZBuHmXPiCtUo=
X-Received: by 2002:a05:6512:1351:b0:5b2:b02c:e8ce with SMTP id
 2adb3069b0e04-5b2d025e1bcmr70990e87.30.1785210562054; Mon, 27 Jul 2026
 20:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724222745.2107464-1-slava@dubeyko.com> <20260724222745.2107464-2-slava@dubeyko.com>
 <CAKFNMok2Op3dAAU8zGWLNPLeh8wj42MgQZbEdP1wSj8jnsO_+Q@mail.gmail.com> <81011aff679fbb673a35a4b049f65b59eed7a233.camel@dubeyko.com>
In-Reply-To: <81011aff679fbb673a35a4b049f65b59eed7a233.camel@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 28 Jul 2026 12:49:03 +0900
X-Gm-Features: AUfX_myioaW8LtNvXSArg2YGK6sH4nnA-hREwsfZkF8XIJRy5m0xFV2VL4az-TU
Message-ID: <CAKFNMomBpySX7cqPUdVjdmaBMOnguDT_miNMK04b-H86BUYvxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nilfs2: add iomap operations for direct I/O reads
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: hch@lst.de, linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:46=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> Hi Ryusuke,
>
> On Sun, 2026-07-26 at 07:33 +0900, Ryusuke Konishi wrote:
> > After encountering a hole, I think we should use
> > nilfs_bmap_seek_key()
> > -- as nilfs_mdt_find_block() does for metadata files -- to
> > efficiently
> > determine its length.
> >
> > However, if you are short on time, I am fine with the current
> > approach as well.
>
> I think we can rework it later. I am starting a new job today and I am
> attending FMS 2026 next week. So, I am expecting to be really busy at
> minimum two weeks (probably, slightly more). So, let's keep it as TODO.
> Please, remind me to rework it later. :)
>
> Thanks,
> Slava.

Hi Viacheslav,

Understood.
As I mentioned in my comment, it=E2=80=99s fine to put this on the back bur=
ner for now.

Thanks,
Ryusuke Konishi
