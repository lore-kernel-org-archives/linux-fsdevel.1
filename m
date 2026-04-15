Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9F22156C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251059; cv=pass; b=JxwuE0msLA621c2N5xuVueOxyYheGhNOu0OI4KzgxUshs9MquVE96qcBV0ehCBXg8m5s9D6gMpR/YNQ56eJCcOr9fggoFRJYvXEIQo04imZVnEn18Rsb+UqkUEMTHy9Cwsb0fAjxto752NUtsmivykn5CEPI6Uq5YgYeaeHxQ1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251059; c=relaxed/simple;
	bh=CPjzZrNGhoqNMhsiNUldRoDdcECk49QgxWuSf4hKEGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDQ9RV+tuZcC2FHXKxPk6UBoeVFH0gv6NyObsBj2Eaek2Mu7uBnLyJXUwAq1I8QbOvQEEYZ2NCnEWoy4/jujbf0N6UZOMuzHAjTBvo7FTfetVvp+f39LOQiS9DAJCFsP9DwpR+HWCVbtPi92qwXX2JnSYroZlaESBYSyROeE50I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=L17O+bWj; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="L17O+bWj"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1273349c56bso8985017c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 04:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776251057; cv=none;
        d=google.com; s=arc-20240605;
        b=C2x4ZaFgFNoUjKnW3HNIvHgYVxtC9/IZFYsEfqokMbFoXLw5SevwA1C6ZkfbmZhZh5
         RakTKPLybvWtDNFOmB7zeWUSyjcSxujnH9mvvcvuG4enBSXpMmWTCwdDaA1ur9hFMeIT
         nGQzThQEKlTioOdsiTxYJ5GqHrtmpvV86Z80JFIZ5qgSrX44UBuWuJkpkfuOUDpRXATp
         ht/wnbgoMQwM1hKmm4Z+4mzEUNZSfFs7QFVw2aFVTOFuvUdWKQxayHB351L6nsIdXPQW
         ckk7zcBQJrilwgmZfnIaWUSFi3olDMqXnceAuK80Idf2zrHP4eOVjixIbGX4glDECxoc
         n0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6JTpcsGEMVePjeNpfTOx+QJp883lRosXuFdBGmCW3k=;
        fh=IxF5w19EVgRjZyEUPKnBa5aXLDu8pqmuJKUxPqc+AV8=;
        b=fUp4I3wLP12jTke038BXUHaSSLgR/9ZgaMfAnDRUYxqeiXdz8HvsjTcqKTuADGXJh5
         XxkhJAoOfEW7w0xKHqqdNUM47HExq62LmxtHZCBHy4J5+Q4JJyI6LXoUlOR9Yg97wmCv
         GhHJvhEZ+cJIlXvKPWO5lV1E0kEJVbTICYyx6h5pPNhM1VrOlni0gF22RE1fAYO5MwGu
         Xd0QvDmVvVQTK7pHFrNUUJM/L8qtNN/0kinh4KpCt5aGrNI1JcbhtHDWETTvGjC40XJx
         Eh/thJftqvE4Dv8xN3Yb9rUtbVcDREta6wXU9gImff6SNSNLzS9EFLaRnr4HaoNs/yFF
         9kkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1776251057; x=1776855857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6JTpcsGEMVePjeNpfTOx+QJp883lRosXuFdBGmCW3k=;
        b=L17O+bWjqwkscXWGbCmdzf+8dWPrDcuZhkda5NRBVjvV4S41gGhpPDu2ByNRZouPpU
         ZgvFirYPNtFnZzaU4dJH3rs3nIuKEKNd0OkcK87EL0DKNEKRxN1qgqSgOLnZwb1FMTLx
         44++vkWmh0A8V5rUOmp+OMkylvWaUYfBGgdLMfkSTfGv0ntN1yPJ9Ig+H2AVUaEgKvuz
         qJqYCp+rMDuu5/C4bx/wojdxpfTW0sa3/3AAAOinIdBHEzzOdX9A97ZljxWO04lzT3xS
         +vpoh4P1FsYIfZl+QVHNLWgCdhnCguAGqiE/A4sKxTjxw5wV6M3qCxOX0xFzm8so36Tw
         kx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251057; x=1776855857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6JTpcsGEMVePjeNpfTOx+QJp883lRosXuFdBGmCW3k=;
        b=bgi2/YvCTePwfJ1ZjaSplp+ds+E4b8ohUvW7/aY0W6+fJE7AFSJqxZvNfVi9FEXSs+
         IvPWdHD7yYU20vK8wteVxU6KMglorPo90JsCc0yfX4V6auPMCu2xZoTM5vUg1D92k1D5
         sX64mG21pzcGxMbYAIApTugdbLUkw0pnCy09o5Va/6UD1G+gnWdbBwAiAYGMNhPaJMXw
         OYekj1u+4Mow9WMehkL8v+tmYi+jUt/RpdmcKtnaaCJ9SOMEvyGxm393KMi2TLnlXJ2u
         kgyLBrLUsexF6G0fOd15APkNSciQ5xUGLilU5K+CnthBddCWh1wA5qAIpsIE+STDeoOZ
         Ho9A==
