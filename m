Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793164663;
	b=anv+F/fyXZ0WjhcdxezDvVVL0d0//01xvE1V55ZEBuiBubZYi7REptwGu9nop4iZjWJH
	 kLvLg3Vzv06zjl0UWnGPn04tLLpT4pKOEZIpEzR4nZlRWEd7fE7XTDLw2dWP377cSCnXK
	 ktRmLrPeE0Cc0faY2NUaofSezfD9HWgLdh3nWw+4SIP3CrVxXz2VbbpT2JU7pwjQXaUrv
	 luzdmYeJV68pj+As/qeV1WFU197hQ1fG/uSZDT3IyF13S2oRPT+QsYb6rMetdjb1hAC0L
	 ZxPYp8R5VsxG3qYM4z7fgpoCV30BSSLZGddIb80GQyApTDxozNxyeixkwf02XM6h0Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GDKL8ACSPYbMdc5hsGwzwbLgkI4rfLvSaTomsxOJ7Rk=;
	b=4z20IfaLQooTy+WadMKvOjLtlvpf43JXcds8a3+1zLywnaXJizCGqIjDso2urP2gKmX7
	 ZQBkLcCwHYpuNzBqYyIQAIFjgHKiFdFRtTEvblx09foUX3k3S3eVgLzVwKSt0yCgGgkQG
	 ssi7yVSAIOEOXzX7x39OhseWYKi2mVA0VVOIY6yGlJ9x3HUUJfLbcT1w29ryKBinb0MIo
	 xJSt9SCH7+6N624x/+8s1UrfphWFdhydSGhRgyuKXcSKVKVLs39OqTjeIl3WNucmEwEZP
	 hR//EqOE394p6zer2YHs40T5ND2uP2oAlzVo2uV95ruueYnHGPvINNh4E9G8CZErU8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PrPg0WvR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54F606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 05:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F54F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PrPg0WvR
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5337c7b9937so194621cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793164661; cv=none;
        d=google.com; s=arc-20260327;
        b=bt8ynaNc6t7JDNRV8qlaoN2Z0eq/YLDSs36UY/jifEhKIrGayf+xKr49WsbyododS5
         0NseNk3U9dqpX8DJTbhhctuoDtzDXFOm/tTfB9F4h1ymK+GZ4uQlmq2cMfh1KAse6hhO
         1RAwdSFjt7XtWdcmuff20rFgOnTjE0o7b7TnMPyoXPAMbTT3xsgoNW8nIpjGU5y565UU
         LrQ/85mf7LhkzenbGy/JsN0tUkkoFq5XJ/4W7BFanRusxwUxpfY9wMk4k4wntsgoDWqa
         PmnG6LHQF/hWtbckVcklObF8qP3clSz3ixUfeZBjO9H0g3vW+76Nhoi3O5d81kACQqia
         /Hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GDKL8ACSPYbMdc5hsGwzwbLgkI4rfLvSaTomsxOJ7Rk=;
        fh=a2iPmRMY4Ifs4in0zPSv7tb4aXIr/YjS43hphiTzGZ8=;
        b=Puc5ofZ0zuZzZOk5l10pjec4SbiWMptgZwpW49AnfZO52POWhzLgKe9seF0tcES5r2
         q+Zmw/pOQAlkCStx1isRBr5QomymdVuSUHi/AB8NySLr8NIAO8MTiT/w90fTTNZ5F23E
         snRrFIX9slmTvXbdh6XPhJRH8BZ2GdWeWUxbc6wq/8aVqMv8uNA3+iu1ESCDNlYpDD+S
         A2tjRJMWJL3Sdl/R0NvnpK+8fb9TcATIQb9EFHsskcw6Wh40QVT4PPKzcfpYmk38JmoX
         TY4Jg9n1i/N3foz5qGSrMhz7QolrA4VPVx6SiOTSMgJdTr8PWjmpueia5K+fc1VyxE9+
         Qc2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793164661; x=1793769461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GDKL8ACSPYbMdc5hsGwzwbLgkI4rfLvSaTomsxOJ7Rk=;
        b=PrPg0WvRGNowNnmJ9Tl+sbouNPGk+kTYr7QdNR5OqCATTtnCAwxJupDZoq14GryW4z
         Z4L1IpM6YAEBIJ0DtG6xP8/7Ptpp/pfvVSrCAVuUzxeBvU2vWt5cSgYVxoT6Js3ubd6x
         tS7AVvnIxJyDkdYUsItAe0Lef02E8BUwxWO2SZLiKAXfht7i40mUljOtrRt+2IkYx09V
         eMShmD/80+/vXy9VvbaHwrsUM7tNIacuun2EeQ4IJqmbrPsfiXneVOJrc08fo8ojSJFE
         ILjz71g4fybCH2hTXaG/dvERW/BZYfufaZHrdS2RNtMBBFrNkV/ZBqTmZSRiGGHGsdbY
         DtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793164661; x=1793769461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDKL8ACSPYbMdc5hsGwzwbLgkI4rfLvSaTomsxOJ7Rk=;
        b=04KTz3sFC7Xa6UwpBs22sgpur82imx8EBGwoWYWQAwSAGJbhjqb3qIwPwA36YRpInj
         UAEf4w2V+ciOpAzS2s7VXg8cBSnoMqUS+5aD1bDxo2TIFVZOuWMCCdEcUJvsk3v5rBJI
         fZEM4zRNo1WBgCo/+Kc5/W+95RqmHmR/T141WK/KqPuXCOQRE3FICR//T/4jmtskjokD
         fp5isWqHgmn5PU09XjDoNDxgfPpkg0oMlXxFew893VB026DMs9edb4V0cX/5MFoCXleK
         rrUMki854NvdBI9cEKRzSHhR8OeV86yNS1ZnfMRWCDLs27OpMNgwRNq1Hxwevz4OYaT2
         fAlA==
