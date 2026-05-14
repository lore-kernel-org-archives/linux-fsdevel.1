Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE925B0B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745719; cv=pass; b=VAwImAJ/g+hm8g8rqszkQGmUKvRTRyMQWtnA3C9QntYu7MZAgYBkkSObjKkgSRKjmd6Uv15Y3woarFKU3BWPBhFHxfodzEAfq5skoS+1JyQCNHA/AF+ataprmmJkm4Dw1NY7tv3JT6JoWlI1Gw9ckcvsq14Z4KtXzr2UAUbxhHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745719; c=relaxed/simple;
	bh=81kN/c0whuLRH0kfnXp/GgeU5xeC5H9AC8PyLrKwRWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXy6qg/qcrqdnnXkQxhxofLPJO2uLz9aWwGXpYEsv57dn0mbF9K8vB/R1JEBYtLkJ60wC3Idsztd2PMlyd+5LXtfs0eTzvwtXj5SfQpwVs20Lwn7sq4URIGkdL6jMfY+qvOrzTDehL9fR9+lOUW3683TMbYwYWqAr4CkgpTtbLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKFUEsSe; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKFUEsSe"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-134ac81c445so2387874c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 01:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745717; cv=none;
        d=google.com; s=arc-20240605;
        b=HPn3lcmS8uP47Ue5sTjeo4uqSsxCbFkGbdrTL4urP3MTK+Lth9oegZA9YFniYC7OxH
         x4bhPMbB/RnCDw01T037MkW7k8vHW339B91zvYUKDJ+8ITYuTAPr4jk6jEqDVaZW6sqK
         Dtt8GCIXXSN1odXcyPyGwhnQzlJWpsAhOVXGh+UiIs18ImICmxtUmroecvSM8GjWhV+3
         x4bEwSFet2iZ2hzRZT6dlJ1Sh/BOmQR51ggkI7uO616thmHxYosVV4yvEmZ40ft63Ql0
         ZuKA4DYb09LI1sQ5ycPxcsQo/IPZtVuOmo6UKmG/il92rYGPI7BLmtmdzqqwv1yIYmYT
         oW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R3rMcHi+SRGerVbM0q8doN39gwMZLkcDzykkfyfOtI8=;
        fh=SpGmfJZaGFX2g5ZR3F+494GOUoJBP2e4MMlB0yxxmxE=;
        b=jT7rPFIfgbP439xDTukPp8YVorC253DPxdKT7Ob02xTApGsFZNihQKRx9QJBGDADO8
         KkJHh3VyecvcfrFcfsEs1/9kmilc6DbU8xw7Y1sgwbRZoYowFPiSQ81vW7D3nfDqVgSl
         35sOtxbkicXHGLUGUU4xQgQL9QMyzDic8ioI1i6S6UHQk2cd7y8wZ16qx+67kiA62JaE
         ZVl3DzO/FItaRo9RGWZvs+gOKIVntZDQR6npibvJPfv0+ozyVRK1ibHzC9G25kDnGc93
         uHyFhBMXHkmPg5vJLKACPto73Z5vENPVkrkDx3xBkysZZfdO12hWwjLZi44QLaz5CCYr
         R2dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745717; x=1779350517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3rMcHi+SRGerVbM0q8doN39gwMZLkcDzykkfyfOtI8=;
        b=fKFUEsSeSYMSDVkCMtt5pEXXkHrte4cGizJMM1N82Q2Vegxnc3Syj9YvD0XPKZKtjt
         EpbOMOEwV3HZ/2myULhHtcOLZoC2z1TF4x+LE1zOwyDOmA2vFfwzyRlSQgplymgW8eXR
         Y5CaM/nja9ImztJ4unodiGVZGogD1hTm+1Cd6lQ0s8OfYNQX0CjHbyEDcpQqtOtylZaQ
         PFEeOBl8GeCRWBPJ9wAE9e7q5y5l8o48ND8z48mFSZVJbxLn6vnBllt2U0lOVoFPg2On
         5mr+8buy/0TJ/HsnwKCdCBJMR0f4eGOTitUN4bF4YD6EesQBQwI93YZVdLARw/6O2ula
         bhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745717; x=1779350517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3rMcHi+SRGerVbM0q8doN39gwMZLkcDzykkfyfOtI8=;
        b=YvCCPKec+Gzki0IzOp2E4mJBNNflqk895qZBw8pysDY/Phbp+5Nnfxf+XUXoMK5ZAe
         F5KK0tpB0597qL6hjVSY3lVXyxSuAl7K+8X/vY/qSXnxOrgB7j/z9OdqzfJjv9uOSkor
         R6uAhBME12KOns/VCWYW3j4nDhNM6mMH51jhKVM9J781KRDB7EiiVmGjUjQtAN/DPwJQ
         22nJg6St9h//JucGe4Jeh9J6vYebODxAOVkpweCAxop2FCHC/i+6CBrJP9q7qchmZ1Y0
         E6eFNPKW+fd6+19uAVxdM88Llw5kWM+e02vmGQiE92LoT024yqNXixukVEZD1zupXCdC
         +TMw==
