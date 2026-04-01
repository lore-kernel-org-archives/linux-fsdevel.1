Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6953AA51D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048110; cv=none; b=hdR4fuz1cUcPw+HXpRqAHCVlmjm4XAajHmi0KNTyRiNPo80opVGp+89p6EyFSPMrDcHvwDMfyJnfQpWJL1B4+HstoK/Kc2lcL8x/UgBBFuAGTrL+IldZqBgM8deqHyQLQWwib+NWfZjJkSjtmf0moimBoxR18eUz5WX0WDqrFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048110; c=relaxed/simple;
	bh=p3DWQnchsgDpcLb76BxV7/WdtY71Dwx/9iPiP6Bjj3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocKHiMCvO4ZtVTfI7j4RoEnRNZp0nYewDq0u4oLRttNYtUxCynK4z7X0gG7fRk0CBGkrKjJOCoUMz7hWTtY0HUOAUbcDFUmaEiQvEZkSGeSdhwyuFUA9fYQRQ64VlgQPdLL4sPMPgCqMVfD1TQW3upOF0oNrHYV61OWo7oe/hPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CwPSFbRB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CwPSFbRB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso61929875e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775048107; x=1775652907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp5jG8J+75UCWMrvYV4yIKDtMqACtyiprBVaGIyK7OY=;
        b=CwPSFbRBnxwgWwffixBI3HsHpT70mZUSq0jmigK40/gsxT2AF/oi4lfWd7P4M87vr+
         6Lu4Eki+CmKFPk1qZCs0XY0IpzCbb/P23zWsRGPscxzB6nUnTo2KNY1Vbr4FXQUy8ivN
         RCgv4ikiPt/rW88PxV4yeArRfm364nc300tWOUzqzozcJTy+fVos+oqGpaBod32F6Ihs
         b0ThZeHDrajiLhyiOcwNHDG4z2reAmeWPimHcj+eBVmqb4LD6j/gO9JagtdsHPfBMQv2
         7Mzzrmwk6w9TmZueeQrg0MRAMDLhUwl3SkXsjaruKtmc/ik6ZY1nt9jfL3z+Ttab87Mj
         SIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775048107; x=1775652907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp5jG8J+75UCWMrvYV4yIKDtMqACtyiprBVaGIyK7OY=;
        b=YMheu9y7b8MPzAVEpNQzY7yfJzijMsXhLYBL1/se5uHhT5UNg64N0/gryP+7yBEXtE
         Mi74ggGmK6C6WS4Q74xmkHxANvxQc8FobqYvUiKiTBgc/6w4qxBjDCg3bScEvpChV3zq
         wiicLSQceB4FicoDWZM0NlGCEOgPA6HyoaYIYgm6ILG0Ra7cteocMXAmrjWjCem47AU6
         VCUVFE6C5EsvVNM1joy5RTZp/n9tNYgtsuXVgyEQFSLEPuxJUY0EZMhciZ1y/8wuBgQC
         jWndVK7bwUsvtmyCFIdo44I0GnaV9SywNUYb0bLlCyQSNemV0u2yucLI8QGjN1fGgaR9
         wJaA==
X-Forwarded-Encrypted: i=1; AJvYcCXHjmsF/pNpdf0TW4JdQfuBnk4OsxCj30Pnbmmje1pp8N4y9/xBfuuapVnK0XAdSIN0yDTqAnh2rb58U/JT@vger.kernel.org
X-Gm-Message-State: AOJu0YyimR7Bjjx343oU+t0sI+NvwEc0NRVxfx67t2StocjQJ6Gk1iXp
	CBBlmJjcOAciw/mg/PPN2IjFZNxmB1cToce2sYh6GHDrEStN77HtaO7PObwmDt7a/pU=
X-Gm-Gg: ATEYQzyx0JGMfW9T/8Lzx0+2qp0cebdihPwAW6Z7LA9sn9lbUGa2Jd1cL99BthufaEp
	EtoPICdiMQXt4apt3YQ8+w0+MGtbu8glPxTnsgmqmCEuXFzC/agFHLUQygJm1A6xIxkqn2q31y0
	Pa2H8TsH7bRcBmFpDqgDHhGbxjuMf1FbrXIYzDPAo1orgHwjYlTz/a0xVjIF/lIlu5jCwGi8AqI
	tIkNJ7whjqOHX4E2m2u1myeM2FzRMSIigMq9EBG9UO+5tEO6083SJdD1WDPKUNvWwCaP2LWHO1j
	YghmQeDBn79MbyR8j7Wobm7oylI0kgtQoDyBXqClhtZbQWpDvOyv4gHJCJ6CsO2GfGOFCaKODbF
	tTbD4f6KZH/lVX7MsDWMiRwQuRGtv0DmobepeGNY0TV7GDoA/Fa9B7d8v7CyvzRNNGdaWSHIRpM
	czoHBqkrrPj9ksKbbOO7Fq2ToYEg==
X-Received: by 2002:a05:600c:3516:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-48883597ccdmr52779525e9.14.1775048107013;
        Wed, 01 Apr 2026 05:55:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8797ecsm89723685e9.8.2026.04.01.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:55:06 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:55:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 4/6] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <ac0VqOikIMl_ZdZV@pathway.suse.cz>
References: <20260331070519.5974-1-ddiss@suse.de>
 <20260331070519.5974-5-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331070519.5974-5-ddiss@suse.de>

On Tue 2026-03-31 17:57:34, David Disseldorp wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There is a simple_strntoul() function used solely as a shortcut
> for hex2bin() with proper endianess conversions. Replace that
> and drop the unneeded function in the next changes.
> 
> This implementation will abort if we fail to parse the cpio header,
> instead of using potentially bogus header values.
> 
> Co-developed-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
