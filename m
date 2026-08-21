Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71139B94F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322852; cv=pass; b=fl5+d/whRiDPtsSFK0GQW+xSum73Y5GcT8uzylJOlKnrF1FdOaRCnQ2u6IcpqHrnetxVcazMSQWqiQdvJSlQVQGqDiXNcwi95yyzgorPXypL8Bs/ahao/jPTgqThn0OwOUIeeUmljDc+OuqLcf7DiOXk5P+LvxmPMJFPzUSbgys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322852; c=relaxed/simple;
	bh=CNCPQxq3ZdhaR1ouJWW018pWCfG50OtSYRmamEvhNac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deZn8853OHe1fNwrMBL1ultem3911CKyD6jpkEy7VYWlu0w/hGwXo0b6cHh/mbga5P1eCnQIrF2yDi47287x1WPikemyf9aIc4fCOrRLpi4r1jfLJ3indAmEtFfzfY8d7N+Wo1MzuwyMaAKBGmOpG+nG1SbtU9cesb4jEg6a+28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GMxuq99t; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GMxuq99t"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a818fc4so6848961cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 07:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787322849; cv=none;
        d=google.com; s=arc-20260327;
        b=b5//1AcHkIXuhvKJUkwiIuP0JRdTt20B5h9C/CADfuAJc5coTfmlaBgTMvTGThxNcG
         bktyDDfcXA6YwM1BsYgriX6db0++IKqX96KHhWsI8sLFeE4fQgPK+5SDHl26SOqDvl2l
         0SKIOAlYt6zg2UANA2t0uWTHLhlzrpR3UCSBhw3SK7tPRy9oHY8us7jxHuRZSvV6e0j0
         UUxL8jjLP0ywqPLoga5pEWus721t0q/XZiebBylmh0zMQ16ZkbXX1IBAMkx1f4Ivr43+
         jrhvx5jcC2JDaDjD3oKGidFQjLScLvgrVpR888xewIsWJr+x57vYe3/lhE+l1TVQSrVi
         o4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eKQmZSiA4pDne5QBCDZj/WFEVTr73qPsvLTzUWIW8i0=;
        fh=zw5Vhx8/3gdPyWGA325gkOLLZ7EgNA45pNQeW5ZObfA=;
        b=cLOsyCXTu7gsF9UtA4ULf8fflZF2JnIN2/SUejxDhwUt35p7YykDAXCdrGwgxHsKxV
         UfNvj4Fc8QTILK3oPitNAQoqouYZjA9MgI6kDrwXLwdlXlR9AsKXqzMElkE8hl2cZm+g
         Fhr9YQHmdsf/3VuxK1zx2gRSxRjMsdxpzskq1Ei0/M1IRPXVhgcv8XB7svTI4ULOyKvA
         XPdjShYsyyJFsdl2CI3MCeT2j9DpcCQSAqsASjrkASk5siTzq/g84FyiFBZ0w95JJz2i
         rADpe2zQ1d+WdjWs3IpLnhIWOQDAXkDDd7zJQ5Az+/5DyA5a2kDOgERoEmAPEOgS37tA
         WtEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787322849; x=1787927649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eKQmZSiA4pDne5QBCDZj/WFEVTr73qPsvLTzUWIW8i0=;
        b=GMxuq99tqMeCV0WTBLFhNMCiOHi2f+k0r5ceZPpCnEpxteKF4bzfEhLsrX/Us1TzgZ
         B4HDXrVB51dsLguEKa47+7R+EXpTQ120C7Ktrs61W+cscKhT2kVpggQQtQfHvkDNuSFD
         1kWRQi3C6DNNoU/XnVCr/QW5QNiIa05lfQXdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322849; x=1787927649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eKQmZSiA4pDne5QBCDZj/WFEVTr73qPsvLTzUWIW8i0=;
        b=CvmR/rBjSZrQ1/hVVPCfNNvngIS/SrP1jyQBzvugpqVsFVbHPDHO4UfDOqaBFTqg7k
         500us9iTOOArJRr+PaznDPLDfC9dM7wiwMKnMRNxHqUvRiXFfBXw199PgJUawE/MXHhN
         AkJE2BAtu8g7c6e0bspmX8om57pdagrQzJmhnTSeMSFzDVxSi5vuUiHsJxznkjpyj2em
         iWB9jhtjNoANmcVRP6Fk3Shr2DgwcGsd7dfYa6M/ng1GCg2G8MELoSz2/T7oU7yUdYFX
         jOyFzHLYGUtC/b8JVaydAjHrUHEZhlw7yblfOXL22v9bVlqUZa3rCkfWJfv/GcSYvZUG
         HrfA==
