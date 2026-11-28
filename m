Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858620;
	b=u7rldXwrogVr/yH3d0cl1WFFa3IMwl+SlEJBGkgHdIvG+5VU6iy3AUxI0QlCdI9n43oA
	 RMTVmcHJeorkC5W9BIfNBZGbn6yfuDG4iLh567/CuRCFyoXb5yw5cwp+vGK/UPS0/I0HA
	 iO1zr5bwQZQLuAJwK/a8Qs5T7XbMWcx/n4r5PEC2l/gEiQwIQMkylTMjG5cJrlSaHi63R
	 WgZ+2+buGTT0Rmel9DukxfMVQL9pGSpTocFUVTqqjEjgRkctVFVhW3envp+NBIzHeLIiP
	 64XtcLOKjmEWwjU5iy5omU6AbXqObxgAii37d9K3Ezz707Qov4cWQCSJYiErROXq01g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 Subject:To:Cc:MIME-Version:Content-Type:Content-Disposition:
	 User-Agent;
	bh=aFuH3CwyqkMoGdxfnHGMpD/JLCCKLuO9Rr2dCftzpuI=;
	b=nmEYS3woWpTCGYMtjg5ft9r9jhj6Ji7Orx1hBC22uFyfO6lg+vdVWdZ3QigEgUBasORe
	 maZHvfByKR7vovorMpkRGdgU7lgVnpepRH+nkerI+D8bQq9b4qxsLNpLGxlOsbZoh9gWc
	 qpqycB9EjRA2D5+pgRM0Az048AKXeSwbY2nbyYh2HlfQJYMW3o3EdJfVOz1mpJatYKVey
	 JCS5GgZSIsQqkA8zqftgHM+GV9AK41CnLpPhG8KWsnii03Ls1Z7di2EkLwf9EyxXgZiMT
	 wK7LTne7zVlUlbNBtK+QcIaVkp0Vs4IILyFgMNAs9fC26am273px60fooEut8Suu+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=JikK7AiD;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF8606A31F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 09:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9CF8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=JikK7AiD
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b5981c4834so10039127b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 01:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795858619; x=1796463419; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aFuH3CwyqkMoGdxfnHGMpD/JLCCKLuO9Rr2dCftzpuI=;
        b=JikK7AiDXvJDf/ciqvCah0/KWbCdIMfKgZGcXs0V9aYVk6ytiwQ6DTBuSrUkytQBfJ
         PMzhzsA+Tt5cyubk3p4ThBmzd1dmMF9425d09sXLUjV6+8ZA347gWoSbmjGlyj6gGOcA
         mUG+o4VpqAbnIZedNFHL5fcwb8iR8lTSrbaaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795858619; x=1796463419;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aFuH3CwyqkMoGdxfnHGMpD/JLCCKLuO9Rr2dCftzpuI=;
        b=zYWnX58iVUzxvrHBBmjXrpJokQhQMOzeDZukAd3fmanR2bibvoAQofn6I5v4fAo3oT
         wHhShGBnpohqxLP3gMuIFxodwjT1kBfoXpqcPU1F80UYDvp0EzdTya+Ckd/tInMbDKSB
         2kGOtfYAnFvnFFJJF33wxjGkvyNPk+6hhojC1NN1r987xoh/HTLl1A/YEoq+WL6zi5wv
         NEMcYdwNXxWfyclt+A+u2HZmJpgUKEDEUy/whxrO6R00PZtA7rNGBU9UVJSdHOJnxHFo
         xEF0cBoDIbnTIqrXg/iFs/t4lYGgzot5j00B3kN+A+i6poIKtgR3d47HkEt1Jjdzg/6L
         vSoA==
X-Gm-Message-State: APuU4Z8icqeJldzEROXa3ZpGn4uXX6Y59Q6JMChS9RcXEtnQtjb2gEIf
	vIcvEHeFwp4ZUr0Yt6cRUlex4Wyr4sPGoPZC+NmcnRMXkH1SxGPoMzE5QWoumfMuEvrCHInAiSp
	zKq2GxBEmQNxsdOs=
