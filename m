Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD631AF31
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276041; cv=none; b=nioso69JYjcJph4zEGOQYMthKHKyLAYrC5OXlDXj006jbls++BghcohepVWH4HmBCEN1r+w48ZZbs+nLsca/TsOVdrhA07bxZ22oY8wD8tc2mwryPGb+jy8BSGm10HYN9tfgS8/7PAeFe2BZr9yLVMOxu2sULznMLJPWDxoxX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276041; c=relaxed/simple;
	bh=xsHxs0EVMm7wYmGuejxGvXu7t/YXvT+40o4eknrGM7s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lxtB4EfOmAcmOiAUfRdMYGhi7EXF+xzfdnEE5Ks/PgouWbXwBzFtY5Nfrx2ubrjEnnCml8AWuPBuujoVOE/QtDL5TWaxr+DpdQWuKB1/IvVs71J8bYdjdgdvXEIoonPl5tBTFqO4wVwJ3uYRsA+AIUt20wbF48n8my2nTNM/Rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=CADjHTAm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="CADjHTAm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so6351757a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1776276039; x=1776880839; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyjSIVQggWZv2yuG1S8MJT6ctCYnQ0vE1n2meEvSQNY=;
        b=CADjHTAm8tYe1a6FyELREqCFXfZs7PLDGdw9DUIIzIV+2CCYLutotvVRTAC+DhPqYx
         yC3fJC3B6bfciRrLIBRBhtu/QUSub/oXCIp4Uo/GTHF2FlEyniCI+tktaFtV3D5tYutG
         566k6rYpZ3n3yyEPRbkboLlRYUh6bKOEatbV6NIw0Dk5OCgKKDBa6d/E5rG4NJt/M+2s
         GIqCWQHw+wCRbgD2XkqgGmlilEMQO/TcDYkjcvQdBJNweLZ4pXJIz4KLGob21shp+AR6
         KXxuWNKJXDB+F3Ri46wwT2R8yuekIl8I+AbfZytU6SBUhniRl2LkNV7dAXorsEvffpjc
         yUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276039; x=1776880839;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyjSIVQggWZv2yuG1S8MJT6ctCYnQ0vE1n2meEvSQNY=;
        b=JCN9KMUwbctn2g8218E4tvq00RJKxTVMha8rdMkoysMx2+a1sDfriCE/RuX8Ezkpvx
         GxgjCkZd2yaoSljjpApw7rvJ5WelBziy/C7YodQtBdvdyZ43Ymj05PtD85bjHYVA/5lU
         P5UKBquAfZabHfotuv/5NoPhSxTo6uOv3TPohAhsR9RKHHBQ8gaUsGLyeILiagj4/vqK
         wNdkojUO4uvNIdMYUKe9mBS+WEAaV1MGbAgPwLipv6CsclmIj1cuViipSMLh9WtMH5hA
         zJetc5TpR6TCk2yBhxu6Sm5965JrvDvRkLWKiHAYKdTDQPdQRztpFeYp9RcmOaBTRGhm
         lWKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vpWpbt16pqM8pLqP458OVIcQfsXqOAjnkcO8k5YI1CAm5iyONJ+qOutIjIx65mZiunGFg4EdrHOpB4aLL@vger.kernel.org
X-Gm-Message-State: AOJu0YwkU+ISsybtI/NTpCN4uNrLQ63GY0LOCrDuEUpCCIe7rxX4dmwI
	qEhdeb4x2/KW/NSulAFMAchf4xDEBdVxWbuzvbrtsZXFg9XbQwhmC26ywKnhhDtplBY=
