Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119943;
	b=RGpbBPOhm2X6+Hh5szkuT9RyDtqi8Up2pH2MlO1K1omSRd4HgdJGicJOwn6hARqGbOgR
	 5G7TTPOx3fsbsDK6k0FJ1gMqjDt8HxwwJP9SG/nbleAmFqVMwzrxT/k0/IQ/8Gg06r1qV
	 30qo2OTpUkLr8kq1PpNC7Fz4Y1xWrMqVh90QYj85y1TCNukgANvpHGgXH74NGZ3JkkjeF
	 qFJXW9QdR+ENvyDTgx/7SGpiftMHXpaYbaK7WI78G8G0hNXMPdGTZASRJNWcnmzP5m2Aj
	 lNBWOghPxs7ax+ovEX3jJkVJqyhcirEcZ2d0ASonCZ6rMZ7KtDJA8u9lqhGZnXTSNbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QNr1I+kaFCA3fT20ORqP0xLCLiaTRq0M5OA3+7qdxsw=;
	b=1dovdOB0LAWaWF8+mclIgDSiW6liEDKAk2AHwavHOv1pb57cTS2fdoOkltRtoqCxVLQ+
	 ZXBpxZW2N+AxP04/aU4rkfSq3lZHfvv9fwPEMJ/d22coh/d2PNYOns4RirOZ9MeudVyMs
	 kfcwcW8W8XN0FfH/Wo/vApE0GK4VL7Be43tXg9y29W/+zfjZ06HAOZkXBF7xK7nf1BO+9
	 5Mx6Z4+a3tBrSbrqBKIr+xhyPRPhIRYlMIWsoqzvsHpnNw3Nf/VPwxkpJj13GQG2qFjLt
	 +eDdn0KIYD5sWYUfFJ30nVBvfd3seTWGZLUiCAx35rcaRAXgEqIggVKWdppz7+LujMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BoOe6zI2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2C606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 16:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D2C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BoOe6zI2
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337c7b9937so412941cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 09:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119942; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+7irhlhkocHXkSmOXFq+ePwjsIKSWf0btmdvx7ObnzfxPLqJipJEb5qgpgd7W/8fo
         AEfLe2uBRHG6LspBVZw3gGCrKMsDMkpEf9iBu7UgnDJnOCUdPgruWDDthdafcWDTewky
         wmHWBSmXWsVg6/ap0x5GzC2wGVNXXnORMKS8kz4B/BzfitYZxrxjaeoTh3K5zPQE03qN
         5ed/bT0Fvl0mTD+JQ4DFx5l16Fqt3smlm3OgFLNYACKRTY9BfbGI8djX+Qh1BFBxaivb
         jjEAC5J1w0g26pqyBTYuLUeP7poUJjIxhvrtGDgAv6dMdQf4qE5sWdrfTj2kRjfhziA9
         YdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNr1I+kaFCA3fT20ORqP0xLCLiaTRq0M5OA3+7qdxsw=;
        fh=C6U0rSILZBAVDBcp8dN3Z5CEYVGyA27DFDEzfVcIoHE=;
        b=UPpsIo3qXWlq55UVMKOaR1Qps27zJ1sxHXciMsGFBw4S9+SAZlPYXzesT8GhxKMsBI
         dfb5fc0/GYRAf4DXH1O3fNPBuvZXOIxiwJ6GTGlkFwxuNedrHV2QVwbyLAof/YpF+NFa
         gbBcCVnqUwBesjHdf7K2+dz9oypDXCjqinLIaWJOfM2z+HgwJzH4o8Gra64I0+npsxN5
         lFncmRu5vM9+n05vDESybRcLdmZW3D6176xFTnLPue+kIG95ny+HJgm8jtOvL/KlbwGq
         wOtExFwzUBNnzPgIhN/hEFuEdddpZPSESA2zS3onOcZhZ32hT7dh7PTIHcL3D3E1XE8y
         eHIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793119942; x=1793724742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNr1I+kaFCA3fT20ORqP0xLCLiaTRq0M5OA3+7qdxsw=;
        b=BoOe6zI2YrJHSarNAirA0NGS72WOoJRYGqV79CVJDuFbL4s0i5Ps9XcPr3h7rdC+eo
         2MSyt19EB0895tKN1cyYtaAnK0cJnxCA/Z84lnHkqqYQFzeBm8f598cNVfIpDsdBOTu6
         bhlVClKQ5c4wlJQ31s/z9onuNnebEwG4DLFIG/1Ne4NJCnbX4A1GIbePiutKb8HcAIkH
         rvLn7bgC1Y6w1ANGTVmgjYQKB/bj1Nv9l4guMnQW9zrIp7i7FdBgbXu7gvwdOf3s5RCM
         cUebgZSCjYFvXdj4BRWSlzONMypsqlRywJk6fuZyu2LAr8YrCR3GnpnalLmzkMH1qPp4
         onVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119942; x=1793724742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNr1I+kaFCA3fT20ORqP0xLCLiaTRq0M5OA3+7qdxsw=;
        b=JJh6/wprdVoPQLYNDVGIQQx8ydqnShXb3HjXTeI1/YTElO6H2YhmqYFiMsxD7zTIWP
         ZdEY5d5aWSgioT7qR7TvhPU4fYboqSP5agztgr1Lqztta/aaOHji2WHwQ2eAJlTd5wfF
         p9HPsIP1gmMMvI/PptEd7mdIH3JeCBsFv2Xz1jG3flZIPxpKJtqfdwQvOl71KvaAIpV4
         HD/evuOoLs11nuLEKPuHHwjEm40fF+yEtohTQnz8awHEM7XrzZcKbDXLFSiRfk91PV2p
         q7xtcSTge4SKpaUgaLpWKa1PWLObu7Dw6demRWbAr/+4n6Ylx+KakA8Bj9fxRM8C3h4U
         HBxw==