X-Forwarded-Encrypted: i=1; AFNElJ/DIyK0uhxLSGuG6AWii9N/L7yUfPvz25xQbJ78pQmkc4Z4PlrOuhGc8yWhlZb63fVbUP7MnDWiw67lAKPO@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJHB1V+9+18UBWZw12tjhLow4gE7FuArvGythVaFt14Nrk68g
	NHKV6HP1xrKmrQfcOqBSSknJgZoMlg+jxvKpIeN30oekaWfJBks3L8w9KUd8oVRFiq7CQDBJ8Gu
	BQMYflai26fEg9ge4fMKAIFpTjZg94+99f13nK+86
X-Gm-Gg: Acq92OGoAEPRdlLXuyIIU3aRL/NsWelFJVDN0o/BrHjH1YHEn11dU7hYvkQn6d/gso2
	HH6l0bhwjtPfnLaiNM+xJRSCVaSpyktd5NChfeWWNFCtbbiGTloXj1B/Tl7JDKyoRt6yHGo0pAg
	Va5WjIf8/7JckcLhXBV7VuOQZ2K9FYWbHUeTYkvgVDT2npA62oQIlqxkhZF11/F5WmhIS5XsgN2
	T882Fu6ZLGzv3VdSYu/eoG8tHhakQTvDGEOgAxrjbmKJOQmSB21TaRdgcbsDwhLziR8+hgQksio
	UbfhYRTKK/QA7pWIGEps7/jOSXapD+MMjDEXxfogl/CL468NVA==
X-Received: by 2002:a05:7022:b89:b0:12c:5e48:4c01 with SMTP id
 a92af1059eb24-1342ee3e06cmr4229857c88.1.1778745716497; Thu, 14 May 2026
 01:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514050455.2954509-1-justin.he@arm.com> <20260514050455.2954509-7-justin.he@arm.com>
In-Reply-To: <20260514050455.2954509-7-justin.he@arm.com>
From: Marco Elver <elver@google.com>
Date: Thu, 14 May 2026 10:01:19 +0200
X-Gm-Features: AVHnY4LXtb13xHae_HjNLF3uu8TPNuAYGsyBqY2dhhK2QMuCmkBsOtE8ngXwGcI
Message-ID: <CANpmjNNAb0apuxu4+tdihHr6PDmdYK5L7Fhg_3SxrVG3UV3_3A@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw_breakpoint_test: fix test_many_cpus failure on
 large systems
To: Jia He <justin.he@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>, David Disseldorp <ddiss@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 07:08, Jia He <justin.he@arm.com> wrote:
>
> On systems with many CPUs (e.g. 128 cores x 4 HW breakpoint slots =
> 512 = MAX_TEST_BREAKPOINTS), test_many_cpus() advances idx to
> MAX_TEST_BREAKPOINTS after the last fill_bp_slots(). The subsequent
> register_test_bp() call hits WARN_ON(idx >= MAX_TEST_BREAKPOINTS),
> returns NULL, and the -ENOSPC expectation fails.
>
> Bail out of the loop when idx reaches the limit. Earlier iterations
> already validate the NOSPC path on other CPUs.
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
>
> Signed-off-by: Jia He <justin.he@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/events/hw_breakpoint_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> index 2cfeeecf8de9..943d040d2224 100644
> --- a/kernel/events/hw_breakpoint_test.c
> +++ b/kernel/events/hw_breakpoint_test.c
> @@ -137,6 +137,9 @@ static void test_many_cpus(struct kunit *test)
>         for_each_online_cpu(cpu) {
>                 bool do_continue = fill_bp_slots(test, &idx, cpu, NULL, 0);
>
> +               if (idx >= MAX_TEST_BREAKPOINTS)
> +                       break;
> +
>                 TEST_EXPECT_NOSPC(register_test_bp(cpu, NULL, idx));
>                 if (!do_continue)
>                         break;
> --
> 2.34.1
>
