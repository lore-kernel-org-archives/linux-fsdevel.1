Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27D3328FA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372060; cv=pass; b=ImbvawR0ijOxIpCyQXL+oE61YdPX3x8h+fG5Xr1EjsSz2dKfqIh6XWUuyZ6vC9MVAtcrnee79HFhx74Jt7GRmxqNxZBYGXP+5vbs2pmTjiBwXj57UVdgvJEFVCSQRrvrcyqz80sKXDe1hE/8kAm6sadGIUwvFv6bAEvFxYEZNEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372060; c=relaxed/simple;
	bh=PEhg8dPymL6XcC38iB9GMzSdyc6pi8g+t0gQGZtO+AU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H61RBf7rIkcLo5v1FlYjJ1eH05PtCczBVVddSTJHk+J9XFqXvVU6dg0797zUkfpydz1nEzfPqsMvyEPtV3bFO2JQQhjwO3ARf0Tlz/Yj47hcrdHPGk3plFfQYNO1OP5MpMItwZ5Iop6EoiXHHdSbhRrzSWMpu1Hdnb+azao9MvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOmRo71F; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOmRo71F"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c126e47a82cso418873166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 14:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783372057; cv=none;
        d=google.com; s=arc-20260327;
        b=qwZKF3wyCcuMEnPWjwFPu9W6Typ34jWWEbLj8FoOOnyADohumtkzauXPvt0nN405eZ
         rYnVXtTLg75P3vdYnlFKsGCjywAT8l4oFPNz/CUZqIlUJLnGhuLB80hIPvjKWpM8cVpf
         pPDnUTDNupnR0TMeebpzEwhuX4TlgB6xktdByALmV8LBsWwsFXb0G9K7syVBrwnbjrGP
         V3JyZHDOGnC1uom/ccypto8/AhLG76eM54US7NG8ng0u5YOt6aNrNYI8mojSZd1Ftv9k
         C4AbwqdSD9BwN04ZxQp1TS5ttvYRCgOvvuQ16t0KZqxt5TEWkhWQkcKi1JgVToB5jXZU
         MKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PEhg8dPymL6XcC38iB9GMzSdyc6pi8g+t0gQGZtO+AU=;
        fh=ToO8m2MH8Cq5TITnTtlQSyp0IoR7i2HM/rF03CjdZdw=;
        b=oMzsS7PGzJuy2QzU2fVSqww/NstBqnqYbN2YvNXtEPiY8wVOwzad461DQ10Zw+bNvU
         N3j1JtWO1U2e5iSxSgYf0mDqcLDBZ6CjChWAAGtv9G82P3m0lPvfPPxvIn/X3B5gd1Fe
         qnBpGJmTUE184E3sAeWFSPD9xOWsDC5mfx2Kt015yzUbjuC92YgeXYVzcNxE4R1OVX6L
         UYIVjLYMzbbsDDgd57uuqfA1SrEF3/mq3/QqVAwI7znWShX08egErWKavNTimaUbdy4s
         narqthcAgt/0+SAAStj0Hl5eONheSF3TaUSrcH6NiV6PkaJrxngVLlR4sPdyQpXFjIA5
         Ul0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783372057; x=1783976857; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PEhg8dPymL6XcC38iB9GMzSdyc6pi8g+t0gQGZtO+AU=;
        b=kOmRo71FkRWGZ8dY5VYHTLUzwG+FSW9yP//VcC98z7KV5p2C0FBwnt8/6t6G/UTx6C
         W+gOyvQk+a6zNHa7JIp1XJM+4T/9Wp4VFrTSiT6fgPjbWJKMSE10SEqFpxNKa2tcHt2M
         RQhL3fBjU1FZc1T9FHMC40X0GmUIJnXKD6gcTRST1FzTQZh4S0ix2VtNgeoIZO74qBjN
         e5Vr+vRATPxD6/PROeWHkN+62SwpuPUBACKQwptFil6z0+YmoVInHHXnWLpa0KLzietJ
         LfYF8IQrfFr+pCHLx79zH7PX+bzoo05nx3FcVMWFy2KrEcoAxCogISzqt/UROoJokE1g
         m6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372057; x=1783976857;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PEhg8dPymL6XcC38iB9GMzSdyc6pi8g+t0gQGZtO+AU=;
        b=OzrMzi63WAERmsBzyeax/hgo4W4JTviMynAM/8AwJHXbZh7VdoDlanEMFc0cvjrFom
         sYTR5zxNY+uUvq6UoWGLcnu+LsqRbU3WS+fKPfmz5+rz0b7C6VS0uAaavWjiToVjLGg1
         dE70RkAyq8x6s2S5lvnjOR2Czymc0Ifh7u65mj6yBd2sK0vVvQqinul8xJtPGle/yOY6
         Zxsl+lkl3uWBBNgeAJ1W6dO2AlSKE8eOjCei9iRMAIbuiNDkPb1VUFJOqzfWGhuZro8s
         f0z6eervZcIcmc8yQfwUY5IXRtx2z3VPWHsmYndfSeLKQAmt6MhI5ZxZUnW/b/shwnbc
         pP1w==
X-Gm-Message-State: AOJu0YyeII2U8kMI0xI5JVRm14jPwWx/d3B1dSO5r/WO2jTbuNPYdq5R
	I4fr3v0aVI2KrKJeUKlyIccoLlzsNBAZzlPzaJzGLfadZY0i1xp+7KF2Ouf0PW9zN6g6TbZ5JWv
	4mKeJHD8b4xi86Zk0zItD+SuCYOpbd8Y=
X-Gm-Gg: AfdE7cn992YI9eSGXh68La+KBYeHIhMiwpCw8vbRiSrfq7ZZEetJLanq6kBhMm6Cm4L
	11In7GAmEtoxTdGkxu/6iWgiIYwG/xub+J8c8FooONJIiPzAvLyOUdheEI2W5FMRyNBXYTRt1O8
	Yc8CahJYQLdwCkJ8cVHjN1WAm1OTGBKk40z7OfBuvtV6Fh2L1M1kR2jbDIfFJ8lNJAMwhk1DEfG
	FbcKJMhF4l1g3rMDoVyp43bJ3lXJzwLffLGgIdaiQCpxrkY0IuboHW/YWVT7cf1Rna7VGDU5/oz
	dLP9/P4GmtcYHNb0kp/eZWdBJ+oY
X-Received: by 2002:a17:907:25c5:b0:c12:9a13:47c with SMTP id
 a640c23a62f3a-c15a66b3206mr171003666b.2.1783372057347; Mon, 06 Jul 2026
 14:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Jul 2026 23:07:24 +0200
X-Gm-Features: AVVi8Cd1VjAgnTVTL5SuzGj8be87p_ud_K4weZLU_Frc6V3gOW9hpPJjjpWZ5lo
Message-ID: <CAGudoHGokvqDNBz8EW5fwudfz_q-0+2eeon7-hyxZ5k=QOpF0A@mail.gmail.com>
Subject: how about enabling Sashiko responses on this list
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I think everyone agrees by now Sashiko reviews are a net win.

The bot is able to respond with concerns over e-mail, see
https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.toml

Seems like a good idea to enable the feature for the list so that
people don't have to explicitly look for the feedback.
