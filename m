Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387372622
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716916; cv=none; b=SEyhkVcQwrGTJ18WcrvUqnh7DMOwlPzWey+9cLORHw/Jm7fV+qjXcFyZImdhWvJbn5Q9HqBqWL5LlA1aMjK42WE3ZneK8MdR3sT6DW/cHMnxYLNzL85HKo7e/C5R2oTFbNTDXZEc/rK7AaanAmDBvgivj4E1krTwajTiaM10e5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716916; c=relaxed/simple;
	bh=Av2TN/PKqrCcMjMKRJuH0SXBFRr4ucK9hZn/kRVcsdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGKt1Hre4a3SHibFk4ZN4Oi8nCXdRVADE44DoAl9Jaze5oGp0DEt19FCOFR9nq8GcPcFf11lleiFiypzwF48pFpKBF2bk3dFEhzAYvjVkAzp9wSVo5E7xy/KnYuMLD1MQ5dv7TZH/j9aXao7TloH5pvOu8F5LfhtRYKD4gEoS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgQMXsxH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgQMXsxH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811f512167so2806194a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785716914; x=1786321714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Av2TN/PKqrCcMjMKRJuH0SXBFRr4ucK9hZn/kRVcsdg=;
        b=OgQMXsxHlQbxBFozSm+GoO5vAJ3tXQvU0F5S6BgQ2JriOcnInY6GHjns/nOWj3oyhJ
         R9SXW0yOEa/LVXB5SvRDaT7SKekQXFP6mbXXaKR476nJk+oWQ9MunxImpYYO3ylZiaLn
         QMm2WvSh5gBXnsAAGs4rO9qJbmkUBtnNP1eU6lJFP3uSv7MkMRc7Vyc4H8DQ5Kaj6LH/
         8/baTiHuuqGadS4N1OjMM6+P5nrydwH3Lq3M0ue8cfPPlDJAVRhycdxerp5AGPmimCaA
         3mpTvOQ+gu6iTAlwDjTbFL3Qf33pIL2ciHkUEQRNvH4wOaQCfWikcdTTRKp2TJI0yxB3
         DVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785716914; x=1786321714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Av2TN/PKqrCcMjMKRJuH0SXBFRr4ucK9hZn/kRVcsdg=;
        b=tWFYHyI98gA0wE3P/i8Bg1LBWRkuVKreVbM97lSDwNzUDnj2DPlAG6GXvXMw3+vrJo
         tMA0JLh/uXWZyOy0q37wEPxqe3q1qZ1B/KbYnAir/u85mYozE0sP8gkhxFgYvXnqjbIB
         rUNANVU3e7PphN3FLENEyA1ozEoJaIYZkCHNMIBXGB8VxKgdQbAxQklcLiER7KezfK1W
         W3LZoYr9KZfUhqeHA91xi9Fuen5OdVOGQLitihYy5XkCge5nNabu5dI4ixyhRRbWiBKg
         NiWVYlTN6nLz0vqAKi3g7PYxSFmRBsZpC6Fxq6WmSrs66N44hBc7saJmLCT0wTqjYW9I
         3O6w==
X-Gm-Message-State: AOJu0Yxd01xVtNqj0JSKUj5IaaYRhSVeHfWl/TQrPAxiV3kgiBYYrT6Q
	hJG5XHkVfFfoGVPIbbGZgTQ7KuZxAgUEp/4hKOnkm74+zcFIReXX4CM4
X-Gm-Gg: AR+sD11N1/Nk2MJG84Jh7CAup5uHij/C3o/6tIN6tr3ksFMhE6wtiUCapB1I96klQUy
	imw7EVE6haJp/OjJrl7nKclajHEWUJx/fme7TtS6d/OvbyKGo1bhJ/jKOF4T3uePiXlQRQ5Q6Fk
	dqvktZqRhTDN8nScYxtW+lt/wTSpW0dmNmI02IIRIgCk8VcJSQa5yu9dDB1tkMXtb8rFGKXUq8G
	JfhpQ/7BkVJbwN+AXqfBwovGL1tfxzcbUHVMESfRhkbetd0GfJh8PzhMycNoGsAt1wzfZZdZNdH
	vI6bPwZljCUMVw/7+xTX2fmHzljqI9HBbWZeSeHE5zOWgAyR26ckX6J4VPypvJXxu8u/8qrgOLp
	4XIT3zA77VJ+KXPZ74PYFY6lavZgaq+1uKNFpmVLelMtJNY3UzIYF1CGuh7cLQKSuDqvw+2qRB8
	5bfCLOe3C6OR+V5zmx5DunCTD1ijoWyFhBiyQShGb720//WI9Ivx/KUpQIMI80jKC0kcI=