X-Forwarded-Encrypted: i=1; AKwUvByd7/BWfm7zVxsZwe2p7XFKUxGiHvV8GMpLllf13+ZDlcJk2J0jMzCl2iKQFp9SQc+AEIl6Co+fJo2TZ3QV@vger.kernel.org
X-Gm-Message-State: AFq9FYJOpL8QTVqrHw6WLM3LVkS68qm6L5y1dYGnm+rP23ZR32wod4u3
	VPs8+g56WSc/jHn9djyTNgB5i0k7TqyI0cTLOHMh9EuxpbKq38yPGJSnhWAU0VdtXSjtDgzVBga
	jjrvfSaI4TbwyfA/3JOUTCc00nj6x/zsKh3E6d2uI
X-Gm-Gg: AYBFou0ng0Tp+DjLInG1n1SbaUPjMyD2oKoJLnjnykQGC/28Fmq/WhwTkirOl1DAI8V
	3/CGhpKjT5FM0mCg5ppWgzvKRyGDqyixBXbESOgk5xq4b1fhBVnyHRTsPJT5x938fe4j5n9E6n6
	MzY/WpR17QRQpWFpT6Mq1HCLH2Z7hLAWayPYOBdHEwSOiHNW0YeIoWWROnJ987mu9IhYh+HudoT
	phYQc3/BoIx6qzSKCWZ0l6i/mN8vNQPDPo65eTJVWHS7AI0vp6hIhYCs+UC9XOD0qd5fnwynskk
	vRxBrMSR8qmOMJJFYDeciyanpfPF0WbppCSDJyyOE4R/F1ogG2KpLg79T4BBQ7euE8opk3qGdPn
	PP0dIeB6q5Ft/sY3TG0qROVwFyO7zV6bPHfrnRmTaeJ4mwrB7VBQ6Jv7o
X-Received: by 2002:a05:622a:4119:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-53ff3cb02b4mr6485831cf.7.1793164660595; Tue, 27 Oct 2026
 22:17:40 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202610271934.fd287c3f-lkp@intel.com> <CAJuCfpG67sV5Vhn1DnAWTV2xZVptOCdmH3iEnUEvYs9GRPbOeg@mail.gmail.com>
