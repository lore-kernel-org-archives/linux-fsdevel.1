Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37138BF70
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604433; cv=none; b=kLBKSPOXhIwHheY6Lyonjs09fJpF5xD0ghgf16TH9z91ygVeZRqR/SYgZkGCBvXV93yFGbz3a6aEsMHN1uy+0rSf0viveDYf6XdnC5TgfGpzFgXCKtjedci15m4fZhQfdkf98s/fKT6XTw4HKbkx6Ksasd4uZiVeSPUT9APQQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604433; c=relaxed/simple;
	bh=FQrmekMWbuiLK5C1J4UYDdC9tNa6lUAtieEGAoZQP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnM1dnTxy4rr4bY05YdVAUf64MQICDkj5XyIksssiE4Z1eY74gl5tPeoYKl+z1+ZvxS/r+0hHUqQZpzIwA/qKFbDCZQHyPwSD8a3bkh7yTA1qF1FbSZkeWdkCicxKXfBlWb0Tp42x690WA+6youR4ow1BgZQh7ggQn2AThFYU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codepure.com; spf=pass smtp.mailfrom=codepure.com; dkim=pass (2048-bit key) header.d=codepure-com.20251104.gappssmtp.com header.i=@codepure-com.20251104.gappssmtp.com header.b=NcrzjApE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codepure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codepure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codepure-com.20251104.gappssmtp.com header.i=@codepure-com.20251104.gappssmtp.com header.b="NcrzjApE"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso1199224f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codepure-com.20251104.gappssmtp.com; s=20251104; t=1787604430; x=1788209230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8B1ZGEXjdJb+smWWefT8+0xp0stSpUkKCGsd/1Ej9I=;
        b=NcrzjApEEt873RVXllEK62wC4wplxGRo7xAuKVpf7FbMSs9TZ8aBVaHr6oa7/zcxhG
         4/yYkDNwa47uDM8voLa8PuQVokK1XhKlXZ/bOPg304FJswSlWfHB1JBI99JT3pijxO4l
         15s2H49moR6pfofK1txixU4qZzCthkLUBwGL0YcoI1oYOiEewiV0Mp21QIOHONuMxtpe
         atKI8aRTGZoykPDFO53ClzTyHthF54KbWQl7umbO0iZ6lcSnOXbOukubMIeAMLUUhbD+
         Q/WQDAq/MGw9F2viVkr5ZEfmTR5D70Yyg3wFVoXirBXMdyzFGUIUYKok9L1xt+tA/c+V
         RkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787604430; x=1788209230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8B1ZGEXjdJb+smWWefT8+0xp0stSpUkKCGsd/1Ej9I=;
        b=JKFevJQgHI39LM/KYROqzI4pZdZbOQNPkbunoFkLW8TAdShrWNcEQRmXGN4W/HYcbe
         bgYr8hxWi3DtbiX5HjU5FxURTfN5izCl0F5aHNl7b7W6+SZEmzgT13rapkoe9S0acfRE
         lQqPrhuXWQIoeLlTHj+e0eaT+NNhFXUPmyzs8m+O/XrI1WRP2rFJQTL6lePRo0sX+IhX
         Ey1Q/ZbVL6O8CLHUsZvovJt6xbC0LZheRPQiAQXBk3Km87Ci+9F/OsAqX4yn5QrYKVBF
         DX0/XxWMPbZCnxbKyKSYMyfDxsz1wz1J6PrLk1thcPHTSc9OQIWiK7beC3DJ7wZLDmGG
         GZuQ==
X-Forwarded-Encrypted: i=1; AHgh+RopwDPgRY0CuuhDdjbLQpGcabCQO9O/CzsRkdNFS9dbOigtJ+kmBIX6I8pTysc9+hBoY44xzXL8fUckcBfN@vger.kernel.org
X-Gm-Message-State: AFuF++koYoS1DF/cwMSOU0apxAlPurOlGQ4wymANKVu3ruARq4t9iRA1
	yfvz+6eB5Dxwxvxgtx/NVDJf7Zbeoy83uSW/NSRk9sScrm+pN6T5mQMi+2ipNAAwXk4=
