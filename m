Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2B3A6416;
	Fri,  6 Feb 2026 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380692; cv=none; b=JxvL9viJJzd9RxQ4uxmuRcRxQgxuMzRiSbMuvIuMrnmBx4eYj0EHLFqP+hUtGIpf2OsCAkiMkZmRzkmtV/lkZchFJXnLZGMmEhPlPG5Kjip5G9+j1C7m3CMo1BkLwK55AaLA/Zsd4wNGPCh2NQkQLpHcgU6EI1DdTRCM5BJvrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380692; c=relaxed/simple;
	bh=O7a8wY2zkizo/ijNU2invfJSeItdPymgjFUDFVkv854=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6spEtiy5VB9vCqbEP1ght7pbKOpzc1dPBOUpJwb/dXQYEVMG5xzIFg6iO0DqLxn1sfA0k1DoGRzXzRsRgFg9ZudT91vniRCnBRqkMmNWU47a8W7Q4TRM6NXd4JTAOMh70+Wb/2gXucg+VvNT9JBbZ7n547u/aNtWyKzUi0HAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZIJZ1tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZIJZ1tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9139EC19422;
	Fri,  6 Feb 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770380692;
	bh=O7a8wY2zkizo/ijNU2invfJSeItdPymgjFUDFVkv854=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZIJZ1tlaooJmKV4EzSy9QGMYd/KPYLJN/nujUHugQhzq6u1LkV/0McKFni3++GtG
	 dogEinMnXpF6hMO+MLs+jb+nNylr8WiCd67HNDFlm2doQNhGy9CnM9jeuIfCkpG7sO
	 fG4MPeAy5wQzlUying7T2UTfgatPx56VUFGatWi8DViuk8R+Y15wCl2RPgjDx2Neyl
	 YIuxesqevK55Mq5XfLkh7N21ZPV8be6iQxQqwHYPlrQTsknGd2T1MJ3nVKTwU5z/CC
	 3EzQvMtto3bjPPetbUp83zcDx8AF8URrVgIQRIJR9IbtN3SPRzNun9XuTGN0wamypJ
	 UOApmRe/nSJCA==
Date: Fri, 6 Feb 2026 13:24:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: luca.boccassi@gmail.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, ltp@lists.linux.it, christian@brauner.io
Subject: Re: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on
 another ns
Message-ID: <20260206-fluktuation-verwachsen-3354f2185f31@brauner>
References: <20260127225209.2293342-1-luca.boccassi@gmail.com>
 <202602061056.b94e9170-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202602061056.b94e9170-lkp@intel.com>

On Fri, Feb 06, 2026 at 10:51:24AM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "ltp.ioctl_pidfd06.fail" on:
>=20
> commit: 16cc0cf19e0b75a336cbf619d208e22b351bd430 ("[PATCH] pidfs: return =
-EREMOTE when PIDFD_GET_INFO is called on another ns")
> url: https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-c=
om/pidfs-return-EREMOTE-when-PIDFD_GET_INFO-is-called-on-another-ns/2026012=
8-065425
> base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
> patch link: https://lore.kernel.org/all/20260127225209.2293342-1-luca.boc=
cassi@gmail.com/
> patch subject: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is call=
ed on another ns
>=20
> in testcase: ltp
> version:=20
> with following parameters:
>=20
> 	disk: 1SSD
> 	fs: btrfs
> 	test: syscalls-00/ioctl_pidfd06
>=20
>=20
>=20
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz=
 (Ivy Bridge) with 8G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602061056.b94e9170-lkp@intel.=
com
>=20
>=20
> 2026-02-03 16:33:15 kirk -U ltp -f temp_single_test --env TMPDIR=3D/fs/sd=
b1/tmpdir
> Host information
>=20
> 	Hostname:   lkp-ivb-d04
> 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
> 	Directory:  /tmp/kirk.root/tmppqdrj0by
>=20
> Connecting to SUT: default
>=20
> Starting suite: temp_single_test
> ---------------------------------
> =1B[1;37mioctl_pidfd06: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0=
m  (0.034s)
>                                                                          =
                                                      =20
> Execution time: 0.100s
>=20
> 	Suite:       temp_single_test
> 	Total runs:  1
> 	Runtime:     0.034s
> 	Passed:      0
> 	Failed:      1
> 	Skipped:     0
> 	Broken:      0
> 	Warnings:    0
> 	Kernel:      Linux 6.19.0-rc5-00159-g16cc0cf19e0b #1 SMP PREEMPT_DYNAMIC=
 Tue Feb  3 23:56:34 CST 2026
> 	Machine:     unknown
> 	Arch:        x86_64
> 	RAM:         6899592 kB
> 	Swap:        0 kB
> 	Distro:      debian 13
>=20
> Disconnecting from SUT: default
> Session stopped

Thanks! This is an intentional change in behavior and only affects
systemd which is happy to adapt to that change.
