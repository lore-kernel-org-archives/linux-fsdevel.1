Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B393E3C59
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060456; cv=none; b=jcohVMeh7UXuZuy3yoPICZ4GsC5RZIuKB1kaXChksU/Mg5IHzdZtT2hgFeVQaIvIFcfuZ5FX75FuXLBSnI0qpwsSN8lZ/Jqoj3j9RAg0b4RrP6+Ll1LTWNJnXpjRjo4UmRhRRepcKiSairmjLIfUcjigO6HlTa5ccTuT0yM2O6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060456; c=relaxed/simple;
	bh=nDG7I7quxbbvxzCxG5kJpJhHMzmvwM14//+3kJNxSO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WazUg2dmwju3Ypuc6Bi7ejFKwZ26ToOaQ84KoJYUETrBrTyOaLb6OsaMtFU69HlSVUueoY8VTs9m8j/ARN1ZiDLQBqmqdNv/KJVJGwvgi03MqI5AYrJRO4laQTI5KippPYOj09GVdMEr6189eC2ERvFnBXTIi/UDQ4q9QeO0BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aL5LwpLm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFvWk+wP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aL5LwpLm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFvWk+wP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aL5LwpLm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFvWk+wP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aL5LwpLm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFvWk+wP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 683A06B6EF;
	Wed,  6 May 2026 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778060453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
	b=aL5LwpLm25f+jCSHF89zjz0VuA9ki5lqszXk5IL6I4a3wfTkpc2GcivWSR1LLYbkajbaWn
	k7KXX/hyLDvmNDHafG61hPbcGOID5wP5AJwNAefCNU6IDTUTAv/QDyj5BEiIs2kRvrL6iv
	YPYl8TTKwHa1wRm3S/vZjD6uzOt8gA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778060453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
	b=VFvWk+wPeu6pCc2CbmntODITOF+fFnz1futXf6rwB0A0WdwogMnskeIWEONihhe/7uve3A
	81ia8Y50DPLtrLAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778060453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
	b=aL5LwpLm25f+jCSHF89zjz0VuA9ki5lqszXk5IL6I4a3wfTkpc2GcivWSR1LLYbkajbaWn
	k7KXX/hyLDvmNDHafG61hPbcGOID5wP5AJwNAefCNU6IDTUTAv/QDyj5BEiIs2kRvrL6iv
	YPYl8TTKwHa1wRm3S/vZjD6uzOt8gA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778060453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
	b=VFvWk+wPeu6pCc2CbmntODITOF+fFnz1futXf6rwB0A0WdwogMnskeIWEONihhe/7uve3A
	81ia8Y50DPLtrLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C723593A3;
	Wed,  6 May 2026 09:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MbN5O6QM+2lXCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 May 2026 09:40:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 708F1A0790; Wed, 06 May 2026 11:40:52 +0200 (CEST)
Date: Wed, 6 May 2026 11:40:52 +0200
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Cc: Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [linus:master] [xattr]  dc0876b984: ltp.fsetxattr02.fail
Message-ID: <lvwxfhejj7q3mx3ylicvnblk4alfpb57rkx47lrdehibwegahk@lnlgbr2rgx6p>
References: <202605061511.8611e3df-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202605061511.8611e3df-lkp@intel.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -7.80

On Wed 06-05-26 15:23:06, kernel test robot wrote:
> kernel test robot noticed "ltp.fsetxattr02.fail" on:

The test verifies setting xattrs on sockets fails...

> commit: dc0876b9846d3d48bb8528332106d1b051578a02 ("xattr: support extende=
d attributes on sockets")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

=2E.. which obviously isn't the case anymore with this commit. We need to
update the test expect success on sockets with recent kernels.

								Honza

>=20
> [test failed on linus/master      f1a5e78a55ebf2b05777fd5eb738038ddae609d=
6]
> [test failed on linux-next/master b9303e6bff706758c167af686b5315ad00233bf=
8]
>=20
> in testcase: ltp
> version:=20
> with following parameters:
>=20
> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-07/fsetxattr02
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
> | Closes: https://lore.kernel.org/oe-lkp/202605061511.8611e3df-lkp@intel.=
com
>=20
>=20
> 2026-05-02 02:19:39 export LTP_RUNTIME_MUL=3D2
> 2026-05-02 02:19:39 export LTPROOT=3D/lkp/benchmarks/ltp
> 2026-05-02 02:19:39 kirk -f temp_single_test --tmp-dir /fs/sda2/tmpdir
> Host information
> 	Hostname:   lkp-ivb-d04
> 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
> 	Directory:  /fs/sda2/tmpdir/kirk.root/tmpcaoemso4
>=20
> Connecting to SUT: default
>=20
> Suite: temp_single_test
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> =1B[1;37mfsetxattr02: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m =
 (0.085s)
>=20
> Execution time: 0.378s
>=20
> Disconnecting from SUT: default
>=20
> Target information
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80
> Kernel:   Linux 7.0.0-rc1+ #1 SMP PREEMPT_DYNAMIC Thu Apr 30 21:16:48 CST=
 2026
> Cmdline:  ip=3D::::lkp-ivb-d04::dhcp
>           root=3D/dev/ram0
>           RESULT_ROOT=3D/result/ltp/1HDD-btrfs-syscalls-07_fsetxattr02/lk=
p-ivb-d04/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/dc0876b9=
846d3d48bb8528332106d1b051578a02/0
>           BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/dc0876b9846d=
3d48bb8528332106d1b051578a02/vmlinuz-7.0.0-rc1+
>           branch=3Dinternal-tdx-kvm-upstream/ci/next-20260424-7080e32d3f0=
9d-2026-04-24
>           job=3D/lkp/jobs/scheduled/lkp-ivb-d04/ltp-1HDD-btrfs-syscalls-0=
7_fsetxattr02-debian-13-x86_64-20250902.cgz-dc0876b9846d-20260502-17404-1wy=
qyyu-1.yaml
>           user=3Dlkp
>           ARCH=3Dx86_64
>           kconfig=3Dx86_64-rhel-9.4-ltp
>           commit=3Ddc0876b9846d3d48bb8528332106d1b051578a02
>           intremap=3Dposted_msi
>           max_uptime=3D14400
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
86_64-92ea0639e-1_20260301.cgz
> Machine:  unknown
> Arch:     x86_64
> RAM:      6899188 kB
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
> Suite:   temp_single_test
> Runtime: 0.085s
> Runs:    1
>=20
> Results:
>     Passed:   6
>     Failed:   1
>     Broken:   0
>     Skipped:  0
>     Warnings: 0
>=20
> =1B[1;31mFailures:=1B[0m
>     =E2=80=A2 fsetxattr02
>=20
> Session stopped
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260506/202605061511.8611e3df-lk=
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