X-Forwarded-Encrypted: i=1; AFNElJ/cxaBy/z8HKtBsr5/MHxvJbbkOzXVW9zp1R5UtHBb1+MwmdVBevDvVO1tF83XO5DLJxzYkV/RK+lApuf8S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq54n+arju+OeCoKow8Wul8sGdlXaRSSdyEk0p1PhtK1Nt5dyd
	FjKot4cuVowDCptndN7v8eL7oOk+Y0ZhC2S8vPGX32PZqhMqNAZPkxvw7056Kuum9BEtQBmWjha
	/0qFK4ayBbzwVm7JW/fcwAYXit59qWnXXju78H8h6Sw==
X-Gm-Gg: AeBDiesmQuKX3blAfrAFq2y3BL7+ual5KSp2fMI/Jxf+1B6H+GYxYxxYKc0ipy++OEr
	RL0IVUBOwK8cR9o5WxUNywGqRuuBHntfaLuSxdTv7NVnBCK0OxYOGWPFjJnQ1bI+/vBfWCvR3F3
	W6oWHTlS5nymz14FwJ9VZ4MZt1srxbKw28CytTKzGopRzUmDgXmlroTqN+cxhOe7s66UW/vA5NR
	dWjVpEXUXyZhey0kjyfdSntU66K4/t+n/6QJwLWR2SFOdd8WH0TImTBKRLF6dTgH1ct0bZmBtJ5
	+plnytTn04nLotELXQ==
X-Received: by 2002:a05:7022:69a7:b0:123:2d38:928e with SMTP id
 a92af1059eb24-12c34f14f40mr10959780c88.35.1776251057390; Wed, 15 Apr 2026
 04:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>
 <ad9g22IbYJatwptY@thinkstation>
In-Reply-To: <ad9g22IbYJatwptY@thinkstation>
From: Mingyu He <mingyu.he@shopee.com>
Date: Wed, 15 Apr 2026 19:04:05 +0800
X-Gm-Features: AQROBzD_1BmCvVWLyoIrN-ngV7luGamoR76FKMMdb49dRkFIzjgEBvjaWEbauhw
Message-ID: <CAAoBcuQ9s68HKiFwhqXPc8-bfXYsFXc2SeD01H3d62pyxi4uvQ@mail.gmail.com>
Subject: Re: [ISSUE] Read performance regression when using RWF_DONTCACHE form
 8026e49 "mm/filemap: add read support for RWF_DONTCACHE"
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com, Jens Axboe <axboe@kernel.dk>, littleswimmingwhale@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiryl,

I will list my phy sec and fs block size at the tail of this email.

I have 2 types of hard disk on my Linux. SSD NVME and HDD.
And I tested buffer_size with range from 1k, 4k, 16k, 64k, 128k.  And
also with/without cgroup.

On both type of hard disk I got same output: RWF_DONTCACHE has very
low performance.

Strongly guessing this is due to readahead.   Pages are dropped after
reading. So system need another I/O to get the next part of the data.
However, I dont test the cases with Kswapd strongly working (But this
is not the core of the question.)


