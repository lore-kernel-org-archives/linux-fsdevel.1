Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CF35DA67
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541685; cv=none; b=WOFqfHZk835YfcWfuOWkpvDF6zR9MgbV3Zgy7HasxWAgC6spT74ZiJxBcEbx8mW7MzKdNLhhire3L9KqM563C0rR+tJmvekge271Umtz+gGBsXoeO16/LUe8tJ7hktt5WVS6cynTk65Bpb6Q8XD+858BTq50YapKTKY9FafqRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541685; c=relaxed/simple;
	bh=HBj6qiAQI/qqiQMcq1LilzS9r+rDo/koSKCkhyRsnnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aboS9xGvx5okzjQD1iuPmsbhE5O9DDq8KpvOXi/am6BO6VcZbPCy4pbF+cMNbYTZ7cxYsyIu3asG2HZwHbog+gSMIe2FyexPwZA0d4Jn4MoKDWfIRTHtFFuh1ABvVU6S7AI0ZT00CZqvoSq1Q97iD6SHP39uyhsQ98JE8+jgGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLn5cqVQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r1rMs5o0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLn5cqVQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r1rMs5o0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783541682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/dH7u+EpgXCIs6Pm5DlLAIaA07OdnJPol506/hGZPc=;
	b=HLn5cqVQMTbWEg5cIleHdCc/JPe/+HBMSOqlTJuKaleHQhU0QTMRjzSe0MQ77diEGakZAe
	xT6yx2x3kIIdzK6WRTDjm2Cvmr5ICpCpUN24KWYHP0/jj6/Q2P6MuuTiGT9CsfEA9a5qkf
	4J5siHidtqkz8xtsHO5dI4bwh7hJAgA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-u1xkDLs6Mmu4kwwPAnWaCQ-1; Wed, 08 Jul 2026 16:14:41 -0400
X-MC-Unique: u1xkDLs6Mmu4kwwPAnWaCQ-1
X-Mimecast-MFC-AGG-ID: u1xkDLs6Mmu4kwwPAnWaCQ_1783541680
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9f6a49e69so1414229a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783541680; x=1784146480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/dH7u+EpgXCIs6Pm5DlLAIaA07OdnJPol506/hGZPc=;
        b=r1rMs5o0zgqB2Qy2n+L+qMAjVyXbV/TSSME9omIlp9eYu1SdNMXbd+J05Ltec/a0Yc
         RBCXu4g8zuXUEx90qqWnmYTmXIU9foE+IJDbn+1wh3Owdps4Q4kMZ5iJMOCFsKOhFmpB
         GCr03+USwedWqRQdd6hPBdwLsOsfgehoNob98N+xwfkMZTWwKZ3YDNgch0S2t+vQDNdg
         4wqdB+vih0+prRVHHtMsMZfEaGL/dxWGDBJumGh8zNrSm+hXJqzPAWm9IzFcp4HD+1EL
         9qd4I4BFY51ewSS4m3Bv2WWhy3k4fJMaRNEC0/Tggg5m938pTW0ToNCIe+F94dJUXdmG
         DqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783541680; x=1784146480;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/dH7u+EpgXCIs6Pm5DlLAIaA07OdnJPol506/hGZPc=;
        b=g6Qcu8kDGBzzjXZJwfCVLl3JmQCmuP9jOGzqMPwuxHHAM+6074O3xrlx5hykBZRLi+
         loFjAIrUFI00ydB7QKokEqQc1bfLKx9kEeOueUpuJgACWDCPRaTQQ2OnbQCG5Mv4Jjwm
         Cz2h9MAy71m8xWZJct8su4ST15S07/sOV0EzbxmHCHJK9FyD9BteCwlIz7uho7U4brpU
         +pSUxqc/p3+PUoBtpGmnCwLkLoUnVTsvl2HUJAB35wnBZOnSANZshco62xTVhhy8GzRs
         bRpA/8/yR7Sgjy0DimQYmQdlcEnnVgojopWfEcSN41t+ZxWW4ycciIC1FWrvRsLffOfO
         gcyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1IqPXSIp8/dlxgjloD1ClxOI2Gf7+30pL/6ebAm8FLcVn+zlcvi9+AicVwED9cqZ9xFIEWkAwebK1/+Cg@vger.kernel.org
X-Gm-Message-State: AOJu0YylB6Izd8UpNIbiGfEjlNaW6EpZA/0dKXeil0B+QG/gbJz4VPQH
	TdSvmZvFI3YmL5+F2wj2DxQz4yrVPwEfU/zvqGUpzP/nfRbvVs+5w/xtI+b+FGg2slIhszEOcBo
	2ob2R3M3HUbP0kDBPTs8pyCOTHfSvgJ2z+p0Rl6ii482A9nNzMpDcyxzxLnhbtBP72ww=
