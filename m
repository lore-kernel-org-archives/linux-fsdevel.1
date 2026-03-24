Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE1314D35
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391807; cv=none; b=hoPGKkJPUdNCOOuKOTXNRSPDR9g2vuMRERofA2CarWRzqzluHr75b33fXioFTFLFlwaXQUG33EMaaN+6WIsd/zICiUxve90seg+7UW2N70EX/4FpapJMkG8RYvREhoT4p7W/PLD5BSZ/Buc4QY2SNU2EHE4QbBHpyjmbUc9QbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391807; c=relaxed/simple;
	bh=D6a4sODgurWumOMmlJU2HZVlxIk8M7hyJqU671PcXTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZnHwe/P2wgKHd+n5lcS8NIn+nvYPETmfTjT/TrBBSQPrwIc1sYzffVexKlWC+fLaPL0jwg5a/sv+1c2OXjlE8JNL8+jkPCaddqHnOdGFYK49skmSDr+5J5waBSzfCd7fOAymyBxAtGm1M5G9KkhJXjOkLkZm8zbn27+YwOYpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JhpEWuqK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JhpEWuqK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so39414215e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774391804; x=1774996604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peEWCpydE3W39BrPkX54rd6U/gBnylU2ryccRF0Lwo4=;
        b=JhpEWuqKcEbry+35H3KA33vTKakB9dHe4PJRw4p+vk6nGQUlSx0vr6/JupqXf8bFx6
         HQ7Mok1X3vjtoEKZSbPYwV49WngOrGBkhW76n21QqMW/kwrPNej2+mPZgMQdvwxCjgwh
         /a6OmJX8u35loz9SWpfsY8x4Pj6efv1AHHLwbhLjJNshHn26QYkiZF2l8aPo59eIe5uB
         EpzdddJRKzy2OGUAnXfZZN1Mocq0Z7FrJM7Zxrw9mIcIl6gnsYgZB1W8c9uTzokyiFUe
         YWDNq9YGG3U/qAfx3U+rFvll9Zva287R3TwNVFghrAtNzfT+6LPuoxdfUMTWV3lYtnFW
         lJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774391804; x=1774996604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=peEWCpydE3W39BrPkX54rd6U/gBnylU2ryccRF0Lwo4=;
        b=PRRDSLsADSrjfnt2RKuUdfANx3f2DPe2zDM0AUFK68ifear+e11FdcAz2fpOhVVlRP
         XoHPxrgZ0t4ebP0+NK5WgH2FRPcGKX5G8gMuTF7VwcnU01qLSs16I6qNCqoTOS3RAqso
         wq9Dsj3Vy3n84hryfxrmdGhWkpwdZ0wzmk9+uxeo7N9w/iBRY5byhIJk+vMrx7rhvVEy
         LyGzuAKcZpPiNX1WaR43MRT3ON2mvuCybtGmKklMRwO3K6HGsRxWZsFTYYwEr9hOIV3q
         mCowjhYFQJfEPmgooTr9v6ObzI0GX0ukV8gcm6qARuUjPt1WyulkazlfR1ZjQ3m8rZe3
         9FGg==
X-Forwarded-Encrypted: i=1; AJvYcCXdkSAXpd7DlJSuiYG8jISYCnjKdgLSTYKAiVLuxQ7d2QVNzy0TBbG8l20sRdkg/nJtuFOn/M+ux3HaLJ/P@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE23a/c11N4cXqkoVMKkxjme7i+1+FnnlQKEuca43yDyM8UHq
	4Xp3a+YOq6OSXLNkTvytpu42GnUlDaYbhroTPzpgvCtjQ78E2geC68Mh
