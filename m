Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB633CBE73
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173735; cv=pass; b=Sf/YPDaRiryxxEH/uOTqD3V7BCIDZP+N6R4YM2X4Diouc+OYr8cyo1yhs7RdjDD/O0g23t5xFQUYTnuWTa08tLSarsuq1xN6u/pm/w9KmhoUEemQOzLOu/bp4UqNBeCn1TlprnuWmjXvGd01U7ec/4ViZwrDVrlRW4D8EngMsqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173735; c=relaxed/simple;
	bh=CislKDFyARtiFmW8Vmp5r7hsmkZU1U1itCBY2Y1nqdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5+9WLoIhvBUD0+fC59ZnWWWXw6wbiagCWh5XNDS0/ISNydMRAd57ARGVsbTG+eV8gyyhruTJLlN1WsVHpcHmAC0NbAP5hb2FZCUcExRFObc9fTstnG3S1XLFdRnY9wvR8OiBUZ31c97LK7uVj10ZV6hI8rgtTvF4W44Fkhb3lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MY3QbnjM; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MY3QbnjM"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517760dc3c2so48508541cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 03:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781173733; cv=none;
        d=google.com; s=arc-20240605;
        b=dmbbAPJQKyxKPoyuBQnE8QG6mGYXPMI673CjQLve5J01U2iS4svcjMyTI8SNEuttuu
         QgBBYkE0W9yLarRTx5MLeV+XXEwHF0b7GXLdHupF7L0ZYs7YWSNYESNOedRGV6al+xHF
         9zkZvA+c9kRTh20Scv8fzMUJyYzM+BYRQpSoOj5wGp5b48zutpozV1wq+H4OY+gBbKtw
         TViiIxPJA/F0GLLcIahJM8GZQvVhalNaJhICBiPcaZN+AgLsZnhboiuSIfx25KnCeFIq
         gf9CBqLs5WpVdkOU6dDohOH7CEpQ4nT7hVQ/g0ktG6n9r4MSlSjTzN85vCD5iKAACTIz
         Smgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LW11kryOtpG26/bj76zRyOWCPKAWxgk5hD+JnYIGwu0=;
        fh=d8VfMjXCQt0iQtP5+A6Pvy8h5P+/Mo6BDge1u1iNaRI=;
        b=P0cm+ds5pzv3HNYPORVulQDonBWajU5ND9ymNRd3DNd52///vxTv5cjFCzfgZ5d2P3
         62jsDO45mUBKmFLDuOV6Jzh4LYBfBXvwgyGo8xtumg/XckBegDNP4MhPUszZPAlFNjlu
         XpRj7EHDRwR7h0vrwLjcMedJmwik4aWXxN4d+9XgFyq1vpHtHsXKBr9Znd+Y5Q9zRy9g
         9OPk363a1xfF7zAWLAp2Hn7bPKWTciDWxwI6RBnCLgQl6IZ3Nv98OfwvjNAwTrqPmues
         PAc6aJOcUf3X7eaHcKwJP0kfnY0KJObMdHtedWxUSDsdLwKFrFPzTszxdA7x63GwqOwt
         eFIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781173733; x=1781778533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LW11kryOtpG26/bj76zRyOWCPKAWxgk5hD+JnYIGwu0=;
        b=MY3QbnjMlZcPtyWsyR4yZm2M0JTeEQc0zBKVAJvgeQn66cNslndUWR/Ch2yAPjRQVa
         7YDfTrIVcz12eppe78QgltBl2kBjq7DdCq84zMccgDI6T/+eM13ylhnBhtSxujoV9FRV
         cvvvRNT/p58XX+z46gxSJuHcx/aj/thQFfY+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173733; x=1781778533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW11kryOtpG26/bj76zRyOWCPKAWxgk5hD+JnYIGwu0=;
        b=pgdhUd4aXcUaSiD8Du9Awej9hCkdKqnGfbrM86xyGuHcNdabx3fyyfx6n1l9ft3OqS
         Gn5vlgY8kxmKOqTMknra8PzJYERrcpZFU8kQLswVishexQUuz1Sq2sgFlsxCQmicZisx
         Rmp0sNZLpo/YeIoTklPrhJ6by7dvz1iq4CbC51y/sqgB8R4PhSUp10Infto4wdrk9Gkm
         31eQwaDUmsjhDIMbgq9VJE4Ebi5KfSGn6u6AWnnhBKocHHMbXpCgtzldVnKjRju6FBAS
         bD0K4qzQtLNjYBXgMnmrHeTW6JNHQYJWJ52e40X8uF5GGYciiJDbyt/QIqWS0oh56gte
         /z+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+I5j04Cqf23qo9sSDWCTBxGF/NCZbtUKgnzs4PdefrYCHuvWla1RK7JKj5xLjOODl3At1ypXY1lc0CdrHR@vger.kernel.org
