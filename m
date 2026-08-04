Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB964399E4
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848442; cv=none; b=O0ng6aVCDLqneQ7lmkBwE0EhihBFiqJvC8xvUz3J9MFoR1Lxgnv2zyRZj/8OqZEDO57lC3lrA+EmqO1LIyiPgZQnMmcFelViYc8TzAm5AbdFSlPIHUU4R/y3Q8Fjesu+VU0xZPxAoHtDprzILXmAE8GAz4G7jcXuuKd+rshbF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848442; c=relaxed/simple;
	bh=Jf/ulHB64njn4WmjKBUzNqvAIC1wFOlc2MREPr/01m8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q1j+Mf0NuWB4dUn3erNqSSQT7Z2pQwWHVd7kl9bWumtmycvKlsPxA73n+eOBnStdqOClr5/Gc2xwD4FO5QLzA5p5skLnKDpQPTI7gt3IEBTEcof27uCMS77WFL0eVTb6u06bUVVDp36BbuFG0UhdQb9Lw4/0wMuNpbBH+AqeZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mnlu+R31; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mnlu+R31"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ae5baaef5dso788762eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785848440; x=1786453240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CD2iqK/EPaClCBXLVXSOQDWirgcUGjlrzZ6ba7dIsAs=;
        b=mnlu+R31J6ogLzyJU9L/xFL15Xzm7aCfoKV7X/e568sX+3uyYWN+HCjxMTRdRfHEZO
         FYCiKTaN2Z5VcTOn8XU0tOAuX0NZj9c0oDGvOMEMxadmpXLIDjls2cTLKSAV6btVcAld
         8gXIlAbcesIlLVIDCjgc4+KxCsjBhwn7caSrGk+Szj+CEGfTN8hkE+isGTATG1uF78K5
         ODyUNJuDCoZLw6ky3CCpYbWE12/vDgoCfFSDMfZ8esYHqSj6+V0EQTOFVPKqZk5z7We2
         psNb99Gtj4gDwddphD6zV1ppAVxxE2Ocu2VynBjMZcqQmi/gWxvWoLceU1HXmbljNDrc
         DHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848440; x=1786453240;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CD2iqK/EPaClCBXLVXSOQDWirgcUGjlrzZ6ba7dIsAs=;
        b=JXUOif7MAwJUzyEQwAm5lvNuk5KdRPTzex2+qKqYp9nA+TopvT64jBZeX8twr8xYog
         IhA7u5vqJTBkwVR+/HHaEenE/HurunXGpsQSZztnpyOSavCuEs0wW2gwEApqvKG4ybTp
         k5lYGFF1YUX6e/FUQn8h/RfOtaz7hhaXpHOpF+UfX/ug7r7M5V2E2CawcJCY1h1bZToO
         mku38ACaU+k6fqFDp3QoYQ0bXjcDh8bvNjTe6Vp4+MzZi1qt4fC9ajdCvf8NwucSUOsH
         Ii/Q3CnyF1zO0PsHgct08HHIJUKXiQqIWUUyMFaF3xGuPL+VCGP5h1B1aUfZPWnBoEjS
         CW9A==
X-Forwarded-Encrypted: i=1; AHgh+RqwZZpu+ByfAdzKYe4GiF/B0+H5coVQuoz06F8yrEcY2MiPUcjOlubHNB2z8fTle1lUnP4wcb1pJGkImjzx@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQOKbax+8T43t6dDtIejW4y4faVuIUMKGBXgl62aD3TB4DgVZ
	zqra9xyxHuxcvBm21KHzsNERawcnjYLvax0uHwYP55JjXm8/WJBMz5Ila8HtMmvk1NUHC421sjQ
	dwrOtW6Y7oQ==
X-Gm-Gg: AR+sD13VF9tobAHRKe5hzBlLUcNSbNZeu6IcMlJHk5/PjbkAKN9Q7mwzUm96BxzX4B3
	WTraR31ItNqxQtj4qX9Sba86U3vKFsF8n3L8ykp5KLhqhM1wqPoghdg1n7zPJvzsvXWwkeEMsA6
	SSe+9gOUFlSVNpW0f/Yq6y5cSsSqjl5ZgTjsxAEJq/1tI3W33FeeFDZxBh70dffJzYuyEzM76WN
	hNyW6RAbalntN9zB63VZjIk8/P0EQDQ7TsZrh93UKZU9z5y6JJjiU+PsytXSkj57ik2+xuGRPQC
	Nkyv5IwFh+4Mxh1E/INc8FJCjjiUy7aKP3UDSXXws8m0wWptGxewvMihVXM6QCoeyOQuxBOJTN7
	+iMUPURFVksUKLFyG8zkud0w16X2XblWcqoXlMqEvlsdyRjK5rAFrxv4VBWjgGRhvHVWgF2y0pP
	x8b/6ZSbEhj9z0PQnMTQ7285bPV+7dzDLxYFN1kHjRJkw4LFkFfdn+UyTMeJZFwvE0zgnnzWZiB
	WzkKBa0kMuBIvZ4Q2f1MvR0LoRYDtXKhhHLLgR5J191jGCt5Gh8
X-Received: by 2002:a05:6820:4de4:b0:6aa:e7f9:fa68 with SMTP id 006d021491bc7-6ae828b8bfdmr4365672eaf.11.1785848439805;
        Tue, 04 Aug 2026 06:00:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm61530eaf.7.2026.08.04.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:00:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-aio@kvack.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260804125524.740996-1-hch@lst.de>
References: <20260804125524.740996-1-hch@lst.de>
Subject: Re: [PATCH v2] block: split out a new blk_plug.h header
Message-Id: <178584843869.926496.8137441533296046276.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:00:38 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 05:55:10 -0700, Christoph Hellwig wrote:
> blkdev.h gets included in various places outside the block layer just
> for struct blk_plug and related plugging functions.
> 
> Split blk_plug into a separate helper to reduce the amount of code
> that needs to get rebuilt when blkdev.h changes and to slightly
> reduce compile times.
> 
> [...]

Applied, thanks!

[1/1] block: split out a new blk_plug.h header
      commit: 758b86f7bc8a2582d0783f3535854ea05d3ff97d

Best regards,
-- 
Jens Axboe



