Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D73C553A
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745312; cv=pass; b=HXDbqVN59Egu+vTaRllUuDA68Pk+9QxuBKF/Ii5S/THjYjMm64yXZ7ZMzu9oEdighQG/jXB0gdzJB1AhvCOIMThJv5nZ0g8ygGLbnTTuL+S/u79y3a8dtzMwW/rhvWPvNc1HNen3wFKf6Nnibwb0/F4/gWWTpTg6vIxYhAJsWXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745312; c=relaxed/simple;
	bh=vAKHwi/+46La1lVZj6I0OUdfUfqhDDBZXGHemI1QJAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqye4vUXPeNqBGODEYdfCW70HB5LBZCL8cXndJ33qMaH6MCPj9pj0I+2qH4e6Hl0kugI0Bemz+BazUfvsoTuQUB1TGRlzZ47T++eRK1pYjrKn9THZ/nU0JFZbQQ/CkKeqsNarjxkYY1bTYB94ZS+3NzTJinu1XiT21XpWidymrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uytzo477; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uytzo477"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1332772f6b3so6324539c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 00:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745310; cv=none;
        d=google.com; s=arc-20240605;
        b=DYuw15tITFq63ARkSEj4ZnI9XVrswm/eIJuX7sny5lkJblNAI4bsTbJA2QA1a08CXq
         0HUOIMMJKcfvQERCJcfDiWxlCmEmkMi1VCgeZiIPA8l0LiwPH55JGMQelajc+Iyl2bWS
         0xbSGYoAffSBbxtdC7R3Q9wm3o/adFERB16xi+ScfBJ/2DtqQdIcNlhKofT1YNikXtwJ
         j1b4HJWhHmRryRM1UsEmscNuQgUXoVdrBNkg0UdaHCIgsVIJ0sJ3dy66UebWRwTq5ZgB
         +rs0GLXMcnsNgtN7b43tMy2PL9kpdUfYyce2xXSdNJaSJXARnzeV/jwiv+/ismly+Oh2
         wSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ILxCmYkL50pA0BzEcihF0YhatRIafK5z4/k4jZSf+Gs=;
        fh=1zvkyZNwOv9rgxNtgKIh+sfHg7BDH83ZHx/aoBFVfgw=;
        b=WS1ri1D6er7alQxAXCebnnxo3mNU62IlQNyuseuKIDg1YfLbCJ+Xnsxzre7CD1+p3n
         runvYQufas1rzEm2Z3PGhDOpkkYrljxaPvaRujZEBwgu9dwOXSOJ/UIiqVpugCup1tmQ
         SsuGsVmqjIaRAXPgz75046oXBsxknGQUPeV0KaTXoMsTGdkjVwVqxpgaTjF1KjAKJtip
         jf88+xIdMUlFzS5F430iFoJOUP3BIeVOLCirRsPvfOQKXBJvlqJVlMjnP4ed345/ADaX
         bFwOyC56miou8w+1FvXC+xB6SjImZpg7hS5rKvAficNoOLiotpXW6EsgZc0T5mZlfCgK
         oFHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745310; x=1779350110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILxCmYkL50pA0BzEcihF0YhatRIafK5z4/k4jZSf+Gs=;
        b=uytzo477x08SpHQC9uceQjFEqoO0aXi9qfuPLn4aD/W/M0iv368kUEzt7YXGiWt7V2
         4V0WeaDYcZlRJsOnYsQ+Qi3QKeE6/FAo4FdRoFexR/oo+RwdwRNOD/IswYmeBaZ4ttHC
         s7x4x9lieiBVGJHHEehr6E+nCb3cMr9t1qUD7d46IVMgV8dv5xIv5SZXGl3YaasHLN6y
         zSxeIJjKHXuW9xo05fCN5nTYAf1TZ2vdme8hOsG9/IuG3xNaRnbUyVNLZj0/fGLkOEfh
         HZQNl+zB+iluTq2MS+Tzc3nLgB7QsfLdNLvWRDZBprAAYtVydThJguTv7+j0HllEh949
         bn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745310; x=1779350110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILxCmYkL50pA0BzEcihF0YhatRIafK5z4/k4jZSf+Gs=;
        b=cwwh3YkCT3fvUuE9vACHQWn5ooGy+ouejlr4Y1xBT5XujMn6e99YIBNvtNxos3Mw9Y
         XcKJdjiqnknEiWqyVE2JqVrJsROOQiFnObNKLaImWfcSF5Tk1XqnnyI5lxbibKFhZQbT
         iygtZrB+Mo3u81XSelfyfwwxTDGVjJFQ430rrIfuhJ11PLuvv5d2zSVG/IvcYvm2ujYK
         cbl9ReyUECmJfzGn72BP9DrbZ4Mcymm5VH990LyL/5ztGbfsktDhjUKfsdlaQM5CSjnD
         Jdd01K7ZVMMIaNHbJyIPbkMftA9Gcvjco0YsCycYwaEwWD7/FO4jgorpg12ek0lZA/Lu
         0g0g==
