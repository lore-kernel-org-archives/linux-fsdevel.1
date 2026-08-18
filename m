Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798A3CAA5F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042035; cv=pass; b=tS/4q3DmnWY25NC5mMSrzYF+Qt2blOhAQ+E9q2AmBbjbIrdamQ/pThhD5NCqj78AkC51lsvgJFdsFu14oQVXNMt2kpVITSrrwKLFDvj1OTTGzRtkWPri/1lCefj1+KXczQA2toM6bbXvvwY64r96HEluVGpPfZ0VCFLMSxp/+ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042035; c=relaxed/simple;
	bh=SKttsLqHHef/ZYfaFeBWGqEb3ljNSuqipQ+udD/dJIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oj/e5SXWQkFdcmVi3okHR0oO5SxmSN8Fmdwz9gRx4/5QjHAmz534PFwdPIZm47Nw8XfKr+gkaRHHNE6DcAOhbnh62wb7fJ6ZcmeW+2z2l0tzmFfKNVOIA9gxwXAXgx0fQfwRTx1diTHaKzI4D9qbjIF2Yqgo6pfmTz1rPorrEFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VfmyJsSP; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VfmyJsSP"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efef6533aaso23350116d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 01:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787042033; cv=none;
        d=google.com; s=arc-20260327;
        b=fuHdeyg4kPE3MKHOoay4aG3S3vjUSkJrd1g5BfcvUat7XPnoCmiNRhU5QApMP5ZYo1
         ndkkBUfZWKoq4JiOLT7n3pxRt29MxEDAWbuKsWBhHMoayn5AHKszuK8gLvoRbFaRDVuc
         d9fSFhdOol0Mi6icc8TPOKSKEhY/EH+PSdDCe+yzuWeSmwLTlBSrC8ONPjO78czgO2q9
         /sSEqjV9yB98tv3X7GzqnfyELATp/jMZYrOxXn3vT5CLS51guXfj6GUILJ4jRS063r9H
         hkRbW9+xIw12PiT3j1Uad4J4P0v8s3m42TpQfB+N07aJolyIflrOoZOf/ED+8v8t2/77
         TVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SKttsLqHHef/ZYfaFeBWGqEb3ljNSuqipQ+udD/dJIM=;
        fh=AkFDM/yoAJgHq6NB2LX2ecAP8rPRDNyhapMleBPF4kk=;
        b=QnZM+YK7pDh091upkOBeasKsv0P3H00DB0V7j0wwGq3vjB0pNonA0IaKkeq2vAolRn
         ovfRWBdc1aCADKVZSyHNEgDpOA2mFzzytmNgbSgsSzV/qkLXsE38n5wTl26Bc6IpX+QP
         oyGFM2PiHZ2sm18kdO4/pE6zhlsY61UYDdEgGzLc4HK/dyjIJx5nIi0jZzp0XMfLTKYR
         6UPDMnnqL/yT7rJJ5KHtFuI/Z2yVLNu1MFuRUcahQfNikQBUzIPK6efR/kTAHgpSrC8R
         OZ2mlJ+siDtor5ukDBka11WAcATjSQWl5fitJ9/92xtOG1P0HdUqUIlLr+PyNyajSf2T
         KQeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787042033; x=1787646833; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKttsLqHHef/ZYfaFeBWGqEb3ljNSuqipQ+udD/dJIM=;
        b=VfmyJsSPwst85mn8KKNSkuAq10Kr1PcKgsIlYOhWLFzXjY//cmU3/R3AttOdDSichZ
         r8iEAqlEAvv1xDsP5rGl8Udi9u8sGxU1pD5BYT/dZueyu4dT0rfzmpcbGNjhywk/yqwP
         Sm1E1ZopaNZ6XlwzPu6tspajFfXltisisHv3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042033; x=1787646833;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SKttsLqHHef/ZYfaFeBWGqEb3ljNSuqipQ+udD/dJIM=;
        b=LgId907DD8/xdMAQ09CUZlTkyCv/FC+PXPVJ+kx2QBoOpNFfdliXtLp7QI8w37azRY
         mdUYt+cMYL3dJg3QgPuko1mm69psQEcjCixIWwTjTRB5HcCDw3L4MDRI3JCnRm7viyuE
         j5BN6o8FL2ZIPcMdHBGb3V6qp+SSWsNsz5T46qh78Vu4UGCkDzFgAJzJxVvNIL352/2W
         YnofMg9YO40FMg1WMuF3YEIsTvRRu4WfpG8Wz4DxH6Lj05Y4F4tOqG/B93xKf0vRqH5l
         PkIjsVFKsl1eXgRm8skjcvmo93Dq36z2PmMDZpadwjIqeFVfpFfGWSOsTfVvXyxSRfzk
         dAZg==
