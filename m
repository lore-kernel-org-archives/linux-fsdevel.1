Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327724414
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771717567; cv=none; b=bKC1vB3ePE8dRO0X8KbwPC/STVqTksMOViWegTuWrOIrfJzik2nhAUISwYxz+gBljeAhqoRHyQTgFpxWqtxbBhnaAy9W3dSxlBzaXYIT9/bO6fyP/1NpYtA0yFqoXy1TlCbmcRanuJ2/wSQALBVUVGo66gFK48aWbpuO7IIfJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771717567; c=relaxed/simple;
	bh=D8wEA4P1R/wLC0WQ2gaxmvJV8Zid0j4uMfM8HtVxkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txbe4BPIYiY4rEd06Io32cWgN/EVyCaGGpD2ehqwM4f2y2YBg7Etaw19yfLUeBIEkABybdgRNGURiHEwupLsNkUZ7liTPQih9sXzlRfs2/gGjFBFVLQ9xhCtxsFwhOkn2KMP4/bxuz05/9O+yH7moQkERCW7OsyK6kSDz96SDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxWuCmMl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxWuCmMl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso23839315e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 15:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771717564; x=1772322364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=hxWuCmMlxuj3d20al60XWs0jh2KLvmk0/jpM7jG8sjLtUj+ARfwmScdZLER6DpfOAs
         J8nWVO9IM04A+Qm71FNtsxpTM5ftoWYuG5CoE6iS+dCZ9RSZYYoP+pmhOyAgz70sC2iv
         LDvuveFZpQZy2/IC/wLc5I7ZkcufMPCm48xDHV18rMz3EllbndGCICEYY+zKzP925M1P
         L1j7TU5F2mxburUB6vGNMZfdQFHuZXWbh2ZEHD6D3l3MvO7SPXGiDAny7QDzYV1siVBQ
         FXjjbYA1cLCF3c7I92iQNDo0U9X7Emu0pfWIOGTBeLkAV5YK+VPmQv02ynK/DYnajvGz
         T9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771717564; x=1772322364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=msGDVj9/x/x8bfjF+xk0LKpUPPubshauIhQWNyghc0Psd/UiRK0P1aSiUg/eVJjxP0
         FJFWFRwzAt/yY9Q+Qhwv8qbooo05i9w+d1lFS9vAdzIuP5rSaPvtE/Hw+e39G1rcqG+g
         lPJpdh+AZ3fVRfRTjcXJeDm3PqMd3wPEMQ8zUgpxgk5tKRP/8DtFb0MECpMjOYZlJjyi
         fiGLXixHSlBiBaIDZQ4E18e2Na7EK8Evs9zl8Gg3571rwejqhh5NWtQTFbdj5U4ZGGXm
         cedXNCk6st/xjywsN7nJv7H56INlK/983eb+GK2tJ1uL65zJilsC/enHZUad2jHrzxjp
         x0TA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRysgWOszzABiStopkMN641dfkLpayd5GgT2llXeAEzxm8vdN52fstaDRQtq8kIfHgAbZ0dT3yWt6kyWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzia8XWMqwH0ON9tx9kGz9F+2dGhxDYOQ3UV7C0Ri2CW6mjkWuF
	LwphPl6G1+RGEZzyoiVM5qvzio8SC0m9mRgR/KgXfZe3rHUglR06S3oZ
X-Gm-Gg: AZuq6aInvXmvwhOO9/e+hmhS09Jxif5zWUeCG93N6/Ls9+AiVIuA9VY1j9iBR80V+Kp
	h43FYUDs4h7f4mkJDu1XAw3I0OLByQpw1MVwfSdQdtpibz6ZUete7ed1R6eN0LWpWBnSHdbqigT
	VecPD8baeZK2UKUs2jEgSEXwMebO3+HCS+RMVeo/ZXGzBHtZrdo6rEeufWvc0+BxD5mlRuDlEPk
	g1jxZVdvx0n1igwAy8MOVy3v+RcHSoUHgImf1gajZo0QXeP2u2t8g7k9X/ybPOZIoxwgwasE7L3
	B7td015pDzY11QeyMxBN7oNH8vHLuv3eeme0KPS3UHXpON5tYHiBvDpitNUwl7/fzAeZjdiZ5KS
	pcm0LjtnRRAcY14enjjLkHa+TfHndyk3p1tnlavpcK6Cq1LL4Rd9nfE8cmmZ7EY7caoASTzZGVJ
	RXTn3MH49ScljvqhXlK1qqTWyHIBVFjg==
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483a95e5ab8mr72338125e9.24.1771717564334;
        Sat, 21 Feb 2026 15:46:04 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c56d8sm251620925e9.8.2026.02.21.15.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 15:46:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dorjoychy111@gmail.com
Cc: ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sun, 22 Feb 2026 02:45:53 +0300
Message-ID: <20260221234553.2024832-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> I am not sure if my patch series made it properly to the mailing
> lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> The patch series does have a big cc list (what I got from
> get_maintainers.pl excluding commit-signers) and I used git send-email
> to send to everyone. It's also showing properly in my gmail inbox. Is
> it just the website that's not showing it properly? Should I prune the
> cc list and resend? is there any limitations to sending patches to
> mailing lists with many cc-s via gmail?

I see all 5 emails on
https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .

So this was some temporary problem on lore.kernel.org .

Sometimes gmail indeed rejects mails if you try to send too many emails
to too many people. So I suggest adding "--batch-size=1 --relogin-delay=20"
to your send-email invocation. I hope this will make probability of
rejection by gmail less. I usually add these flags.

If you still expirence some problems with gmail, then you may apply
for linux.dev email (go to linux.dev). They are free for Linux contributors.

-- 
Askar Safin
