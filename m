Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683848;
	b=i9D8CGi189TicKJkDU24N1iuUcyuZnLrA8uJ4pjk0kt3u6E8IbLvGwc0BaWYdyfWm+7H
	 qCiXBFOFU4NPfIaFl5XLdAxunGIwuFzgyNXSVUq9BR6yIdo1zLB7MVj+j3pA1Jzc565Pp
	 R+STYZd68zO55ozWTGWP9WtPyHeLsKshKCSJn7TDpE3RhpgGR3JCW7f/OY6uHs270BKGf
	 zlIMiZ5Oi8X2doeWNHtV9pQ35IqQQu4D2XJJWz/q7lY0JJ0ZTobM0XTUCg3iSgIIngxY1
	 uFggpU1kvDnV1CC5PVC14abYCpgUMzMo3f3kbOGTDPY/urlNf8Fc10SoTZ7j+k1QvMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=doGDFu72fntktSMaYIfbAaZUxiOF1i8vKvNKZvEixJo=;
	b=Z2sVk+KCfFKMotZp2pgDRtUCwlJu/udkbjFOv2TgC9YPPs0DH6759Cu80aWBI7giq3dC
	 T7ryZgjtgK/v5Coj5qGqw2YoLAmtL4qKR61u7YTf+p5nAOsPGl9aFLKIEXv1xFN0q47Df
	 cPmvA/hTc2YIYBJdnIb+bTaHm9y4IyCANHU3kNP2fGOVfhcBEgYRLwu6Oh6du8QsoACDy
	 QxEPsa2CsiGLigR0SdeSP/j1A5Cfvg3h59gpNKO6CpssQQhIExoKxygczLYFjiPRzRNgQ
	 SWoxpT1h/yNevQbPIOzCgYss3OKYiyZjj4X9MinDGWTCmeA87RHqySEweUXxndubXRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pW219Xzh;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F7606A31D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 15:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475F7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pW219Xzh
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so5065677eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683847; x=1793288647; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=doGDFu72fntktSMaYIfbAaZUxiOF1i8vKvNKZvEixJo=;
        b=pW219Xzh+aEdlSC+vVl0yPy7km0/n8uw8ZrED2cVEbi8joL7ypXHbP9ilLCwvEVy2O
         UB8Ed/asc7hapoCb1pCOhiVJJRrXg72GS6ND8pS0pb1umj6eFTDA9/3gnNziSIzfq+7O
         eQwIsN54ACAWmtTtWgt/iNTtZhbnN3IfxH9YSrKNmmoSU715jqJk8ftoSgYPnISxxfbt
         lU/onYEbn1aVhyW7gGq9/uwQaU2Za4HWKMyD388x7/UUDP003FqS4yBg3WJBKd850BY4
         T8HFws8rpYIS1uofypw6PMTs08POOKfO/7zNkYnGd1dUP/g0jrt1QthNJcfdxDV1mNeJ
         P/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683847; x=1793288647;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doGDFu72fntktSMaYIfbAaZUxiOF1i8vKvNKZvEixJo=;
        b=hBWEAnlXf9ES5lsZR2hQ1bgtnUgVns8Jss606luFx19P9Dg01OKoQ0ObSowcg7E7yT
         gMMjJrM4opkQlvHwBeQikqTVVjcBDozYDujbnRLhJHgD8T70OqlqKKRTCsTRPWG7XRmh
         Kpk7QJ16BMHvrgUh6szoP3HrC6uN+YXi6nttZR9payVfsqBiCNMBSgbfQfYOIAm+fFdV
         TKxE4yRWkxobt3uXfOtuRbSjgy5EXNPGXilhTZdQew537rOj1SJwaNucv3nQQGCswHYA
         QHGm+JL4ierfgCmxPrw5gpO6XDnuf2G9uEjwllq6oTDfEfO/OhkOYwlO63+DmOvhL2PO
         IG3w==
