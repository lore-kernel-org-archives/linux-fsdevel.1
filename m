Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832185;
	b=Y/8yYSriF36+YpRoordswLyAdS1PTe9Z3MSuipdpvMgzqVr1vqn8CwoIm33KazpCpfQI
	 mCQMMbp44rVJ7oP19DiNBO7e97dJFsiVRfYAu/kPm8YyMcLrKCMHtfBMzmIQR6ZVarHOg
	 SlMO6WTqwca7ES+xb6Y5Z7QO/34v87E/SsbKDA38ZpgE52NToDWaXQwHE8w899eTca6Uo
	 CBjgZQxDUJSfQdOhEZCWP9RDOSvsGaLMM0lcHm2yhHkhJupxsl3HkVH/4JDFVaBj5tTP2
	 gDxAcrN5F3MUqWC9UnIXyQPoZH5hVv/pVLm3+E6EvCExi20jK1zurY+hLjqzaKnG4Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832185;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D6Gd+45O6jd/WTnyKl3qNGPwrR7aNETEgKYw1kcr+R0=;
	b=ZqNKXvCmBZi1vjK5/6s8jIgCiSyN9wow/+zk6/xPLA59/oWG+/QtKUhAlIsfZ6+UcT6G
	 DbaAagdUX4xHtiK6l2/ZCEq+Ji75ixkZP5GRa/qpzwdnPKJsj083sDeqW0fULOQ8Xs22c
	 IZvSpWGSGc1SagwohHg5GF5NTQpxBc8sf6XLpTMCRKQ95gIArytJA7pQ4CVQtSOEParAN
	 XQ8fc/OAU52YJ5nBmV31vuP3anrwYGY0iALD/0pbpMWWT7md9IboNWCH19GQB7s8c3yfn
	 Zm5JQLUoZEvs7pD1BJ0U6rfT4+NHlvcEuNJ2JOFdPM3F/XvmasxqZPW4kHAP3aQhToQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXBXu7oW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15663606A338
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXBXu7oW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36481F00A1A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832184;
	bh=D6Gd+45O6jd/WTnyKl3qNGPwrR7aNETEgKYw1kcr+R0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oXBXu7oWdd6jOEskNxnLNKXj5NDVmJ1bZ5msx5HExb5Pste4QfoLQO/cacnE3POpO
	 GPihD/3ocKKggiPisHsKYkQPQ5tR1i5oblR/kEtDJHe89NnLRsgdFYncOUGQrgiSCO
	 0ERAAGlyBhlIazvzEVxXiPT1k4gsNC9mVSkCwOtS4MBdPM1pGY0DKe6iIVLZg5EKuz
	 TRITyqyYPsfEX/IqFKz3KgtcoZZIxxuv7cgd/J80/cfiJNmb+gbjE09RC1GpTrHlM2
	 rnRPtd8uxYiHDyBMMozp5vGFcTxCvtUU/2yUmIE7ZScUQ50xBVOmImTTr3oA7YrOz6
	 NoXm3FhKW4u4g==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso1408805a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 14:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzdnQfidJNS4N7TbjwzSdpT9pCMs+ZUPG3qth5uAnX7GdaFL0FWET3JBbtFL6MsAhLtejfPyHyuPfeuwPJu@vger.kernel.org
X-Gm-Message-State: APuU4Z8Sxg3QoIttksQgxsG6WQZCtjlhKgIJTyVRc+MWd5JlTL6KL35g
	n2GlwcNGmf4i3g+2KwSNlDXakQxnPVsJkWCpm8TzH7P4Ctp+VLG8IsSStW8dwEzPSXRwlBYpItn
	8GShdZr/L/+Yg1darGHUNzR/LoPcZ7ww=
X-Received: by 2002:a05:6402:4485:b0:6b5:5d17:e27e with SMTP id
 4fb4d7f45d1cf-6b55d17e2dbmr2505843a12.19.1793832183452; Wed, 04 Nov 2026
 14:43:03 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-exfat-dropbehind-v1-3caa58820a82-1-qiwenjie@xiaomi.com>
In-Reply-To: <20261104-exfat-dropbehind-v1-3caa58820a82-1-qiwenjie@xiaomi.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Nov 2026 07:42:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-B=jAQmirmtFycab_A-f_7WwJO3-jo=JGPT4L4UcajZA@mail.gmail.com>
X-Gm-Features: AclHuK9sZ8fC5MaT5ANgQ7UtQYzaYRrCF6oXuG6pQyKO8IO-RfgzTtGPLe3T2bg
Message-ID: <CAKYAXd-B=jAQmirmtFycab_A-f_7WwJO3-jo=JGPT4L4UcajZA@mail.gmail.com>
Subject: Re: [PATCH] exfat: enable buffered RWF_DONTCACHE
To: Wenjie Qi <qwjhust@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:50=E2=80=AFPM Wenjie Qi <qwjhust@gmail.com> wrote:
>
> From: Wenjie Qi <qiwenjie@xiaomi.com>
>
> exFAT uses filemap for buffered reads and iomap for buffered writes and
> writeback. These paths already handle IOCB_DONTCACHE, including marking
> new folios for dropbehind and completing writeback bios in task context
> when needed.
>
> Advertise FOP_DONTCACHE so preadv2() and pwritev2() callers can request
> that newly instantiated page-cache folios be dropped after I/O. This is
> useful for one-pass reads and streaming writes to removable media.
>
> On an NVMe-backed exFAT image with 128-KiB clusters in QEMU with two
> vCPUs and 2 GiB RAM, disable KASAN, lockdep and tracing for measurement.
> Compare normal and dontcache I/O in three pairs with alternating order.
> Read a 4-GiB file using 1-MiB calls. Write new 1-GiB files using 8-KiB
> and 1-MiB calls in a memcg with memory.max=3D255852544 and no swap.
> Write throughput includes fdatasync(). Median throughput and peak cgroup
> memory were, with percentage changes relative to normal I/O:
>
>                       MiB/s                   Peak memory, MiB
>                 normal/dontcache  change   normal/dontcache  change
>   read,  1 MiB    5788.4/5124.9    -11.5%      1353.3/18.9    -98.6%
>   write, 8 KiB    2924.6/3400.9    +16.3%       244.0/106.7   -56.3%
>   write, 1 MiB    3534.1/3985.0    +12.8%       244.0/188.3   -22.8%
>
> Dontcache reduced peak memory and recorded no reclaim scans or steals
> in any profile. Normal reads and writes scanned and reclaimed about
> 710,000 and 200,000 pages per run, respectively. The memory-limited
> writes gained throughput. Reads reduced peak memory by 98.6%, to just
> 18.9 MiB, at a modest 11.5% throughput cost. This smaller cache footprint
> can help reduce memory pressure on concurrent workloads on
> memory-constrained mobile devices.
>
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Applied it to #dev.
Thanks!
