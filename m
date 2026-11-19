Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096504;
	b=NFxG3feFhiZRbr04MeGUtHljZyI7xyYSS+2ptE33KjhKB+ZtPSoZoRJZlIfWjOBFgEej
	 MJc0FqDbnPaoLg5irW6ZdCW316JLJXH/BH13mJKVvJrXhSKNDFm5/XvI7oGMoRbAVIlLB
	 /XnpRZvgJElcF00XKtNMpmKF6h6GDxYVAgr1wdBxFg5MM8b95M1c7aTxxZA9kdHKYHqwK
	 ihvtvDT2MKuehWVoK2dq2CK9J03KIBnPyrlVX0Nbl9k3TF9kJqOZl4IR6bROo1JGd9qnE
	 0Re2mLS/S2FsT+ChawFceqcdFn+XJgdOEkXUVqjPnUw1iCIVQ2sWsIPlIGuaVWIgIvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+RZLDuEn66qi2YdxAFuL7DH1veBrGjXr3VFwAmR19bU=;
	b=IIGOFHjsk/r/WzbBsCb2WFr3AAL1pNT1l/zBBktCxPUr+GT8IAt3VQsPwVos9/GWxtGF
	 3PCpeIADye/8Dd1iziDoGuYNx1JMTuMwd/mPn5LuW3aQ73xBwU0cU/6pY6yhqcrDobt1g
	 qbUMU/m3IxMKDmphtkqNGZ75BVRkxoNeChORAzeBd+/m71ZeV/VyR7p7Cqu8brkGLFRpA
	 rywr7QimepPMhJdBM4laG+Rwuv9DowJHcjs8XcRwYTzzPIcojkfKy1k87iaxPwFv2OuGY
	 SWw9TfUPwHV7pYzTgsodDGK3PzR10h/Kh30k0RhR/8qDefkQnujbVIphrJr7eFq6iIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kLOkQS5R;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03160A262A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 13:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E03160A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kLOkQS5R
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2edcf6c3a57so2931815ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795096504; x=1795701304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+RZLDuEn66qi2YdxAFuL7DH1veBrGjXr3VFwAmR19bU=;
        b=kLOkQS5RpbJ6rgyY0XMuyR5K/iOBzyUMoQNhQBIHbxDOK53m7LhMV1n9bhG6yE7wDN
         Q2u2IhW00UKCGp5uS1FbFqOF0anJTOY9XG47zlvU3ymFqz3GsoLKPBCOcJvum5ksvv4N
         I1xaDJkS50qpQy7mq/CBuNCILne795NdE3/b7ZHisalPUGDf3czd0/d5nKo9vKwlEdJ2
         Jno62qOYQGmA972JL1XDXDOc7vgZizjC46wTsnpzJRLqwWb5W1sOQ8Ci1SINY3nX5f9L
         6pOrkcVkCUMzcj0r27dj9KqaOt01977uayrWyqnV0+XLNi8GNxf82ppZw1fF3ruCg8Hk
         srcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096504; x=1795701304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+RZLDuEn66qi2YdxAFuL7DH1veBrGjXr3VFwAmR19bU=;
        b=W1dMh8f3ScWERzYvYgAtgMDPVVu+f3pjH2Ev/MrwW3OLfUAdlJ3VPCqKYWTlaD+LKi
         3z2tIG27AQgtFQA3yoCWKeCom7Lymr8LFKUNECVyiui+uuhFartnZOCuLb1QFBOaySWT
         nx9tV37FFrXkYHYhtZLgBm83HJ9obykyd4wH24Xbp1nPbaQ2WG0w+H76DnzjcPjjHAFu
         r5t51X8ktE0GIV5JiLERrAZBQvqB2fMJdWWVG/haNnXbXM9gLFg6vXTGE+rmNKye+yzW
         OAssjlBEcV0T/AHE1x/XnzCEuGPndPMyHRTYagrY+pGOcahpkvqEamRQ6qbxPu2CT6O+
         j6aA==
X-Forwarded-Encrypted: i=1; AL+hErG/Ud1NXK4dn5v7sporTPbcIdR9mzf4l0/a7vroGp9etu5loM3Fslrt6Hf2Ye2M4UcZnlX+o2aDmjB1wkoJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+6m1K2lNsvH+qYKPFKkNShMSv5kjl9FRbMbYIlNbmNTq41E+d0
	eWOV9xHmmjViOcIucZ12NMlIQ7kCEx5sda7r0DtNQw8czPpPfneQiJF7
