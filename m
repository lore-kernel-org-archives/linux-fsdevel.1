Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624289;
	b=YUjxMmCgY0Qkhc09tl2bsoJA9El0hzd/Y8I5SpshqXI9JKeM9sUzihE0NSAe+42y5HfT
	 1oWCXbZssF3iwK7QDIdXhz858vGKNgJXnwyH/bDCXwk+/TaepU7I4HVVHiJPZGdjuworT
	 fC2qdxvo6XWFrfp4wEySzt9fnJRpq7WeyDwMeGlt3MVzx+c3lRoNjHonRdi33JqTgdW2j
	 w3C4sPIHGUPw7nyVyHK8uqtnefeQ3VKvz/4+rpn40djypqz43RTsnDSec5rSMaOZIMxZd
	 bdZv+KqvlCkyrRtDn3GvbsfMbFm82LYZpZ4ckzUua9KmHiMWJPyDgige3kisRT42HhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NjxkkFfQFqJqbORPS3WtzVfM2hxrb9c8ax/FBEgm1DY=;
	b=cVBBMSpu7Y0ftLzGtK1fXO1ha/jOn0sSXGaB+i4Gwnls9rF2Aa4JZJqrO61wCNIQCoNx
	 /7ne4BrTPdXuhXuO7IqnMRDv6g/U5XpBxToB7uYW9wBu7s+MSWyfe+v+Co3yi/KtDrnGL
	 MLJ9fS1upf8lWUoxUa2mu8AaWf1Or2oOrhAG6oZvn9N/JD8/RjkV16bSbGYlDXcvktJ45
	 S/uIzrz50ww8xNT7GoMMT6rXaV0OJlAYh7luVxcdzVeMQAPR9YyBu3nXSg7LH+fF+fzeO
	 mIqgCK4LjqpkP4UsY6wNPfpI2auUW13WVy//2UPI9UXhGenAk94utG9Khjc0qkPErng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p/Hhig7P";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B8606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9B8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p/Hhig7P
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso3196968a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624288; x=1796229088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjxkkFfQFqJqbORPS3WtzVfM2hxrb9c8ax/FBEgm1DY=;
        b=p/Hhig7PZFCT9Fv59nbo+wU4gcH3v0e9KqdiRfY/0ZMOqNzyBVyvyltuIttm8+a28/
         2bw4cuEpz6d0FQf9C0iW7hDPqbKk0YQMwaoisbXPgenGqtHQ6f9aPZwCT7RiRGPx3ZvK
         QQw2BdRAO0JYtCULKlbg8He5cOpXatIBWGxD9ArEaAarcaaQOdKXmW/r23PYzO/cfPnT
         00GQjzQlNwO0JjxasZ0wV7BGAdWyn95fTYhvOPGmQehS+v5YSIyxc/pYqQT/q2TnloeA
         Xck2E4BAnkkiGqXJV+ky4Cad7eegTuYenMxbjsWtebQWlXmKOr6uCNX7LrsHW6DrV/VG
         6FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624288; x=1796229088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjxkkFfQFqJqbORPS3WtzVfM2hxrb9c8ax/FBEgm1DY=;
        b=VmY2+46qvVwNUUUewyeUPcGH9EuOO3Dh12HLYD8qLoSWeMeyw7yA0AwrtoCw/4jrYc
         tn7h1IvYFHOt/CH/Yl0HBocIczKF0iAbO3hVFEgK1RQDfhdDeemrmojY2LmFZUpuNbY7
         TNFYiQipd66TzZaKtmw5camAezD3389M8hWjnpl9CmGQ1sPhziaa0Rp4kSSnSUvULjNU
         G/QvRNI92FPwl5mYjoOJtU+0b3C5uAQ1Z6WZNBZBGeL2yJyAbpeeb5Dc8OvJInjc6w3H
         0EJ44WpnTxmFt23MRiSmA5bzHoUGh9MmZ3F97OwUzIYM5wNLziIHPgItIsfvpxEa5MTY
         iV8A==
X-Forwarded-Encrypted: i=1; AL+hErFXkxh3MkiQlj2XkGy65cju7BrjdWaHOS4gCluD/s78hm3IyW+QSZXoqIZYeTxE/wu7mABnR4bfjbvlJQ7S@vger.kernel.org
X-Gm-Message-State: APuU4Z8dtwUaNg6VuIjAizj9ZCTfydhs2WV8ptL6iqDgHvAqlWEz5YmC
	/DbaTSfPRlsB/MaHqlSkSBL1lJG7YTcd9Ygh14D6pyf4l7M3nbaolPyz
