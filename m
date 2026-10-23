Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784662;
	b=qhlCjzjJQUvJkF/1ts0I0g86084iYiqP35mVXn/lXkPme573C2ockPb3kOheQmmEZSF3
	 9BLYRC147oKc98SmxcWVZZJT1t+efAPSz8RsC+PbF3V01huqyym9yM7pT2Xu4e1zgf2SO
	 OOBQa6ypYR7+uMC7TaYRtxJBC3EDHOqNc8vLOuX4mVVnPe2fB3MYFO+S9WlGqtXJJp5zm
	 vhIohmbF83Tl4lsfwtvy7m8iog05QAAgr+1tZDwpnS7envYJTMm0HFVxST00CnGM8+wVK
	 L9mQOZ2ciLhUpviIBNVeiiBycgHy47gnjzvJ9c8Hx2u7WN3HUx9zFsYixt422ttOhsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mVbXnBjxDzKYkZPvUUkhvSfwmh7lftHOpNhLPwW39UM=;
	b=1KzjNEMbVGIzYknvqCsDQ2dIkDc+ftyHNrHq/MDWb1ChyU9IK/rb95dmOmOudZuoIj1w
	 yDr1H4DIxV7yBywPhEfTycUJ73K4gtz7TjLSfBN7iwWUlK4aMayD1olx6mHnFPuDe0237
	 hooBDrQKAGN4m9ZK+FbZH2kUmd0kIGtNmX9A7y3xSaQtUARRGYqn5nsz2lWJVg30H17lo
	 dgIFTCyT4T8Vx9xoAthXxzQLKp+2aZBk4AUv748cwAY5hO8oPllFMa658/4ARFz0Cy4zY
	 p1HK340cVpb8e8kfb47dckFd+e+UnagsL8JsbISvRU4KwMWpvepwmPZiWwNk01JLjzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fxevVrmN;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B7606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 19:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC2B7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fxevVrmN
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso1734887a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792784660; x=1793389460; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVbXnBjxDzKYkZPvUUkhvSfwmh7lftHOpNhLPwW39UM=;
        b=fxevVrmN+qQk6z4wdz+jRQcpYg24sj0t+ofO8nLsLeiFi+DqBI1COHGX69UHrqwohA
         9O1JFU+0OJd2Zlr2r5F/zVdQDbNx9DiiEpEuRENw9os04R0OsG90xF9KnONZXxUpM0NG
         lspPLsuq0W3lLyFJ5Zj7hAMvOoR7NsDDudPac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792784660; x=1793389460;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mVbXnBjxDzKYkZPvUUkhvSfwmh7lftHOpNhLPwW39UM=;
        b=OL78VJX0yYQh0QhWczNVDc79q3AU0YOkF40iIWONCtsAqs2WEdQ5b34edunORFTCnJ
         qpV6eQ95qUN5DU5NGBWrozq2jD3pLJHE/BTO5/vjBzdZSPYeZRf0yclIz5QaLDp/Yk6j
         wgyBY1nnntn9jizunHug3mcsYyOKd0qMtFgNY1oOlFMzh8dqbhYvgy8RaqjX7sgxQcLx
         kjUtGzHRyBUV+bX3dmuicyXYJEyllTmo+OWrKzgNHKYrJUoDNlV5iXYilH/BRWQMIDXE
         ixgn1m0kTB75GfLztyQV/mp154b0dKFDA8l27AurpUH14DGuOm1gB3PZ5kPUS63+JU/J
         XHBA==
X-Forwarded-Encrypted: i=1; AKwUvBwRZdOeGR235DGSPPgG/1erh2PZLXpmKMHH4m83GCZudIdzn4ISBXHCMFPy89898qY78Ba0YVL9nWCMuFwH@vger.kernel.org
X-Gm-Message-State: AFq9FYLSBzEyTqiKEAqcTY8clq6/suDcoQfH03mOtcCJlUZ60f7X4dJg
	Wj/TjkWXePqbNSncZJ1RqY5pBAWXwkBk+0SU2Tg6DDK7woAt6+TwHgCxD6/5mhr41gjnn4wH0Mu
	YlQLsa2Q=
