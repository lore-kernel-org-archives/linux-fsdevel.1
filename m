Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFC3B6363
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940294; cv=none; b=lI6VY4YZXrXIGlsM3Tv+vxMtR2yR0QY5O+OXwW5yWr15M1b5mnZsgbUlbb96tHvBqS+pRA41lDTpROUTAI8Xy1KX6uJ/2dm3YBHYAE1/drpf/CPt+o93OrMLFjG6gaAnod/qW2h0hZ/zL9Zg43/4D5CWwTwpdipnfk9DqbuV8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940294; c=relaxed/simple;
	bh=++/qmZXTMQ68hraBTB1ddHNUtBYya21+wyElV2k699g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7T0o7zO2TDFVnhZi09kKy7SNeinRzYIX8oHYoewDZ3Pqfdv+5KkWClMO+mzm1VTFdQNrWeBY+x65TgsMjYLwwR9KHScMTxTbhp/PijFwnuqmnwXLuHpKy54P57WVURPTMSQOIvYzTFyED9/pEiO9DOlIipFg7SoyaqCQvs1ilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXrM/g26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXrM/g26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C190EC19423
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774940293;
	bh=++/qmZXTMQ68hraBTB1ddHNUtBYya21+wyElV2k699g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FXrM/g26/3Pwi7cpaFMDiF2SxboLJIp2+hZymwyVPBh8Q4ZhOuanzAZMOCq9iyIxW
	 79kVnayQL02PPfMkzfYW0lVutG5ktpDmb2IYI4487pGAU4EJopU3gC/Ls3qxe2FHWT
	 sTlFqgY9BPfk7xfDbYVPDVE0htDWs4o38XJ/q/8zaOI8Le+xRNs9dZpYEd+zyCLnMD
	 cDkz+0CEheS97mCqcaCslNGiPbouVyJRbzqlQGeEx5viqGryQWF3eKbe5MkQ7E0osw
	 A31iH4vsUmTUVOLXR8Qiq793E+YINzAXYVc3+nyOo/EUOdYzZRVs82oAb0yWUXVtl6
	 EszSmjLbT+sQQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66c5b2e41c1so140479a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 23:58:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCChDBW4cy4Eb971LQbeBOvpGOX32SYI8E4y7SAbfwC/u3NAgdhC0mILE1bVTi/P13gJC86rEYLH3BPsbm@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqWmiKyyH19MkyGvoYl0HieVmsmcLgmfZy9fOMCiY9++02Jce
	fVEY4LBzi3AQ+LQESc4lZmM8BG6emuvvhu4s6YBxICeJQBkwInFYLvJWw0B2SsgJXqqy0+SwaCs
	HX1RpDmUYPQd+ecoyuTtujw9uJuk9yZ8=
X-Received: by 2002:a05:6402:454b:b0:66b:eb33:6660 with SMTP id
 4fb4d7f45d1cf-66beb3369dbmr2789482a12.14.1774940292447; Mon, 30 Mar 2026
 23:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org>
 <20260330063821.GC5897@lst.de> <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com>
 <20260331054616.GA31506@lst.de> <CAKYAXd-2=AM4vdwB6wzycDAXQd5CJEqUU0GPjRvskqZYFXS2eA@mail.gmail.com>
 <20260331063755.GB2061@lst.de>
In-Reply-To: <20260331063755.GB2061@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 15:58:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9QnpwUAnh0HMVuV0RCvO9a59t6HOdubk+uGkDoe8N46A@mail.gmail.com>
X-Gm-Features: AQROBzBFjnHws2xL6Ukmku2BNRe33t3tcCvIy0Opp8HTv4FtahFAxWv6lazwFp4
Message-ID: <CAKYAXd9QnpwUAnh0HMVuV0RCvO9a59t6HOdubk+uGkDoe8N46A@mail.gmail.com>
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:38=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Mar 31, 2026 at 03:36:35PM +0900, Namjae Jeon wrote:
> > Since Jan's series renames __generic_file_fsync() to
> > simple_fsync_noflush(), switching to generic_buffers_fsync_noflush()
> > now would cause a conflict with his patchset. I think that we can wait
> > for Jan=E2=80=99s series to be merged first. So I will drop the
> > exfat_file_fsync changes in the exfat iomap patchset.
>
> Or just open code it in exfat for now and switch beack to the generic
> one once that becomes suitable again.  But we're pretty late for the
> 7.1 merge window anyway, so maybe not rushing this might be a better
> idea.
There are still several things I need to check and improve, including
possible changes to the core iomap layer.
So I agree that It looks difficult to get this series merged in the
7.1 window. But I'll submit v2 patch-set so it can receive further
review.
Thanks!
>