X-Gm-Gg: AZFdTZfEX667C7TPsIoiyHpk8x6PFYLAA4iR08d0dYeTF/gyqaJUF/XzKGJE7fXyD3p
	YEbZGldbDd0bjYNHtom9D8Q/e0SXcH7wVORA7DLIDWWL2QwsgWevZU/czFJ4ngKNoVQf6BqXk9a
	mv3mh+xRqqKFAvhoG7Tdlm6B8BxMHf8HxmnLofsDOr2hNhoV7f5nTpGEb3sLeyzTdOVEt+MI1ZB
	ZGooRfcNLKZHth9E7Q5Z0fPYORVre/9Uouwg+pfsMEbDQPMXLKwqJLcg8S5w3NfT8OVHTcvIQTB
	5nmUsxyk7u2HQ2NO7FfqBRSjzCYOto/Bm4i+Tn+cbJqvRXgMnXuFsEA8wDXNy1p4Du/KFORv/uA
	XQKKbb1XSbHdKg9nu0w3Wxgtta1JPHIcM5b9a3mQJcJXvRiAzK+ie9dTq0g3L94YlInAS9n9rtf
	Rr66TlvHniPXpzFMvWxkutrfbkqGT8ISnNHcP80UdfhhNcW0Mgx15Ya6TVsy/U4WTHZsNfRUtul
	/g0fCH5Xy0jge45GxlzraW398MuK8pZsNYoQ3jTuSaeUUUITiBIyTrlc82UR8MO/zYo/z5rWuY9
	vMQQH/HlJiM3dkLYTZfEBq2uZj7Tr5//5Vh/tpnMh3w8KasdyZdadJ2Aea9L3z7bTZ5vZiGHr52
	czG6x40hgucLJci3OxxSIsFLCrI2MS/U=
X-Received: by 2002:a17:90b:5543:b0:3ae:8106:6074 with SMTP id 98e67ed59e1d1-3b41c8dc6ccmr16588554a91.16.1795624287733;
        Wed, 25 Nov 2026 08:31:27 -0800 (PST)
Received: from DESKTOP-TPPBPA1 (36-226-201-204.dynamic-ip.hinet.net. [36.226.201.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm27421770a91.7.2026.11.25.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:31:27 -0800 (PST)
From: Roy <rongh7426@gmail.com>
To: William Chuang <founder@logarcheon.com>
Cc: Roy <rongh7426@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c75a7db5ca6ae96ed2d4@syzkaller.appspotmail.com,
	syzbot+8c0a48f6c8357c9da819@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] configfs: give the root directory inode its own lockdep class
Date: Thu, 26 Nov 2026 00:31:21 +0800
Message-ID: <20261125163121.620898-1-rongh7426@gmail.com>
X-Mailer: git-send-email 2.51.1.windows.1
In-Reply-To: <20261117065314.4309-1-founder@logarcheon.com>
References: <20261117065314.4309-1-founder@logarcheon.com>
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

On Tue, 17 Nov 2026 06:53:20 +0000, William Chuang wrote:
> Not tested: syzbot's own C reproducer.

I tested this on arm64 with a syzbot C reproducer.

syzbot has a second report of the same cycle, "possible deadlock in
uvc_func_allow_link":
https://syzkaller.appspot.com/bug?extid=8c0a48f6c8357c9da819

I ran its C reproducer (it creates functions/tcm.usb0, the
target/usb_gadget/naa.*/tpgt_1 group, then uvc.usb0 and the
strings/0x409/iad_desc symlink) in QEMU/KVM on a Raspberry Pi 5
(arm64, PROVE_LOCKING, KASAN), mainline 65e4fd942f72. After it I also
ran a teardown script: rmdir of tpgt_1, then mkdir/rmdir of tpgt_1
three times.

Without the patch: 2 lockdep "possible circular locking dependency"
reports in the reproducer run, and 2 more in a run with only the tcm
mkdir/rmdir steps (no UVC).
With the patch: 0 reports in 3 runs of each, and every step gave the
same result as before.

So this looks like it also fixes that report. If you send a v2, maybe add:

Reported-by: syzbot+8c0a48f6c8357c9da819@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8c0a48f6c8357c9da819

Tested-by: Roy <rongh7426@gmail.com>
