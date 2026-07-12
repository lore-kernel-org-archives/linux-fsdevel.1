Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667E3769F6
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859755; cv=none; b=NBksq1e6TjXSfsUG1DIVo5Pq3vHnhW7DV/xmY5Y67H5+A5o5OS3GL1O//BZGr76bh7lp4dXSXxWvBd3s8e5RvpJBHhrCaiR7B2J8BixcyW7FpGQI4JlLBEJMij99x6CzgwkFLbmuhKDs40zV5gBEeSKdG0pDKz9rjVSimHXWGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859755; c=relaxed/simple;
	bh=vbmsavjMRnQA+eomV66j+Hk7itBjYjDe+/oxr9QMvXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up4QvV2sP0dIzljaRZhdpxzrGOcPMJ8Kc2YmT8KvDxSu9OD1+Dgk8bs9OkHwGjNt+kMAcKo3ceWJD3M38NjVGst2Sohu4/QX3Nn+8acFQbluYz08z2TRJC7Px+U5fovN7OMhghNVsKFz/z8V0ggvoo3nEZoU4Kc3Yn1XhKvzdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTa8hEsz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTa8hEsz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f75f7172so12210335e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783859753; x=1784464553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFr7i1z8fyur2AGVEYY9/WLrL9vlCD+OnEC6ZMaETYg=;
        b=mTa8hEszFZ274aJyuOI3aegKmqIFb0feb1k8X1wQDWkqvIb7bL9PEGn5ZuZ5dMIZ7K
         75QNysPl8xDhWLtpQ+qBWoBWMs4nNUZntM6Hf2alTrrz5aCyxZfqK15tIWJEJ4v/+sZm
         uDNZW7haqy3VN3ZyWzWYMVumTqv2J6EvzkKIjZUlO4u6ZFx1qCjUPd5Si5W3png5qti1
         uzhEXWzILMFBH7+4Z2/x07GM61yDxUC+NXsFmiWUKAUjj5aPTZSV/b6u4kQ/nd5X7gWb
         ICXmgbuA3ndMslPwuEl1bfsUQtnolCoF9Z06A5THlbnPQN4VkpcYlJrNcGNiJ3d1L7UM
         DLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783859753; x=1784464553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFr7i1z8fyur2AGVEYY9/WLrL9vlCD+OnEC6ZMaETYg=;
        b=m1ifF4uYj5brGurkojGShvuMoy2pkGzTvVJbenOspEjEseNq0aY1ShijUL+29p8v4M
         zhyKARjhvSabmy1DLyYanQCGzc15aGlxiUNlCT0q+tDW/4dKBlKSlrgN/aIGV3pQDIVJ
         pHMxHdeIq6/WUfbJoYK019XbzPO0+FWGLeJXW7KNrtF3gqwD5xC0V+zhg3uoyC2y4D58
         kyRqskANQnEkgm87WYYFjgui839M6AKTHyNrNQNWHRLwQa4QktRDGMCf0ao0GoWeDI8L
         Wt22LKiLvdVWTRTcYybq0U46IzFxuiJ4T5Df+IoRqDHKKBPK9oWllN2FsaRYWd5EAdVw
         WN5g==
X-Forwarded-Encrypted: i=1; AHgh+Rrju+oY+2YmMCrO4YSD1FxlnkbQX9sd/JCR7AekcfN47mAvyh5tU32dXqsZljJOGcKYNmQZDx53FOqt1pFM@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQDQThp68rdrjwWDpsd8UgTRbar5qyrtE99SPamj+09iru1fZ
	rjsRvv3NUtAsE1PWaXgBoHTI5i9fhq8DJIm87ubJNBu2wL4Nn2ILJ4sk
X-Gm-Gg: AfdE7cmHrOuEukqWN7dcTvaW1XEFTO0Tr3ll6qY5dXeaerDkEpFXsVKdJYPL6G3HOD2
	1//0Pxyuf2tB5gFHGwkDUUegivgSDoA1sGHsFPQGc1cZKid9pEU7KEJ8SabcVy0JEKFPlJHknhM
	JTFOPBD+enxHodfzNT3pM6RCQFNyEZeBDffCWlgfhwOUtY3xdhfblWRt8NenxHZe3X5+sEJiPGe
	LxkzUfKm6VBWReCDIFCz1o7bi5sBq2pkBHTvyN0FgLQw6L7bpxQGcjA+84+qVbA/+tMhHG0fFHs
	kpr3LXwJFyV1c7EjU6JabwPukuBE8a8JfMyHNiJ4xAGAl9HBz5ew2sJc8JXetkk2pAKV/k9KpAq
	Ss2jePi1nHOWerTM4/E4xjn70kmk6EgV+2l7SzBSmKpZxL5IfpsIG4n9M6uJNi3e3y80NA1fQeR
	2aazzJv1LTkGVGMTDjsnUPgOgXQN2UxQ==
X-Received: by 2002:a05:600c:190c:b0:493:b91c:6bf with SMTP id 5b1f17b1804b1-493f8818dedmr55304095e9.18.1783859752393;
        Sun, 12 Jul 2026 05:35:52 -0700 (PDT)
Received: from fedora-dell-ale.Home ([2a0e:424:a465:0:bdde:db24:d709:ef36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm76497317f8f.11.2026.07.12.05.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:35:52 -0700 (PDT)
From: Alessio Maroni <alessiomaroni0@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	ojeda@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: fs, hrtimer: replace read_volatile workarounds with atomic_load
Date: Sun, 12 Jul 2026 14:34:43 +0200
Message-ID: <20260712123502.2829-1-alessiomaroni0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712121420.25179-1-alessiomaroni0@gmail.com>
References: <20260712121420.25179-1-alessiomaroni0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please disregard this patch. 

As pointed out by the Sashiko AI review, using `atomic_load` here
introduces critical alignment issues on 32-bit platforms for ktime_t
and violates the safety contract regarding concurrent non-atomic stores
on the C side.

We definitely need a proper `read_once` abstraction in Rust before 
handling these cases. Sorry for the noise!

Best regards,
Alessio
