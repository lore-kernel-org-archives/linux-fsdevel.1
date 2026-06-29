Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A423FBB44
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725799; cv=none; b=atHcmDCNYZrmxTNwgAYiDzgdH/H6EK7dKRf8JKE7NG3kyIcCjDvCjnc63Chp8KUV8qUysswf4CLhzloKNqf64f7Oesn9Ck1aJ2gltvMOLrAAt1KG/1xHIpHO3EUkxSqjrThL16v+zuFEReFBzy6UJE4qsz683a/8dADvQUwL3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725799; c=relaxed/simple;
	bh=0l9MGm5ea0mr75L2caNh2S4gYswrKhMJrS7zyb0kDyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svlXi0BegvDNQJoOn8wD75S0Xe305MSP4U1RwXwRm3zLdEb418F2HNfGtPPFb4oZQSVXrsosv8HbHxNWj7noB2+ZGyXWwYYzTbIMSXgaABZRzfxwgRvI21A/1Tv+gYUYfpxA0aXYpxMQeYDxcNgGb4XJi7tYtEGmiBxYRa8PRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1913975D0B;
	Mon, 29 Jun 2026 09:36:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F075779A8;
	Mon, 29 Jun 2026 09:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5TykA6I8QmoyYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jun 2026 09:36:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A3D7AA10B5; Mon, 29 Jun 2026 11:36:25 +0200 (CEST)
Date: Mon, 29 Jun 2026 11:36:25 +0200
From: Jan Kara <jack@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: AnonymeMeow <anonymemeow@gmail.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [linus:master] [fanotify]  82c6dd2047: ltp.fanotify21.fail
Message-ID: <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
References: <202606291514.594c4370-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202606291514.594c4370-lkp@intel.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1913975D0B
X-Rspamd-Action: no action

On Mon 29-06-26 16:45:58, kernel test robot wrote:
> kernel test robot noticed "ltp.fanotify21.fail" on:
>=20
> commit: 82c6dd20479bb6a9625e1d63a650c3be8865e2db ("fanotify: allow report=
ing pidfds for reaped tasks")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

FWIW this is expected failure. Patch to fix fanotify21 to accept success
in this test was submitted to LTP.

								Honza

>=20
> [test failed on linus/master      5a66900afbd6b2a063eebad35294038a654de2b=
0]
> [test failed on linux-next/master 3d5670d672ae08b8c534b7beed6f57c8b44e7b4=
3]
>=20
> in testcase: ltp
> version:=20
> with following parameters:
>=20
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-00
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
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202606291514.594c4370-lkp@intel.=
com
>=20
>=20
> =1B[1;37mfanotify15: =1B[0m=1B[1;36mskip=1B[0m | =1B[1;33mtainted=1B[0m  =
(12.585s)
> =1B[1;37mfanotify21: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m  =
(25.438s)    <------
> =1B[1;37mioprio_set02: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m=
  (0.037s)
>=20
>=20
> ...
>=20
>=20
> Execution time: 9m 29s
>=20
> Disconnecting from SUT: default
>=20
> Target information
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80
> Kernel:   Linux 7.1.0-rc3+ #1 SMP PREEMPT_DYNAMIC Fri Jun 26 20:05:34 CST=
 2026
> Cmdline:  ip=3D::::lkp-ivb-d04::dhcp
>           root=3D/dev/ram0
>           RESULT_ROOT=3D/result/ltp/1HDD-xfs-syscalls-00/lkp-ivb-d04/debi=
an-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/82c6dd20479bb6a9625e1d=
63a650c3be8865e2db/0
>           BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/82c6dd20479b=
b6a9625e1d63a650c3be8865e2db/vmlinuz-7.1.0-rc3+
>           branch=3Dlinux-next/master
>           job=3D/lkp/jobs/scheduled/lkp-ivb-d04/ltp-1HDD-xfs-syscalls-00-=
debian-13-x86_64-20250902.cgz-82c6dd20479b-20260626-11320-p5g804-0.yaml
>           user=3Dlkp
>           ARCH=3Dx86_64
>           kconfig=3Dx86_64-rhel-9.4-ltp
>           commit=3D82c6dd20479bb6a9625e1d63a650c3be8865e2db
>           intremap=3Dposted_msi
>           max_uptime=3D7200
>           LKP_SERVER=3Dinternal-lkp-server
>           nokaslr
>           selinux=3D0
>           debug
>           apic=3Ddebug
>           sysrq_always_enabled
>           rcupdate.rcu_cpu_stall_timeout=3D100
>           net.ifnames=3D0
>           printk.devkmsg=3Don
>           panic=3D-1
>           softlockup_panic=3D1
>           nmi_watchdog=3Dpanic
>           oops=3Dpanic
>           load_ramdisk=3D2
>           prompt_ramdisk=3D0
>           drbd.minor_count=3D8
>           systemd.log_level=3Derr
>           ignore_loglevel
>           console=3Dtty0
>           earlyprintk=3DttyS0,115200
>           console=3DttyS0,115200
>           vga=3Dnormal
>           rw
>           keep_initrds=3D/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x=
86_64-5ccf816f5-1_20260531.cgz
> Machine:  unknown
> Arch:     x86_64
> RAM:      6898364 kB
> Swap:     0 kB
> Distro:   debian 13
>=20
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       TEST SUMMARY
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> Suite:   syscalls-00
> Runtime: 9m 15s
> Runs:    188
>=20
> Results:
>     Passed:   2339
>     Failed:   18
>     Broken:   0
>     Skipped:  45
>     Warnings: 0
>=20
> =1B[1;31mFailures:=1B[0m
>     =E2=80=A2 fanotify21
>=20
> Session stopped
> /tmp/kirk.root/latest is not found
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260629/202606291514.594c4370-lk=
p@intel.com
>=20
>=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR
