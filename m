Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727633A9E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688623; cv=none; b=u85N0pW1Y82NjlmT3GKT2Yq9lqC1OyINSqDOcW5jNqQbRN2vXZLVSVFPUpktWRscA0ylgAKC6esraB7g87pXqd2t63Yqsd9r0L8MjUJNaJ79AzthajRlpAKuTuJuae3GJknfYq8ZReTgFRrlqt2gzr7HTuTLXnqftFUCDQilg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688623; c=relaxed/simple;
	bh=PlGPZoglXUuh1dfeukJH/LeqqwBMJABO0C248s1v9As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2UFh/XqzyC7ap79qKVwKtJQ2SxOPha0hOWfGOQcjECWSrED7SDh61s1I7oRgbGkCcYhRtc6b6v/GbG462VX6wgHezR+jxAei6ETged/0cw5hLKSSq+4xeU/EfB1EGnBrlD/oMGwM+zRi5soQMK1bkrJ5M7otpOd83JaY97iwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD4WVQWy; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD4WVQWy"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so6626397c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773688620; x=1774293420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Hk2XaBHC8Qa6dgUkCoPcN4E9YBKjMdtHqI5bOd6Xjw=;
        b=HD4WVQWyGgPLd3jJ1GHewURwI2RV136um/ZLg30U6PJAfKIrEqj+6n+G4wRMMjiuBl
         jOxtr/KhWksLAsVS2bUzx7O6V6pv2zcXY67mVAUKWmNpVsdYM/xTg/D72dHrQYovLI3e
         Xc8zwrB5H1BzBnHy+qvpqtBiBgv7kMIt97ICOkMTyBnip7Gh6YTYwW9UYg3ibW+J2y9f
         /HB7uMi6w/jcLl4tLvaMxt2zIkHv/P+3r1jA5hdpi8F2ivOmWTcMm8h/IRIlZF+z3+iq
         i+e0FdXRJGvD+P5ZsiY4Oe4t1L0iVnud09QWF6I1zhXuuCuhc9u69FUMELRjdH6sZJY3
         6nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773688620; x=1774293420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Hk2XaBHC8Qa6dgUkCoPcN4E9YBKjMdtHqI5bOd6Xjw=;
        b=MBpp2zOU6wscomnVpGxmoj96K5DRFncBbS+e6qSS9uz+2pJ6hi1HkHCDDut+1rVvlD
         x5zMR6vbwt0+LYu+e4I9yHPoLMC7BEkroFXrg/WEb16CcpHxGIVRGx7lksFm35STRGUy
         Ddcu5RxzA2Crw4KRBpHf8S25YOmYJHG1VZsaRiVuKFrb/61CHU5GzX5N5Y/4VzPiIrWo
         T6WFXq0VHunprsz3SNapM768jgyvWk8+b2XnlLVYDXiZyo2288uTmQmfc+Fs41NuAwH/
         H0EdJPZAjfduRst+QYO6OXAGm0nq2P2nLqrI8f4qNEp9hBp+VeD9hPorejubErWHLsv9
         ErKg==
X-Forwarded-Encrypted: i=1; AJvYcCU+0GkedMiHcrtzOLE79kzH+P+CV4r2+bRCUNCe60Qo2I1zSe13acjwKGib1aNPMob0v8UGhdeQJyHtG+tN@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcPKWmxa9THwN7Ale17UawyFz1bNzq+qLQCuZhrHPC16BYimE
	BunDDz79Ii3kwqTAGsTu+CrvEHsPd4A9vZA8nI02KKqshCH9mPCKvgVV
X-Gm-Gg: ATEYQzybl01wL+jFeTQ4cnojlzgVWHJN7yQNCAISm6mSUK4BpH6S00buTbLqU3RycmA
	BvAEJ1DLYylJpxcIbj+goF/qf4y15oW1+vdA9W2+x2+JZnA5zkvxhCvIjJ/Uyi9uRtEyTi8H9M4
	FgZ6khvpcac5sxW2UGJFyMSvhnXpSzwFWoj9yQvAZdTHTLnVwfUo+OKGBG8aaNMZVxewIIzC6jH
	3KOoHeU6fsF3RwFxUtMUhQPjN8K9/2HFPY+paSMzCOlQVCNIBUpSFE5yh9CVRfKV69qV1xhGuw9
	yUOtMM9uTjbtog7pMEqas7Nd4V1Hj+XBObquz7FptsU5zJ06LBPVvMRjrqmNqRC96OxCFOlE/Is
	O15ytnBpTr727ajrIjfuJQXQk2obGsfM4GOZ4m2s2X+nSUQ+WIFdqL3WgPtQwZuH3jtihAviXiI
	ReR71bvpoEhRwKMe6tuU5TbrZuJTp8shv3NKdv
X-Received: by 2002:a05:7022:925:b0:128:bbad:9a52 with SMTP id a92af1059eb24-128f3e52ca3mr5874419c88.39.1773688620362;
        Mon, 16 Mar 2026 12:17:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm17035721c88.3.2026.03.16.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:16:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Mar 2026 12:16:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
Message-ID: <a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net>
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520021615.741800-1-keescook@chromium.org>

Hi,

On Sun, May 19, 2024 at 07:16:11PM -0700, Kees Cook wrote:
> Since bprm_stack_limits() operates with very limited side-effects, add
> it as the first exec.c KUnit test. Add to Kconfig and adjust MAINTAINERS
> file to include it.
> 
> Tested on 64-bit UML:
> $ tools/testing/kunit/kunit.py run exec
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
...
> +++ b/fs/exec.c
...
> +	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
> +	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
                                                                   ^^^^^^

Google's experimental AI review agent tagged the above change as syntactically wrong.
How does this even compile ?

Thanks,
Guenter
