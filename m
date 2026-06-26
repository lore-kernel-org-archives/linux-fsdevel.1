Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA793009F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485493; cv=pass; b=PkXuHUwTcFJLlFuPPXY8ChHmykMgBCiqHuWgUBsgTrd29oLDeFViwOwg7IMzwQptpQ879eUxAmUk1tHkQQh9Pb8XOHFKfkPKqKVChJMqfhcab7Nc9+MwEuLnkWBdwTr6o01O+QUyA2sgip+3vHOLV+0GN1GgUFpFXWQ9MRi17Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485493; c=relaxed/simple;
	bh=F/vTTa+gFZE1/PfB4U5xRpdZYv0DcxHltEmaOMRgRKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcTtd0MrMPE51jUje5M7QtyI228kbrXTgwV1zas2GRYfmdxUL3sKfHxZrZxoLF4vV8Vt6JHQzl8MKLKYBv2mX5dM0JuglvV1YqmrrfG+2e70dI8mgl52QobSFh0h6dJ2Xtjz05HaN2BRbcoyErHUQqIFmDOTDCztLHKZziCgdMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ps4hgRy1; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ps4hgRy1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46066e640easo580737f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 07:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782485491; cv=none;
        d=google.com; s=arc-20260327;
        b=i4eIVxoK5tyGF6aeAwZ6tIvKVxAHcRnQEbWcOWq8Go75pQxH9MkoPJxCV2rFl50eca
         UN3ZPUsx+w3GvHJGXXlwOAC4dEsfYpJvQVFaVF9NkxXhgjG1vAGoduH9y1vDIPEWbjg5
         lTDW86IQ9tg3vYnYqBxXgYyT8pPhMRrQK4kwea9RjxZF4IIST82eQdPqntAE4AcB7FWj
         muYq2BA8/cKRR9syXuwoMP3yQXDWJ7AphCqKY/uJ19rYV/TgQb1i9Cg8WmLsSYpc27Ga
         ShkVQayv5hTS3K9J1P9pRXMb8P6GJEZ7hoQtDK/4+MzQh0NxpiKCbaRY1KVMqiS9BYAJ
         9ZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
        fh=k2TWn8vWLFI0JEWgut9ybZ0KrTCw7hxK72fVRquSIic=;
        b=p5pCa0bivhUCDzib8+AVeooDG+jKJJO/p8y5Qjf4okz4AoIi5Bzfb+NLmYGB/kk+Xa
         ijNdr5XabkWsbhznXErRTGfd/bVHuXheAXDR/DJwUU+bRBs7AhYT9bDsgLcb4XnU3faA
         x9aDDKcvRVzC/OiC7EzdReB/E8Z530g7bwH8TMXLozprXFvTqbxSYjABk9vxPdok6cmb
         YxL1o7MHpPmG4peMq5DIB7Bb3r64eCDFa+4YySpazNpZOJC5IJRTo8yG+AktoH3NBGDN
         rGcc+CCgi4AwN75LVjyLAwy7k/xFU1qTv/ZFPYn2josoAbwbIRAAx1+a1koWCn6jJLw1
         ELZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782485491; x=1783090291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
        b=ps4hgRy1TOSS9Riyv3W173MqEmxS0jYow5bSnuvVnKOOWngRr9msR0u/sU4Nz66e9A
         KFzMejI8vHcUiFAGV0qXjJliUOnN+laMroqRrzAApP3BCZeq1MO2Pyk4wAQNhIQkQLoc
         rgMUGsC06Kp/yaqAQrwIOAW2FhzEEoDsUKtabw2AsStH4xzvq5LPUB1sHTUedthWS4WB
         jdGIRKg7TywTT2XMl6dBYB3vG8gw9GLR3KpZ4wmrFkjR+c790I6LbHtKKplq2UGcpD08
         zQxbatEmWFt2p9PFrhF2HVxHcV/gEeluH8H1EUgZA/dre7weEkJT9H/m1r9GvlFIiOFF
         O2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485491; x=1783090291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
        b=L242m92+c+79H84VdW1rX03ZYMadOHKdJ2xtGAqaMv5P0oCmnDNNlnu6cp7jbn86J+
         H+KfINvMr6xjIT2p73kNOhB6oIJlIUMsGt5OLUUP0QY+MAjOLTXi732KXx2uc42jGe5V
         eupNzV4RrBiFTFKCQ0baA8UIzERO3h2svb2is5gDuv+z4XtVGE7R09lq4GJ83cbQovxy
         EPMxNL1Q5bsQM85b+/tBzIg6HzVm2IAQD8gcnmAf1c1PRDGLcsadkkqDevr91Z1M/dRs
         ncPUBGk0hR+6C0jtT6vJC4KjEqFGRE8cyYUVYI4NxMgrb9M33cJIFDmVhFkcpi2q8/S2
         gECw==