X-Forwarded-Encrypted: i=1; AFNElJ/i26DhspFgiYrWIDX9ErHH0or1cXMe+bxkbOtm9hpRWSL93BY4bXHT4gp/PMtiEX+cLqBO5qmzaCGIrJ+2@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBLLjn+2KmECnc+XQvewTK+GH+UT6GAI3hXV55AZKK4a36CZk
	jVARnw4EI53D4TRbBHIFy89hneY1jFYS4ENoIs601JCA6yFVNydP5HxlSSMBqISxvqObzH1QzPz
	EIxVXGSK5Qj3lz2CfXWPKleNDkt22I59bAdbGIo6Q
X-Gm-Gg: Acq92OEzFFt7HbCXm23YvnaPeFsEmhz5//E2mZ4nTNQ8cYV8UXNTP/kZ66boiLrWbD3
	hmnFH12MZSXqzu+GHBbgQaPqyYQHdklqWz7FjVEAWLrGfSotVGLUsnz8mrRb/Uye5zK1Mywa2+L
	p+kp3YSspKaY6eTh5C9Be/EUgm5GF3BjCToFf8wlvssbF9/9oV6PW5ZVT+1XveWs3MfbTKDBnkM
	BWYmK6TRFBYwq/dkGaqJaWNflFq+gq97wtVciw91wsgeAUz1DkHy6XekfZpmvJSD8wCTlJA3nVO
	8lKkqG0keIkovD5f+QIH2mXphbnbIPqm9S2DMTar8AxcJt1QRQ==
X-Received: by 2002:a05:7022:f9a:b0:132:2486:b47 with SMTP id
 a92af1059eb24-1342ef3d502mr4606238c88.3.1778745309159; Thu, 14 May 2026
 00:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514050455.2954509-1-justin.he@arm.com> <20260514050455.2954509-3-justin.he@arm.com>
In-Reply-To: <20260514050455.2954509-3-justin.he@arm.com>
From: Marco Elver <elver@google.com>
Date: Thu, 14 May 2026 09:54:32 +0200
X-Gm-Features: AVHnY4JSKKs4-AOrzjQCzwh9kSmbyo54JL-yInX3IhQgKt6h5_imJyB2qQ8DYtg
Message-ID: <CANpmjNMLa39q=Ss7TVzSi=TTef60AX4_C67XUifanio9YeHB9Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] kfence: kunit: skip when no pool is available
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

On Thu, 14 May 2026 at 07:07, Jia He <justin.he@arm.com> wrote:
>
> When KFENCE is compiled in but disabled at boot (KFENCE_SAMPLE_INTERVAL=0)
> or __kfence_pool is not allocated, every kfence kunit case fails with
> -EINVAL.
>
> Use kunit_skip() so they are reported as skipped instead.
>
> To: Alexander Potapenko <glider@google.com>
> To: Marco Elver <elver@google.com>
> To: Dmitry Vyukov <dvyukov@google.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
>
> Signed-off-by: Jia He <justin.he@arm.com>

Acked-by: Marco Elver <elver@google.com>

Fair enough - typically this failure was a way to know something went
wrong in the test setup. But I also understand that it's not always
possible to just not load this test if kfence is not enabled, say with
some compliance test suites or such.

> ---
>  mm/kfence/kfence_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 5725a367246d..e376329dd621 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -822,8 +822,10 @@ static int test_init(struct kunit *test)
>         unsigned long flags;
>         int i;
>
> -       if (!__kfence_pool)
> -               return -EINVAL;
> +       if (!__kfence_pool) {
> +               kunit_skip(test, "kfence pool not allocated or kfence not enabled");
> +               return 0;
> +       }
>
>         spin_lock_irqsave(&observed.lock, flags);
>         for (i = 0; i < ARRAY_SIZE(observed.lines); i++)
> --
> 2.34.1
>
