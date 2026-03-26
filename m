Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3F4035D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542753; cv=none; b=egMII8eRVSyxWlcR1UWNKrDaacWwoncRP8J2TQIa9jUkN67uamNMYAW1chYMy0wJJUMmQr9NEXEDsS+sA43Ut+bjZEyYtASUUUxtXRUCQq/LrLKn7zcijK8/JnPJPs5KMXngAla1IPGzIr3Y9jrPJ0Pd11IKnwNSuYhMPcuv+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542753; c=relaxed/simple;
	bh=Q4c7/7zN7xJWbJCwdIxXOXQsNwkLH+bjDio0p+RopfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPXMZuUQi2p4naBtqNJVpUQi3JPHwIZxfEUncxmTadByJ4zz+r7a2HnRT3JI+pZzaxZE2FsNDZIQqEDYHp1WewnwMQyWTMrMvSp5Co8iDibF2LQv5PwmPhCW7ffmRvCUXBSxCTy9AX2wNzYdrTnIIdzi+42+lu6UY87G1fdHGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kq2/ozxD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kq2/ozxD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so13793665e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774542749; x=1775147549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zhCL64yvsuoLg1TgzSSen+t2xC11oYAapBvJbYAT/Y=;
        b=Kq2/ozxDrXySnpzf8fhc+YZxoUJRhic0yYUSN5VDJ0y1zrTJPw8PEu4qoP7ALWzrOk
         Nc0VIZ8H0rr8F436QqB7hBf17yZqdsDFnNvgEkLOxwHWIWzK68ciH/+4LWcvG7gBZ4n1
         WqCA6deV+20wOmw1F15KY+4WM15WlwC4kyglsnXO+MYfbfBVZ3A4DN5KSn5Rg4Tadc3s
         SkyU0288syFJAtApmsyAbhziOJTJ//k5Y7tAsyarE71AZcgFV1Xwc2PkOqUbB3/THbRW
         EjkJYW1cy5312d6Yo2N5In4+KBfwiVs0EkeKEAb8olnB+xHWx3teOM6PMAvF4eAeybRR
         sbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542749; x=1775147549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zhCL64yvsuoLg1TgzSSen+t2xC11oYAapBvJbYAT/Y=;
        b=l7YJJXL0gy6Asaxom2I5YTkVcOVWkOv9nK30CSxWj8K4wXUhnPg5iExVtmSfWV8DfH
         hhdV7COOirmXEQz42Fx01t5lYPR+zeYkez6TFY76KJe/D1sNY6u8Z+j53Z1L2G0NsUTs
         tpLsaevUhG/2N1aofobAZcBhjMyBTPA/I+E3Voe1+tL3WhSjCGccE61Xw/dQJ0+rfEkI
         3lrgScTsJ5gli+1n0nStMhTDIHDByLOriWqC+2ZkIX2//pFqbITXLw4NZfAEp0oVpySM
         Rd7IGNqM6QfRxMJBZfb6IhpUBAes8IFMvziQ6IxXHTw4T026KqVe9lhaOcD1diA7jdhR
         k/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCULozn6a1laVeaRdunYVAeQdiEcdjFrIjGLfAzCbmWtptpj4FsowXpKWvhwwRDRcJntiKo+KKteAfVMsj89@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaRFwWcVDtzLUP3KcLDws9QoFHs5XJBLMWY9wCoADDlVgs+/g
	5+C5nVB/+7zzElfvoXHyaujxDm2/Ow0zRTY5RxSk8yEovoIkE83EZVeuWtzzAaZMNTChyfJ6La4
	6eUA7
X-Gm-Gg: ATEYQzwEcv9ig3iDfyBTADLQFNY1P6i3Bj9vdaqNfLGhmDR27+mLrYDQn8JN6pHlzcF
	8x+kyWmWD5DetL7YLetD13KaeVbM9uRPxKjRzS1iv9ySl2NflZnvr9Rlp7Fy7DZ7+0uszUk1UE0
	ZMpofMyQcGkGTuNNUWgjk2hbTWlRucNvjbGE+MVkbI759GVICW4Web/U49kfOuNzfyQ8FM9eWEe
	mBJPVcdq24OX5ZyHtaDmJvL1oUEvHj1VTyyPzjzUC/7pd8enS3B5c6yMH8tjyPPPNkjtsTUBVoo
	3oC+2V5/i4uZuNedNAxLMWJ8JaKgMvpNLtMFd/eSBN/mbq/u+lomjKVxAJJ1DDyVFgMsbCUOmvz
	fsRDKnWO6ZOmezPDDlpvDjQo+/GCKXKABjb9SdW03Rez3zABmqAsslVnWTUsm+SqBmvqMVOk1q7
	4zAZNZC51em3+oXAomcBeRi09fqQ==
X-Received: by 2002:a05:600d:486:20b0:487:386:3714 with SMTP id 5b1f17b1804b1-48716043919mr93799325e9.17.1774542749342;
        Thu, 26 Mar 2026 09:32:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725ead058sm158665e9.7.2026.03.26.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:32:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:32:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/6] vsprintf: Revert "add simple_strntoul"
Message-ID: <acVfmzcIR9-UAAkJ@pathway.suse.cz>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
 <20260323150054.3587083-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150054.3587083-6-andriy.shevchenko@linux.intel.com>

On Mon 2026-03-23 15:54:21, Andy Shevchenko wrote:
> No users anymore and none should be in the first place.
> 
> This reverts commit fcc155008a20fa31b01569e105250490750f0687.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
