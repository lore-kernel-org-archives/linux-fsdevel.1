Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5E38654F
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046763; cv=none; b=jQq4uqsSSFfafCIKELws+t9cTMRuPNZtng0kmKN+Wbf0yd+TKxgKAwpha8/9+1209sFIowHPZyi6eD9wg5KabL/ugNdC2rAg/Q9t8KOGsitoR/oSko+HXrzseXf5i7TblZEnKhPRHXJF+AbvNesSQF1VvMlzNSYEm2wHAdHLuE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046763; c=relaxed/simple;
	bh=ye58AcR8tXFspNeWhGn8kt8C52ePCaI6/gm4KfvrHKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkCEGUY49T6FgwAtf04Dci6CixTfc8HobrnLaB2AaJGSogogqh1otil15R+FFIRls76PQRSPUszMHipGflSgBk3Uft6vEHP+ylmt4DbZ8PM00VVET6Oc9uXkbIuZX4eS+z5/7NRjtrRHr8ZbY9wKzUINUS6rRSAUcATb8cpJTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA9Sa8fz; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA9Sa8fz"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so2767330a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046761; x=1790651561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUZcYYbpW5Qt6ZCdEAJL7kXTluYm1p3zuK14Agl65mQ=;
        b=iA9Sa8fzylbbqb6qrlicP5KOJSav3fZz/JmnXEnvrfcYpzGLF6VtZnTaHNmFb3dbr6
         dRJt/k28eus+oin9iKYp6l9aAlrTfrlYzsCezpbuGRqiG3k3xZIFpsHKeIrww7SKBFHY
         Rt2FjJB2nl5AdRZM2V2EUb8T906gEtu1GkuvAsMtpk6kI5oQEjztfCbZFc+9Fak73wvI
         NpuRafFfZcvxv1SbE/e7fWsrDUBUunTDIT+Lx1BMH50th6ax6qlxlELTkqUvYQIV1Z7R
         2veQhkiCp6odXNQDyHk4FVj3e+zfCK22J7jsORaL+a7LBqJdFApowBaLw5ls6RvJPkRf
         J5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046761; x=1790651561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUZcYYbpW5Qt6ZCdEAJL7kXTluYm1p3zuK14Agl65mQ=;
        b=slVBk2dpmSbwPrOIn7RW2DgNf0gcpb91usv4RwIPGXuNlFCKbiKpDcyq+9TAfQIaDg
         LNGev3WQ636ESF8+knebjawixrUMMGF7Ekiy7VMX2Qg1DiU8b8zV+E2fW1wurWMgu0cu
         G2iGplyMDfkJvohAeEJMltaVKgttOyGzvJ5HWaUh66V/9tf0IZPkBn6yHaD5NgT/klJl
         i0ncLkWojCkGGNjwazhKHSVnNDtYcAJkWtyiwPiBvCAkgZxKIKEbznfU+Y1/9rTHOmIu
         9B60NP5L7srWmNmfr6mGiJ1loqGWfBSpJtAVBAhzq+mWo3Q/EWDoTM41u3dmhD/vCdHw
         UEWw==
X-Forwarded-Encrypted: i=1; AKwUvBw1zJVouVlC8RuVP5gr4aXiZGiS8/lbmwToKzznL6LgVq/e8bSvfUKJ76FUPI3u/f61BuiK+ZQXO9gO5pHN@vger.kernel.org
X-Gm-Message-State: AFuF++n/bymlE5rc6yuOrMZfrPZszcUOoqa/ODtHMbHxbpJzKcFT2sAY
	EmKxwWWHh35MmQFT2Ex2Eybmv08AH6UFhyI1rOPr1lYFVaJjtIOL6RMb
X-Gm-Gg: AYBFou36Dud4CDVuiH9pAqsw7oiCbGhpVd4dsmjTdQgPeXs4ZKpFu/DbPkY0PhpBeqi
	xQVJbVArkzIu9K69Js7+TPUND/7QOlDyvBSXBjIMWZKEqtA3oAPK+o3/K668Ouw0D5JJ4bn9RN8
	RH/aVPwOEkBeZ2m5gXZWyCA5PIDjseKjCLLcPazibGormkUAzWJ+/SlqBR43cO6GjYvXzsvbm3P
	IyKgEPmM2XgMqCfM75HHdY30aCsXSfFFCYWzPSGopgOqSkYC0tY1yz/ke2GiMWjkS9nNIuDi2T9
	VpjP4vTDxPxmmztgJquXNmlH2gKLoCRvG5f3XgxU6psZeBvr9q+xewXKsKBknPEB92CuTphHzzw
	Nnfyfa8T0l6KBnS7ofRfdrUshIZSmX5dbWHZ6pfu5v+pBAYGc8LQf+ThYCpofxqioYmrVBRGbQh
	D16qtqvfojW0sK5/P0ouVxNFuWkHSZKpWUqGt5UiZVZZpOD2ZdDn6QUKRp+KjgP3DsxCI/VCHB1
	VKyn6NhvGU=
X-Received: by 2002:a17:90b:3909:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-39e54f35cf7mr23022914a91.15.1790046761190;
        Mon, 21 Sep 2026 20:12:41 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cbe3714sm294627a91.0.2026.09.21.20.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:12:40 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: kees@kernel.org,
	joel.granados@kernel.org
Cc: kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] time/jiffies: Saturate in mult_hz() instead of wrapping
Date: Tue, 22 Sep 2026 11:12:28 +0800
Message-ID: <20260922031229.2300283-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
References: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
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
small value and is stored:

	# echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
	# cat /proc/sys/net/ipv4/tcp_keepalive_time
	0

One less is rejected; that value wraps to 384 jiffies at HZ=1000.  65
sysctls use proc_dointvec_jiffies(), among them tcp_keepalive_time,
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

