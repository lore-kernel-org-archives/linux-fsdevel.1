Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3346331EA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173363; cv=pass; b=dFu6U0zqaOLNfKJ0pN1H3ldUP3b2IcjKHg1kznxcpehsb5if44MxPIvUmuxegTrGx7I2b23vVB6pS0oiU5GKYKVmLX+FxJDSFwql2TaMneJ5rMFov4dl+5kYe1gDPLePUcKPlHTBDyZlfRzVpuqn1mu0ziupbgI9tPKvNZv8+8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173363; c=relaxed/simple;
	bh=9rd5ao9UX+dRdCRfac+Al0jz3HeZixBGrRexHervq2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK7jSPGyvO3Deg00v7rzaDUJNqAMcWgN6vlTw9GNUNEHVf+8LkUsAKe/iQvCy1X/+4/iW5Zo8KvMkVpvkt0eyBAoSKcyP99VY/k470ioNXRN/h+37tCDzSSNcliaRkc68uK/zTAnyLEOdduH7FtduFwKcSuBbD2V0zZoiuVZqeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OTF8zohF; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OTF8zohF"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5174a3a025aso79486481cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 03:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781173361; cv=none;
        d=google.com; s=arc-20240605;
        b=HOz19ZkwsOUUDm8I9K7l41uHQicp52Wchy6EvRxmm99LHtq3jf/ur4cJDFQTPitqwG
         kVAAFsoqXJu5NiAeD1aJ37+Usg0ySCr5DiuuiBD6Ah6TVHeajZklzKJdaUEXOIVBK37n
         azjUuYqQbnrTyu93PwIbNpy1Sn8jznVtYso89OK5iEllMAw5mp+3jGlKdDi9Lw5evYYa
         lY+I+gL5x+USljNJ8RFPsZECYvi4vYjToNznprIzZnDohKwAY4VWRCrb+cET5tHya05W
         Rw61POf9R9gx+TskBbHb0HM+rpuhGbt22d81JxokxARbW5iIvcKi+WbiuhddBbNHw4jx
         BgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZdX0Q5Dj/m/HuXrzpkAdoJ/jZuUveaL90+L63Y1EBAI=;
        fh=qk5NJgyHGLicmKpzsSm4RS0JF72t7p83a/+2j1qBGLE=;
        b=L3GJ7A9FPlA5+m4N1mcPYPU2jnjWkdGgTvmd1p6PU/JaUq3ya/VpCeWMlNJV9nDQpC
         hucqc5riHRWkBaCgPdp+xLjDj7r3G9mI6okop2tG92gDgWAfKJMNvjPtssZilITqyJmR
         UYTFbA9wcqGCm8iUUP8YlUtc0bCv0UpjsRnTbNZxJWSzFPmbbMi7+Ps/jLMIUYKGHjJK
         2hWXdLHEUYiZBg+c6trmDceP/iGqwIdXq/+2/twZm1y/3iCRLc+tThHT0ph33gGkWi3y
         4ZhAo6Hu+c/Wpgm6WkrSY8iajb+Pi6MeHSukEt5/1dTeWoSfEUVV574K+lf2MKppf9UH
         HD6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781173361; x=1781778161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdX0Q5Dj/m/HuXrzpkAdoJ/jZuUveaL90+L63Y1EBAI=;
        b=OTF8zohFsJVlZr6ws2Abv0gTeJmK0zD7MmfaID1jzVc/USrBTCewyyhj9GT4vtpY4O
         ms7AwaPUfikslTgpPiVC2X4ryQ50/H2jLhsJT3Qli/YtcvctDl9pGrXN6zQf2mjXUVbo
         Am7v6zhUFq5ZbahxSMvpaBA/ObD1f4kwGdXkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173361; x=1781778161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdX0Q5Dj/m/HuXrzpkAdoJ/jZuUveaL90+L63Y1EBAI=;
        b=btOB/VV6h50kVGSX+6u9XtQO7sbfYjilxjRw1cphFdhWNoL0ivQuA43vxSm8rf8wLI
         59VnhBj3zByunkSZYGrhBQeC2NtirS7Xj1QowdeATtlMiz8oLGn4F5DWGbgm2zhWs0LC
         vw3pABIJ1hCh9Qjp5RD/YW3xpsvvqTB4EOkdVkyFibzfp1CZL6F5ZVDLSpaUqmsNZc8B
         +G4MpQF26PStdExxTjpUKBuPeYhr3QAJqIzKZGbb1s4qblZjNM0cOv6+w4dU00A0fDej
         FCcSm53LJ9FxOpphp6EMf4ty+jACqtVrTgjPKnOO98CYtw4qd0QVEKSTaWbnHiGUZ9ge
         0LRQ==