I guess this case needs optimization. But I am not sure it needs an
optimization or just I got wrong using cases, as I am not a proficient
kernel developer.
So I need the advice from experts like you to make sure.
If this is a case worth optimizing, I'd like to do that optimization
 ( But I think many people might have noticed this problem, so I'm not
sure I could finish the optimization before those proficient
developers )


RWF_DONTCACHE Performance Comparison (MiB/s)

+--------------+-------------+------------------------+------------------+
| Device Type  | Buffer Size | RWF_DONTCACHE (MiB/s)  | Normal (MiB/s)   |
+--------------+-------------+------------------------+------------------+
| HDD          | 4K          | 119.6                  | 2268.1           |
| HDD          | 16K         | 1568.6                 | 3814.7           |
| HDD          | 64K         | 2351.0                 | 4161.8           |
| HDD          | 128K        | 2951.4                 | 4061.0           |
+--------------+-------------+------------------------+------------------+
| NVMe         | 4K          | 148.7                  | 1556.1           |
| NVMe         | 16K         | 619.0                  | 1601.5           |
| NVMe         | 64K         | 1139.6                 | 1618.6           |
| NVMe         | 128K        | 1725.4                 | 1579.2
  |- NVMe @ 128K is the only case where RWF_DONTCACHE > Normal
+--------------+-------------+------------------------+------------------+







# lsblk -o NAME,FSTYPE,SIZE,FSUSED,FSUSE%,ROTA,MODEL,MOUNTPOINT

NAME    FSTYPE  SIZE FSUSED FSUSE% ROTA MODEL
    MOUNTPOIN
sda             1.1T                  1 PERC H750 Adp
=E2=94=9C=E2=94=80sda1            4M                  1
=E2=94=9C=E2=94=80sda2  vfat    110M   6.1M     6%    1
    /boot/efi
=E2=94=9C=E2=94=80sda3  ext4      2G 517.1M    27%    1                    =
                /boot
=E2=94=94=E2=94=80sda4  xfs     1.1T  70.4G     6%    1                    =
                /
nvme0n1 ext4    1.7T     5G     0%    0 Dell Ent NVMe v2 AGN RI U.2 1.92TB =
/data


# lsblk -o NAME,PHY-SEC,LOG-SEC
NAME    PHY-SEC LOG-SEC
sda         512     512
=E2=94=9C=E2=94=80sda1      512     512
=E2=94=9C=E2=94=80sda2      512     512
=E2=94=9C=E2=94=80sda3      512     512
=E2=94=94=E2=94=80sda4      512     512
nvme0n1     512     512

# dumpe2fs /dev/nvme0n1 | grep "Block size"
dumpe2fs 1.47.0 (5-Feb-2023)
Block size:               4096

# xfs_info /
meta-data=3D/dev/sda4              isize=3D512    agcount=3D566, agsize=3D5=
16864 blks
         =3D                       sectsz=3D512   attr=3D2, projid32bit=3D1
         =3D                       crc=3D1        finobt=3D1, sparse=3D1, r=
mapbt=3D0
         =3D                       reflink=3D1    bigtime=3D1 inobtcount=3D=
1
data     =3D                       bsize=3D4096   blocks=3D292326651, imaxp=
ct=3D25
         =3D                       sunit=3D0      swidth=3D0 blks
naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1
log      =3Dinternal log           bsize=3D4096   blocks=3D16384, version=
=3D2
         =3D                       sectsz=3D512   sunit=3D0 blks, lazy-coun=
t=3D1
realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D0


On Wed, Apr 15, 2026 at 6:05=E2=80=AFPM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> On Wed, Apr 15, 2026 at 03:28:27PM +0800, Mingyu He wrote:
> > The smaller the buffer_size in the test program, the more the
> > performance dropped. Initially, I used a 4k buffer_size, and the
> > performance decreased significantly. When the buffer_size was
> > increased to 128K, the read performance with RWF_DONTCACHE actually
> > surpassed the non-flagged version by about 10%.
>
> Maybe you have block size larger than 4k? Core-mm will allocate larger
> folios for page cache if filesystem asks it to. And if you try to access
> it with 4k buffer it gets multiple read-discard cycles for the same
> block with RWF_DONTCACHE. Without RWF_DONTCACHE only the first access to
> the block will lead to I/O, following accesses are served from page
> cache.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