X-Gm-Gg: AZFdTZcsSYWmwZDUKXQQZfDj12xy1lNi78u3HCSXQnFi05tdz4leBjsM3yG/z7TkJdk
	XCoPBAO14+aJgFNmVVT1jXjgwha8/jfWJU9Glwz4X6ebJOHtTE5Y/X5vsKgLOvBbSAcLgGH5DCU
	c6bZkTnxejGfs9gAYgMwEUNRwBR3iiniYU62sKK4J3ZOGjA859qrvgnHs757cAdGim0DB0esXEO
	kQGJJqt1Aky4Gz/o8FWapndYS19Llrjr5nDw/QTaqIOBpnO+h6Oppaoz8t+IU8IoQvr9g9IFCtB
	ikx2U+7vTOhTqO540o+rSe3fRJO5+YPSnq5WEi1OvrpQ/QjfSLmjN5qewHc7Y0/VGWNV5DPFOn3
	67Ubtk1p4RcmPo65Rmh1dd074LjSlPwPfh0d9IzoQQGC56DmN2ruU5MxhrA1in74b0QHjeaBYvq
	l1V3N2oZUQvqIBSpk1ktHumaIBRZnvojYaX7RN72xeUTyq6mFEV0kl0KV3kyQyyUJ9+JsXk+A3r
	zxtZ3+UmoY9dpSfWougYXU7B/YvvCdtBR6qMJcFVA8SAio+NmDo1qjulSMXCcNoUngIvvLpo1i/
	wbtQhsr2bIwcRuZD47geZqyE2RTmhbK5YUwK596hK1N8WtgP9I5fA/1ZtuEOQ3wOU9VviCP9fEJ
	ZAcNwLtBd/nKQ/QNZmHU7/7ZeN+TnJXJv8hDX5eKTsqx5e0Mj7fJWSWHwJMCrJ/jL+xV0kjMdYC
	36HTiKwQrLFICyr5swSYyCYSRoSBahcGTmOARWnW4lMwQwI6R8C57B07zl1KNWT/ewhDFxGbaMp
	LL8VX6xR0ya3BozpaK6/E+vARWRdqMo1ig2NAa51JIG
X-Received: by 2002:a05:690c:4a03:b0:8a8:5c3d:903 with SMTP id 00721157ae682-8b520519690mr101400097b3.62.1795858618844;
        Sat, 28 Nov 2026 01:36:58 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201ba5c1sm105483647b3.3.2026.11.28.01.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:36:57 -0800 (PST)
Date: Sat, 28 Nov 2026 01:36:56 -0800
Message-ID: <cover.1795855037.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v2 0/2] timerfd: Support CLOCK_TAI
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jan Kara <jack@suse.cz>,
    Anna-Maria Behnsen <anna-maria@linutronix.de>,
    Frederic Weisbecker <frederic@kernel.org>,
    Thomas Gleixner <tglx@kernel.org>,
    kernel-team@meta.com
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Both hrtimers and POSIX timers accept CLOCK_TAI, but timerfd_create()
rejects it. An application with TAI deadlines and an epoll based event
loop is left with two options. It can convert the deadlines to
CLOCK_REALTIME, which brings back the exposure to wall clock jumps it
was trying to avoid, or it can stop using timerfd.

Patch 1 makes timerfd_create() accept CLOCK_TAI and makes
TFD_TIMER_CANCEL_ON_SET work for it. A CLOCK_TAI timer is cancelled when
CLOCK_REALTIME is set and when adjtimex(ADJ_TAI) changes the TAI offset.
Nothing changes for CLOCK_REALTIME timers.

Patch 2 adds a selftest for this.

There are two existing limitations I noticed which I have not fixed here:

- Relative CLOCK_TAI timers stay on the TAI base, but hrtimer_setup()
  moves relative CLOCK_REALTIME timers to CLOCK_MONOTONIC. That makes a
  relative CLOCK_TAI timerfd expire early if the clock is stepped
  forwards. The same happens with timer_settime() and clock_nanosleep()
  on CLOCK_TAI today. TFD_TIMER_CANCEL_ON_SET does not report it because
  it only applies to absolute timers.
- The offset which cancel on set compares against is first recorded in
  timerfd_create() rather than when the timer is armed. If the clock is
  stepped between the two, the next clock_was_set() cancels the timer
  even if nothing moved, and a later step back by the same amount is not
  reported. This happens with CLOCK_REALTIME timers today.

I can send patches for these separately if you think they are worth
fixing.

v2:

- Make TFD_TIMER_CANCEL_ON_SET work for CLOCK_TAI timers (tglx)
- Add a selftest
- Rebase onto tip timers/core

v1: https://lore.kernel.org/r/abuTTv9FC__H_8RC@chrisdown.name

Chris Down (2):
  timerfd: Support CLOCK_TAI
  selftests: timers: Add a test for CLOCK_TAI timerfds

 fs/timerfd.c                                 |  20 +-
 tools/testing/selftests/timers/.gitignore    |   1 +
 tools/testing/selftests/timers/Makefile      |   2 +-
 tools/testing/selftests/timers/timerfd-tai.c | 183 +++++++++++++++++++
 4 files changed, 201 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/timers/timerfd-tai.c


base-commit: 0359ecff58853a491dd0f09792fea8e87235ae06
-- 
2.56.1

