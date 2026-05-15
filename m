Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544103E1692
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869827; cv=none; b=X3jyzUZS3em2QiVavslEeTWxvyaoaFBNbG/5lQrN3EOWOZTaxcExe0QFG/tXoUmIl7MciX5otPZRfMQMzZldcZmfPeaIhTsOJ2t4hrEgA4pdA+RdkO/xmibO/LP15FE8zjynsesAxX6JLJHPHRHcq3aU7VQ5qcZN1W7BSxac/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869827; c=relaxed/simple;
	bh=FJ1CmlQ6zsQ+MAOInKPXJ7AX6bhdHoCN86zCtwhXZnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU6kbYZHp/RTeav7eRAr4G7KTXytcqiUjMjT1gC1gXJsy8Flyqczsfm8nO4BufiOW/IG518BqlqQEOmSw+/K0A7uoecTCOyKRRZkJy19Cb93AcgQfCoHGYraikVzTldB/Fdlm3LkQha/qJdxKfn1xOYIEJr9Bc/O6CT02cluvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF8KJQqi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF8KJQqi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso678345e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778869815; x=1779474615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGg9AfFIHCQMhNpGBqKuAPyLtBd2s31DOya6UeJpRsE=;
        b=eF8KJQqibjj74DPejC5OBynfnjR13KWslNh0CwKYoHa99ltu7nt6/f4QFm/W7bms4D
         925Z381ODL1h1aCG3XxuEcprQ5hpfVGneAzV2tEWPsbcsYgL3oEyUnDOVPWrc0hBoAOD
         yUcTbd0+MEoVwU5ANvicxAl9V3/USqIq+3XjjuLr1hDx3gak7ny2y7P7cpVMojVz1z/9
         3bZkb3e8dMiCsB8KkD+q2f0pU41bnPMQHoyCADztJzYfS8AAgtnfJSUCQhLMZo040Apk
         RqlICK5NXkmB7MGbkgcLvTcl/XHghtverAuj/aByUmGrYUn5Hv51il0Smapio6Cgel0O
         qiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869815; x=1779474615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGg9AfFIHCQMhNpGBqKuAPyLtBd2s31DOya6UeJpRsE=;
        b=Z9IyfYukchZQWD7w9bbgNLQeOlpnXK6jArho2K6zspxxnI9zZpv+YK2O6WZpbM3Y7B
         iOoJlQRE7lQSIb7oYIIGLiLu30IW4aLDhsILK+TnPJBCM9g/61d6GEMJHwK5Xl6IUV9y
         t1xLdlYLMpt6VF0Nax6Cc00aF2lum9R2J+07nAmntesITNf48J8F10aLFcpx5h6YCs+1
         jqH3ww+pnd50MymvFtbrjxUp0b9JVqFGG+t6BrayhovrIP1HJKUGtnbY8WRbqK+Hqsr5
         t3GLDonhkdUebAa6WkocbUzkxyHjSFSefK0seYrRloLmAlnybtV79TS4uWXCLaecVDpv
         WFtA==
X-Forwarded-Encrypted: i=1; AFNElJ8EGYIqOSX4u2OQI3sniTS55SMu/mXUNGWysGBtO2YLznVVgeVYf86SjeXGd3C9ANY/eXU8l/Ec1M9f5gID@vger.kernel.org
X-Gm-Message-State: AOJu0YzxplMF92xfG4pE9Hs8lIMUVjNdwe2frMY+7L3dbMYwO7chIeQJ
	1qtaPb7S3AjnBPw/xlVVvy5ujJz77xABx1QXhohxgZrHI6nH3Aq1DWkj
X-Gm-Gg: Acq92OERQh6UcGOyoPHlPez25Ihr8IEPfGH4GJ7OLB3k6GdWpF6RYcROaJLS/0/R8z2
	PJaWOUGFaEWSWZi/FmO0dU8HGqYeW4XKtVBz2eHnaL3CH7WOH0YR2qxaoSrT2MlGGoAPEj/fIa7
	1Ys1odPn3bCIfDz9UKHxXaezFdHj9W6nLu8qhQqm5lhzUJfKaw8bPXFs6m6UY9Ix5PrnU1RRz4a
	zMYcqS9tiVoOkpyetx7kholc7vxnLUczK3v3wiJaFJNy7t0yrO+lrg61CeIt0ek/kqABmgDgPas
	/dZZVVW5Gj8yNYAhiPdIG/KyeEV+2hB3a8Ej5BLN5Hob69k/fd54DiTmlced05rQnSDVHGkLIu9
	rO4J3/vzU8QIDGs0z5N5mHce7TSfAQtUFSv6jBaQkAna0yYO52aHSaCQ/G2nLsrvTfyx+v9Ppx7
	6nxPGowYZadUueWZSKJ/DIDsC2C62AQHLENx27RTxnmNCmFI5fmyqvMlb2rOdX
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48fe60ea590mr70278195e9.12.1778869814718;
        Fri, 15 May 2026 11:30:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4862209sm78901635e9.0.2026.05.15.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:30:14 -0700 (PDT)
