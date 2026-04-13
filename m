Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B163E2760
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103405; cv=none; b=hTIKwOnXG99SbEhUtReD9a7bBkz4RSbMbwVCezwTbJsE9JzrFoAqvUZT13h+fRqDHLhBoPbwI0CR8ojTwgUkLelbzurtS0Riuq1JFIcm5gah3VQAdxT+MmyeJOX8sKstYTvSNrGCLEb9SuFY8pGYXyIOdvwCbJxWCmWOryw/8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103405; c=relaxed/simple;
	bh=aSWy0Kscxi8cfpgFC/3uOBnL+Wgcvaotj3CFK8WJ3LA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r/I7ClPBS6hPVDx5mulgd/WMgCAN1cpz21GnDRrq4AOtKkPp9bmOSrv9exHjnRtlloTtkqIJ32LFysTxnf/b58c+oM1fsk6Rb5tUS6nkJ7jS9GUrFmDzwJk60o3DzkvF9bSHpwW55kU90oXRk87kxMUY2K9sNS0kv2aFJtIKkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=eXD7+Bas; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="eXD7+Bas"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fb7f51171so1136341a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1776103403; x=1776708203; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32k8m+rp4X7lFHAD78RstXAJnqtkVrw0d/cpSdquZjk=;
        b=eXD7+BasA/rqXAXmEgRs226U0zTzIGDkcb/vVVO5+8ygjXd7BSJBbTeReXaHcvN5pf
         /wSItHrCIuD749l/reyWkgB+KrsWAhrk0idBKxPiUh/qoR/YRPAFPfC5MDCH5nE2Z9US
         0OwJtHJHg6+YijieboZRGwu64+1hYKAdfMB7Ux9qTgnAewF3zVxQilfOjaErFnfoZnic
         JYPr+klfiQcz6B94LLlqRj+onhdTBG+qbr4r8bYvAikV0mKDatv0TJAkDbTAvEkjJVf0
         1atbrW7vCDUxED8t2ix+C8lwYRKIWjTXNy5awYRYVpGeZZcBTxo6zw7OREzKLMYsz/Zn
         UzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103403; x=1776708203;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32k8m+rp4X7lFHAD78RstXAJnqtkVrw0d/cpSdquZjk=;
        b=m1L63rB9XYoTQQKv03IoXMn6xe0xHlCS26jGi3rqBgZRQuIeKv1ojJi8vy5RxX69Yw
         /vi7ru8aF8qkNjbTu+v3v77XYKuJ35ZcPL8AvUbHSQMALjbDwbV6uBdVNkKPMUVDas7l
         tTGaoAKE519HZRtoC0zp1PnhNEySERu2FuahIzOIoGPjIqK8SuwnhSjjjmSfX/pHSrFW
         I0ORepyjGb0FkEaiOGEe/ReKXsWVoBcMEQQnBGKX9IyunRTm1gaPCP9aDwLckFewdOKq
         xvlTKSBvBl9xWvDOqWIBtycNQngLOs2T4xzZuFhCYkG6sF279rqQdvxf+bhtsBSTafzd
         4imA==
X-Forwarded-Encrypted: i=1; AFNElJ/LH2p0wte98oQiu+soela0FsaAsqgY3ni0kzdTtwZm5R71K8ogHgN9KSs85QyWDB1ZoFVMHTZoahugz/tM@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrfsD4FWYiNoPYHqNs4M8ds5a9M9NrX1jTNCz5Lr7KG6EvRo0
	IO09GARzkZVnH8opDe8Z8ViZJTYEvZHSC16IBjXHkY32h2S90MYFLkokiv84T7iJoyQ=
X-Gm-Gg: AeBDieuASIoujdNh7ah6IOlem2y6W5140oiFYPpd+E61tKbA9/Ygw3XuurxTZkuWI9w
	qvlRQVsjHxN2z+nPkg+AoNgy1gZ1Jmaq04xvAKr6Z/0je36U6zuvjpIpK5RZkc1Fp9U1AmcXEyn
	IvhHBdxxFtKlwbXjly8Na/QjJQsBllzR8h1+Kz2SRf9z82KkTVtgPMPWDT1ZB1a0Z38il4zT6Gt
	xVArbPzQEZ70YkansSo+DgpJFoCKGg/2iDAO+V+1nsQPfA12Lv8nR5HXllxMlZZntcp7QJFPE8V
	tzM2Oe6GKofwFmphVwhtdREBXngOGP/ah0Z8AHtSH3zjcXRxDqx1QG7AnOve92gze1x403jnfTF
	rdEhca8ZIha9EHXTuHppTgBLesN01uzAxtMc+hydvaZCbJrQ9LkN9bYehaIUvGo7lzEfDqgJS50
	SKlIO3SNgTKxEyn9y5clUvsZ2i7kRbX7DqHi2koIZgip/VIlyiXPsQIod5nHsfSMwZe6/UdGk1q
	QWYnw==
