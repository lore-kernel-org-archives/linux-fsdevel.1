Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743C46A61B
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922319; cv=none; b=c/OUfFv4UhSuuxqYaEu2fvoqo/uFxR8V250+pcy6HdRaNW1DVUhAEQp7YYn1002ZqhuP1y4dylOMBbTIQt4fbMVbEFmHgSzyKIsJJPYjUb9Ia4H7CqEr/V/FhVp25MqjuA887CyRZV9BENkvB3EMxdosrIBXwC7uiuDyFt6ncrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922319; c=relaxed/simple;
	bh=BZ+InYykFNcAFRMiH3X3hSnvJox8xbd+XMPKC2AST/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TydG1it2kdwyGq6xvtgh89isgzrUJxqqskMriinkxM8jwhaRQoITihadgoC5aZzLpMYM3BN42kis+U3iB0P7ocDJHGWnRdcfxpCKi38K+L0lCANv3JG/sdE5JRwyJH3NsM2OPwkeiaRnkTNC0vC4dc1m5Uo8NYcLIn4CfHcUdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=BhP7nom+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="BhP7nom+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ecf499af9so8177817b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784922317; x=1785527117; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hd1IuKWfv56+I72Hk72tW6ggfznB9X/tt0IbpBW76Nc=;
        b=BhP7nom+TZP2geN7HJG1GfbUcoNMMrXiu4sNtsBmginjrWZ8rHDCZTvlyZ4TxAml0Q
         kA87W20/OcEIWWzQAmvSJIR/hMNd7tcRdomaHM1dqwMcbTG77NsDdF8womoQ4vtGhrnz
         JsZbh++Yg5lvZzFQdjbCjmVJnVJ5V5OTpRGYSK2zCWzNE9z+vCBB4SiPMkmJGFdD3I/f
         DxlKhXXUzfht8nFLIKZW5tl7gxrqasoxLzwLAM79abP3sINq5/4pULrsEdGwV1PG88AD
         lmkiCqRpYUKgluW4Fc7mNirDfeZlLT96HVnjkCRdI6hMCdw/JHggdcS4bPwI7iRCgPKu
         ie9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922317; x=1785527117;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hd1IuKWfv56+I72Hk72tW6ggfznB9X/tt0IbpBW76Nc=;
        b=YfhcnaGIaDZSgJbVbgKpCXgQuLqBCRMk0EBra5P/6uJR08NUBrEM7SjG6OvMximlti
         4RuKdZLXwdXs6DlDspoqZMvAeBCuX61wKkGEKN9ZbiYkWEpyzMb3pIB8FWE/26+SyWKp
         t0+LE1FliECKEr2WrKxjw4jc5DAa04PADQyhlZzK7pCMd5FBk0SGXS5qHZdzjkeR+cHR
         egpBUDnvDMZmlb/+RsPGBPYRotMLb5+zrv9GTR0OqNhgzm7qlmar4IlOd1XdKOOwc+BT
         jrRMjVIiCclBRFqoeZBlZ7S+UNge/KV1xoQ8I5iAUvMB3mXaH2YzzyjauJbPtEbRw+L2
         or3w==
X-Forwarded-Encrypted: i=1; AHgh+RqfTKKMRz4x1LZY47Q9M75bj07uIICIpXKSo1QJVOL8Ki7EktTWFItYhkvfZLOiXVNaI4urXHvEt9JagsA3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdy0Fl2pvGwdwwRlZqvScSjf5P5c8883rqNiBJnokkgCLUTVzU
	VfqrX3S2Gv/6gAoS38ZFFDKI1wsat/r6wgEhANKCNmwbRu14aD34eBqYVYXgorLF4wm5/niMeXy
	ib6pNe/8=
X-Gm-Gg: AR+sD10sqk3FdJyv33Q+kOvJkfcCvjyv5jqNWyKA5mt6ivPDrlO3a551tnSLq7aN9S/
	hx/PcLYlUbY13fVmfgrqwTswtT/fIZD5O7aphs+qHkYGhwj6+g0X4UweHqcxpdg0nnjvftA4VJC
	ceURaiGmXXg2x5XZE6DPysBNDIeoqkC6Mq65XHj5VuHxeQj4qchPi6IsE1MujbYMv9BznUlU48r
	Iz8bu7ezyNZmxq7kaEAJKF51Hc6t3qyxwaikXKCWnqm2O/2coegBX0y5zIvxQOjlsI/KMCP1hB9
	ob8TVh8U3ch5Ntzw8k83Fyl9LqqJ3eVoqsLvq2Huw/aJfMJ18lO/kX2q7fVX9oDkcaE47GI8hl8
	xK0ImfzwLR/qQasAXQypnOVZkXS4qf3Jmfff/ei7HtkjlnNpYyGvLLVoEszywhui0FqWQrBAkVI
	GZduxjdPyhvsvQSoItYwIDLNmTq2EroJLn730lB5XOfCg2RndUsDCmWp+LlxemLygDSNpCU+mBV
	rC0yhiLoemXLsup6556aOHjzHd0LGjiRgssxhwdeDuNO0LGQPD4H+/iQZU3+SYy0U28WW8=
X-Received: by 2002:a05:690c:7248:b0:81d:3018:6eca with SMTP id 00721157ae682-81f4c162286mr29155537b3.12.1784922317286;
        Fri, 24 Jul 2026 12:45:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b0dsm5378327b3.1.2026.07.24.12.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:45:16 -0700 (PDT)
Message-ID: <78cb029e014d9590463729c43519b647f3a38dd3.camel@dubeyko.com>
Subject: Re: [PATCH 4/6] hfsplus: add iomap operations for regular file data
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 24 Jul 2026 12:45:14 -0700
In-Reply-To: <20260724053229.GE4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com>
	 <20260722213759.1360225-5-slava@dubeyko.com> <20260724053229.GE4181@lst.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 07:32 +0200, Christoph Hellwig wrote:
> On Wed, Jul 22, 2026 at 02:37:56PM -0700, Viacheslav Dubeyko wrote:
> > This patch switches regular file operations on
> > iomap based approach.
>=20
> Maybe spell out the benefits tradeoffs, odd bits here?=C2=A0 This commit
> log is a bit short.

OK. Let me explain it in more details.

>=20
> Also does this actually work without the following patches?

The following patches are needed too. :)

>=20
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *=C2=A0 linux/fs/hfsplus/iomap.c
>=20
> Please don't put the file name into the file itself.=C2=A0 It is pointles=
s
> and prone to get out of date.

I am simply following the driver context. Other HFS+ files contain
this. I can remove it, of course, if you like.

>=20
> > +static int hfsplus_file_write_dio_end_io(struct kiocb *iocb,
> > ssize_t size,
> > +					 int error, unsigned int
> > flags)
> > +{
> > +	struct inode *inode =3D file_inode(iocb->ki_filp);
> > +
> > +	if (error)
> > +		return error;
> > +
> > +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> > +		i_size_write(inode, iocb->ki_pos + size);
> > +		mark_inode_dirty(inode);
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> We've have a copy of this in various places, maye add it to a header?

I can do this.

> Or even into the core code based on a flag so that these file systems
> don't need an end_io method?

Let me double check this.

Thanks,
Slava.