X-Forwarded-Encrypted: i=1; AFNElJ89Zmcx9ACMjj8sH2YA8iTAZRdrJ2S5j9Obpm32SD8SFt7SQiT8rqZ1P8zQ8WENN0mq/9fR7AXEfK2+2qcu@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGBYhFn8SiihYm76NGX9yXCuxqg4ECLM0TKZUH1R5mp+vIBN/
	nQn9kR5fx6gWAWS8fZV3FDtywGy3lhzz3luw+0vMrMdAM3TOdS2/I2T+REgGF2B2Vb5MpOQJC3L
	gSzD1m3b75FOeSf7jrRIC0pPgmnBg6++lmVfYKXNzIA==
X-Gm-Gg: Acq92OHNFibHotM2zAPF5NxvoDzsVcHN9g2J+NLWY7ou3UpQgst+K8R0rHV4WfMh/JU
	7kHOUzYPxhZl7QfjA2W+fX4d98ajL03WQeKjh1QnwlqUcS/f//7LroQvgErmXfPvAHJi4lHv3R6
	Sl/1a+4t2ea3VJujopKvzFsrkyQrdW71ncCPy+fq9tmDEqGU6qySiOwQ94++1DgPIUr/lFJfx+8
	F1NOJZtuk1lkgyhivh4r5EZkV8HzgrNZl4ey/rWt1iJ4WByb1+sN1CI5sXzyuMpYUicKShkTSQK
	ifX1oonbGYMezBEZN5+kGh4cfvuee+Engn5KgKLlwiGdSbfKKD0=
X-Received: by 2002:ac8:7d55:0:b0:517:8aed:1498 with SMTP id
 d75a77b69052e-517edd196demr32813551cf.16.1781173360617; Thu, 11 Jun 2026
 03:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-wip-cuse-leak-fix-v1-0-1c028d575e97@redhat.com> <20260408-wip-cuse-leak-fix-v1-1-1c028d575e97@redhat.com>
In-Reply-To: <20260408-wip-cuse-leak-fix-v1-1-1c028d575e97@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 12:22:29 +0200
X-Gm-Features: AVVi8CdMAm9XTPu_tz3eNH4Gr6oH6gYH_KlQ1VbfnPRDcGzO9UeXR4dc-afKowg
Message-ID: <CAJfpegtWTNEDcDds5X_jsXc_wKWtuW5oZqXQnrTrzW0rw8fa7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: fix device node leak in cuse_process_init_reply()
To: aruiz@redhat.com
Cc: Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 17:23, Alberto Ruiz via B4 Relay
<devnull+aruiz.redhat.com@kernel.org> wrote:
>
> From: Alberto Ruiz <aruiz@redhat.com>
>
> If device_add() succeeds during CUSE initialization but a subsequent
> step (cdev_alloc() or cdev_add()) fails, the error path calls
> put_device() without first calling device_del().  This leaks the
> devtmpfs entry created by device_add(), leaving a stale /dev/<name>
> node that persists until reboot.
>
> Since the cuse_conn is never linked into cuse_conntbl on the failure
> path, cuse_channel_release() sees cc->dev == NULL and skips
> device_unregister(), so no other code path cleans up the node.
>
> This has several consequences:
>
>  - The device name is permanently poisoned: any subsequent attempt to
>    create a CUSE device with the same name hits the stale sysfs entry,
>    device_add() fails, and the new device is aborted.
>
>  - The collision manifests as ENODEV returned to userspace with no
>    dmesg diagnostic, making it very difficult to debug.
>
>  - The failure is self-perpetuating: once a name is leaked, all future
>    attempts with that name fail identically.
>
> Fix this by introducing an err_dev label that calls device_del() to
> undo device_add() before falling through to err_unlock.  The existing
> err_unlock path from a device_add() failure correctly skips device_del()
> since the device was never added.
>
> Signed-off-by: Alberto Ruiz <aruiz@redhat.com>

Applied, thanks.

Miklos