Date: Fri, 15 May 2026 19:30:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>,
 Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
Message-ID: <20260515193010.056ef472@pumpkin>
In-Reply-To: <20260514200129.94862-1-amir73il@gmail.com>
References: <20260514200129.94862-1-amir73il@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 22:01:29 +0200
Amir Goldstein <amir73il@gmail.com> wrote:

> Code using ERR_PTR() is almost certainly intending to produce a value
> which qualified as IS_ERR_OR_NULL(), but this is not the case when
> code calls ERR_PTR(err) with positive or large negative err.
> 
> Introduce a fortified variant of ERR_PTR() whose return value is
> guaranteed to qualify as IS_ERR_OR_NULL().
> 
> We add this in a new header file err_ptr.h which includes bug.h
> for the build/run time assertions.
> 
> Subsystems may opt-in for fortified ERR_PTR() for specific call sites
> or by #define ERR_PTR(err) ERR_PTR_SAFE(err).
> 
> Link: https://lore.kernel.org/r/CAOQ4uxg=gONUh5QEW5KJcyXLDF15HbLnc9Ea7RKPcgtyfPasTA@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Guys,
> 
> Please follow the Link to see the sneaky bug that Nirmoy tracked down.
> syzbot has complained about this a while ago, but neither me nor my AI
> helpers were able to track it down from code analysis.
> 
> Honestly, with AI review, this class of bugs (return a stale err value)
> should not be happening anymore, but it annoyed me that ERR_PTR() can
> return a value which is not an IS_ERR(). It messes with code flow
> analysis.
> 
> What do you think about this macro?
> 
> I intend to #define ERR_PTR(err) ERR_PTR_SAFE(err) in overlayfs.h
> to fortify all of the ERR_PTR() in overlayfs code.
> 
> What do you think about this opt-in method?
> Any reason to make this more widespread by default?
> 
> Thanks,
> Amir.
> 
> 
>  include/linux/err_ptr.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 include/linux/err_ptr.h
> 
> diff --git a/include/linux/err_ptr.h b/include/linux/err_ptr.h
> new file mode 100644
> index 0000000000000..829ec5f771528
> --- /dev/null
> +++ b/include/linux/err_ptr.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ERR_PTR_H
> +#define _LINUX_ERR_PTR_H
> +
> +#include <linux/err.h>
> +#include <linux/bug.h>
> +
> +/**
> + * ERR_PTR_SAFE - Create an error pointer, with validation.
> + * @error: An error code to encode as an error pointer.
> + *
> + * Like ERR_PTR(), but validates @error:
> + * - For constant @error: fails the build if the value is not a valid errno
> + *   (zero is allowed, producing NULL).
> + * - For variable @error: warns and clamps to -MAX_ERRNO if out of range.
> + *
> + * Subsystems may opt in for all ERR_PTR() call sites by adding after includes:
> + *   #undef ERR_PTR
> + *   #define ERR_PTR(err) ERR_PTR_SAFE(err)
> + */
> +#define ERR_PTR_SAFE(error) ({						\
> +	long __e = (error);						\
> +	if (__builtin_constant_p(__e))					\
> +		BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));		\
> +	__builtin_constant_p(__e) ? (void *)__e :			\
> +		(void *)(WARN_ON(__e && !IS_ERR_VALUE(__e)) ? -MAX_ERRNO : __e);\

The object code bloat would be noticeable if this were used everywhere.
But you could make it a bit simpler:
	if (__builtin_constant_p(__e))
		BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
	else if WARN_ON(__e && !IS_ERR_VALUE(__e))
		__e = -MAX_ERRNO; // Or maybe -EINVAL to stop and other boundary errors
	(void *)__e;
 
The check for constants may be fairly pointless.
One of the static checkers may already detect the obvious fubar ERR_PTR(EINVAL).

-- David

> +})
> +
> +#endif /* _LINUX_ERR_PTR_H */