X-Received: by 2002:a05:6a21:a97:b0:3bf:6f30:1ccd with SMTP id adf61e73a8af0-3c92a7bda5bmr8059858637.42.1785716914233;
        Sun, 02 Aug 2026 17:28:34 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm31037640eec.10.2026.08.02.17.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:28:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 63E53420A9B1; Mon, 03 Aug 2026 07:28:30 +0700 (WIB)
Date: Mon, 3 Aug 2026 07:28:30 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tigran Aivazian <aivazian.tigran@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>
Subject: Re: ext4: spurious "orphan cleanup on readonly fs" due to remount,ro
 failing to reset orphan_file structures
Message-ID: <am_gplyBEyvbuHM_@archie.me>
References: <CAK+_RLmWU-GjYu9Z+AWnoKd__AiaWZUt=zOkx3jr2-a4Hv3KHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3QVTYZfKyLSL06hz"
Content-Disposition: inline
In-Reply-To: <CAK+_RLmWU-GjYu9Z+AWnoKd__AiaWZUt=zOkx3jr2-a4Hv3KHg@mail.gmail.com>

--3QVTYZfKyLSL06hz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc'ing ext4 folks with full reply context]

On Sun, Aug 02, 2026 at 11:18:39PM +0100, Tigran Aivazian wrote:
> Hello,
>=20
> I have been experimenting with optimising rootfs for custom builds of
> Ubuntu 26 with various options like fast_commit, sparse_super2,
> orphan_file, inline_data, metadata_csum_seed, etc. And I noticed
> something strange: if my root filesystem is made with "orphan_file"
> feature then on every reboot I get this message:
>=20
> EXT4-fs (sda): orphan cleanup on readonly fs
>=20
> (tested with SSD, NVMe and even old HDD -- because initially I thought
> that maybe it was NVMe controller failing to flush its volatile DRAM
> cache to the NAND flash, but no, it wasn't the reason)
>=20
> I think what happens here is that when a filesystem with the
> "orphan_file" feature is fully unmounted, ext4_put_super()
> successfully clears the "orphan_present" superblock flag AND properly
> collapses/resets the physical orphan file headers. However, during a
> read-only remount (which systemd must do for / in order to halt the
> system) ext4_reconfigure() clears the "orphan_present" superblock flag
> but skips resetting the physical orphan file structures. Consequently,
> on the next boot (which starts with a read-only mount of /),
> ext4_fill_super() observes that while the superblock flag is clear,
> the orphan file itself appears non-empty. This unconditionally
> triggers ext4_orphan_cleanup(), which prints the spurious warning,
> scans the file, finds 0 orphans, and completes silently.
>=20
> Let's test this theory on the kernel 7.0.0-28-generic of Ubuntu 26:

Can you also confirm this on latest mainline (7.2-rc6)?

>=20
> # 1. Create a filesystem with the orphan_file feature
> mkfs.ext4 -O orphan_file /dev/sda
>=20
> # 2. Mount read-write
> mount -o rw /dev/sda /mnt
>=20
> # 3. Remount read-only (Simulating systemd shutdown)
> # This clears the orphan_present flag in the superblock, but leaves
> the orphan file structures intact.
> mount -o remount,ro /mnt
>=20
> # 4. Unmount and mount read-only (Simulating the next boot)
> umount /mnt
> mount -o ro /dev/sda /mnt
>=20
> Expected result in dmesg: nothing (well, except the usual
> mount/remount messages about ordered data mode, etc).
>=20
> Actual result in dmesg:
>=20
> EXT4-fs (sda): orphan cleanup on readonly fs
>=20
> Since this affects the default shutdown path for any modern Linux
> distribution using systemd and ext4 with the "orphan_file" feature, it
> would be great to get the remount,ro teardown path aligned with the
> full unmount teardown path in this aspect.
>=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3QVTYZfKyLSL06hz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRwG4Bv3KXTpY/7j318J2xkpeRKHQUCam/gpgAKCRB8J2xkpeRK
HSjJAQCrTKPJqmqDsTmmKuuhPdXQqQvie8vEnTlFEPH0aYG+6QEAsM46SzZSFQS7
KZ+FYthoqCrwK657LOkMj/2Ive8VtgI=
=X71E
-----END PGP SIGNATURE-----

--3QVTYZfKyLSL06hz--
