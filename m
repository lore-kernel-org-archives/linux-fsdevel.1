Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A73D1CCA
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041521; cv=none; b=ul96MMl8Z3QBHe+ogKPqdZXvTudzgBOZDk0hTt78EuzRS0FpSYHzAQgT61OI6mS3Qa2Y2Yl1Ait8g4WdT5ImphK39qeV/mie03g9XSLrN4G3kJlsSlnZXRu6IEm/I/ct1hpgAjfEHrm0L7RVHaGrjTuXv7L0WXvL2+GTM6EbSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041521; c=relaxed/simple;
	bh=yAF5KLeRkn9cZ2ilHNNEXS+YpamdStze0/rD7gJWkQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4oSQ4UxtOvLbsH7IvjRxjrSVxzUntNh1/J4vpNp++K9m7oMKL7zYMOKIARlrXg74Vx8RiSzzyXMYnTMpEMwcJZeJvYIpBJiQgfu9C5YLdvcWloqcPwrxAAV9u5FQc8qJMkkPfEKtpVtS8gE2uspvnzPqhoZxZ3o8j2A6YxgAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Hgir1AHg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Hgir1AHg"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so6232333e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781041518; x=1781646318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yAF5KLeRkn9cZ2ilHNNEXS+YpamdStze0/rD7gJWkQg=;
        b=Hgir1AHgHlPmbWaogdY5/5iVRsNxhIityihALuZVVpjXZ7NYxjcNdlPyFMEDY+9H/P
         MxROWNPRP+8nkzKIa6J5mY/RCKH14Vupzd5WQZ1QQWF+LPsiKpM+C1EFwk35aWhJFpkE
         d5DIU7oGvYyAcmrFP2Svq5wvjVTEvyLmmDh0MJ3ogvRt/Ib2t34TxOXyVSmOKbjSAJ8I
         NPzk1KTbNIx5OIPd1fTXYwdhopLvvgGYO29QgOu1HsVY4hULIIrmdfOEwFW03qHF5zlm
         5UyDrf3CiiAo+z3Wlv4zoU4+18Q00GVEJcknK7kvy+P7NZpp+xq/EbPnh8kbqQcf1Ogd
         mLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041518; x=1781646318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAF5KLeRkn9cZ2ilHNNEXS+YpamdStze0/rD7gJWkQg=;
        b=csFIc+VB/VQYawxF9Rl0Wt7qBQmFsqecXjX2q4R4v9ti87kpBF5TrUWZ6mkYWy/hGI
         kAp4M+hswk6MhbYA32dYDYQoNMN9kJL+IK/IvGrdox7VcvWs0E8mK/vO339GydV2sH2q
         bFZvM/9lNR6gvEci8i6XAgXSiZRjJentI1TpP+v6NpXhsLtGTlljBW17I+51XPl4kkBo
         246GA9Kzy0XqIYIxII/P16pW0l39iJmBkgeYacTYlUb7gmpsNw9NtKLOli4Iy0Rh/IjH
         SbjR2rpDtS4ULxVuZhBdT6cbtGVW9BU2H92CVqEME7zl3M9BAwd7cMgxhopPtvD9oel6
         6yKw==
X-Forwarded-Encrypted: i=1; AFNElJ9xpeI5fdyuGf75cUF6/r9Q7rrFH3ZytkOdE+CH8UKwJIMYdkSS745V+FOGjTgqbcu5HmOgZXNaMdTHxqJ/@vger.kernel.org
X-Gm-Message-State: AOJu0YwSH3QQCs3uERhk8cX/4jTdPHa3Z6eJ/B+t1ItzWA3zAGsasgZh
	ELQ7jSKK3WjqgVbeq8Ubjd99fTwyHr9du3rxKJoLekhukvOea6/5vvDczBG7M4Eu8t4=
X-Gm-Gg: Acq92OEG7WLAYzH3hLK+CxpzqsXjGul9Vz4VfCAOw9mYyAiCz4sQ1uoTbIsVrwmpQOu
	RFW1pawX4VoVwMafmHGaXbN1p6azExFZ//CrK2jQwQTeWlepDMaMEgaGXePjlpQPFPRuoRP2tFp
	iWsRbipkhAlLUD+D87G2JGzagOV1xh+F4EwiUj1lOphbkpzRQjUfPaHXo74cIlIV1iG3CuHzhOr
	KWJfbPkQ96ctsqESwUvrcGWNXksZiPLJ5UNsfOfg3jILZ0biIKa1tzLm4BJIsqZk+NBk8iMSqBX
	GMkUVEvHWxjpDkhCH/MbnacKqEyyE2jsRAxdxGKzy1mw4K8JczrG8TK6nClLtkNfqQe+SYGCc7e
	iThNcTLomAi3u5WnsHUAA5qLq+XBhJRMh5FBKcOnPK2zbESmNLmE4tbjgbzPluSwN/TkifBCCpw
	JTGDBJtXVmQUUhF2hHgAC0tGzPSahQ5fGFOEkaH53oO7RBdumKBFcb1m3vlYPEaf06N58XYjVHd
	D3gphBG2YIfrmIfaW+02MSbQytKmdnGzRAid16dz4BoUtNqQfdmNt8cauaaoOPuin4=
X-Received: by 2002:a05:6512:685:b0:5a7:468f:1b82 with SMTP id 2adb3069b0e04-5aa87b69dc1mr6791891e87.1.1781041517776;
        Tue, 09 Jun 2026 14:45:17 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b990486sm4816210e87.68.2026.06.09.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:45:16 -0700 (PDT)
Message-ID: <1ea0b6c5708ad7948bb37669e8f508607f17fe6a.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: return -EFSCORRUPTED instead of BUG() in
 hfs_write_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Tue, 09 Jun 2026 14:45:13 -0700
In-Reply-To: <20260608042425.1085828-1-davemadmaxxx@gmail.com>
References: <20260607035339.1015062-1-davemadmaxxx@gmail.com>
	 <20260608042425.1085828-1-davemadmaxxx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 04:24 +0000, David Maximiliano Hermitte wrote:
> Thank you for the review.
>=20
> That makes sense. I agree that replacing the BUG() with a silent
> return is probably not enough if this state indicates serious
> filesystem corruption.
>=20
> At this point I would prefer not to slow down the fix by guessing the
> best HFS/VFS error-handling policy. My main goal was to report and
> narrow down the reachable BUG() site and provide a minimal tested
> patch showing that the crash can be avoided.
>=20
> If someone with more HFS/VFS experience wants to take over the final
> form of the fix, I would be happy with that. I can also help retest a
> proposed v3 against the public syzbot reproducer.
>=20
> Thanks again for taking a look.

If you have corrupted HFS volume, then the issue should be resolved in
mount logic. I suspect that we discussed this issue multiple times. But
I still don't see that anybody can finish this work.

Thanks,
Slava.