In-Reply-To: <CAJuCfpG67sV5Vhn1DnAWTV2xZVptOCdmH3iEnUEvYs9GRPbOeg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 22:17:28 -0700
X-Gm-Features: AclHuK86VLRen4xrSLePLZdR0AyyfK7lbNEkSzdjf0kj7NdStnby2nfNoH9JMbE
Message-ID: <CAJuCfpHEDeyWYUp73Va9Gmobpeg0r9vXEFkCtJunGsQSh=gXpA@mail.gmail.com>
Subject: Re: [linus:master] [selftests/proc] ca5480fb53: kselftests.proc.proc-maps-race.fail
To: kernel test robot <yi1.lai@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:52=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Oct 27, 2026 at 5:31=E2=80=AFAM kernel test robot <yi1.lai@intel.=
com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "kselftests.proc.proc-maps-race.fail" on:
> >
> > commit: ca5480fb53fa73cb5816b696b103826daedab1ca ("selftests/proc: add =
/proc/pid/smaps_rollup tearing tests") https://git.kernel.org/cgit/linux/ke=
rnel/git/torvalds/linux.git master
> >
> > [test failed on linux-next/master f1ac44c32cba88ad65dcecd4a279661d14e93=
651]
> >
> > in testcase: kselftests
> > version: kselftests-x86_64-d6d3455d8751-1_20261013
> > with following parameters:
> >
> >   group: proc
> >
> >
> > config: x86_64-rhel-9.4-kselftests
> > compiler: gcc-14
> > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.=
00GHz (Skylake) with 32G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <yi1.lai@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@inte=
l.com
> >
> >
> > KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rh=
el-9.4-kselftests-ca5480fb53fa73cb5816b696b103826daedab1ca
> > 2026-10-26 14:37:46 sed -i s/default_timeout=3D45/default_timeout=3D300=
/ kselftest/runner.sh
> > 2026-10-26 14:37:46 make -j36 TARGETS=3Dproc run_tests
> >   CC       fd-001-lookup
> >   CC       fd-002-posix-eq
> >   CC       fd-003-kthread
> >   CC       proc-2-is-kthread
> >   CC       proc-loadavg-001
> >   CC       proc-maps-race
> >   CC       proc-net-dev-lseek
> >   CC       proc-empty-vm
> >   CC       proc-self-map-files-001
> >   CC       proc-pid-vm
> >   CC       proc-self-map-files-002
> >   CC       proc-self-isnt-kthread
> >   CC       proc-self-syscall
> >   CC       proc-self-wchan
> >   CC       proc-subset-pid
> >   CC       proc-uptime-001
> >   CC       proc-uptime-002
> >   CC       read
> >   CC       proc-tid0
> >   CC       self
> >   CC       setns-dcache
> >   CC       setns-sysvipc
> >   CC       thread-self
> >   CC       proc-multiple-procfs
> >   CC       proc-fsconfig-hidepid
> >   CC       proc-pidns
> > # timeout set to 300
> > # selftests: proc: fd-001-lookup
> > ok 1 selftests: proc: fd-001-lookup
> > # timeout set to 300
> > # selftests: proc: fd-002-posix-eq
> > ok 2 selftests: proc: fd-002-posix-eq
> > # timeout set to 300
> > # selftests: proc: fd-003-kthread
> > ok 3 selftests: proc: fd-003-kthread
> > # timeout set to 300
> > # selftests: proc: proc-2-is-kthread
> > ok 4 selftests: proc: proc-2-is-kthread
> > # timeout set to 300
> > # selftests: proc: proc-loadavg-001
> > ok 5 selftests: proc: proc-loadavg-001
> > # timeout set to 300
> > # selftests: proc: proc-maps-race
> > # TAP version 13
> > # 1..6
> > # # Starting 6 tests from 2 test cases.
> > # #  RUN           proc_maps_race.maps.test_maps_tearing_from_split ...
> > # #            OK  proc_maps_race.maps.test_maps_tearing_from_split
> > # ok 1 proc_maps_race.maps.test_maps_tearing_from_split
> > # #  RUN           proc_maps_race.maps.test_maps_tearing_from_resize ..=
.
> > # #            OK  proc_maps_race.maps.test_maps_tearing_from_resize
> > # ok 2 proc_maps_race.maps.test_maps_tearing_from_resize
> > # #  RUN           proc_maps_race.maps.test_maps_tearing_from_remap ...
> > # #            OK  proc_maps_race.maps.test_maps_tearing_from_remap
> > # ok 3 proc_maps_race.maps.test_maps_tearing_from_remap
> > # #  RUN           proc_maps_race.smaps.test_maps_tearing_from_split ..=
.
> > # Expected stats:                                                      =
       Rss 892 kB
> > #                                                              Pss 82 k=
B
> > #                                                        Pss_Dirty 82 k=
B
> > #                                                         Pss_Anon 54 k=
B
> > #                                                         Pss_File 24 k=
B
> > #                                                        Pss_Shmem 3 kB
> > #                                                     Shared_Clean 0 kB
> > #                                                     Shared_Dirty 860 =
kB
> > #                                                    Private_Clean 0 kB
> > #                                                    Private_Dirty 32 k=
B
> > #                                                       Referenced 892 =
kB
> > #                                                        Anonymous 120 =
kB
> > #                                                              KSM 0 kB
> > #                                                         LazyFree 0 kB
> > #                                                    AnonHugePages 0 kB
> > #                                                   ShmemPmdMapped 0 kB
> > #                                                    FilePmdMapped 0 kB
> > #                                                   Shared_Hugetlb 0 kB
> > #                                                  Private_Hugetlb 0 kB
> > #                                                             Swap 0 kB
> > #                                                          SwapPss 0 kB
> > #                                                           Locked 0 kB
> > # Actual stats:                                                        =
     Rss 892 kB
> > #                                                              Pss 81 k=
B
>
> Hmm. RSS is staying the same but PSS is changing. I think I must
> filter out PSS stats in this comparison because they depend on page
> mapcount and might change even if VMA tree is stable. I will update
> the test to exclude that metric and will post the fixup later today.

Andrew, David,
I posted a fix at
https://lore.kernel.org/all/20261028051312.1505295-1-surenb@google.com/.
Could you please take it as a hotfix?
Thanks,
Suren.

>
> > #                                                        Pss_Dirty 81 k=
B
> > #                                                         Pss_Anon 54 k=
B
> > #                                                         Pss_File 24 k=
B
> > #                                                        Pss_Shmem 3 kB
> > #                                                     Shared_Clean 0 kB
> > #                                                     Shared_Dirty 860 =
kB
> > #                                                    Private_Clean 0 kB
> > #                                                    Private_Dirty 32 k=
B
> > #                                                       Referenced 892 =
kB
> > #                                                        Anonymous 120 =
kB
> > #                                                              KSM 0 kB
> > #                                                         LazyFree 0 kB
> > #                                                    AnonHugePages 0 kB
> > #                                                   ShmemPmdMapped 0 kB
> > #                                                    FilePmdMapped 0 kB
> > #                                                   Shared_Hugetlb 0 kB
> > #                                                  Private_Hugetlb 0 kB
> > #                                                             Swap 0 kB
> > #                                                          SwapPss 0 kB
> > #                                                           Locked 0 kB
> > # # proc-maps-race.c:961:test_maps_tearing_from_split:Expected 0 (0) !=
=3D compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_teari=
ng_from_split: Test terminated by timeout
> > # #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_split
> > # not ok 4 proc_maps_race.smaps.test_maps_tearing_from_split
> > # #  RUN           proc_maps_race.smaps.test_maps_tearing_from_resize .=
..
> > # Expected stats:                                                      =
       Rss 956 kB
> > #                                                              Pss 83 k=
B
> > #                                                        Pss_Dirty 83 k=
B
> > #                                                         Pss_Anon 54 k=
B
> > #                                                         Pss_File 26 k=
B
> > #                                                        Pss_Shmem 3 kB
> > #                                                     Shared_Clean 0 kB
> > #                                                     Shared_Dirty 924 =
kB
> > #                                                    Private_Clean 0 kB
> > #                                                    Private_Dirty 32 k=
B
> > #                                                       Referenced 956 =
kB
> > #                                                        Anonymous 120 =
kB
> > #                                                              KSM 0 kB
> > #                                                         LazyFree 0 kB
> > #                                                    AnonHugePages 0 kB
> > #                                                   ShmemPmdMapped 0 kB
> > #                                                    FilePmdMapped 0 kB
> > #                                                   Shared_Hugetlb 0 kB
> > #                                                  Private_Hugetlb 0 kB
> > #                                                             Swap 0 kB
> > #                                                          SwapPss 0 kB
> > #                                                           Locked 0 kB
> > # Actual stats:                                                        =
     Rss 956 kB
> > #                                                              Pss 83 k=
B
> > #                                                        Pss_Dirty 83 k=
B
> > #                                                         Pss_Anon 54 k=
B
> > #                                                         Pss_File 25 k=
B
> > #                                                        Pss_Shmem 3 kB
> > #                                                     Shared_Clean 0 kB
> > #                                                     Shared_Dirty 924 =
kB
> > #                                                    Private_Clean 0 kB
> > #                                                    Private_Dirty 32 k=
B
> > #                                                       Referenced 956 =
kB
> > #                                                        Anonymous 120 =
kB
> > #                                                              KSM 0 kB
> > #                                                         LazyFree 0 kB
> > #                                                    AnonHugePages 0 kB
> > #                                                   ShmemPmdMapped 0 kB
> > #                                                    FilePmdMapped 0 kB
> > #                                                   Shared_Hugetlb 0 kB
> > #                                                  Private_Hugetlb 0 kB
> > #                                                             Swap 0 kB
> > #                                                          SwapPss 0 kB
> > #                                                           Locked 0 kB
> > # # proc-maps-race.c:1050:test_maps_tearing_from_resize:Expected 0 (0) =
!=3D compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_tear=
ing_from_resize: Test terminated by timeout
> > # #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_resize
> > # not ok 5 proc_maps_race.smaps.test_maps_tearing_from_resize
> > # #  RUN           proc_maps_race.smaps.test_maps_tearing_from_remap ..=
.
> > # Expected stats:                                                      =
       Rss 956 kB
> > #                                                              Pss 84 k=
B
> > #                                                        Pss_Dirty 84 k=
B
> > #                                                         Pss_Anon 54 k=
B
> > #                                                         Pss_File 26 k=
B
> > #                                                        Pss_Shmem 3 kB
> > #                                                     Shared_Clean 0 kB
> > #                                                     Shared_Dirty 924 =
kB
> > #                                                    Private_Clean 0 kB
> > #                                                    Private_Dirty 32 k=
B
> > #                                                       Referenced 956 =
kB
> > #                                                        Anonymous 120 =
kB
> > #                                                              KSM 0 kB
> > #                                                         LazyFree 0 kB
> > #                                                    AnonHugePages 0 kB
> > #                                                   ShmemPmdMapped 0 kB
> > #                                                    FilePmdMapped 0 kB
> > #                                                   Shared_Hugetlb 0 kB
> > #                                                  Private_Hugetlb 0 kB
> > #                                                             Swap 0 kB
> > #                                                          SwapPss 0 kB
> > #                                                           Locked 0 kB
> > # Actual stats:                                                        =
     Rss 956 kB
> > #                                                              Pss 83 k=
B
> > #                                                        Pss_Dirty 83 k=
B
> > #                                                         Pss_Anon 54 k=
B
> > #                                                         Pss_File 26 k=
B
> > #                                                        Pss_Shmem 3 kB
> > #                                                     Shared_Clean 0 kB
> > #                                                     Shared_Dirty 924 =
kB
> > #                                                    Private_Clean 0 kB
> > #                                                    Private_Dirty 32 k=
B
> > #                                                       Referenced 956 =
kB
> > #                                                        Anonymous 120 =
kB
> > #                                                              KSM 0 kB
> > #                                                         LazyFree 0 kB
> > #                                                    AnonHugePages 0 kB
> > #                                                   ShmemPmdMapped 0 kB
> > #                                                    FilePmdMapped 0 kB
> > #                                                   Shared_Hugetlb 0 kB
> > #                                                  Private_Hugetlb 0 kB
> > #                                                             Swap 0 kB
> > #                                                          SwapPss 0 kB
> > #                                                           Locked 0 kB
> > # # proc-maps-race.c:1141:test_maps_tearing_from_remap:Expected 0 (0) !=
=3D compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_teari=
ng_from_remap: Test terminated by timeout
> > # #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_remap
> > # not ok 6 proc_maps_race.smaps.test_maps_tearing_from_remap
> > # # FAILED: 3 / 6 tests passed.
> > # # Totals: pass:3 fail:3 xfail:0 xpass:0 skip:0 error:0 not ok 6 selft=
ests: proc: proc-maps-race # exit=3D1 # timeout set to 300 # selftests: pro=
c: proc-net-dev-lseek ok 7 selftests: proc: proc-net-dev-lseek # timeout se=
t to 300 # selftests: proc: proc-empty-vm # protection_key_support: error: =
rv -1, errno 28 not ok 8 selftests: proc: proc-empty-vm # exit=3D1 # timeou=
t set to 300 # selftests: proc: proc-pid-vm ok 9 selftests: proc: proc-pid-=
vm # timeout set to 300 # selftests: proc: proc-self-map-files-001 ok 10 se=
lftests: proc: proc-self-map-files-001 # timeout set to 300 # selftests: pr=
oc: proc-self-map-files-002 ok 11 selftests: proc: proc-self-map-files-002 =
# timeout set to 300 # selftests: proc: proc-self-isnt-kthread ok 12 selfte=
sts: proc: proc-self-isnt-kthread # timeout set to 300 # selftests: proc: p=
roc-self-syscall ok 13 selftests: proc: proc-self-syscall # timeout set to =
300 # selftests: proc: proc-self-wchan ok 14 selftests: proc: proc-self-wch=
an # timeout set to 300 # selftests: proc: proc-subset-pid ok 15 selftests:=
 proc: proc-subset-pid # timeout set to 300 # selftests: proc: proc-tid0 ok=
 16 selftests: proc: proc-tid0 # timeout set to 300 # selftests: proc: proc=
-uptime-001 ok 17 selftests: proc: proc-uptime-001 # timeout set to 300 # s=
elftests: proc: proc-uptime-002 ok 18 selftests: proc: proc-uptime-002 # ti=
meout set to 300 # selftests: proc: read ok 19 selftests: proc: read # time=
out set to 300 # selftests: proc: self ok 20 selftests: proc: self # timeou=
t set to 300 # selftests: proc: setns-dcache ok 21 selftests: proc: setns-d=
cache # timeout set to 300 # selftests: proc: setns-sysvipc ok 22 selftests=
: proc: setns-sysvipc # timeout set to 300 # selftests: proc: thread-self o=
k 23 selftests: proc: thread-self # timeout set to 300 # selftests: proc: p=
roc-multiple-procfs ok 24 selftests: proc: proc-multiple-procfs # timeout s=
et to 300 # selftests: proc: proc-fsconfig-hidepid ok 25 selftests: proc: p=
roc-fsconfig-hidepid # timeout set to 300 # selftests: proc: proc-pidns # T=
AP version 13 # 1..6 # # Starting 6 tests from 1 test cases.
> > # #  RUN           ns.pidns_mount_string_path ...
> > # #            OK  ns.pidns_mount_string_path
> > # ok 1 ns.pidns_mount_string_path
> > # #  RUN           ns.pidns_fsconfig_string_path ...
> > # #            OK  ns.pidns_fsconfig_string_path
> > # ok 2 ns.pidns_fsconfig_string_path
> > # #  RUN           ns.pidns_fsconfig_fd ...
> > # #            OK  ns.pidns_fsconfig_fd
> > # ok 3 ns.pidns_fsconfig_fd
> > # #  RUN           ns.pidns_reconfigure_remount ...
> > # #            OK  ns.pidns_reconfigure_remount
> > # ok 4 ns.pidns_reconfigure_remount
> > # #  RUN           ns.pidns_reconfigure_fsconfig_string_path ...
> > # #            OK  ns.pidns_reconfigure_fsconfig_string_path
> > # ok 5 ns.pidns_reconfigure_fsconfig_string_path
> > # #  RUN           ns.pidns_reconfigure_fsconfig_fd ...
> > # #            OK  ns.pidns_reconfigure_fsconfig_fd
> > # ok 6 ns.pidns_reconfigure_fsconfig_fd
> > # # PASSED: 6 / 6 tests passed.
> > # # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0 ok 26 selftest=
s: proc: proc-pidns
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20261027/202610271934.fd287c3f-=
lkp@intel.com
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
