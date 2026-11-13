Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584680;
	b=MzORqxXC4dLMpyMK+0m/vREVcCikuRcVyqmH4JbSZgIaCYgBOsscR0PoTENZd8OaCwl+
	 zlkxIV3XItYBmWwn60CtcN1AM0e3RhiGwRHV91o8LpZ2ZWM5rg8frcc0aN0uNGlT/YSWe
	 Z6+haJM18XHH1Y97aGtxsIdV/BoY1lG6bzpNUu661TlQazinR8VUOjHo9kTf4iqpJT0gV
	 mmMlkmx/v7fGTz0C4OP0hpbjc/s4xaQCy48mdg68RtFsAPZuTliq0w+WTc/rsBzGzYI1H
	 gEwtNmziD45PdQXip8C4VQQhB0JfDlR49/NgDdF0snzhwxpGtRq3cp51ZAiFJw32jeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k3fq7sobyjyzCNZzJN1bjMh/9ywA3Vs0nu6XoBVK3sc=;
	b=mqKzxp14QbIL/C6vHHFcG3O5Aif3VCEs9lZksveXRcqggJw73QkLaJZxZ8Zb9gpEnDSC
	 kgQZig1l9pPHYNE1Hu2B98+rkaF9uF0lMwyxN29i+YZEVSXtxlgmyTuuHyIlUq+j932uR
	 UGjerakjXBZrYb+Iai8R72was88CPj+P3EPU0xRfNiJI7HRsYvf35MkUdQyifdEGSkugi
	 vq3pIy8qdMYH8ephuUQDEunqoxgBk57W/YwyMq5X/TkSPw+1m6esQBU0T+1noMozqJ/2U
	 pOsP57cIg6DcRIWPPnTVNIfKKD9nCwwx+pVuT9qWnshCpZgIFBqZfeihvoBA44Tvm9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Slc2SJQy;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB5606A883
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDB5606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Slc2SJQy
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b1535be329so1179406a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 07:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584680; x=1795189480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3fq7sobyjyzCNZzJN1bjMh/9ywA3Vs0nu6XoBVK3sc=;
        b=Slc2SJQy0o+vUZrOsbK+aKIq4EI0IHDy5IaM1eGdDPfCjxpZVYHQRuNfeHwqf6EE6t
         uwe+ey69VctbElih+X+LuaQG0m6fCoNJ6X0jubKAuhE5NmAp4SnGSOD4nPq0XCLxiMLF
         1Gfyzm+E0NbITwpwTA15YJLNWbWKeIWKus8Mknj8dneQl0DuwXpSaSxle+DK0ZJqIJx5
         oa9djP2LKWzb142nfgp2ONsXcM4CZTBRZB4cOdKcqB+B5c4GTwiiVobD+iH3BnvlarRv
         Xdr3E6WRS8XlHl2uVy24nNE8+GDhFQGkJgMTw1bBsJIO8CbaCnKvlkVgYMU+tVgfroam
         OTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584680; x=1795189480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k3fq7sobyjyzCNZzJN1bjMh/9ywA3Vs0nu6XoBVK3sc=;
        b=LhzdXQZJMpoEMq67cf5yDWO/rv9TUzHo+3oDXv49N+FVGXMompG1CCLImK6UXadFtw
         bI8Ti3HhA1p5ybiJgaycj/msTuP3vBg4rt/GmoFXVXVb1Oi0zM6r5kyXyKTpWjBkIUx6
         kTxsVk0Dt2eSncZDGTKduCho2RK4+p5j5lXU0NTSyKPLkHTcXkmGetYyNYTLdQ3zJ/95
         Ql8ZCCioC5hpOvfWnpFptli4BQjN0BLFXUWP0zfdHRMR+VeZvKBcL9cLM62aPe6kx+iB
         vnKzINSCCR08Q8BVRlG76D6QQ9C2Z18eDikGi1ZtyY6Hx+sx70HsaIfcd3a4pRx7UVST
         +39w==
X-Forwarded-Encrypted: i=1; AL+hErGta3oDMAUlusLH3L28ENq0DftF0drnEdxw9KasvupytUcjVIsgK3RDaMS+an/2KNK4vZt3gwmJhfZNresq@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q9mdw0p/aPNSSZ90WUVFuAehHQ+2ypUe+/9dfNi16eVKxF7Sy
	xIxHh9CxyHATd57rUUtucnzBRnyU2L4eEFkeb/afjUHKE7/Rd5BFgLnq
