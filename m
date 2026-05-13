Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D33AC0FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702141; cv=none; b=HJZOclqKDz0VbKC5Gfwi1Be5gFH9nmCa25rMaw39sRkQzk8RGE7RkTd21Iz+KmatUuHyKNdDYBy9kvoIPL2jU0dqNWyw5WaIiiJT3q1voCepXYJQ2tjiqnXrEyergFM2uf6Z0ZRrx++j0nNp2R1MUd1tUmVSshjPbPLp0v+7OkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702141; c=relaxed/simple;
	bh=6q+Jlew0Fwj+Ewp6UZdrRl4SO/A/6VSjk4celCdXvTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pAz3uhfJHkhNLE/5lYRa/KT2EM0N+44daX7Ks7FfmURTHtGGO9Zdv3wE9Plzeaark4Xj2u/0Bu+IYti4ScWM6ucrStHyrxY/8ECuvzTy78KG6zcptcc22aT5tv8V35bv3RYkGck1LyYTAMyK9drhF8ml3oXzI8uMrAHKxWGOABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Huic3uXR; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Huic3uXR"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dca00c1591so2459367a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778702138; x=1779306938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63STWXd9Wzpt4PhrJ/B9urLFnYXotN9z6wtEWKI/5Zc=;
        b=Huic3uXRAqUq/jmsHa2NBsfRiXjoa/vPexojOpjASE6BgTsG807o2YheMpXGIUXneP
         Z/t2sWQS3wgDk4th5MIBHDd067Y1kMlVWCEjV4FO296ftCeE7RJTRHYNwpjubvg9sL/y
         eQsPuYpW1kV1+d/FTPihD7q4dApBVKwbwJcsFWrxshG5R0Xayu5Hwaw1jE/Es2NZkMQw
         FwBjiASSdWnVgovI4rGAhJ18S6KcfbOdTdVapvkk3Kq/4IPJ9nAkEo66Bwxs4rSF3CAM
         xJ7UUsc+ZBHMC7eR0L17Re+wDZw+wcOo1p6/jkj0/iS8dD/A2XRBZ2Mk6kPrE+9Sl1xM
         YuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778702138; x=1779306938;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63STWXd9Wzpt4PhrJ/B9urLFnYXotN9z6wtEWKI/5Zc=;
        b=KTH4wnPURP6CAQjeDKdona27bswEopym8mSAxLmjITZuT3pcyCW5FK+ExwgMeeRUjX
         w9e6Z5ePXoEArBpjzBEZvjqolA8MXRbQ6jCxB/VoR5mBxo0KyOKDsITWRwvS6793wPxK
         riM75tePw5Ar10nVre1o4yCCLqGHQe7cq4r0CSDahRnrW3AngEB9kI/BskdgupukVUFV
         SK8fzeZkbU87DloxG7m9ThBgfQTgradze/MJXVczjK7TaPui6WeE25wZ4spcTlP/+YxR
         kms3L7uWeg4d7clftRgUpVP3Aq5a6F899BtkOgtm5U40Ub9emubbwzJ9/GJTZuGjTcqA
         s/6w==
X-Forwarded-Encrypted: i=1; AFNElJ99aZuwmhvktxxG+ThHOAUefsC3Ql1ZRc4//mfrkaScKkl5oa/fG75dAO8lYja6BbgC7WLjkNtIrYGFYjjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVydxLZat3nMVfe1a7j4YtW4jzVBzovjQxwFsFNNlgEfN0mXd
	x24RWgxN6raZXZD4Nry0yImuvRxoaNHfkdOrsyRSmWIvhJw79c6gWtYl3ibB4UH5uZyl07WynzV
	FK6QM
X-Gm-Gg: Acq92OHrZOhUAb69JEi4/373p/kgB84K4+iBgPPY96yzIxaU1Ue6xk1emCTfMhnuQpW
	6HGZQF/kj4ypPuHJOJ7GXLuezs0H5H8UI8Nceo/k7C30asryT8YZXYJriU8p3RAFb5FlMiauijP
	V0El38eT7kI52llFeOpug5iMTY/kos1GmjbLi+EcUOfC4IBVyVNWrQNiJ3kgi8tkqxFZ9yysojr
	hAwnQqbW6M+L+QrqLybTU+WzZYH79hbKOSXdoEmScdec76+gtVvJVVs2Oa4CVyDJ6AAdQcL0BxW
	pwkGHmx072JovVczsms6xF9DcuWLTcGtd7/C3EezTVErdeA1HDCDwNOfmgGxdEvakHDMgRWOeAV
	ur93NYIWfImTS7AKcL61X4rkJ6EIedKqCV9frJQKQ4E8kzcXYlZWdWhuoH/tU5gnpS/XRbiWg6+
	mqnCAUbyg+givKbR2V8g4ve5HTzPJp1T61WCz3CQJnfMZgJqB5u4w/o76vJNYmdvFYdpfEFNhSv
	sWNj7lfVRR5zA==
X-Received: by 2002:a05:6830:6ac2:b0:7de:b878:3106 with SMTP id 46e09a7af769-7e3da08eecemr2719920a34.7.1778702138210;
        Wed, 13 May 2026 12:55:38 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3f3edbff9sm260584a34.21.2026.05.13.12.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:55:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Pankaj Raghav <pankaj.raghav@linux.dev>, linux-block@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260507050153.1298375-1-hch@lst.de>
References: <20260507050153.1298375-1-hch@lst.de>
Subject: Re: fix block layer bounce buffering for block size > PAGE_SIZE v2
Message-Id: <177870213725.543218.16808866598223942501.b4-ty@b4>
Date: Wed, 13 May 2026 13:55:37 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 07 May 2026 07:01:46 +0200, Christoph Hellwig wrote:
> this series has two fixes that make the new block layer bounce
> buffering code work for the block size > PAGE_SIZE case.
> 
> Changes since v1:
>  - update a commit log to better describe the applicability
> 
> Diffstat:
>  block/bio.c          |   27 +++++++++++++++------------
>  fs/iomap/direct-io.c |    2 +-
>  include/linux/bio.h  |    3 ++-
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: pass a minsize argument to bio_iov_iter_bounce
      commit: 32d5019ed3b6ff4439cb075fb275f655c8a2059c
[2/2] block: align down bounces bios
      commit: e7b8b3c5b2a65595d506ffedafac66f0a11fbdc2

Best regards,
-- 
Jens Axboe