X-Gm-Gg: AYBFou03Ab7LXLvxFl7nfZ43q1tcesHOOUW3rHJa3rMLfzSdnct7btB2lZUxK2pF4CC
	fnxLsWf//E27i0f3VOqSM1W8fsNaaO+nPVm+lQfkkOjZpXxQvDr/pWbIuwp8u4pULSnuSjDr0YN
	rcXWTGKwUwoRS2zsOfhRO4EXyDmQNtbfYlkZoqJmpMgjeIJR0IQ6UJ3xwvfxrNnzK6gWtkmW4gJ
	X/r8YAS1ftjGrrYdfbiUR9k/rkEvvikYHH5nzPjBK1UOzR01lVvvJ7vm5Luly9X2wgTO4PecNfb
	eHBE+n64YHU/G+8/zPHbckQ2m0htumgS1UupSaxCXdhzIGsnX35+opdMBrNvgjpsfRfeP3zWQdN
	a8MdmWYwD/WM7Z62VZ1I6XqAChZMXSk8utxro+XiHf7kl3Ti8s8SeWF3567S8lumh0ZDSIYToic
	8+HiTaEFmvaN26kP7xC6vy+Y7SkJwKK17Kbq4UWYkmzpp6gTTCFOhd+B2IDVrZdMGlSXLR3QdsY
	CbTGlkVMqYBONb6DzRPglA1YM0QWDnFci9YDzl2XUFFGjBJG2iOyFpKiNJiAqhoK3+6Gix3vV93
	hzTAzop7ddsEI4grIvYDCRr8ovu8fqY=
X-Received: by 2002:a05:6402:a515:10b0:6b4:2fc3:7d85 with SMTP id 4fb4d7f45d1cf-6b442fe9a23mr181282a12.26.1792784660161;
        Fri, 23 Oct 2026 12:44:20 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44212ff15sm208872a12.32.2026.10.23.12.44.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 12:44:18 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso176576766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 12:44:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBztBKsxrpRpV1YsO3OcodnTZtHxw1Bh81CpiMa9TuWj0fTg9O8hkhIyMtJDshKfTA+A0yxAYJ2aqHcY+a5Q@vger.kernel.org
X-Received: by 2002:a17:906:c114:b0:c2e:5efe:f1cb with SMTP id
 a640c23a62f3a-c46a906cf08mr483222666b.8.1792784658608; Fri, 23 Oct 2026
 12:44:18 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atdn5xA9AZHAWNsM@hobbes>
In-Reply-To: <atdn5xA9AZHAWNsM@hobbes>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Oct 2026 09:44:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgjwxSCDQ7VhH5NgHSK2RG+9tDb=infbWbgQbWWHjVbow@mail.gmail.com>
X-Gm-Features: AclHuK9Mh6sUKYQ2dknAEL4P43JX1aGmqjH66ERkCdfbwvVpbQlUCwKUI7maYjg
Message-ID: <CAHk-=wgjwxSCDQ7VhH5NgHSK2RG+9tDb=infbWbgQbWWHjVbow@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl changes for v7.4-rc1
To: Joel Granados <joel.granados@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Yibo Tan <lhfff@tju.edu.cn>, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 03:09, Joel Granados <joel.granados@kernel.org> wrote:
>
> * Disallow partial vector updates
>
>   Stage sysctl vector writes before updating. Removes the chance of leaving a
>   sysctl vector partially updated due to erroneous input. This is not an atomic
>   write; a concurrent reader can still see a partially updated vector.

I've pulled this, but this feels like it could easily break any number
of random scripts.

We used to just update until we hit an error, and I would not be AT
ALL surprised if there are scripts around that echo some
not-entirely-cleaned-up string to /proc/sys.

Put another way: I do not understand why that commit claims that the
vector data should be unchanged just because the Nth element wasn't a
number.

What was the impetus for this change? Was there an actual problem it
fixes, or was it just a random decision to possibly break user space?

                  Linus