X-Gm-Gg: AeBDieurZf7cSXrBY6SpQ8qF2FpUt3L2j2i5J/dC2uiCb22UvNu7RkfNti6iqEMHqQL
	GPF5e0VHDpNYvMUeYjFA3dQLzjX+Yc/5S2RUM3VoWfeJlU0iErZVARd3bNGpbtAyGKub+4VN6ib
	ZQL6eJ0aboj1lnQrBp71OzYrKvsFeZvL40y4aMBXOuKEakk0GcbrwYexlbvqv9t7qFMt5LHGdol
	TfmiSKyZ0C36d6sV0CTmMwrbAoga7BgWb4pk7Zuo30lm7IpoBCPfB7KSz4yBoEUGmeVia77jzTn
	Fo0z1b2BB9lZ+sIbKovzjWm7OjexdTLe0y1pDIfXUCoeHj2KaIgC/0hmaZQ7yGCoXLyRmBVOH01
	BhPGQlS414PR1ILd3yvom4vYcNKOW5xWtTfFnYY4xE0+qM9vJQLeZrGVQLYpGI+/m4AtmaBnAaP
	3OwoZ/wVO6AcRNAk2QQiVrNiub702l5hn7E/+FLCoXdc0zv09YQoqOfp/4n6tue05HCLJRvfMSJ
	NZZYlyibddupL/F
X-Received: by 2002:a17:90a:38e6:b0:35f:9ab2:a5b4 with SMTP id 98e67ed59e1d1-35f9ab2a8bamr8851412a91.6.1776276038607;
        Wed, 15 Apr 2026 11:00:38 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd20d0e78sm4093440a91.11.2026.04.15.11.00.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 11:00:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [ISSUE] Read performance regression when using RWF_DONTCACHE form
 8026e49 "mm/filemap: add read support for RWF_DONTCACHE"
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <CAAoBcuQ9s68HKiFwhqXPc8-bfXYsFXc2SeD01H3d62pyxi4uvQ@mail.gmail.com>
Date: Wed, 15 Apr 2026 12:00:26 -0600
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
 linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org,
 hannes@cmpxchg.org,
 clm@meta.com,
 linux-kernel@vger.kernel.org,
 willy@infradead.org,
 bfoster@redhat.com,
 Jens Axboe <axboe@kernel.dk>,
 littleswimmingwhale@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0F17C4D-C1E3-4778-A352-AE9CA3434E8F@dilger.ca>
References: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>
 <ad9g22IbYJatwptY@thinkstation>
 <CAAoBcuQ9s68HKiFwhqXPc8-bfXYsFXc2SeD01H3d62pyxi4uvQ@mail.gmail.com>
To: Mingyu He <mingyu.he@shopee.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Apr 15, 2026, at 05:04, Mingyu He <mingyu.he@shopee.com> wrote:
>=20
> Hi Kiryl,
>=20
> I will list my phy sec and fs block size at the tail of this email.
>=20
> I have 2 types of hard disk on my Linux. SSD NVME and HDD.
> And I tested buffer_size with range from 1k, 4k, 16k, 64k, 128k.  And
> also with/without cgroup.
>=20
> On both type of hard disk I got same output: RWF_DONTCACHE has very
> low performance.
>=20
> Strongly guessing this is due to readahead.   Pages are dropped after
> reading. So system need another I/O to get the next part of the data.
> However, I dont test the cases with Kswapd strongly working (But this
> is not the core of the question.)
>=20
>=20
> I guess this case needs optimization. But I am not sure it needs an
> optimization or just I got wrong using cases, as I am not a proficient
> kernel developer.
> So I need the advice from experts like you to make sure.
> If this is a case worth optimizing, I'd like to do that optimization
> ( But I think many people might have noticed this problem, so I'm not
> sure I could finish the optimization before those proficient
> developers )
>=20
>=20
> RWF_DONTCACHE Performance Comparison (MiB/s)
>=20
> =
+--------------+-------------+------------------------+------------------+=

> | Device Type  | Buffer Size | RWF_DONTCACHE (MiB/s)  | Normal (MiB/s) =
  |
> =
+--------------+-------------+------------------------+------------------+=

> | HDD          | 4K          | 119.6                  | 2268.1         =
  |
> | HDD          | 16K         | 1568.6                 | 3814.7         =
  |
> | HDD          | 64K         | 2351.0                 | 4161.8         =
  |
> | HDD          | 128K        | 2951.4                 | 4061.0         =
  |
> =
+--------------+-------------+------------------------+------------------+=

> | NVMe         | 4K          | 148.7                  | 1556.1         =
  |
> | NVMe         | 16K         | 619.0                  | 1601.5         =
  |
> | NVMe         | 64K         | 1139.6                 | 1618.6         =
  |
