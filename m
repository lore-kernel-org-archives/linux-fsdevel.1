Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055502E9729
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900627; cv=none; b=jXsP8ReSdRRkTC9A0b+r3rL7kYQETE7XCEBjIreX5pxqD2R4C3yH97Eb9JjO9o7UcIyfdcSlAhDiZvd9E02KXjFN1IfU1pJDl97FiIegJcSylBa7lF5q5ptXiRXp/YmJhpEs9UuGN/TUpLOJ5p+1gvESwQSRW3Nqnl2K1tO1oQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900627; c=relaxed/simple;
	bh=FwFrEW+RURHBw7WKKqQHKGXgJDCrCvhXUxNto9nnTDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NcvZU6XIpFA4l2vdWBrxbWCwbsI7RFDXAmC61qPd/4RsmM785JBHK1GzJCq0GNfzLgGx2/6Qdy5eFWn4Ny2rKLamdeBYLJu6KIEdCcXwKfDioYNIC72z4YeRZvwmi5qoxFdTKvzKJJ2wk7RAWbrGINMvuE7I7aY0H/MFI525A0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=XZ4Bvaug; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="XZ4Bvaug"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824c9da9928so493827b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1773900625; x=1774505425; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+IpXC/tr6nHSIcVnPf5v6ih0VFm1BQSd/i2Tt2i3iE=;
        b=XZ4BvaugzLGGXtuHYmdfNPnpPUxoiXw0/ksvAjsd2my0IVaVvy/orTvyoNadJDxFOA
         xEdcDknZZ7t5cRIDz6YpQblHsXvOS2n5fpVJvpi2Df6uLiizFUfqOpnc2RwkGtj+ZBnP
         7ajZmhUBGVVfkXH0xSpNElkNCFzYle3asNl5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900625; x=1774505425;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+IpXC/tr6nHSIcVnPf5v6ih0VFm1BQSd/i2Tt2i3iE=;
        b=RYpibDKjEGvvQZDAyvvGqQvdkqFVSoMY1CvEzQUq+GRLmvY41XZcq1GuLOlLYASAmg
         eEYK02ZXgpUZm+HdeELLNwrIYQ8c861DAr+dGp0B+NILHcffS1GjOzWKsqfd9SLF+U+h
         9MYOSaJp1Xi3tSSQAaMJyRwTegxueqBdoUQtwt9B0L0PqgFIbtSyg1R19k9eFKBA5Wum
         gaRVQb+bY/qK54aBUZLieqXD1g6zd87spHkBQoBOCICXn8coCI4XQ3R28kf5hgq0cAPW
         mgHfXCXA4UqpJfb43004pq//InRVk9mOjHUXB5J/CSwSakZA8mHT0443oDzbh4x+Cy+z
         OnQA==
X-Gm-Message-State: AOJu0YwslaEwfa5HY/STCbW0+tIvnVvven+KTVYXE8ru6+0ULzsN9WZB
	rWOw2mJTBHeDaFj9K62W713Q5HUx6m5+ASEiFXWX2gGrQ/+xo9bAIjedickd7fxwFICfNsl1Poi
	3W+rd1SCFHg==
X-Gm-Gg: ATEYQzw8mipn3YB0r7jVjsNimfh9tu7NxJcuR1QtPqeCRExY6MoM+eRROmxUnGJ0kxc
	IIg9E13E4kBNPcQS685P128+alsnx8cIuV8xrJTayiPJkpJfQ7l98RW17VZfXflBaZ5kwDBogLU
	BQBB7SLa7c/+LscyP+/724zWgbQ7ln3XAH4Z9/oS9W6y7wepSutZD2XWmYaYVxDbfsBZkFW9e54
	D46P5TZwOQ5J7UxrLPZhUJGjmRFTDHgqCeX2ii6zxrFyp1O/AZ1N8PSYInGcqW2tXt56aCdI6kR
	APYhg8wP4G3Filq5gTVmSsHvRoHQyVJrM60kMYfOX0VjBYbHslBmCg6/unh7ECdrbBmjA/i1p47
	tkVVFoe8oLVoFjkRPDU9DpSFoXFXBy7QJ/tZQvYcKeAqMybVscfAL7qLYYFVl/AZuLZkjQlthA9
	Q7pkqoqZ7lg/0GdWgJRWEy
X-Received: by 2002:a05:6a00:3e20:b0:824:9451:c1e2 with SMTP id d2e1a72fcca58-82a6ae70bfcmr5551828b3a.59.1773900625263;
        Wed, 18 Mar 2026 23:10:25 -0700 (PDT)
Received: from localhost ([116.86.198.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2802sm4723004b3a.31.2026.03.18.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:10:24 -0700 (PDT)
Date: Thu, 19 Mar 2026 14:10:22 +0800
From: Chris Down <chris@chrisdown.name>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, kernel-team@meta.com
Subject: [PATCH] timerfd: Support CLOCK_TAI
Message-ID: <abuTTv9FC__H_8RC@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3 (50e3b1f3) (2026-01-25)

Despite hrtimer and POSIX timers both accepting CLOCK_TAI,
timerfd_create() rejects it. This usually corners userspace into one of
two bad options:

1. Convert TAI deadlines through CLOCK_REALTIME, which reintroduces the
   leap second exposure the application was trying to avoid in the first
   place.
2. Abandon timerfd entirely and use POSIX timers or busy wait approaches
   that do not compose well with epoll based event loops.

Avoid these bad outcomes by allowing timerfd to support CLOCK_TAI. The
underlying hrtimer and k_clock infrastructure already supports this.

With this, epoll based applications can arm TAI based file descriptor
timers natively.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 fs/timerfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 73104f36bcae..278ad4ab65c8 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -404,6 +404,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 	    (clockid != CLOCK_MONOTONIC &&
 	     clockid != CLOCK_REALTIME &&
 	     clockid != CLOCK_REALTIME_ALARM &&
+	     clockid != CLOCK_TAI &&
 	     clockid != CLOCK_BOOTTIME &&
 	     clockid != CLOCK_BOOTTIME_ALARM))
 		return -EINVAL;

base-commit: a989fde763f4f24209e4702f50a45be572340e68
-- 
2.53.0

