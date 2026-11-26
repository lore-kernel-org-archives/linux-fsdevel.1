Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672866;
	b=yelOtHH5+ep69JqkTJ7wXGS4dAusIOT5mz8NfMO6fyuNMIj5hfLVdIHHt/cy9T4OGA2Y
	 uP1JKN0/mEfVl+7JIfHdsT8NryAgV2ePb7dY/BVcBnuL5YDXH4W2fXwTEDGpvEmeq2mct
	 Gq19P/YMbG67w6J1QY+0Js2+3928e+0Z42a7Xz7W8Nh/IlO16U0WVe1qaeLkG4RYgfZ77
	 wKSZ6RHdZUIsO/XfCqhvfYyTDhCtPhyfTw2HDcfIkakh9VaMZoIKrlw8/yPUr+ueSQ0d5
	 9HzsQm2cXRDnVbjbIkpSOYbmoelv+um3HPA1U0U1bF2aXJo74b4FffkqIS9iDudKmFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=noZQpOwfLBmz3TPp2KJmxS4eR0zft1CATjF4Oh8nA1Y=;
	b=sgmpT+cnmol1xAPE/w7Sf+5SsAL+sbZFRDOtTucWR0fTRZyytGtkyIqOOwJTshfx8b6J
	 cif/y1xLoI1xvpa4rLCBdGOxCdbwXnlC1P4nhStNKF/T3IvOCoV8fnevgVYqCWjLThh0p
	 +yt56Vn8Hz8/Den8W0NwcEPz4tOeWkLqnWcAuFDRhT+wVRRuU+NMZYCNZtCe2rD9mX+we
	 KAb5V8EwXMfuTg6kxBZawOAmX8xdE26WTjXDwSbn5wR0xkh0c8Rwj+IxUcuqGseecs6jF
	 QeQJkplQ/HSck+8pj+UoSQKTNJ3vri7uug/ydb0CTjQBSZP6SsAQ7SAFBIikc2U8WSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwKMnaF4;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643D606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 06:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9643D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwKMnaF4
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb606491faso34798025e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795672864; x=1796277664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noZQpOwfLBmz3TPp2KJmxS4eR0zft1CATjF4Oh8nA1Y=;
        b=LwKMnaF40gf2NenBXd9HKjJk5NoW1bd0N0ZWMM3TpugQG/lZzB1W6d03tog5bTiLqe
         0Jvfo/vFCCLvRGpI562On+rVz6xBFos3VbGVKjMbgwjA2dm9AX61nRdbebCiA2kOJ1Ek
         LJkKEG6J5pAIyys9SO3fl1X+FbVOdv38Qz98IARCZRsxnDEGCM1iRsa4VBblcseyMJVX
         kJH3BAT9gYcIOmeX+yqyYXFkWpd21tw6Jx7rNhSzRLvlxAhNA4MegBpp8DaLs6RD8waG
         oMKYEpCN2j1XC9VvBj+8DnyA8b2+d19uF9kvyPrV7rv0y6Bg1P3ju/HNvfo4sgBdaS3m
         736g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672864; x=1796277664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=noZQpOwfLBmz3TPp2KJmxS4eR0zft1CATjF4Oh8nA1Y=;
        b=AGAq3D6SpPgENQXZ2WwmAxdyFmk7VCX//l/W1Ve4qFRZLGFGGSfzFCCYzIQm7QVNgd
         mvr65dlHXn9kLCqe7A2zGvN/Ya3YiRXy6EeXiKsQ71hIXElnsJkET9KFwpKoSJPofEBE
         UE64HcgjPq0I41MUk27/j7bJN+f49Sqj8iV3zHC6I8Cd8bUXC/MWQpKMTSoOCxNlCvnr
         T3l+haDxkeh8BL0wipHLJ5LKNDp3ucve4fj3oLpGfMUg3BAZhLO3RyMMdQIBS+liUPGP
         ke0wBkHATbkEa4pDoS+HQgv6byLVy1Dsy7uaVAAaAYlOnayGg45QBw7/QOo9OeVYekyd
         0ZDQ==
