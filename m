Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AA37997C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960535; cv=none; b=kfcs8N2NKlXDWtUOxRA35T3LPimjU/QPM6LSkzxTud/3ACMB28i13mPITx14TXVdwkOGGNdE3B77IjJk5hraZwglSNmMagd7TVtjxNO/CeVVFXYzb8O/6Q9nYSoWmNEonV4E81fGpxtRVVxrkEEu13EjwmYEGDlOdu6ekn3WjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960535; c=relaxed/simple;
	bh=8pLb21ljR7OmMKWr1a9z0o663+LQ8VTu6q/JNK2wrww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTG+isc2I+KvN9M5TJNP3aFXrvCVb6+9rk1lu5fH5C0PI2D9BqUscae23mJKniv/PFQrAC+VdnPE6SU9Bd74auqG4viHJq1jrvs4pogBkUT+OaNWQ+3OligivNw0fudBcEHJvDQrFYsGuZTAmahtL5F8VwMm4sgCEvn7pcmYcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Mn3o99G1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Mn3o99G1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso14845275e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773960533; x=1774565333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pLb21ljR7OmMKWr1a9z0o663+LQ8VTu6q/JNK2wrww=;
        b=Mn3o99G1vcmT5A/15HiJ6J5nn8i90GdN9ZVxOSqpVJ3rF8iTSKMNJ0W+93QNxlFcC5
         io65r5+Odrxes0xy0zZKQDicFQ/G8Mkr6UTC4hmvqmmlDNdKgXCg9o93cRpjmxQa+6KS
         OG5stIWk7PamG2WLySyxgmNO9kJjy58uI7IhZf931mHW++1PPxERZVdZH8Fu3oAiYVm3
         XNvjPH9ZhH7vg2U/ZNX93Q/t0TYmMNgbfor5wJ1IJcfdVxznKJfZFuwxYlS2w0Ve2FAK
         zyH/2nKf5yubuhBYPGrdNQ5gX/3V/uOCSYphA1ZRupIGIEzeGL552mteMS7XbKNpKy6z
         qa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773960533; x=1774565333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pLb21ljR7OmMKWr1a9z0o663+LQ8VTu6q/JNK2wrww=;
        b=M5DdWkA98prS431eLYMo8ir2SFQnPcvi6EdalRPEAIkht/ova59SVcqdAsB7tuXRqV
         Nxps3KJPEzY4pGtCSWh8oE2WwpIv6D99eLads6t2sziYbP56Li3JwWV0kegsTE9HkWcH
         tiQAhbUkEanZmDU7t6bHt4aPbB8vzLYau8PVPIG0wd0QgvOpwX42J0M1vq8TW9mV6yuc
         maqBpPAxbYD9DeWrdVRwsG4PJYhuqyXqh3gVB/uuCeZiCtMfAtXUhlOy/1NmsZQrfA7j
         MA89da1t3k9amGDJ+lyoZN4U0K7QSyrVIQRW2EiH0br04nZfc862hiF6yfY3udWrayeo
         hPyA==
X-Forwarded-Encrypted: i=1; AJvYcCW/j5uJOS019t2ecowHmv1IAOOSMYQfWt6Hr/ixjoV3HRCfy7YW+8KAR+eNC9+EDlw3tHfd7bEhvGV8heb8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzee0EqMjiT3fBFRTG+9OA0ZHJWV2FimeL49jPVIPThrtn7WVBL
	h60eXFHE+UfAbTmLQ+gO69VGvLXvrMkucajowzniDUs6D93kscc4aFmu
X-Gm-Gg: ATEYQzyH/3UHZmOP9y3rRGQ/qw8/Ed6jh0sMOM8isCygaPgMngOGTMsJ1+z/mSDnO3o
	Od/P+WZDKp1eZXqkB/LmnPqPaJCnPTWjboe3HeNNTzwILo3WR40yKTmutFOwULfytALoktSmhVB
	utrohHG+CDeRMGezCe5LSUpchlhjgg9IdXGji0qxWQ2YG2uGjt077H0U2TV++W6bJj5iG5czGSL
	Tgk9b/GPPhKa99nG+bA4jFN29GZDaBjS0hExTHLu+HwL5RvJYOmKILMEy8lP5s/E/akEUWDyDmv
	7E1o1XbY40/add8EK/FQ32+X+Z4x/TcwQendzTS3mZ3ttXrThTBCiDUH2ZlCPP4OIW2heEdqIdR
	B/U32MvlPQjnSOl8WJKEyeoD04wYbUYuZGUsn3hx0K0I8WFdHhz4D9b+pQhZuFqU6r4ZCsXPQ1f
	AITlo0J1qdCEpSA9Ma3wM=
X-Received: by 2002:a05:600c:c48f:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-486febb6014mr12401135e9.7.1773960532786;
        Thu, 19 Mar 2026 15:48:52 -0700 (PDT)
Received: from DESKTOP-I0B9J3E ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e3a94sm22967195e9.7.2026.03.19.15.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:48:52 -0700 (PDT)
From: buermarc <buermarc@googlemail.com>
To: ps.report@gmx.net
Cc: buermarc@googlemail.com,
	davem@davemloft.net,
	elias.rw2@gmail.com,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com
Subject: Re: [PATCH v2] sysctl: fix check against uninitialized variable in proc_do_large_bitmap
Date: Thu, 19 Mar 2026 23:48:49 +0100
Message-ID: <20260319224849.52923-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319195841.227edf09@pc-1>
References: <20260319195841.227edf09@pc-1>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Buerg <buermarc@googlemail.com>

Hello Peter,

Thanks for the feedback :)

On Thu, 19 Mar 2026 19:58:41 +0100, Peter Seiderer <ps.report@gmx.net>
wrote:

> I personally found some of the commit message text from v1 very
> nice/helpful, specially the part about the writing to
> /proc/sys/net/ipv4/ip_local_reserved_ports to trigger/observe the bug and
> the maybe condition on CONFIG_INIT_STACK_NONE=3Dy...

I understand, I'll adapt it slightly to better fit the new patch.

> Besides that you can add my
>
> Reviewed-by: Peter Seiderer <ps.report@gmx.net>

Will add it and send a new patch version.

Best Regards,
Marc
