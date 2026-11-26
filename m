Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685282;
	b=V2C/XSanc22f1u7Epgf/cjFXpWne0sqYPFt+jtZALde8iRItKsQzBkwv1SoYkNv/lE27
	 UheqHh994ASfAxZQT1KyLJEDPo+3hoxpxZfsaf0izuCv/ID6zQ5ANvSYqfVLahA6swf2K
	 8JAGzLr3a+bJH1XV9jAJIotAuEfX5OQayqc/GIaW8pvqifuolEeEstaLCubS5do6rJ8u7
	 nvQ2YUVO1qQycz/595QoxIt4yWy6TkkQ285ru4BFWTSHScfaxMAgaZzR2H7DvM1W3a8Ew
	 zTCAlRTY5hbPoLtRKBrfPOblH3+MAgcB9Ex8SDiv+wucfDgplJx2+Vn/zuJnzz+3i3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T1rSRkzl9awRiglIgFpbzWob53mrf2jMTVjGG4JCJCM=;
	b=TpEu41+oFlvyR8s2Fvq7aWm2+F0psy5m27pqJKIemKPFuGyOx8DrmSniahojfqZnxG2u
	 k2MoUjVE0Fufwcy/geQS/esBTcbJdZwZ/UjGN/TGActVxRLla2Ljuxph6dQZCvThccB/D
	 nKctXeyJAielddrb5XgLW37xVffPa/JfF9kgOejE8Cz8RD31VPVGME+7fy69nciRbF71m
	 /0qEfak4WgFzjqxks4R2LJ49zCY64IX59kSUC/7EBYMGjYaxLZqDrFOLlB29Apu2hkPDP
	 XaF78ZZYdIGx6sa4FwYuVvYvIRHnXF+p7/QmmqmQ/ZVurDnD2tytK1/XWmMfZmFWgvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SihxB5bK;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A72606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 09:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A72606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SihxB5bK
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e3b22e971so3541803f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685281; x=1796290081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1rSRkzl9awRiglIgFpbzWob53mrf2jMTVjGG4JCJCM=;
        b=SihxB5bK+QPJHxaaKBfNka4GcM1M7hWevMT/+d19CiGwXlvqlqntuFDsEmK7kGMJoF
         ATR3EBM5cQZQwa51XfXjyq7fC0UPYZBnoob08c4EhbSrAF6aVG9fpOSx4qSX3eOsIbeA
         KcPGEE7wiaIO9FUpT+QTyV4LULNcxXH5mJ/6c6RQeBaNqHHMmQK3kWna/HxXJCEUIcX+
         6KmjAbB4ifpQ5jAzuoR5lzKnuX9RfTzF/QwDGj/oyHju/3HhaFb8g9oI3YVfn3VJMM8T
         qytU8NiShO2ZQwBwBwLNGrbRXe/pfFZ9Fxjx+eBqYFxD+G+p4qFeRvyUmyBYpy5HqmMX
         DVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685281; x=1796290081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1rSRkzl9awRiglIgFpbzWob53mrf2jMTVjGG4JCJCM=;
        b=O5e7CVDQjRx5Pc8iYEpCI1J6eC1s40hzg6TY7UKyJxZ+HWGvvIw2K1oSlDMrr1fMi7
         GMhOYVunxtzgcx24L6YpVQBPRB1J2fcPCEMTAV6w2VVju4banbXfc02Dx05sv163qST7
         W55NVpF0+z+TenhLKyDi6yyW0C9/yKQPJh0waHqeAUFFLvTimV0HPrzVc9jc8sSmvlWC
         DpBgZOUifrJ80d8uGIzvryU6jL4jlpyOaR1KOZHbiHu2QJ2bM6wJmQYByj5y4tzNOK0/
         OJnXRPeI03SEPHrVYpJcmBkQZzDyUpA5LX8j5VaAaodvT8zQ2ZJcavs5Ai5CH2ihQJPI
         3Opg==
X-Forwarded-Encrypted: i=1; AL+hErHx/AZ5iuxqNbOMe9PawkwXFGsBSgwz6BmiMEIOI/Br+AN78YRR5frLnhjTbjsV7/XPleDvQyPDX2bv/VHU@vger.kernel.org
X-Gm-Message-State: APuU4Z/BcSmlhEvJIA0swPwufhc++CCvztJ1e+ev1WQwsyIT5GBshRIi
	TerELaiYNRysZjOKzp+adJBOGtkhsOtNYUmzVxUL8Ra1Xbf2Ci2+rUXB
X-Gm-Gg: AZFdTZc5sETBwtBjyNIUU7ypxWyIdv1hLf+v8PlbUz0fhy17OZqiQq83onRUeV5cV8Z
	X0pGUwn6t/nQnMsokPPCgfzvQulWXG7+nleE/EBQNbTToNmw4PtJsq7oazYd1drP0l5RCrtqQgS
	o1fHiQx6aARHnXop0S+hQhTorW3GJU0x7agPh3et0/SoqGL2T+FSbsEKqsfo9Ak7fnqZQ8SIrGP
	P6TAGMW08VwmaDu14bKnfSe0SKtGK/jRAQBIigI2F1x+i8+CcD8QSjAjsJxiPcWvEPcXRTm/UV5
	Cc8Vg/90ugym9ThYEjL9BKRL49P1qg1EHSOswII4x3pvJyWWdqW52ISg2VRJShPA5aInEj+s1gZ
	Jm1sEDubZg8aI4/6f7iFts4BNyZDiogAzW1DULxWTZbhynvOLwzMB7600ShrFPjRW/pJ73TMfV1
	tdeKC5dp2OMSXAYa8fSIFwf1ZZR3f7Lvv1cTLzthCO90XFIy16NzdXKnCtfbS9WgnVotIDkZ5ED
	IFUKd5XgIz0tLro+dBxK7mxm7hhu6ggRnykTwmDM+5XNEmbpTYN6DqiPnWW2HlpdOMQr+/wZA3C
	TvR69JfXfIkEtrCW1OF/8Fk+VIot07RAvDf2r7wRwLv8CVw=
X-Received: by 2002:a05:6000:29d9:b0:48e:bf0:30f with SMTP id ffacd0b85a97d-4abb2910fbfmr28308833f8f.34.1795685280415;
        Thu, 26 Nov 2026 01:28:00 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab69bf680fsm45387870f8f.14.2026.11.26.01.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 01:27:59 -0800 (PST)
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
Subject: Re: [PATCH RFC v3 21/90] fs: seal a mount namespace for a cell
Date: Thu, 26 Nov 2026 12:27:49 +0300
Message-ID: <20261126092749.2894153-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-b4-cells-v3-21-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-21-bc9095937a84@toxicpanda.com>
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

> +			      ns->root->mnt.mnt_sb->s_type == &nullfs_fs_type))

I don't like this. nullfs is multiinstance now.

First, we have usual userspace nullfs. Then we have knullfs.
Also we use knullfs for marks: https://lore.kernel.org/all/20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org/ .

So, instead of "s_type == &nullfs_fs_type", please, check that this is that particular instance we need.

I think check should be such:
ns->root->mnt.mnt_sb == init_mnt_ns->root->mnt.mnt_sb

> +			/* Whatever is on top, now that it can no longer change. */
> +			while ((m = __lookup_mnt(&top->mnt, top->mnt.mnt_root)))
> +				top = m;

Why not use function "topmost_overmount" here?

Also, why we need "root" field of struct cell at all? We can simply call "topmost_overmount" every time instead.

-- 
Askar Safin