X-Forwarded-Encrypted: i=1; AKwUvBxZ/PveK20JjY6a+NocyksRWQHRZRTiMQ7Th1JP+apJehxfyPlSBeLU3rwW4P9FHZuSRlBanWXjmFFwXEzq@vger.kernel.org
X-Gm-Message-State: AFq9FYLsfXFdfFAxq0a+AJG8rWwgt/6/6A9b88RycrdZQyCXpFi+mCOQ
	AWGPjionq+GNYP9yjHTxdXcY/S/fPwDLmqzvDvFj8F4vtVl7AB5KXjtGih3hrWP7FywSLKLyAkz
	guLMinT+/8KdgiwFfndDOTsxlx78UI1F28opPLEdL
X-Gm-Gg: AYBFou0ldQP0udtCCA8iqALimcEjbnHrLty3XVojIgWyXXLXLJwc5IceQYDlVrGw47Z
	sQ9ljh2YkeQSFvX7z9n01P4HrSQXj+b0yU0eIE+7BRu36aSFL8+1+WeUl7BM9yQYdslWBkqp1uj
	sDb1hB8VNqbyrZ8mhnumzLTz8T7rGSScaEyGqMSLCPeQU1g9ammWjqxbusXGooR9oa4T7MOrHPo
	30ZJRWUHG+PhiOWUxTougyXbVPNrETimTKwheeZtb5xz8sP2o8MWVx6TkWo3KoXknyaaI6IKbFW
	UFkuqSqZNRfOaiz6sIUKf8qiGIBTJN7DNQ3CjXfJxDNnT4KHKv85t3Ha0UmixtSAIOCaUn2QynZ
	/0tkQV12l46HcX77rc7ODrkQCbGwBt4A16enY18vM/vg+jD8VlHkTQSNRPSlji9zOlA==
X-Received: by 2002:a05:622a:408e:b0:530:e335:4ef with SMTP id
 d75a77b69052e-53e52a4dabcmr22708611cf.2.1793119939533; Tue, 27 Oct 2026
 09:52:19 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202610271934.fd287c3f-lkp@intel.com>