X-Received: by 2002:a17:90b:3845:b0:35e:30bc:96e2 with SMTP id 98e67ed59e1d1-35e427ad801mr15153510a91.10.1776103402928;
        Mon, 13 Apr 2026 11:03:22 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dde346sm117681635ad.29.2026.04.13.11.03.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 11:03:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
Date: Mon, 13 Apr 2026 12:03:10 -0600
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk,
 brauner@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1515863-5EA3-44A7-BEC2-40A49BEDE7DD@dilger.ca>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
To: Pedro Falcato <pfalcato@suse.de>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Apr 13, 2026, at 09:04, Pedro Falcato <pfalcato@suse.de> wrote:
>=20
> On Mon, Apr 13, 2026 at 04:23:46PM +0200, Aurelien DESBRIERES wrote:
>> From: Aur=C3=A9lien DESBRIERES <aurelien@hackers.camp>
>>=20
>> This RFC introduces FTRFS, a new Linux filesystem designed for =
dependable
>> storage in radiation-intensive environments, targeting embedded Linux =
systems
>> operating in space or other harsh conditions.
>>=20
>> FTRFS was originally described in:
>>=20
>>  Fuchs, C.M., Langer, M., Trinitis, C. (2015).
>>  FTRFS: A Fault-Tolerant Radiation-Robust Filesystem for Space Use.
>>  ARCS 2015, LNCS vol 9017, Springer.
>>  https://doi.org/10.1007/978-3-319-16086-3_8
>>=20
>> This implementation is an independent open-source realization of the
>> concepts described in that paper, developed for the Linux kernel.
>=20
> Well, here's the obvious question: do you have a usecase for this?
>=20
>>=20
>> =3D=3D Design =3D=3D
>>=20
>> FTRFS provides three layers of data integrity:
>>=20
>>  - CRC32 per block and per inode (hardware-accelerated via crc32_le)
>>  - Reed-Solomon FEC (encoder implemented, decoder planned)
>>  - EDAC-compatible error tracking
>>=20
>> On-disk layout:
>>=20
>>  Block 0        : superblock (magic 0x46545246, CRC32-protected)
>>  Block 1..N     : inode table (128 bytes/inode, CRC32 per inode)
>>  Block N+1..end : data blocks (CRC32 + RS FEC per block)
>>=20
>> Inodes use direct addressing (12 direct block pointers) plus single
>> and double indirection. Directory entries are fixed-size (268 bytes)
>> stored in direct blocks.
>>=20
>>=20
>> Compile-tested on x86_64 with Linux 7.0 (this series).
>> checkpatch.pl: 0 errors on all patches.
>>=20
>> =3D=3D Feedback Requested =3D=3D
>>=20
>> This is an RFC. Feedback is welcome on:
>>=20
>>  1. On-disk format: is the superblock/inode layout reasonable?
>=20
> The layout itself is super unix-filesystem/ext2 reminiscent, so if =
something
> like this is really needed, I would strongly recommend you perhaps add =
this
> there. One feature (crc32c checksums over several metadata structures) =
already
> exists on ext4.

This was my first question as well.  If this was some existing =
filesystem
that was widely used in satellites or something, it might make sense to
add support for that format (though a FUSE plugin might be better if the
performance is not critical).  But it doesn't necessarily make sense to
implement a greenfield filesystem that doesn't extend the boundaries =
over
existing filesystems very far.

Modern ext4 has metadata checksums for many years, and fsverity can be =
used
to add Merkle-tree checksums for file data.  Data redundancy can be =
handled
by the block layer.

If code size/complexity is a significant issue for new embedded =
satellite
controllers, then implementing "read-only" support for ext4 could be =
fairly
straight forward development to put large chunks of the code under a =
CONFIG
option.

You also have to consider that filesystems are critical components of =
any
computer, and having bugs in newly-developed filesystem code could be as
fatal to the satellite as the radiation.  The general rule of thumb is =
that
filesystems take about 10 years to mature.

Cheers, Andreas





