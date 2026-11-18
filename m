Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795004339;
	b=HzilY2G7w64MqJ6hlF6P6Z2gkshMINaTCVllzLDEXVJGn/HzvrIQmWtr3oLE58SCKHsZ
	 282y9cDu5AffilygWCamUPiHjupbGxsyyCzaDacYB5k4z6ClSg2vpUP6g6GFyTjjs8B/E
	 7An6qxh9KhuAORFRgjZbLlt2voENZvEldUZ0jGl5xMCrduWcBBMBaINM0dxK7CkFWzR+p
	 Pc3u4w/m4ghAx3Tq59dixefOlVoPofzdNUQsfwA94oQUrQVGyoUSmeHm6nA4pUDC4miZ1
	 mMfQg85rqR72YkDBWTFnifQyy2ekXgrQtudAgNy89NM9l3JdbqRzo+m7t4k7T1C7yoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o9aKWm+SqAHOn/oQI+zXHjehk+aUQHjPL9nMoWUaiPk=;
	b=bT5QMZQ/4QlFfeRM4gf9/dN15owVK5GwjSKzJ1uDxm+CVkzIXjD7IqrkWEohgiMzpMp0
	 wh3W0Gy+XTrHSS5aKbDJZPUZYDwQuHetDZX+aA9brVYabYiTbOpE+XcpVZFtz2x01+EHQ
	 naLVnXsKY8+Yp6AbZVXPWsEjpWgymSd5JPP/euyrxsREB7GarJVoH/5TO26jKynQNLf6M
	 bYNxN2XxQ5bRWCvMEdor/SQE47X27aOj/CLoLtMqATGhG4FvE+jHLoytv12CbkJJUX1cV
	 TRzHV25p2psOQrSrNkOS+TqzPacOqzmN8p1eAjG0U6swv9jwHJbrjMEssXorLszlMMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgpzyzFD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8F606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 12:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgpzyzFD
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso2407939a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:18:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795004337; cv=none;
        d=google.com; s=arc-20260327;
        b=rNVb99xKI+gigdMmbsXLaP0g9xnNLv6yBvK5ul8hu4z93VXEzE0ieTQUSTIzgA/bqi
         1XlF9GngLcjpFAN2ncTAjM3e8axosb460cSQyovRoUuZwzdmXkTd+CtIXDj3NgxVDCHD
         sQfJDU+d7Xz8FMfeztHCCxtbyk+6r+OVkTe4dI+32FUWcmXEFmV0nDQr+InxhiB7yABz
         BDGa8TUIp3FLEmxbqE6vYQe+/RlF8ptBnN4ql0Sp0vwLpKZXW100607hQSrXTz46poAX
         hWhVAoCHVjFEUOwVHNEBSQ1b96beYpEU/WviWmW3d/KsJ/o0toh3PBi7SpWsz4qDva8z
         tlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o9aKWm+SqAHOn/oQI+zXHjehk+aUQHjPL9nMoWUaiPk=;
        fh=PMQa3eG0dmqcFNZ2xOIK76+RaY7Z5MD1tbZmfeXs9HY=;
        b=SzIgAzfnQpJrvwHiwWDHhdMsVzHEiIPOIMNqGHKhyo59JNZB8Eb12hoH3yPtKCPWAk
         atHjZz4yISJtQTzxyJsuivm2i23D6ey0Eeijo0Gr4MJPhb9Wvg06bRWd0Rz2jl4AOg7F
         qKj5+blsnbMfnxDkvR3jxrK6Je5fo1CnR0pg0GH1yYSsUs/+TeuGZBHAuz/MTkS4/HI/
         o45e0O60rUFydNp/osOsDd/N7nmwRsukWWCVrsAkFpX4HMVmCMvU40b+rQ7kgxpMeL4M
         Gs1fa5Mn+6ppWCXnt1weJUhQopfdH5Qh3DyGiBbkogUrR0rd6xQ1L/oiqN6N7rrxGRiD
         n8VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795004337; x=1795609137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9aKWm+SqAHOn/oQI+zXHjehk+aUQHjPL9nMoWUaiPk=;
        b=kgpzyzFDoGYIXwu2LZPf/7z9Q2nXwRR4+/2w+5VJFN0eBcfTLr73QEZk3oU22iCP7g
         FWA4Nir6Im0Kfn0IxDtaKoGjjDH6r6wexNqZKg9mEtWr1mTUSssLDH0HpAtMD807Tuno
         BdVmXZlr9uvc5AfkAO07AZNpEoSzyPgpQ0CmQGZSI2Bw5liDvzgLTw6B4GkM3dKe4t1x
         LF6nYH5aD6jULUhNFyBx3zwNPl9nBBILXDWsSY9XaxzWTpw2vt7SGYn9h5otgRfRAnvo
         ZNYCqfuCLQdOtbn6OFm3CX2S3RIQkRJ3RGeJ7z7C9KJxyp6BMC8UhUH8VfbIjhxYDBMO
         S/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004337; x=1795609137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9aKWm+SqAHOn/oQI+zXHjehk+aUQHjPL9nMoWUaiPk=;
        b=PnGQLv1SDo4XJz5GKPZF4xP5ZrHzmIcQGyTApds/8mhq6IQSKbd/vGVt5IyIFYQMs8
         pHJtZ6JqR8mH0+FAWfWleOkVTbokoxJcVSS00BAAEph1HQLlpdF1I7wHF/8VM2/ZlpK/
         LECpFTDV9HYsW0IxO1wD2NjNmYtF1hQzpPo/2gsfWjF3nRxhpfsYrdbuej+KVdmg7me9
         ntlNkzIpQildbEQj0v+X/4rr/0N00GSneOCi77WiLhHDPmxJYl2VyoWcND3Q3P7eF03z
         W1JDqSgq/D47P5B6Tx/KhK4hnJg/Wr/eMhl/ZZohOlvTAgUQmFepRVh0BkNUeNwNd5Ud
         AUyw==