X-Forwarded-Encrypted: i=1; AHgh+RoQqkbXKPZ80gGYJXbQlxpIu9P0yDjFBEby/Uk8QSbrr8730z570EfpW1xVwOvphhT3hv1ZrrHc+11Eec5Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPBHfDNpWxcYq4GgErfnJveFd+cmPFkb94m2aOtn0JiiGSePH
	uM6tk8JQM/IDf2hJdqMy2luBJJ/l8u4gUKqZu22YLQ87EG/caM2oVo8B0V4jFYrbjuAoKqpV64Q
	JxvOeet3f76iMQPqgGE87OmafzIVT9TlyvzpykZvByA==
X-Gm-Gg: AR+sD10hoqkOIu8tv9XNDZWvCOm4LVUpEpI15dhD6JxCAsn+vgEb04h8SRVx8eJDpGd
	HgLqMKJ+153tAUQ6q7n/YHBuug/LIe3HweTF2jvAVNERi5MnXcELicZqtMCq2zjc5OCvysz4x2s
	Q+FcuWhJFNGuzEBRGBJkg4E/hJKDkvnZ23CbdPqESe5E8sAVGiVBBM6IHVMC32c3JgInRaJzOos
	WLIycQHocBeuvWLSw1lNnXfCaLxHxJqKAuKYBCCyhx28sx+pZYJ80vRbG6EWfXpb9eYbFQ46NXP
	YgstoifnEaFXKIq2h9j4m1ZGaFW4aKLLPjWCPDdU9PSCF53bKonoNlXpZf6dh7R7hNn7UORRh3w
	j
X-Received: by 2002:ac8:6f13:0:b0:52d:824c:4856 with SMTP id
 d75a77b69052e-52df5a065f7mr63552401cf.31.1787322849295; Fri, 21 Aug 2026
 07:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com> <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com> <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com> <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
 <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com> <20260821083000.GF687043@noisy.programming.kicks-ass.net>
In-Reply-To: <20260821083000.GF687043@noisy.programming.kicks-ass.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Aug 2026 16:33:57 +0200
X-Gm-Features: AcwNN1Vpn8g0_rQ_fQGFeXngl74o3K0y7X2OQP-ZffOH44_34qVsJH7mtV5OL48
Message-ID: <CAJfpegvRw0Emd=2hsEeg3AvYaLgRBUbMdo-=eUMa3FRFfnetgA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 10:30, Peter Zijlstra <peterz@infradead.org> wrote:

> That would be adding conditionals to the mutex, something we all pay
> for, always.

It's just one bit (could be stashed  into LSB of ->first_waiter),
Condition is checked before going to sleep, i.e. adds one branch in
the slow path.  Don't think this could be measurable.

> One way would be for each file op to be wrapped like 'link-$op-unlink'
> such that the client (the task doing the file op) gets linked to the
> server (the task responsible for satisfying the request) before it can
> block, and unlinked once its done.

Okay, how do you know which task or tasks are responsible for
satisfying the request?  That's not a generally calculable
information.

sshfs is a simple example: the transport layer process is ssh, but it
is in no way involved in fuse transactions, there's just a pipe
between the two.   How would the kernel know it has to link the ssh
process when the pipe is written to?

There are probably many such examples where this fails.

Thanks,
Miklos