X-Gm-Gg: ATEYQzzq7xg1w6QqLgXGyqoH5w0YK740bGApsFAEPU1zHOsZOa9Jc/RqYenJFsni/nt
	cY6HuGfct7nNDF8WugzHAh+YINw44qT6xCh3pJ7Yvq8+bPhhlhysoQNHeBn4stM1twYTKMfDTog
	9KjrSe1x/kDdA+ictXiKxTb3bPMM2mEIvbNQ66wywhDuqmPrpDbJbLN8OMFbSaOFtu0POHUsgul
	uwlA9PRzW1oGJ8+sPA9Txw2rWNJewEaeSe9+cfYllIkP0yzfV+2xAdAmiY/jYdWsJHIEttWbGrb
	ANT2O/OaxRd6/dG6Qy61KZ0znlyrZZ7ZncjqRl6ZDWP49vH5IR3Ua4w3yDBRnIcBGoO2XRHklDa
	yX2NRdt4bX1qteEfR2eIIhvRf0VFcVuYnfozRI/vFQBlDrOpRVFP5egv6CShLE9LD9K3A2gO4DV
	XUfTFhMAxB8uzKWn8iwec=
X-Received: by 2002:a05:600c:a112:b0:485:5c6e:8a38 with SMTP id 5b1f17b1804b1-487160429dbmr16208605e9.17.1774391804149;
        Tue, 24 Mar 2026 15:36:44 -0700 (PDT)
Received: from DESKTOP-I0B9J3E ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113c4eb3sm91713535e9.0.2026.03.24.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:36:43 -0700 (PDT)
From: buermarc <buermarc@googlemail.com>
To: joel.granados@kernel.org
Cc: buermarc@googlemail.com,
	davem@davemloft.net,
	elias.rw2@gmail.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com,
	ps.report@gmx.net
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in  proc_do_large_bitmap
Date: Tue, 24 Mar 2026 23:36:40 +0100
Message-ID: <20260324223640.807029-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <msjawemtxqykmbis625wctfjry7ycn77nxjjbibbck3m3atvsm@rfwow2ytmgtg>
References: <msjawemtxqykmbis625wctfjry7ycn77nxjjbibbck3m3atvsm@rfwow2ytmgtg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Buerg <buermarc@googlemail.com>

Hi,

On Tue, 24 Mar 2026 08:44:13 +0100 Joel Granados, wrote:

> 1. len is calculated by doing len = p - tmp
> 2. tmp is the beginning of the buffer
> 3. p is the first character that is not a digit.
>
> There will always be at least one ('\0') character that is not a digit.

Yes.

> So len will be less than size at least by one (could be more if the
> string contains non digit chars). When it is parsed to the end,
> len will be less than size by one.

I don't think this is the case. See below.

> TL;DR

I'll try to make it shorter. size is the length of the user buffer, even
after the copy to the kernel buffer. The added '\0' does not increment
size in proc_sys_call_handler(). Following the example for
write(fd,"123",3). In the beginning of proc_get_long():

size = 3

@:012 3
-------
 "123\0"
  |
 tmp=@0
  |
  p=@0

After strtoul_lenient():

@:012 3
-------
 "123\0"
  |   |
 tmp=@0
      |
      p=@3

@3 - @0 = 3
len = 3

(len < size) => (3 < 3) => false

And size must be 3, proc_sys_call_handler() does not increment it. If we
provide something like write(fd,"123\0",4) size will be 4, but now we will
return -EINVAL.

If len < size is true, we call memchk(). memchk will not find a trailing
character as p points to '\0'. This means in this case we would return
-EINVAL for the first proc_get_long() call in the while loop. Reason is
'\0' is not in tr_a and therefore not a valid delimiter for the first
proc_get_long() call.

I hope this get's my point across.

> All this holds unless the trailing '\0' is modified in some way in that
> BPF call.

To my knowledge there was no bpf tracing enabled on the affected host at
the time that the behavior was observed.

Finally: the fix which adds a check for left introduces a regression.
"123-" is wrongly accepted. Not sure if you saw my other message. It
should not be used.

Best Regards,
Marc