X-Gm-Gg: AZFdTZfuCAlKMQPiC3W5LtRkP4A6Q5kABGT/dylUOvqvQfNdpFXPiChNFr5LlAI4vkb
	Ana9VxGLCYoOsGTBq5OlbjQEu5KXoZAI4UbdM9pwKtTPV/IBjWx/t48ClTf1i3GTUn6Raq1Rx4U
	ga8ja+rv/fySefT5Tzfo4395l0X9BQL6nGZVC7N5/zAQpJZvGgBCUOtwXT/eaQR1gk4LboyRIUj
	Ra8AlSns2LQ5eF7/9l/HVOZVjTnxg/VGRmS4O4eSN/Ua/EUYJO26rpZCHja7cE2dTh1SRnJFT4l
	LXqTwZE+mETAK/6/ktIwEQnzUW5gouwOHe6kjGjcspnCaMrnWjBBJkJkt/cwChiXISJ/w4svH0S
	HYlT/lc1n916sX2YkbgNTEUjWD6mGtkDTdYqE0jFXLOJIES3yrTFEZkaI4VjrBrEq0l6oJZe/2s
	/bCEkrp2Ioa9j1YWfu0jekwLQpSfRFwj6m2KMyueRQd03rsn0o80FMEQj/yUBQ2GUDrBwranMjx
	VKCdPK2fxHnAFHu5HbelFfXs+mbRKo/QHxp1ptUVFZXK2Xdxycw2FQExAM4XHx3PHztw7QaBiU3
	wK9lOZc+aTP+W7V14p9Bvm8RPz9Xq4ZOOlFVKJ/DDz1NCAvS+0S6i0UgKPKB2la1pNKhHtJjmNi
	3xiBO0sEDmvyVkcnXJMeSd5nt
X-Received: by 2002:a17:903:3bd0:b0:2ef:eadc:5c98 with SMTP id d9443c01a7336-2eff6f86b0emr95446435ad.0.1795096503762;
        Thu, 19 Nov 2026 05:55:03 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62876a6sm30641315ad.63.2026.11.19.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:55:03 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Sargun Dhillon <sargun@sargun.me>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Chen Linxuan <me@black-desk.cn>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: restrict pidfd_getfd() to the caller's pid namespace
Date: Thu, 19 Nov 2026 22:54:52 +0900
Message-ID: <20261119135452.990-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3e4103cbcf7b76535e2f957762174515ef00f08d.camel@amutable.com>
References: <3e4103cbcf7b76535e2f957762174515ef00f08d.camel@amutable.com>
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

On Thu, 2026-11-19 at 14:42 +0100, Alexander Mikhalitsyn wrote:
> It it an interesting point, because pid namespace itself it not a
> security boundary. While user namespace and capabilities are mechanisms
> to manage permissions.

Hi Alex,

thanks for looking at this.

Agreed, and the patch does not try to make it one. I followed the rule
Christian suggested in [1], requiring pid_vnr(pid) != 0 for operations
that grant access to additional resources of the target, which
ee8323fdc827 then applied to the namespace ioctls. pidfd_getfd() hands
out one of the target's open files, so it looked like it belongs to the
same group.

> Currently, you can do something like this on your machine:
[...]
> and this will actually print hello in the Terminal 0, while the process
> doing that lives in nested pid namespace. But this is not a problem
> because this guy is a root:

Right. As far as I can see this also works for an unprivileged task of
the same uid, as long as it can reach the outer task through a procfs
instance of the outer pid namespace. So pidfd_getfd() currently behaves
like procfs here, and the patch would make it stricter than procfs, in
line with the pidfd ioctls and PIDFD_GET_INFO instead.

The case I had in mind is the one Jann described in [2]: a task in a
child pid namespace that gets a pidfd for an outer task over a socket.
When it has no procfs view of the outer task, as in a container with its
own procfs, that pidfd is its only handle to it. There, the ioctls refuse
the pidfd with -EREMOTE, while pidfd_getfd() returns the target's file.

> So please understand me right, I'm not saying that your point is not
> valid, but I'm not sure what was the intention behind pid_getfd() API
> in the first place and we might want to have semantics and model close
> to the one procfs has.

Understood. If pidfd_getfd() should keep following the procfs model, I'm
fine with dropping this patch; the inconsistency would then be on the
ioctl side. I'll leave that to Christian.

> To conclude, it looks like we have a little bit of inconsistencies
> around here :-) [ But please, don't go and change anything in procfs as
> we might break some tricky use-cases like CRIU and SCM_RIGHTS users. ]

No plans to touch procfs.

[1] https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c153cb3f9f74@brauner/
[2] https://lore.kernel.org/all/CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com/

Thanks,
Jiwoo Kim
