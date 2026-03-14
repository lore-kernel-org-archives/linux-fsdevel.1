Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E624BBF4
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481057; cv=none; b=SLHTgnMjeAr21qPj4HS0tdbz4rHrjB4G4fOJdlBFMlBVU6gB9Unzvs+QToEhh8CG74kAIMpP5XGLwSVUn92tTxOsN5IXqYa210WTtH31/uwKqXT1gCfDqDG9xt0tZhZgE1C2172NHUgx3+YiIJdFvee0pphuOaVLiE4DIwi+a7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481057; c=relaxed/simple;
	bh=PW82vmyUoBo5SVpPvpbFQcYkYuhkW+kzsIfiM0ZCnUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPKmz+69iUhxHXeXZWBLERhq6mkR4eSR7Pfs1dZ/rw/UoDLDvTEV54E9tvspDG7ihVNrEAIqc6dhQ316ueADc8pCt0w6KjnKWOF6lk/7T8MZ1akf1lfQZCUP2LUR3XwOrxF0CRNyvgxmpbmPDNInixhxysdM+LUOQUEg8XPWQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BCtUQJE1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BCtUQJE1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso25460145e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773481054; x=1774085854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxsA2YZ471Q/xGiQuKEeLiqvlRJiwCfIC45xI+go3Hg=;
        b=BCtUQJE1Rhvg2C17QMxGnp6flTDLEW3x1RPaYtxhVGqxIE21LJeOMOkPUHDuJLIVRA
         O/1IssRmLAFe0LXojhHfrt7WeAmvyXb631QakA46BvEt+RB+pIZZ3x5OjfKQaMPinTA7
         NBPUeweElMXn4MpSyFsQLtwGu951wZt6f8rXmkYGDCB5Km1tvd6QbYuFv2ikAN2UQ6d8
         VFhwBMmMK2FmeCyVpd1YDD3iazX/heb7XsrMGg+2WzCZrrg9hgU1nForLEaHiXlYOOe9
         OSusbP5LQrXZQLhJv+3QCTAVbePFBqgNEymJ+yHJJfmW2+n+v8enwMmcY5Mm+bUjtsj7
         Qb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773481054; x=1774085854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxsA2YZ471Q/xGiQuKEeLiqvlRJiwCfIC45xI+go3Hg=;
        b=q2/DHW5lv1rFh2T2mfZ1ELa9upjkaVD0uscxo9pOHrt++9INpBh2km596BsGjcU0s2
         GLMXG75MLpLgfE3rfBBVPZxKlJq+zx16WL3lr0kVO1q7lAwRKGE4YKZkjFblhlqnsfrL
         /J0EXUF2Uj05MuWPnY3c1xPEqiQ4Jv6TsvsiF6ylp9OPckZbqRxTdXJU9eKqEhrQ3swb
         gyujlt5WbKZgWmO1VVPYNS0dF9wyMjM9gqINkP+jxUI4fp8qlnW+upZe7Jp/oXtpFPw/
         R3RP1c2mPpvVY0DUuILszW8noG92/C2NdFGsvo6xqn9UTICPuI8UPVe2rPRgvUf9QwGd
         J7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXofWfmlDDeoMDJULsI72NK65ee/KBWPLCd/YNKDw9l7wkwpOugh3YfWVt0yN+anhyLJhl08ff9miEiFV2z@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXaxwTn/V/vDpaG33NTV57y8ZdD9+3Fb+VhEcpP4ECsl1bpBU
	Il1MlMPUGWkOBOenVzDY3JgQxq2iJ5f83clRGRQzh6DXJbUx/xoYMR0K
X-Gm-Gg: ATEYQzxsUzOBYEHG9BP609L05OHmXQ635Tfff7DZXkAau2yQq4VZOsTzEY4cf1dJ09W
	mPrpjvNqDgIn/0Q8+5kP+bTYBnQsC34RgVEeJ2NCLLfpeF9+ivjRrctcl4eak0J3uRSAXfIihg7
	+sigXP6HWpY/8+7ouk80kz1aXLi5Gyn8TofmN0N3soROGMh54Zq2q4RtLlz3YmTT3ujnX6YwElb
	npS7S4u1BkOXLgX+ujQ1j9ngU0Flgf8k4s0/tj4Iv2fi84buBwTNlbVLlGDLVoIl6ucmSIAhQgN
	i5xT5Lqo53DpF8g+ot5326ACyEFV2MK/dgIClG8bE0jg74e6vX9FlnDEw1F0uvObbcl8dItd1yH
	y3Gp4SElkQDY54YMlIklMRbz+A4IQfOxszVEDYmuXm+JxQelKUqskz+TgDWLsEQvMZmoRHEQtaT
	4u+ibUDgz2Z5p0Nu91+ij4vOBq9zavjZwG0LARN6obyi8=
X-Received: by 2002:a05:600c:1388:b0:483:badb:618f with SMTP id 5b1f17b1804b1-485567050dcmr98705965e9.25.1773481054070;
        Sat, 14 Mar 2026 02:37:34 -0700 (PDT)
Received: from ccde1gl2920.wdf.sap.corp ([130.214.226.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c89186sm113974345e9.1.2026.03.14.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:37:33 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
To: ps.report@gmx.net
Cc: buermarc@googlemail.com,
	elias.rw2@gmail.com,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ] sysctl: fix uninitialized variable in proc_do_large_bitmap
Date: Sat, 14 Mar 2026 10:37:25 +0100
Message-ID: <20260314093725.12429-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260313121708.137dae22@pc-1>
References: <20260313121708.137dae22@pc-1>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Peter,

Thanks for your feedback and the idea. You are correct proc_get_long()
does not set @tr if @size is zero, therefore, left in
proc_do_large_bitmap() should be zero when we expect @tr to not be
written to and c still being uninitialized.

> Would the better fix be:
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 354a2d294f52..89db88552987 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1427,7 +1427,7 @@ int proc_do_large_bitmap(struct ctl_table *table, in=
> t write,
>  				left--;
>  			}
>  
> -			if (c == '-') {
> +			if (left && c == '-') {
>  				err = proc_get_long(&p, &left, &val_b,
>  						     &neg, tr_b, sizeof(tr_b),
>  						     &c);

This would explicitly fix the problem as it enforces that we only check
if we know c contains what we want to check for. Fixing it like you
proposed seems better to me.

I am somewhat conflicted because leaving c uninitialized allows that a
similar problematic access of c could be made in the future.
Initializing c could prevent that. I also do not see an immediate
downside, but that could just be my naivety. Further, that part would
now behave similar to when we apply the default hardening configuration,
if my understanding is correct.

On the other hand, we do not read c later on, and I do not see a reason
why the function would change significantly. Still, it feels more
defensive to me to also set c to 0.

In the end, I am not so used to the kernel coding style. Is there
anything that can be argued against providing both? If you think this is
unnecessary I am happy to follow your reasoning and go with only the
check for left being non-zero.

Kind Regards,
Marc