X-Gm-Gg: AfdE7cm0ScmdO9OT1wLxsiXJGnRlIIXxYI13WWexTgtT28/xzXDMIeeDjEoTFdTk5yQ
	dHOOP/BMWjyxZo+r7ecq0HQIQ6sfU4Ugk4lQQatmwe5s8APW2QtBPtnkjAN4OHPous1v7sUWhlW
	09n2z5D9d3K9UW13dKRYj+Qp2ldgf2TSrgULY/Gfehgo7qEGFJxHPizGYAkC4ZdVsL9EU37P5t5
	kYxFMAwSEXBGIGuNNKGN6nCqX9BCz7/d7QO0Ze1J5s//O14hymOyhBrRr3rc43wLY46e0GlVADF
	G1s4/f+cIrzRpXwGtBYg10/mqwXQb1hJeOKRxowbppnaH5w0btV6KOwuHJzccY/jGv31twNerW+
	xK/HUS/H3qQ==
X-Received: by 2002:a05:6830:2589:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7ebcfe7ad5bmr2983120a34.11.1783541680296;
        Wed, 08 Jul 2026 13:14:40 -0700 (PDT)
X-Received: by 2002:a05:6830:2589:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7ebcfe7ad5bmr2983090a34.11.1783541679717;
        Wed, 08 Jul 2026 13:14:39 -0700 (PDT)