X-Gm-Gg: AYBFou1oFlIWqDymojXTMYlcpmdphSBFf3FbqHlVdlNJ5CZx7/bXWuo35P9VklvgGQG
	Cw9KI4/1sDMKqk09xiJqnlibCoaEG7f9WjPaWuSjuOqJI2TZB0usPL9gPt4dkg8Imo5hsbzRXrj
	Pqe8oA7FIWzG9NQQCBdBSgFIsos/uHcUUXh7jkOgRaMBltTurwH0FMi9O0Mk4yZbNhxHjKdukZP
	POSwM6xUMlcabo+tRHquR1y1atwoLLK6BCIo1jLMVjVkiONsjAfxUtRaJQoV5QrfC0d2jnTDNh1
	x42UyBLXushv3a+54AN1QJsnv0qInZNTeEcj1Kx0QYI5i57thmVTPD+RHn5hsBF4sIieEUO8kuH
	fpUZ+D0MWkS2ayq/tagLhKcFdWzQHrfLxL8TW1SFOank4GQ312+Z1OxoTUsjQpvmJ8CAbOxPrao
	pTYg0XciOwWzcerAWTMJUh45lkAZp3awYNgSB2Eb1VsJ4HjOfUp6aL8KOvM6mKiLPr3XVSy4uMF
	YBTLXgeLxLLC6Fs75D9ls55U4ycq+JcJ3yoR8YaXfY7FWruyxGK+kPEvFxjS82yOFoqha1Tl2L3
	z0kRYol8bO9VizGx5JFzDpQNnP8n54ucTtby3FKUtUQDxL6HBbkd6yzkX4E4SJuwG4MfhDo=
X-Received: by 2002:a17:90a:d44e:b0:3ac:8527:3fc5 with SMTP id 98e67ed59e1d1-3b1b081b149mr2743869a91.3.1794584679691;
        Fri, 13 Nov 2026 07:44:39 -0800 (PST)
Received: from localhost (218-35-178-218.cm.dynamic.apol.com.tw. [218.35.178.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm2064587a91.3.2026.11.13.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:44:39 -0800 (PST)
From: Kurt Lin <lylin1023@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Lin <lylin1023@gmail.com>
Subject: [PATCH v2] selftests/proc: proc-empty-vm: handle CPUs without protection keys
Date: Fri, 13 Nov 2026 23:44:11 +0800
Message-ID: <20261113154411.568272-1-lylin1023@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109151912.156518-1-lylin1023@gmail.com>
References: <20261109151912.156518-1-lylin1023@gmail.com>
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

On x86 CPUs without protection keys, pkey_alloc() fails with ENOSPC,
as documented in pkey_alloc(2). protection_key_support() only expects
ENOSYS or EINVAL, so the test fails on such machines, e.g. an Intel
Core i5-7200U:

  protection_key_support: error: rv -1, errno 28

Before commit dee87e09b0dd ("x86/pkeys: Fix pkey_alloc() return value
when pkeys are not supported"), the first pkey_alloc() call on such
CPUs wrongly returned EINVAL, so the failure only shows up on kernels
with that fix.

Treat ENOSPC as "no protection key support" as well. Keep accepting
EINVAL for kernels before v7.3.

An AI coding assistant (Claude) was used to analyze the failure and to
draft the fix and this changelog. Tested on v7.4-rc1 on the machine
above; the test now passes.

Fixes: bf5add391eeb ("proc: test ProtectionKey in proc-empty-vm test")
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Kurt Lin <lylin1023@gmail.com>
---
v2:
- Mention commit dee87e09b0dd, which made the failure visible (Kevin)
- Add Reviewed-by from Kevin

v1: https://lore.kernel.org/linux-kselftest/20261109151912.156518-1-lylin1023@gmail.com/

 tools/testing/selftests/proc/proc-empty-vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b3f898aab4ab..a9d3c973a663 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -77,6 +77,9 @@ static int protection_key_support(void)
 	} else if (rv == -1 && errno == EINVAL) {
 		// ospke=n
 		return 0;
+	} else if (rv == -1 && errno == ENOSPC) {
+		// CPU without protection keys
+		return 0;
 	} else {
 		fprintf(stderr, "%s: error: rv %ld, errno %d\n", __func__, rv, errno);
 		exit(EXIT_FAILURE);
-- 
2.56.0