X-Forwarded-Encrypted: i=1; AKwUvBxdx8adCSgXXRQZYKjBuklfwzHbCu+OOxSeWip75Ste/dMJkVbwRsFpwrQo0tpiODbA9hNbYkAw9YPiYFdk@vger.kernel.org
X-Gm-Message-State: AFq9FYKZqaRsakasurcPFp45kMsV15zqMumJ4bz7wyuNsBTPq3QHN1k6
	d6cQRaS3raQ2FQGXjqxLmOT139cvDb4StuCbXzYmT0r6RLkIhnPrG0x1
X-Gm-Gg: AYBFou0rsuuW0z9iF+FUppOFYD5WbMv8c4nnmgkrRIz7XkUmjCVKSSlblDaq+QKhcqI
	atSipE2Xu7MGRGPnQLN/he4tUFZ2VuCH4rTg0Pom0mduSZKaAoyI1V604mAKucEWlsXwzhzItts
	qreIT0+Houq5vHVxnIZfVnxNZKTLRCduPU11iggHKSt76xsQsm1KNhC2T9shCP76WRLvw21iFEO
	FKTapJTWnZNug3Z9NhLMzuDI+y+ZaLsaeSUToLq8U9SN2CoaouQj1bhCpNOyW/zaaBFomPrEr+/
	p9yzg5yQpBp9FoNI36i6lrmXy7bGiIX/LXFhCB0ZlLgoeC2cANkpg8EDjiNvKdhYSNCtY6wR48H
	qpZBbx7zcZ6Y9QemOKj3dYp2s8WIwD6Il52/28JNEb6smm+9wH2Egyx8mkhSZqZZi+QjS9sO8EK
	PV4RWgvcduX8PRL+Ht501GgnpwzlbJqcINsjOkRrjTCSQXcHohmiGh71dZEHCsjIF+U7GJyptQO
	FRPKpmt7U4vTcAbPkDr88xgxIctOISZs+JkS4oyAtq6rqwp6t5jplIzlA0KrbcXPSxVdfVsGqbD
	En/6dgjsmJwWXf8C7PuvfXs2rw==
X-Received: by 2002:a05:693c:8955:20b0:360:58a9:2704 with SMTP id 5a478bee46e88-3674c63d542mr7841871eec.6.1792683847346;
        Thu, 22 Oct 2026 08:44:07 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e153519sm18526695eec.3.2026.10.22.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:44:06 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:44:06 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] fs/aio: io_setup integer wrap can exhaust global aio quota
In-Reply-To: <20261022152305.GP8374@kvack.org>
References: <20261022091748.3653127-1-teel4res@gmail.com>
 <20261022152305.GP8374@kvack.org>
Message-ID: <179268384018.50580.15623131516982541149@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ben,

Thanks for the reply. I agree with the security triage: reaching this path
requires root to raise fs.aio-max-nr to an unreasonable value, and I am not
claiming a memory-safety issue, privilege-boundary bypass, or UAF. The impact
is limited to global AIO quota accounting under that configuration.

I do think there is a factual mismatch regarding the execution path described
in your reply. The validation raises fs.aio-max-nr to 2147483649 before
dropping privileges and calling io_setup(0x80000001). In that configuration:

  1. max_reqs retains 0x80000001.
  2. nr_events *= 2 wraps the request to 2.
  3. The wrapped value passes the ring-size check.
  4. aio_setup_ring() creates a one-page, 127-slot ring.
  5. aio_nr += ctx->max_reqs charges the original 0x80000001.
  6. ioctx_add_table() is called and succeeds.
  7. A subsequent normal io_setup(1) fails with -EAGAIN.

So, in this tested path, the ioctx is not destroyed before ioctx_alloc()
returns, and ioctx_add_table() is reached. The ring is small while the global
quota charge is large.

I agree that this is a low-value, configuration-dependent correctness issue,
not a security fix. My point is only that treating the configuration as
unsupported is different from saying the wrapped path is cleaned up before it
can be installed.

I will be more conservative about AI-assisted findings going forward and will
set a higher bar for preconditions, security impact, and whether a patch is
worth maintainer time. If you consider this configuration unsupported, I will
withdraw the patch.

Thanks,
Cheng