X-Gm-Gg: AR+sD13gJZVmgTyRRvbE/lc/0gCNN5UajLnQWDEIyRcMLGTQo6z70QH2Er62nr0p39O
	jdxfm6fyUMihgSAFuRZoF9Hju4ROXS37ECgwS9GJZCFf2NW04OKloe9SL1WN1JG7+fvLJvv1YFL
	Bl+fyC6A7i8Q1WLIF4gAA0WU9IXt8jUIsfyUEPplFPT5/UpzUTsXqMAswG2mP3dCyJTmjWUm+n3
	ZFHcPeef69pq+itGL9lcPt/FPsbNibs4TXppH1c6uN/67Vyda4IdWErsZEwKwWylnUH9rMaAUCF
	vG3tFAjofzs8xgdrfpTE5SpXrnwhqIBr6v9Ua9mNhczzEuugj6iynSmp4TDK2i0HHBnIDdSwv4h
	f9d0GzB3P8CRAQ/4ppl847MZ2FIQ7N2JU7o9ruTonUlnew746+hwlWKjCvIujiAHoAg1c25m5hJ
	UJiTmR7GJJ8LV8iFKxMh8s+dsu5ntpuk8aGEpS6wncPz7otDQgY0cPf9suAeq36sZr0RMkDQqBS
	g==
X-Received: by 2002:a05:6000:718:b0:47f:95e8:2ebf with SMTP id ffacd0b85a97d-482c814589bmr28199685f8f.12.1787604430306;
        Mon, 24 Aug 2026 13:47:10 -0700 (PDT)
Received: from pc.tailb940a4.ts.net ([2001:16a2:cf84:7100:a82d:c226:a397:9def])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78d6bsm9141873f8f.11.2026.08.24.13.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:47:09 -0700 (PDT)
From: Fahad Alharbi <fahad@codepure.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	security@kernel.org,
	Fahad Alharbi <fahad@codepure.com>
Subject: Re: [PATCH] ovl: fortify ovl_copy_xattr() against underlying layer modifications
Date: Mon, 24 Aug 2026 23:45:31 +0300
Message-ID: <20260824204534.1951414-1-fahad@codepure.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
References: <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: your patch fixes it.  On v7.2-rc6, FUSE probe LEAK -> NO LEAK, and the
unprivileged tmpfs racer goes from 78 of 5,000,000 copy-ups leaking (5 of 5
boots) to 0 of 5,000,000 (0 of 5 boots).  51 of 51 functional xattr checks
unchanged.  One behaviour change worth a look: under a racing lower fs about
6% of copy-ups now fail with EIO.  Tested-by below.

Your three earlier points are taken; hence the shape of this mail.

Setup: v7.2-rc6 (075b74841bd0), your patch applied clean, both kernels built
from a byte-identical config so the patch is the only variable.  I checked it
reached the binary rather than trusting the build: ovl_copy_xattr shrinks from
0x504 to 0x443 bytes as the grow loop moves into the helper.

Results
-------

  test                              base            patched
  FUSE probe (hostile lower)        LEAK            NO LEAK
  unprivileged tmpfs racer          5/5 boots       0/5 boots
                                    78 of 5e6       0 of 5e6
  functional, 51 xattr checks       51 of 51        51 of 51
  termination probe                 0.100 s         0.101 s, EIO

Before, the upper file receives 6b6b..6ba5; after, the real value.

The EIO path works as designed: against a lower fs that shrinks the xattr
between the two getxattr calls, the copy-up now returns -EIO in 0.101 s
instead of copying out the unfilled buffer.

The behaviour change
--------------------

Under the racer, on 1,000,000 copy-ups per boot:

  base      ok=1000000  other=0
  patched   ok=939548   other=60452  (errno 5)

So ~6% of copy-ups now fail rather than silently copying wrong bytes.  I read
overlayfs.rst as saying that is exactly right -- modifying a lower layer of a
mounted overlay is undefined behaviour, and EIO is the defined detection --
but it is a real, unprivileged-triggerable failure rate for anything doing
copy-up over a changing lower fs, so I would rather you saw the number.

EAGAIN=0 on every patched boot.  Copy-up latency max 44-48 ms, nothing over
100 ms.  No BUG, WARNING, stall or oops attributable to the patch; the one
"Attempted to kill init!" trace in some logs is my harness shutting down and
appears on both kernels.

Two limits: these builds are CONFIG_SLUB_DEBUG_ON=y, so the leaked bytes are
poison -- proof the memory was never written, but no kernel pointers in this
run; those came from a separate non-debug build.  And the racer is a
size-flapping tmpfs lower, not a general workload.

Tested-by: Fahad Alharbi <fahad@codepure.com>

Reproducers and full logs on request.

Fahad