X-Forwarded-Encrypted: i=1; AL+hErGG4s1BWo+5TjfvaeBbqYnQol0Vjy8kmLLhjYMqBqzYB6q0w96ssrGx4R/lm/UrK+F0J/3sdn2IuHpsxIWI@vger.kernel.org
X-Gm-Message-State: APuU4Z83nOZ7XC4LrM6efDSt1pdtBmXjpJh5my+IYw7N8llgquP7ht1y
	EG3yh1rJgQMupLTBedh2mc3hCXDBRt0nTdn3CfV4cEqnxJP3JbvFuGBs3eN0f2XJFsDsv0PvhtK
	PwYHttB4pDqzED3JPl0Cx/OyNo1qWRAo=
X-Gm-Gg: AYBFou3x3APMRnq6oBVwPWach4Exb9RlOMiUZhCnSpi0sY5YcKLzLvmBavhMIqnO3+P
	whF2hBkhE0A7i7ResffO6y8AnYko85KxbDI3rvKKxdZn/QgXf/8JEsjSv8gh1+QhvU4mc9gQZjJ
	JyT07nh57An8i58RaMz/+WlgzWyCskYg4zr1VmIK6B8JnicC05g0lE7jOFTLLQAtWpD0O2+sjQk
	dGpXRWsl7dvnztTmo6c0BgrYndyf1qoOtRsOrKO0CkcqecocUPDy7kL5NcVh25pF2hlJWkgDYzt
	x4pKKE5pQaTGB9+S26hfv2LDydBvkk+YnDTD03nGoOHXyYc30i9uEdXAGn/aQ/NA0J2iw6BsSuT
	jP2GLlXAoZ5R8ZEZP08GuACaAAtDn5rRYrYTKxdNeGrQPJpqkOPZGpSfzK5Wk6v5ccDH7cw==
X-Received: by 2002:a05:6402:446:b0:6b5:669d:a4aa with SMTP id
 4fb4d7f45d1cf-6b859bb8770mr3421492a12.20.1795004336484; Wed, 18 Nov 2026
 04:18:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOQ4uxg5baphOjo+_A=3nZBmFEmMV7KOiv_W=rjEVYV41eTEaA@mail.gmail.com>
 <20261118113241.29101-1-dingf3ng@gmail.com>
In-Reply-To: <20261118113241.29101-1-dingf3ng@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 13:18:44 +0100
X-Gm-Features: AclHuK9FoYJUa1p-vY7Lz3sAya4iQaiog_UjZvBgKmW500nBxyznHeTRsAFiz5A
Message-ID: <CAOQ4uxgk=Teyci_b1PVaTgDip-UHXXsnXFCQQatFTSVxSHynYw@mail.gmail.com>
Subject: Re: ovl: sync_file_range() does nothing on overlayfs files
To: Ding Feng <dingf3ng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Josef Bacik <josef@toxicpanda.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 12:32=E2=80=AFPM Ding Feng <dingf3ng@gmail.com> wro=
te:
>
> Amir Goldstein wrote:
> > Like this?
> >
> > Completely untested.
>
> Thanks, Amir. I tested it on v7.4-rc3 (20eef29b7c84), where it applies
> with an 8-line offset in mm/filemap.c.
>
> Setup: arm64 defconfig in QEMU; overlayfs with lower and upper on one
> ext4 disk; periodic writeback off (dirty_writeback_centisecs=3D0). Each
> case writes 64 MiB (16384 pages) through the overlay and calls
> sync_file_range(fd, 0, 0, flags). Dirty pages are read with cachestat()
> on the upper file's ext4 path, before and after the call.
>
>                                    before patch       with patch
>   ext4 file, flags=3D7              16384 -> 0         16384 -> 0
>   overlay new file, flags=3D7       16384 -> 16384     16384 -> 0
>   overlay new file, flags=3D2       16384 -> 16384     16384 -> 0 (4096 u=
nder writeback)
>   read-only fd opened before
>   copy-up, written via another
>   fd, flags=3D7                     16384 -> 16384     16384 -> 0
>
> cachestat() on the overlay fd reported cache=3D0 dirty=3D0 before the pat=
ch
> and cache=3D16384 dirty=3D16384 with it, in all three overlay cases. All
> calls returned 0, and the kernel log showed no warnings.
>
> Tested-by: Ding Feng <dingf3ng@gmail.com>
>
> Two questions:
>
> 1. FUSE passthrough also keeps data in a backing file
> (fs/fuse/passthrough.c) and already forwards ->fadvise(). Does it need
> ->f_real() too? I have not tested that.

Yes it does, although FUSE does not have d_real(), meaning
that nobody probably tested uprobes with FUSE passthrough
I don't know if IMA/EVM/IPE are applicable to FUSE.
There is no obligation to implement FUSE f_real() from the start
if sync_range doesnt work now it can continue not to work.

>
> 2. In the copy-up case, sync_file_range() on a read-only fd can now
> open the upper file and return that open's error. The man page lists
> none of those codes. I assume that is acceptable, as a write would see
> the same error, but I wanted to mention it.

The man page never covers all possible errors
especially general errors like EIO, EACCESS, EPERM should
always be anticipated.
I am sure this is documented somewhere but I don't know where.

Thanks,
Amir.