X-Forwarded-Encrypted: i=1; AL+hErHnHp6b0o3rrQkYJROXNNTHxtgjFuDuXH9na9uEBKjukro6JaNuzhL8p5wYSq2sEVaHK0j5ghLiyVUSUgWn@vger.kernel.org
X-Gm-Message-State: APuU4Z/SEqulyqa7CuHAjqg0/9oOE7y+gTSQ3hDUjePtggb4Bybv+//L
	hms0sOG7KYLxuCn183SQSyOL3W6EQutJc1FCxcceQAa2dPWiMcv9WRzjRGQMYJDP
X-Gm-Gg: AZFdTZc/MIeodU8AQ+0DZwZ/cZryYM1foKgbnyeLMH40e8K7FdFWLqING6ipcw0W05c
	F+oEeNC0OkSu0I6oU0YwJFno6YK1GjfPphKaxeE52kph8ykeOMcMUzeC0UsJEExsTUHTH3ePJXI
	0FqTI7Fd15PZEFUQ2UvhkmO/ou8Bf6JUJrBLEk4PyJsaOvMnR5r1sbgS4ezG1r9FzZ4iB/sBTvI
	bUnyjN0SqeJp2YKnXQTuPISWV7kH6l4Y3yZ9WyHU/59xgqMQVDUG+Oxqy3SdumYAsSHMovIaogX
	kEm3feQjcUXH2JYVwKYpChybZCAIk3gLctjBdaA7bxKDX2WeT88OP4R+Ogdmrs5SKEW3s+DlLOn
	SOO7rDAPdZCqWRVWltRq8vfYxSR1NXGdQCarU5JRl93+aCKbGIahj8psyHJzOHsAcOeU8xfgD4p
	XPGdEUwOIHZqI5mwZUvIJeaoUO6hDMfBgwjI/GmjRr1cI7US49AjaVUMJxBQT+n6xCzC7kfHyJE
	9MvSHbAXiWf+Va+lKc1MSsooJDUYpaeROoEizzhZ0PhoIchWMatmafmvj/u5qT5zOaGADzwx2wU
	4aBDWC58cGCJS20jJDSPsbjHBQ==
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr451553765e9.10.1795672863649;
        Wed, 25 Nov 2026 22:01:03 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884911e3sm697608555e9.6.2026.11.25.22.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 22:01:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: josef@toxicpanda.com
Cc: James.Bottomley@HansenPartnership.com,
	andrew@amutable.com,
	brauner@kernel.org,
	jbingham@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sergeh@kernel.org,
	taherafahimi@linux.microsoft.com
Subject: Re: [PATCH RFC v3 01/90] Documentation: add a design document for cells
Date: Thu, 26 Nov 2026 09:00:54 +0300
Message-ID: <20261126060054.2554394-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-b4-cells-v3-1-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-1-bc9095937a84@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Josef Bacik <josef@toxicpanda.com>:
> +The mount namespace stays owned by the user namespace of the builder.  That is what
> +keeps a task of the cell from mounting anything.

fsmount creates mount in anon namespace. So fsmount is allowed?!

> +not poll readable, ``PIDFD_GET_INFO`` has no exit to report, and its ``fdinfo`` says
> +``Pid: 0`` and not ``-1``.

I don't like this. PID 0 is idle process (swapper). Let it be -1 or -2.


> Nobody has to
> +wait for the task: it is reaped on its own, and the pidfd tells how it ended.

I don't like this. I think task should be normal task, which reaped normally.
If user wants the task to be autoreaped, then let the user set CLONE_AUTOREAP.

Also, you said "pidfd tells how it ended", yet your later example reads status
from cell fd, not from pidfd.

Anyway, I think that we should get exit status the usual way, i. e. waitid
on pidfd with P_PIDFD.

> +   pidfd = pidfd_open(cfd, PIDFD_EMPTY);   /* no task yet, the caller does not fork */
> +
> +   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/usr/sbin/nginx", 0);
> +   pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "nginx\0-g\0daemon off;", 21);
> +   pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, log_fd);
> +   pidfd_configure(pidfd, PIDFD_SET_FD, "2", NULL, log_fd);
> +   pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);

Does new process indeed start with empty file table? If yes, then also set
fd 0 to /dev/null in this example. Usual userspace programs are not
prepared to fd 0, 1 and 2 to be closed.

(I am human, not LLM.)

(Don't add me to CC for next version.)

-- 
Askar Safin