Received: from [192.168.8.207] ([45.81.3.233])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm2528223a34.13.2026.07.08.13.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 13:14:38 -0700 (PDT)
Message-ID: <9b0fb337-88e5-484c-8618-09ed2274444e@redhat.com>
Date: Wed, 8 Jul 2026 14:16:12 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: do not override CFLAGS set by the build
 environment
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Abhinav Saxena <xandfury@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, raquini@redhat.com
References: <20260306002100.519673-1-aleksey.oladko@virtuozzo.com>
From: Nico Pache <npache@redhat.com>
Content-Language: en-US
In-Reply-To: <20260306002100.519673-1-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/26 5:21 PM, Aleksei Oladko wrote:
> Some kselftests Makefiles assign CFLAGS using 'CFLAGS=...'
> which overrides any CFLAGS provided by the build environment.
> 
> If the environment set flags, overriding CFLAGS may result in
> inconsistent compiler and linker options and cause build failures,
> for example when building PIE binaries:
> 
>   # export CFLAGS="-fPIE"
>   # export LDFLAGS="-pie"
>   # make -C tools/testing/selftests/ TARGETS=mount_setattr
>   make: Entering directory '/build/kernel/tools/testing/selftests'
>   make[1]: Entering directory '/build/kernel/tools/testing/selftests/mount_setattr'
>     CC       mount_setattr_test
>   /usr/bin/ld: warning: -z pack-relative-relocs ignored
>   /usr/bin/ld: /tmp/ccikConN.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [../lib.mk:222: /build/kernel/tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1
> 
> Fix this by appending to CFLAGS using 'CFLAGS+=' instead of
> overriding them.
> 
> The fix is not applied to the Makefiles in x86, riscv, mm, arm64
> and powerpc as they fully define their flags.
> 
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

This is very much needed (I cant confirm for all the cases you changed here but
we are experiencing the same thing internally).

However this does not apply. Can you please do a refresh/RESEND and hopefully
you get more attention on the second round.

Cheers,
-- Nico


> ---
>  tools/testing/selftests/efivarfs/Makefile             | 2 +-
>  tools/testing/selftests/exec/Makefile                 | 2 +-
>  tools/testing/selftests/firmware/Makefile             | 4 ++--
>  tools/testing/selftests/ipc/Makefile                  | 4 ++--
>  tools/testing/selftests/mount/Makefile                | 4 ++--
>  tools/testing/selftests/mount_setattr/Makefile        | 2 +-
>  tools/testing/selftests/move_mount_set_group/Makefile | 2 +-
>  tools/testing/selftests/resctrl/Makefile              | 2 +-
>  tools/testing/selftests/safesetid/Makefile            | 2 +-
>  tools/testing/selftests/signal/Makefile               | 2 +-
>  tools/testing/selftests/timens/Makefile               | 2 +-
>  tools/testing/selftests/tty/Makefile                  | 2 +-
>  tools/testing/selftests/vDSO/Makefile                 | 2 +-
>  13 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/efivarfs/Makefile b/tools/testing/selftests/efivarfs/Makefile
> index e3181338ba5e..f6c412059af3 100644
> --- a/tools/testing/selftests/efivarfs/Makefile
> +++ b/tools/testing/selftests/efivarfs/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS = -Wall
> +CFLAGS += -Wall
>  
>  TEST_GEN_FILES := open-unlink create-read
>  TEST_PROGS := efivarfs.sh
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index 45a3cfc435cf..54cdefb9ccb0 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS = -Wall
> +CFLAGS += -Wall
>  CFLAGS += -Wno-nonnull
>  CFLAGS += $(KHDR_INCLUDES)
>  
> diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
> index 7992969deaa2..dd9acf972cf5 100644
> --- a/tools/testing/selftests/firmware/Makefile
> +++ b/tools/testing/selftests/firmware/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # Makefile for firmware loading selftests
> -CFLAGS = -Wall \
> -         -O2
> +CFLAGS += -Wall \
> +          -O2
>  
>  TEST_PROGS := fw_run_tests.sh
>  TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh
> diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
> index 50e9c299fc4a..5a5577767a35 100644
> --- a/tools/testing/selftests/ipc/Makefile
> +++ b/tools/testing/selftests/ipc/Makefile
> @@ -3,11 +3,11 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
>  ifeq ($(ARCH),i386)
>          ARCH := x86
> -	CFLAGS := -DCONFIG_X86_32 -D__i386__
> +	CFLAGS += -DCONFIG_X86_32 -D__i386__
>  endif
>  ifeq ($(ARCH),x86_64)
>  	ARCH := x86
> -	CFLAGS := -DCONFIG_X86_64 -D__x86_64__
> +	CFLAGS += -DCONFIG_X86_64 -D__x86_64__
>  endif
>  
>  CFLAGS += $(KHDR_INCLUDES)
> diff --git a/tools/testing/selftests/mount/Makefile b/tools/testing/selftests/mount/Makefile
> index 2d9454841644..38361a896363 100644
> --- a/tools/testing/selftests/mount/Makefile
> +++ b/tools/testing/selftests/mount/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for mount selftests.
> -CFLAGS = -Wall \
> -         -O2
> +CFLAGS += -Wall \
> +          -O2
>  
>  TEST_PROGS := run_unprivileged_remount.sh run_nosymfollow.sh
>  TEST_GEN_FILES := unprivileged-remount-test nosymfollow-test
> diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
> index 4d4f810cdf2c..fbdb8f69b548 100644
> --- a/tools/testing/selftests/mount_setattr/Makefile
> +++ b/tools/testing/selftests/mount_setattr/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for mount selftests.
> -CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
> +CFLAGS += -g $(KHDR_INCLUDES) -Wall -O2 -pthread
>  
>  LOCAL_HDRS += ../filesystems/wrappers.h
>  
> diff --git a/tools/testing/selftests/move_mount_set_group/Makefile b/tools/testing/selftests/move_mount_set_group/Makefile
> index 94235846b6f9..8771a5491ea3 100644
> --- a/tools/testing/selftests/move_mount_set_group/Makefile
> +++ b/tools/testing/selftests/move_mount_set_group/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for mount selftests.
> -CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2
> +CFLAGS += -g $(KHDR_INCLUDES) -Wall -O2
>  
>  TEST_GEN_FILES += move_mount_set_group_test
>  
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 984534cfbf1b..1d566a91faa7 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> +CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_GEN_PROGS := resctrl_tests
> diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
> index e815bbf2d0f4..d3811515d8e3 100644
> --- a/tools/testing/selftests/safesetid/Makefile
> +++ b/tools/testing/selftests/safesetid/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for SafeSetID selftest.
> -CFLAGS = -Wall -O2
> +CFLAGS += -Wall -O2
>  LDLIBS = -lcap
>  
>  TEST_PROGS := safesetid-test.sh
> diff --git a/tools/testing/selftests/signal/Makefile b/tools/testing/selftests/signal/Makefile
> index e0bf7058d19c..6c437f95132d 100644
> --- a/tools/testing/selftests/signal/Makefile
> +++ b/tools/testing/selftests/signal/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS = -Wall
> +CFLAGS += -Wall
>  TEST_GEN_PROGS = mangle_uc_sigmask
>  TEST_GEN_PROGS += sas
>  
> diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
> index f0d51d4d2c87..357077792395 100644
> --- a/tools/testing/selftests/timens/Makefile
> +++ b/tools/testing/selftests/timens/Makefile
> @@ -1,7 +1,7 @@
>  TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex vfork_exec
>  TEST_GEN_PROGS_EXTENDED := gettime_perf
>  
> -CFLAGS := -Wall -Werror -pthread
> +CFLAGS += -Wall -Werror -pthread
>  LDLIBS := -lrt -ldl
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
> index 7f6fbe5a0cd5..e9c22dafe5e1 100644
> --- a/tools/testing/selftests/tty/Makefile
> +++ b/tools/testing/selftests/tty/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS = -O2 -Wall
> +CFLAGS += -O2 -Wall
>  TEST_GEN_PROGS := tty_tstamp_update tty_tiocsti_test
>  LDLIBS += -lcap
>  
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index e361aca22a74..1f4628ceb975 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -11,7 +11,7 @@ TEST_GEN_PROGS += vdso_test_correctness
>  TEST_GEN_PROGS += vdso_test_getrandom
>  TEST_GEN_PROGS += vdso_test_chacha
>  
> -CFLAGS := -std=gnu99 -O2 -Wall -Wstrict-prototypes
> +CFLAGS += -std=gnu99 -O2 -Wall -Wstrict-prototypes
>  
>  ifeq ($(CONFIG_X86_32),y)
>  LDLIBS += -lgcc_s