In-Reply-To: <202610271934.fd287c3f-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 09:52:07 -0700
X-Gm-Features: AclHuK_3KSlFoltlMYw06N9_sWSCTePL0tqpj69pnEG8YO4IImaT_s7RyifcLcw
Message-ID: <CAJuCfpG67sV5Vhn1DnAWTV2xZVptOCdmH3iEnUEvYs9GRPbOeg@mail.gmail.com>
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

On Tue, Oct 27, 2026 at 5:31=E2=80=AFAM kernel test robot <yi1.lai@intel.co=
m> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "kselftests.proc.proc-maps-race.fail" on:
>
> commit: ca5480fb53fa73cb5816b696b103826daedab1ca ("selftests/proc: add /p=
roc/pid/smaps_rollup tearing tests") https://git.kernel.org/cgit/linux/kern=
el/git/torvalds/linux.git master
>
> [test failed on linux-next/master f1ac44c32cba88ad65dcecd4a279661d14e9365=
1]
>
> in testcase: kselftests
> version: kselftests-x86_64-d6d3455d8751-1_20261013
> with following parameters:
>
>   group: proc
>
>
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00=
GHz (Skylake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@intel.=
com
>
>
> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel=
-9.4-kselftests-ca5480fb53fa73cb5816b696b103826daedab1ca
> 2026-10-26 14:37:46 sed -i s/default_timeout=3D45/default_timeout=3D300/ =
kselftest/runner.sh
> 2026-10-26 14:37:46 make -j36 TARGETS=3Dproc run_tests
>   CC       fd-001-lookup
>   CC       fd-002-posix-eq
>   CC       fd-003-kthread
>   CC       proc-2-is-kthread
>   CC       proc-loadavg-001
>   CC       proc-maps-race
>   CC       proc-net-dev-lseek
>   CC       proc-empty-vm
>   CC       proc-self-map-files-001
>   CC       proc-pid-vm
>   CC       proc-self-map-files-002
>   CC       proc-self-isnt-kthread
>   CC       proc-self-syscall
>   CC       proc-self-wchan
>   CC       proc-subset-pid
>   CC       proc-uptime-001
>   CC       proc-uptime-002
>   CC       read
>   CC       proc-tid0
>   CC       self
>   CC       setns-dcache
>   CC       setns-sysvipc
>   CC       thread-self
>   CC       proc-multiple-procfs
>   CC       proc-fsconfig-hidepid
>   CC       proc-pidns
> # timeout set to 300
> # selftests: proc: fd-001-lookup
> ok 1 selftests: proc: fd-001-lookup
> # timeout set to 300
> # selftests: proc: fd-002-posix-eq
> ok 2 selftests: proc: fd-002-posix-eq
> # timeout set to 300
> # selftests: proc: fd-003-kthread
> ok 3 selftests: proc: fd-003-kthread
> # timeout set to 300
> # selftests: proc: proc-2-is-kthread
> ok 4 selftests: proc: proc-2-is-kthread
> # timeout set to 300
> # selftests: proc: proc-loadavg-001
> ok 5 selftests: proc: proc-loadavg-001
> # timeout set to 300
> # selftests: proc: proc-maps-race
> # TAP version 13
> # 1..6
> # # Starting 6 tests from 2 test cases.
> # #  RUN           proc_maps_race.maps.test_maps_tearing_from_split ...
> # #            OK  proc_maps_race.maps.test_maps_tearing_from_split
> # ok 1 proc_maps_race.maps.test_maps_tearing_from_split
> # #  RUN           proc_maps_race.maps.test_maps_tearing_from_resize ...
> # #            OK  proc_maps_race.maps.test_maps_tearing_from_resize
> # ok 2 proc_maps_race.maps.test_maps_tearing_from_resize
> # #  RUN           proc_maps_race.maps.test_maps_tearing_from_remap ...
> # #            OK  proc_maps_race.maps.test_maps_tearing_from_remap
> # ok 3 proc_maps_race.maps.test_maps_tearing_from_remap
> # #  RUN           proc_maps_race.smaps.test_maps_tearing_from_split ...
> # Expected stats:                                                        =
     Rss 892 kB
> #                                                              Pss 82 kB
> #                                                        Pss_Dirty 82 kB
> #                                                         Pss_Anon 54 kB
> #                                                         Pss_File 24 kB
> #                                                        Pss_Shmem 3 kB
> #                                                     Shared_Clean 0 kB
> #                                                     Shared_Dirty 860 kB
> #                                                    Private_Clean 0 kB
> #                                                    Private_Dirty 32 kB
> #                                                       Referenced 892 kB
> #                                                        Anonymous 120 kB
> #                                                              KSM 0 kB
> #                                                         LazyFree 0 kB
> #                                                    AnonHugePages 0 kB
> #                                                   ShmemPmdMapped 0 kB
> #                                                    FilePmdMapped 0 kB
> #                                                   Shared_Hugetlb 0 kB
> #                                                  Private_Hugetlb 0 kB
> #                                                             Swap 0 kB
> #                                                          SwapPss 0 kB
> #                                                           Locked 0 kB
> # Actual stats:                                                          =
   Rss 892 kB
> #                                                              Pss 81 kB

Hmm. RSS is staying the same but PSS is changing. I think I must
filter out PSS stats in this comparison because they depend on page
mapcount and might change even if VMA tree is stable. I will update
the test to exclude that metric and will post the fixup later today.

> #                                                        Pss_Dirty 81 kB
> #                                                         Pss_Anon 54 kB
> #                                                         Pss_File 24 kB
> #                                                        Pss_Shmem 3 kB
> #                                                     Shared_Clean 0 kB
> #                                                     Shared_Dirty 860 kB
> #                                                    Private_Clean 0 kB
> #                                                    Private_Dirty 32 kB
> #                                                       Referenced 892 kB
> #                                                        Anonymous 120 kB
> #                                                              KSM 0 kB
> #                                                         LazyFree 0 kB
> #                                                    AnonHugePages 0 kB
> #                                                   ShmemPmdMapped 0 kB
> #                                                    FilePmdMapped 0 kB
> #                                                   Shared_Hugetlb 0 kB
> #                                                  Private_Hugetlb 0 kB
> #                                                             Swap 0 kB
> #                                                          SwapPss 0 kB
> #                                                           Locked 0 kB
> # # proc-maps-race.c:961:test_maps_tearing_from_split:Expected 0 (0) !=3D=
 compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_tearing_=
from_split: Test terminated by timeout
> # #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_split
> # not ok 4 proc_maps_race.smaps.test_maps_tearing_from_split
> # #  RUN           proc_maps_race.smaps.test_maps_tearing_from_resize ...
> # Expected stats:                                                        =
     Rss 956 kB
> #                                                              Pss 83 kB
> #                                                        Pss_Dirty 83 kB
> #                                                         Pss_Anon 54 kB
> #                                                         Pss_File 26 kB
> #                                                        Pss_Shmem 3 kB
> #                                                     Shared_Clean 0 kB
> #                                                     Shared_Dirty 924 kB
> #                                                    Private_Clean 0 kB
> #                                                    Private_Dirty 32 kB
> #                                                       Referenced 956 kB
> #                                                        Anonymous 120 kB
> #                                                              KSM 0 kB
> #                                                         LazyFree 0 kB
> #                                                    AnonHugePages 0 kB
> #                                                   ShmemPmdMapped 0 kB
> #                                                    FilePmdMapped 0 kB
> #                                                   Shared_Hugetlb 0 kB
> #                                                  Private_Hugetlb 0 kB
> #                                                             Swap 0 kB
> #                                                          SwapPss 0 kB
> #                                                           Locked 0 kB
> # Actual stats:                                                          =
   Rss 956 kB
> #                                                              Pss 83 kB
> #                                                        Pss_Dirty 83 kB
> #                                                         Pss_Anon 54 kB
> #                                                         Pss_File 25 kB
> #                                                        Pss_Shmem 3 kB
> #                                                     Shared_Clean 0 kB
> #                                                     Shared_Dirty 924 kB
> #                                                    Private_Clean 0 kB
> #                                                    Private_Dirty 32 kB
> #                                                       Referenced 956 kB
> #                                                        Anonymous 120 kB
> #                                                              KSM 0 kB
> #                                                         LazyFree 0 kB
> #                                                    AnonHugePages 0 kB
> #                                                   ShmemPmdMapped 0 kB
> #                                                    FilePmdMapped 0 kB
> #                                                   Shared_Hugetlb 0 kB
> #                                                  Private_Hugetlb 0 kB
> #                                                             Swap 0 kB
> #                                                          SwapPss 0 kB
> #                                                           Locked 0 kB
> # # proc-maps-race.c:1050:test_maps_tearing_from_resize:Expected 0 (0) !=
=3D compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_teari=
ng_from_resize: Test terminated by timeout
> # #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_resize
> # not ok 5 proc_maps_race.smaps.test_maps_tearing_from_resize
> # #  RUN           proc_maps_race.smaps.test_maps_tearing_from_remap ...
> # Expected stats:                                                        =
     Rss 956 kB
> #                                                              Pss 84 kB
> #                                                        Pss_Dirty 84 kB
> #                                                         Pss_Anon 54 kB
> #                                                         Pss_File 26 kB
> #                                                        Pss_Shmem 3 kB
> #                                                     Shared_Clean 0 kB
> #                                                     Shared_Dirty 924 kB
> #                                                    Private_Clean 0 kB
> #                                                    Private_Dirty 32 kB
> #                                                       Referenced 956 kB
> #                                                        Anonymous 120 kB
> #                                                              KSM 0 kB
> #                                                         LazyFree 0 kB
> #                                                    AnonHugePages 0 kB
> #                                                   ShmemPmdMapped 0 kB
> #                                                    FilePmdMapped 0 kB
> #                                                   Shared_Hugetlb 0 kB
> #                                                  Private_Hugetlb 0 kB
> #                                                             Swap 0 kB
> #                                                          SwapPss 0 kB
> #                                                           Locked 0 kB
> # Actual stats:                                                          =
   Rss 956 kB
> #                                                              Pss 83 kB
> #                                                        Pss_Dirty 83 kB
> #                                                         Pss_Anon 54 kB
> #                                                         Pss_File 26 kB
> #                                                        Pss_Shmem 3 kB
> #                                                     Shared_Clean 0 kB
> #                                                     Shared_Dirty 924 kB
> #                                                    Private_Clean 0 kB
> #                                                    Private_Dirty 32 kB
> #                                                       Referenced 956 kB
> #                                                        Anonymous 120 kB
> #                                                              KSM 0 kB
> #                                                         LazyFree 0 kB
> #                                                    AnonHugePages 0 kB
> #                                                   ShmemPmdMapped 0 kB
> #                                                    FilePmdMapped 0 kB
> #                                                   Shared_Hugetlb 0 kB
> #                                                  Private_Hugetlb 0 kB
> #                                                             Swap 0 kB
> #                                                          SwapPss 0 kB
> #                                                           Locked 0 kB
> # # proc-maps-race.c:1141:test_maps_tearing_from_remap:Expected 0 (0) !=
=3D compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_teari=
ng_from_remap: Test terminated by timeout
> # #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_remap
> # not ok 6 proc_maps_race.smaps.test_maps_tearing_from_remap
> # # FAILED: 3 / 6 tests passed.
> # # Totals: pass:3 fail:3 xfail:0 xpass:0 skip:0 error:0 not ok 6 selftes=
ts: proc: proc-maps-race # exit=3D1 # timeout set to 300 # selftests: proc:=
 proc-net-dev-lseek ok 7 selftests: proc: proc-net-dev-lseek # timeout set =
to 300 # selftests: proc: proc-empty-vm # protection_key_support: error: rv=
 -1, errno 28 not ok 8 selftests: proc: proc-empty-vm # exit=3D1 # timeout =
set to 300 # selftests: proc: proc-pid-vm ok 9 selftests: proc: proc-pid-vm=
 # timeout set to 300 # selftests: proc: proc-self-map-files-001 ok 10 self=
tests: proc: proc-self-map-files-001 # timeout set to 300 # selftests: proc=
: proc-self-map-files-002 ok 11 selftests: proc: proc-self-map-files-002 # =
timeout set to 300 # selftests: proc: proc-self-isnt-kthread ok 12 selftest=
s: proc: proc-self-isnt-kthread # timeout set to 300 # selftests: proc: pro=
c-self-syscall ok 13 selftests: proc: proc-self-syscall # timeout set to 30=
0 # selftests: proc: proc-self-wchan ok 14 selftests: proc: proc-self-wchan=
 # timeout set to 300 # selftests: proc: proc-subset-pid ok 15 selftests: p=
roc: proc-subset-pid # timeout set to 300 # selftests: proc: proc-tid0 ok 1=
6 selftests: proc: proc-tid0 # timeout set to 300 # selftests: proc: proc-u=
ptime-001 ok 17 selftests: proc: proc-uptime-001 # timeout set to 300 # sel=
ftests: proc: proc-uptime-002 ok 18 selftests: proc: proc-uptime-002 # time=
out set to 300 # selftests: proc: read ok 19 selftests: proc: read # timeou=
t set to 300 # selftests: proc: self ok 20 selftests: proc: self # timeout =
set to 300 # selftests: proc: setns-dcache ok 21 selftests: proc: setns-dca=
che # timeout set to 300 # selftests: proc: setns-sysvipc ok 22 selftests: =
proc: setns-sysvipc # timeout set to 300 # selftests: proc: thread-self ok =
23 selftests: proc: thread-self # timeout set to 300 # selftests: proc: pro=
c-multiple-procfs ok 24 selftests: proc: proc-multiple-procfs # timeout set=
 to 300 # selftests: proc: proc-fsconfig-hidepid ok 25 selftests: proc: pro=
c-fsconfig-hidepid # timeout set to 300 # selftests: proc: proc-pidns # TAP=
 version 13 # 1..6 # # Starting 6 tests from 1 test cases.
> # #  RUN           ns.pidns_mount_string_path ...
> # #            OK  ns.pidns_mount_string_path
> # ok 1 ns.pidns_mount_string_path
> # #  RUN           ns.pidns_fsconfig_string_path ...
> # #            OK  ns.pidns_fsconfig_string_path
> # ok 2 ns.pidns_fsconfig_string_path
> # #  RUN           ns.pidns_fsconfig_fd ...
> # #            OK  ns.pidns_fsconfig_fd
> # ok 3 ns.pidns_fsconfig_fd
> # #  RUN           ns.pidns_reconfigure_remount ...
> # #            OK  ns.pidns_reconfigure_remount
> # ok 4 ns.pidns_reconfigure_remount
> # #  RUN           ns.pidns_reconfigure_fsconfig_string_path ...
> # #            OK  ns.pidns_reconfigure_fsconfig_string_path
> # ok 5 ns.pidns_reconfigure_fsconfig_string_path
> # #  RUN           ns.pidns_reconfigure_fsconfig_fd ...
> # #            OK  ns.pidns_reconfigure_fsconfig_fd
> # ok 6 ns.pidns_reconfigure_fsconfig_fd
> # # PASSED: 6 / 6 tests passed.
> # # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0 ok 26 selftests:=
 proc: proc-pidns
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20261027/202610271934.fd287c3f-lk=
p@intel.com
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
