Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF8369D53
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560943; cv=none; b=oo35ktwG4KpfIqy//W4yr/KtzTGFG6WqzIHIbyMCmKiIMHB4B5VTuq5LsjwgWQYtATUyC3//INi16cTY+zg+gtnbr64bo5PeIYCBDRC34ZULaAeELOFBhe+ycK15xkDnbyskY6Ij+WQso58+3Aqk+V1h86zUMqcKiULu9yfZrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560943; c=relaxed/simple;
	bh=ihHQCwHfXIBTqU3cGgDQUJLl42Sx9EJlpyZHqBbkqs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4q/KAvbMi8SD4YrQ84A7U6+3u7/hJKWhcI6zL9/I11GqvtYT2BgSbIfXlcadUqx2PgtDEiseHDXl9e0zxrQ/dc+DeTg2FMInGi5HU3NkAwsbBEnZoBsQbOGRFWkDd6qM/c2EoBLu77yXBDsoJ7z1sau5t+fGnAGcNZf6EFkAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEqY6ykM; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEqY6ykM"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb752so1235628a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790560941; x=1791165741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIHLpa6pyR1JPLrjcI2ICfhGuunWTnStXbLN19mlT3o=;
        b=UEqY6ykMDfj+gOpPwO/ULeGtruhHOiNEq5d43TjMBsQ7B0Of+fkK1UdjxTbaNTgujE
         kwdxbwQEgMy0PHHknJatrYzyhbm+WgBiFbJsYH1soWnXTUYEMELAvLy1Isb4BSxkY3JQ
         VNGxmVRptw8UEBrTunCVsw9UazhVXoKYTbFPSJ7osET38jNOj0/EiauYKUKRlkABEatu
         899zJKg3hln92a/TG/Ixbq3XZvJhTjm5wCPLmnx2Zkuaj5xU65DUXjZyNlaWU3CH4GLE
         7te/BIGmnBij7SKPxNZLHdij4AVffStKdP2RLuD6xJPJbCv/wf+YERIHqumqRW6gCZ5n
         NdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790560941; x=1791165741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIHLpa6pyR1JPLrjcI2ICfhGuunWTnStXbLN19mlT3o=;
        b=0CweCod7eDg02N8A018Ds1ksIvp0kFITlHQ7KQeN65Xa5bxK2o4i2768rXu3sMB77+
         dK2OGGggrzP6QJsGXlPLCwnoKGS/aezWQfr68vvRuou2JSLIuESqYZl70yp7S/E0luAc
         cFABcDtswt8Je9efftvc8NPTnTwbu62Fuc/Zjk+M9Qtz0u0DIOqq7VMgkCr+b9QJsGig
         NJR4xr6olgRRyWhI/1LbEOBFM58ho9g63ZPT+LK5dQT1tkBqRQD9k/nFlhcedrDp88lA
         B6bhygHOjvu/pwhU17wcMFV5Tky081oKeHbyDmg+TNPJx0EK91/BDHqyRJ/rs+7FFf52
         HLow==
X-Forwarded-Encrypted: i=1; AKwUvBx1lv/mf7kUhU94lzfnDqllHklkBBppE6ctG855WLlY8GLtyMeb93LyRYuQ5sEgJxzOBvqkQVrH8oFBvb0g@vger.kernel.org
X-Gm-Message-State: AFq9FYJSoMV4xVJMAU97D6oI/TqeeyaTB/AXH1eFAGcjl8dsq+rbklK2
	f4j+zp7Gb+SBU9+10I6lVWhP5qtXzcD0WSEVM8SMPgKM9Ss+TJEKndY2
X-Gm-Gg: AYBFou0gTRrsW4NMNIebqDsNrpeGcqt+Zk9HUhV3hliGXPfx9frMnjBimgWibNftT2h
	OIxhTtUKbB5HPkCDoZBqMKIMTiisJwDb29+cWiQgEHHbvU9RNN1LUWSLJPq+6e4mvb0JimaTx8u
	X7T1larWMa/D4LLlIxKR68es4jcFNSN4hWI0vZt4eDb8oA5fjFiQzBgUqGbBsQQDJE6OMaKy03I
	IH+a18pcIcacBleNWYkakhKs1+ScRclj7vbNldZydAEnTURbakduLOcTiQUOprmuTNTTijbkWhg
	YaVmMYL11XLpEeipDW/KOTK91Ouo6NJaBhCmNN+EqtINtzblZQaSRoSFpnzOcniod26c5qoDppe
	7sbROsw2V9/rOg+FeHK2aH2fUc79OgpwecXxIrN5bnmMrd0s/okYR7KcsvOKQjdjP42qKhU0riL
	jSmHF51C9qFEKg9w22AMCPR1LqJQeihTVUYbJybbeXi9uSGKorWRCwgUF9cncU1CixmBclT9Zld
	SmrfQSVi+c=
X-Received: by 2002:a17:90b:4fd2:b0:3a2:b0a1:456b with SMTP id 98e67ed59e1d1-3a2b0a1459bmr1351002a91.47.1790560941492;
        Sun, 27 Sep 2026 19:02:21 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e05d674dsm4631129a91.4.2026.09.27.19.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 19:02:21 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] time/jiffies: Saturate in mult_hz() instead of wrapping
Date: Mon, 28 Sep 2026 10:02:05 +0800
Message-ID: <20260928020206.977522-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928020206.977522-1-zhanxusheng@xiaomi.com>
References: <20260928020206.977522-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mult_hz() converts a user-supplied seconds value to jiffies for
proc_dointvec_jiffies().  proc_int_u2k_conv_uop() rejects a result above
INT_MAX, but it inspects the product, so a product that wraps arrives as a
small value and is stored.

The input has to exceed ULONG_MAX / HZ for the product to wrap, so the
value below is specific to CONFIG_HZ=1000:

	# echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
	# cat /proc/sys/net/ipv4/tcp_keepalive_time
	0

18446744073709551, one less, is correctly rejected.  Dozens of sysctls
use proc_dointvec_jiffies(), among them tcp_keepalive_time,
tcp_fin_timeout and the conntrack timeouts.

Bound the input in the shape clock_t_to_jiffies() already uses and leave
the INT_MAX policy to the caller.  The bound was open-coded as
"*lvalp > INT_MAX / HZ" until commit 2dc164a48e6f ("sysctl: Create
converter functions with two new macros").

Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new macros")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 kernel/time/jiffies.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 80c354811538..9b3487d40cd6 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -101,6 +101,8 @@ void __init register_refined_jiffies(long cycles_per_second)
 #ifdef CONFIG_SYSCTL
 static ulong mult_hz(const ulong val)
 {
+	if (val >= ULONG_MAX / HZ)
+		return ULONG_MAX;
 	return val * HZ;
 }
 
-- 
2.43.0