X-Forwarded-Encrypted: i=1; AHgh+RpBi7sVWPe2Jlrdx+jOkjxErM4IZVY0iKT0WXYvqeWvkZPLF4LQRyXg6EhXVtPpCWnGtspKbYDEje7TON8x@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIgLOcQHJcgHQX4HJ1D/Ymkma83glCcZv6j56jhzW9NRwYDIr
	VAh8mk9uinIGtRS/SyWBREYBJey8L9IIi3IeKjPawaRf8cAwjae7vKtZJd9sywvzP1+VobeHEiI
	9szbf8ALLiENVEvOMVshgT3VPeB+u1DU=
X-Gm-Gg: AfdE7cnby/NavRf9PHKwexlWrOlWtL7wdR0N+9/2PGKEn/KRrLNWkQFw9ne8VvlxyuD
	lyjvVbtYMiu5lxPNIAVwfJhm4Mof0pyHDgEEhBj27ZAZdp1f3AERHU4tKUI+2kXt+gZjVAeqmyW
	HmuemFx/a0eP8QuDLqYR2N5OKIM92kOeZHgL2PMVRZztKbVvzUAYu+q2yoq7ZY/ZjGMIEG+PoUx
	w6jTlyEEDIv0PQDJLhNPZZoudvcUFad52TEPCMhT6lL096nmtYIL4X5udCMUFz5tODQ7mgnb3R0
	7LpBLcEGLXIkap99ZF6Y/FBWXZSpfz296Yc7d/oA5a5fju88JQMuLSM/pMgIh/I=
X-Received: by 2002:a05:6000:4b1b:b0:469:3037:37d6 with SMTP id
 ffacd0b85a97d-46dbed361c5mr11889497f8f.2.1782485490511; Fri, 26 Jun 2026
 07:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625120803.2462291-1-hch@lst.de> <20260625120803.2462291-3-hch@lst.de>
 <20260625174758.GE6078@frogsfrogsfrogs> <CAJnrk1YFeirQ4g7qcVsda-8qPLeAtoiyW6ZBuJb2qDsGpxi-tg@mail.gmail.com>
 <20260626043319.GC8078@lst.de> <20260626061637.GA10337@lst.de>
In-Reply-To: <20260626061637.GA10337@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 26 Jun 2026 07:51:18 -0700
X-Gm-Features: AVVi8CdX3YEuehBm4GMevCFp3lRCSJHGYeePQFfRezoeBrVyeHAViWscCz8GoDk
Message-ID: <CAJnrk1aJbQ0092f=wcTu8v62rdxZ7-NxyF-1vp2e42oSEo6LBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 11:16=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Fri, Jun 26, 2026 at 06:33:19AM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 25, 2026 at 11:32:40AM -0700, Joanne Koong wrote:
> > > Yes, that works. I think that's a good idea. fuse only needs
> > > submit_read logic for readahead. The change would just be:
> >
> > A nice, I'll fold that in.
>
> Btw, can I get a signoff from you for this?  It looks like splitting
> this into a separate patch actually works better.  If you have a
> preferred commit log I'd take that as well instead of mine.
>
> This is what I'm currently testing:
>
> https://git.infradead.org/?p=3Dusers/hch/misc.git;a=3Dshortlog;h=3Drefs/h=
eads/iomap-read-submit-bio

The submit_read logic is only needed for readahead. We can remove the

+       if (data.ia)
+               fuse_send_readpages(data.ia, data.file, data.nr_bytes,
+                                   data.fc->async_read);

change to fuse_read_folio().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne
