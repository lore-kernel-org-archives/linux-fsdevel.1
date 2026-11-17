Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874672;
	b=WjqKSsQn+bQlVNNwiZEjqhIwXCR3kfCUIRCCEu4UuynpTC4xSc//rTO2TF7Uo8i8Buw1
	 yeoJcm4DJuWG1v2VpQEE/RhExCQHVj8LYXhRs2x+oYwiU3njrcvP/8xy4Z/VHbM/geFVA
	 2tdIIQBp6NpdOgQociByE/b1+HGwwY3WnLVhj7gZ1idR32Nfc8i5osT4TrHB6WmezhZaz
	 u77DCOfblVCJt8XapbeL2bEFOBlHjce9L8YjGwgoHZZWZkVSpkUBaX1/nCAwxircxB/cL
	 R/ePlH8rkDxTcrCu1XqS/x5hbndnqqWnAay9cDahvRQH3SlGtqq0Q/ArHEVXanw1bVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=g1CqHinjbY2OgjrRQj70R8H/Be4OoPMLQb2dQpJZInM=;
	b=MeEkL/mgTw4V07LCwMXVpkqWn+0VMtKLnXIltVlymeNWPCfVFCmmmuHpIfuNUxtwhfRx
	 e+eJTevSddtw7iM+RQwTZDhXr/oDaxjf3vhOjvb5KIxh6/lCZTtYEYGQ/Y3tgVBqGB6jb
	 Dxm8HQMB81FKfBy06dklgih/+YXHYYOs562edlJzL4eHlDShgjYfqei8Swzj5yZAzwHVE
	 ssHAFHaQGHkEydx3kPJSeCWNT19u2oWDbVXqeSuFuUsHqjIgBkFoF0FIDqYzp2kaUlUQr
	 1StqEKPSsnJwkaTvaE6IM6pGs0CUO8xSFGXpaBFbjwltu7XjpKZgvnhyQ7azL/p7ovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiup1+eY;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F7606A889
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034F7606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiup1+eY
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so317829241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794874671; x=1795479471; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g1CqHinjbY2OgjrRQj70R8H/Be4OoPMLQb2dQpJZInM=;
        b=wiup1+eYOz2l3MPJFqbC2wWZVp7n9BZT7aJO+IKN0DSmQLsuWzJH2RJVc5Kblj+Pkx
         I2Wtall3JpLxHg1fEoXnXo1+85nJ5O7mP435yfASIJsWSaoQjNwEGb6AyT2vAAytemJJ
         WZI1cwFuTlBRTWuCY4ED/Rt6jbEhvGhNszXnx6gz/ymNQFEZ880Bby6NrcCNeU+xcT9B
         NyNFratNa0H1yQs3em3My5L1e4/tGZKaeSUX7GghX6EfoA7qqGpPf8iTFTxOy3XeyaeV
         62v30fIoCiRJXjYUo0kxV6GHs4Eb8l7C8ofZ1YUXJ0aFPf/mKXMdzICjdJ3l91+42QY2
         2xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794874671; x=1795479471;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1CqHinjbY2OgjrRQj70R8H/Be4OoPMLQb2dQpJZInM=;
        b=Jl3w33dMtylFuTnPSSuLooZ1KtZkUJLXAsp+AP2PF/kFWLsWg/PLnVERTFijFTpwur
         k7+kvIIC8VZh03aBYVC9+R4QyK5w9nSzCQN6xwXrM0QSYduh2SWbtYZPzeSSIvRuK47h
         B7T7+LgtaFGxzPwdK348jeJFM0p5D8680TDAWdebLIPfMIEkmgInN1WRwxtVaKtVXyoU
         aXFTolJbJ+XeelAHUSgYEW/ivQv6i0SzYaKU+i8u4TU/2Cj/JHwAw1fgoWfvRKplxb7g
         /VH50QmEsth/hoXC0VhzKtphpRI3Tu+DpdPFuo7Z5e2FITeR6NbqFoe0mYe3t0bpA0GE
         wnwQ==
X-Forwarded-Encrypted: i=1; AL+hErED03FcX9PaHWd65L/Pv8lCN1XD5czxGoAjhDdE1XfdkvZCoZjYIJdnVvyLOGfoi71lJ8gh3CUKFkw95Re9@vger.kernel.org
X-Gm-Message-State: APuU4Z8JJuDETqrQOSurwufnu/dhjr6rvSZgtcuW/7GNvEDNxlZ8rQs/
	Pum92jRkz5lIrjuymCBvxNvM6UFJZSdZg4MIiT9L7y0KCwoh1yVlHMLU
X-Gm-Gg: AYBFou3ViJY5p4LBkKvukB9EXgAKXHbxxGCKc0ti6fYG77XcK96mOLVvGFlh1z9BHUZ
	SCnY/K79QvNhYfGHlC7P2mT6CcbN3OefTFxeqXNOXqYlIDQ2mmEysbtqdixI4DcRNhjDcaqAg8Y
	nxE/KQ+ntw11TftRW1YDVR2IQ4jS6w3eNUv0WweocyhDvV9kiuihYJx+y3csvTQAbCN4jhh5qnm
	uwhtzKepIxCEego4ISXa2fHYGms9cGp4s53C7Aa4Wu82tIDLOJ8zP+IwJj/XsF7mTbAnI/xKvrq
	X6aTzyKaVLm77DHNXTQtzIasdO4t+fZ3ZMXNq+ejaPIX5Hpa0js9kzts0D+HvYmWm0M7j7M3cmf
	YNolUyzJjHODy7FlK+Xa7A6oPcSrPVaM9IpyOOLs9Oty0Ub3h7PYHVDhLZ45ENIUKqpktfAqBxr
	Gq7oeCk5Ckefmv7hk81QmBOM5cklgT67uVZRT4CMwazN3YnQ2Jx6f+tBQCp2TfxyrZxrLrmTpYy
	Ti3E6WuvpnnR0PsFxX/2mWT/U0AFgUSjxxca1nvVFcLiVe/IyScB/Z9CJEEC1gvA7Y7A0E4Y+nX
	ObY+755WeOSQOTgm8L0LEWbSUEHRjwhDmKhMcHwIufojtGbNtF6HeLCeuIo=
X-Received: by 2002:a05:6102:54a8:b0:7cc:905a:331a with SMTP id ada2fe7eead31-7d69f73327amr262988137.14.1794874670820;
        Mon, 16 Nov 2026 16:17:50 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.79.161])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69e0859ebsm1155725137.10.2026.11.16.16.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:17:50 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: Alejandro Colomar <alx+linux-man@kernel.org>, linux-man@vger.kernel.org,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2] mount_setattr.2: Fix nonexistent perf_setattr
Date: Mon, 16 Nov 2026 19:17:48 -0500
Message-ID: <6091006.DvuYhMxLoT@daniel-desktop3>
In-Reply-To: <avuYP6-OQJMhLqCn@devuan>
References: <6099049.DvuYhMxLoT@daniel-desktop3> <avuYP6-OQJMhLqCn@devuan>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

The problematic reference had been copied from openat2.2, where it was
fixed in bbed82c0693a ("openat2.2: tfix: fix minor reference typo"). I
performed the same fix for mount_setattr.2.

Fixes: f3a5ba3f0151 ("mount_setattr.2: New manual page documenting the mount_setattr() system call")
Link: https://lore.kernel.org/linux-man/20200929223509.11783-2-cyphar@cyphar.com/
Link: https://lore.kernel.org/linux-man/20191003145542.17490-1-cyphar@cyphar.com/
Link: https://lore.kernel.org/linux-man/20210730094121.3252024-1-brauner@kernel.org/
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 man/man2/mount_setattr.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index 0f4b619d8..bb8da7ca4 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -846,7 +846,7 @@ acting as an implicit version number.
 (Because new extension fields will always
 be appended, the structure size will always increase.)
 This extensibility design is very similar to other system calls such as
-.BR perf_setattr (2),
+.BR sched_setattr (2),
 .BR perf_event_open (2),
 .BR clone3 (2)
 and
-- 
2.53.0