X-Forwarded-Encrypted: i=1; AHgh+RqEIcyCeFgm67zxN92q8RRbUgEpSCAf9m5h5jwf3ecARqfQdfbDu8reYAEuYqpgxJeqq5BlP1A8mHAGVWZi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+4DYwAWWyuF28S4QqZnae9K0H+V9rldczF0xlP7yRXTlBdU4
	l2e19Ct8G8gzqAldcak8M6ZoYcMRPGSTsyqstA0gFt3dgNoLJgT72aFmyPrpuZY89RKqmZiwxcN
	g0LUgBs3rlZMxDglzlrq1E5ynCwVLujE/iISALhoWVmXj6FVumqIu+HI=
X-Gm-Gg: AR+sD12N9TBc3H2flfzMKj/2BvO7AblsmEtroV6rY9hSnzYJPztW3ROKSEyJdX/3hwU
	yHtdS/ThkVGx3eoIZNtllu/wA30PjXAnaJ5uF3tskxosn0GV3/7PhAhBT4HyQFewmV7xgYoRBON
	NH9SgbbmGO0MCkF2tVCXWX5Klu/eUV2leIjOXYBLM5jzBLl2kkiW5ja634jX0klGxjya0DfrsDB
	zZQjudS7WfM2d16oO/83UHhwH4xk7pJxrBKkZc6aPtSbmEdYbWmfkQd4XHEr/aUagHz+5m1b8rn
	2ZV1CjZWqXugl4u9X3lzzGH19AqMQ75LaR8PHdmcCihG0ry4vzMwa8H03OmH/n4fklg2FUjYS0f
	yLsY9+icLMGI=
X-Received: by 2002:a05:6214:21a2:b0:907:5aa8:ceb2 with SMTP id
 6a1803df08f44-90a91d647d8mr323277136d6.18.1787042032962; Tue, 18 Aug 2026
 01:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814134015.618488-1-libaokun@linux.alibaba.com>
 <CAJfpegvKQrOGAFCDidFeELrQb08sebJVo=WHXB5SoWAwjodSKA@mail.gmail.com> <4b0dc107-f9fa-4e84-9a6e-f1fef12d56c9@linux.alibaba.com>
In-Reply-To: <4b0dc107-f9fa-4e84-9a6e-f1fef12d56c9@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 10:33:41 +0200
X-Gm-Features: AcwNN1VXYO6xNCojCdkXsyY5H3THuDSLH4RdaJM7EA9h-rP00PZfUTxto1M7Viw
Message-ID: <CAJfpegtMS-j_KKAxaki3Um9U=d=maQKWG4naCCYGtYxSiep9uQ@mail.gmail.com>
Subject: Re: [PATCH] cuse: wait for pending RCU callbacks on module exit
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Aug 2026 at 10:00, Baokun Li <libaokun@linux.alibaba.com> wrote:

> Many modules (including fuse itself) already call rcu_barrier() on exit
> for exactly this reason. Documentation/RCU/rcubarrier.rst also explicitly
> states that synchronize_rcu() does not wait for callbacks and cannot
> replace rcu_barrier().

Got it.

Applied, thanks.

Miklos