X-Gm-Message-State: AOJu0YxSU64Z1x7p4bqwI+8bKWAJBq1vfryO3oBAUpbV0H57XG4q6xVi
	PiPIvER6tquVWUHbJ6uWEdgc+fP0w9Lo8PklQ4Fqd71WAngiDINhFjAFXpnW+tQtNzYy/LcJntY
	dx2vqUx6T19XgtH3eJvwkZU/3l4joDELRMJPFQmJHy/Fsxd+eFHR0fXbjDg==
X-Gm-Gg: Acq92OE28nFJ9A8jz6AWwn+IfCNHp7NyQn4ag67i7wkZHn94soqxGZIe0Y4w3wHSeC5
	aNOqGlyxBIw0EJBsfbbNAJWIS9kVw8N2mujN3Wj8zI4pfyJ7zYjvksZbPb+t+Yb1JVyAe3OWOPH
	JkiNhCl2njQtBx71PybUjQUl3aJ/nDLVVnHvn0NxazscVASh1cmAWqp7r6AU4mk7Kk2SibwIojX
	WMFZ2vSuEuzclUttvbCIccqnKjsh/fhXWHshToVHCcX0Eq5z+ceKLmNSpBSXLbUdlIDfHN9OhWG
	yDGr2iUfREJK3sC07pKeLt5ldGRM5Zp+x35BPHdusZAS2kfEdAo=
X-Received: by 2002:a05:622a:54a:b0:517:76b7:7b3e with SMTP id
 d75a77b69052e-517ee21406emr33317811cf.38.1781173732847; Thu, 11 Jun 2026
 03:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-wip-cuse-leak-fix-v1-0-1c028d575e97@redhat.com>
In-Reply-To: <20260408-wip-cuse-leak-fix-v1-0-1c028d575e97@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 12:28:41 +0200
X-Gm-Features: AVVi8CfnSu0q8VDbJtoyGEYJCcOjl2tDogUfywRgVL7x8ZxksWLzTZXyfJZDryE
Message-ID: <CAJfpegsDNoT7MYDMdwFDmnZQNBK6FWd2o7KNncpyk6e2CAuMYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: fix CUSE device node leak and add regression test
To: aruiz@redhat.com
Cc: Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 17:23, Alberto Ruiz via B4 Relay
<devnull+aruiz.redhat.com@kernel.org> wrote:

> Patch 2 adds a kselftest that reproduces the bug by forcing cdev_alloc()
> to fail after device_add() has succeeded, then verifying that no /dev
> node is leaked.  To trigger the failure deterministically, a
> CONFIG_FAULT_INJECTION-guarded module parameter (cuse_inject_cdev_failure)
> is added to cuse.c.  The test falls back to failslab with stack-trace
> filtering when the parameter is unavailable.
>
> I'm on the fence about the fault injection parameter in patch 2 -- it's
> only a few lines and it's guarded behind CONFIG_FAULT_INJECTION, but I
> understand if it feels too intrusive for production code.  Happy to drop
> the kselftest or rework the injection approach if the maintainers prefer.
> The fix in patch 1 stands on its own regardless.

I don't think it's worth adding this to upstream, though I'm impressed
by the  thoroughness of your work.

I'll reference this patchset from commit header so the information is retained.

Thanks,
Miklos