> | NVMe         | 128K        | 1725.4                 | 1579.2
>  |- NVMe @ 128K is the only case where RWF_DONTCACHE > Normal
> =
+--------------+-------------+------------------------+------------------+=


If the HDD performance is 4GB/s then it is almost certainly a RAID =
system
with multiple individual spindles.  Reading at 4KB or even 128KB is =
likely
only reading data from 1-2 spindles at a time. The 4KiB read size is
showing that a single spindle has about 120 IOPS, while modern HDDs have
about 250MB/s bandwidth, so you need to read 2MB/IOP *per spindle* to =
get
peak performance.  For an 8+2 RAID that means 16MB reads would be best.

Cheers, Andreas

> # lsblk -o NAME,FSTYPE,SIZE,FSUSED,FSUSE%,ROTA,MODEL,MOUNTPOINT
>=20
> NAME    FSTYPE  SIZE FSUSED FSUSE% ROTA MODEL
>    MOUNTPOIN
> sda             1.1T                  1 PERC H750 Adp
> =E2=94=9C=E2=94=80sda1            4M                  1
> =E2=94=9C=E2=94=80sda2  vfat    110M   6.1M     6%    1
>    /boot/efi
> =E2=94=9C=E2=94=80sda3  ext4      2G 517.1M    27%    1                =
                    /boot
> =E2=94=94=E2=94=80sda4  xfs     1.1T  70.4G     6%    1                =
                    /
> nvme0n1 ext4    1.7T     5G     0%    0 Dell Ent NVMe v2 AGN RI U.2 =
1.92TB /data
>=20
>=20
> # lsblk -o NAME,PHY-SEC,LOG-SEC
> NAME    PHY-SEC LOG-SEC
> sda         512     512
> =E2=94=9C=E2=94=80sda1      512     512
> =E2=94=9C=E2=94=80sda2      512     512
> =E2=94=9C=E2=94=80sda3      512     512
> =E2=94=94=E2=94=80sda4      512     512
> nvme0n1     512     512
>=20
> # dumpe2fs /dev/nvme0n1 | grep "Block size"
> dumpe2fs 1.47.0 (5-Feb-2023)
> Block size:               4096
>=20
> # xfs_info /
> meta-data=3D/dev/sda4              isize=3D512    agcount=3D566, =
agsize=3D516864 blks
>         =3D                       sectsz=3D512   attr=3D2, =
projid32bit=3D1
>         =3D                       crc=3D1        finobt=3D1, sparse=3D1,=
 rmapbt=3D0
>         =3D                       reflink=3D1    bigtime=3D1 =
inobtcount=3D1
> data     =3D                       bsize=3D4096   blocks=3D292326651, =
imaxpct=3D25
>         =3D                       sunit=3D0      swidth=3D0 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, =
ftype=3D1
> log      =3Dinternal log           bsize=3D4096   blocks=3D16384, =
version=3D2
>         =3D                       sectsz=3D512   sunit=3D0 blks, =
lazy-count=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, =
rtextents=3D0
>=20
>=20
> On Wed, Apr 15, 2026 at 6:05=E2=80=AFPM Kiryl Shutsemau =
<kirill@shutemov.name> wrote:
>>=20
>> On Wed, Apr 15, 2026 at 03:28:27PM +0800, Mingyu He wrote:
>>> The smaller the buffer_size in the test program, the more the
>>> performance dropped. Initially, I used a 4k buffer_size, and the
>>> performance decreased significantly. When the buffer_size was
>>> increased to 128K, the read performance with RWF_DONTCACHE actually
>>> surpassed the non-flagged version by about 10%.
>>=20
>> Maybe you have block size larger than 4k? Core-mm will allocate =
larger
>> folios for page cache if filesystem asks it to. And if you try to =
access
>> it with 4k buffer it gets multiple read-discard cycles for the same
>> block with RWF_DONTCACHE. Without RWF_DONTCACHE only the first access =
to
>> the block will lead to I/O, following accesses are served from page
>> cache.
>>=20
>> --
>>  Kiryl Shutsemau / Kirill A. Shutemov
>=20


Cheers, Andreas





