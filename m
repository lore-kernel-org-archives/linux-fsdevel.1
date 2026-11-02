Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630855;
	b=oI6/7ap4/pqbWxAr1V0rNrcYE5z13a0MIlw5XxBwVQ+eJRnDK5YjAB8t0OiPrUOV6klZ
	 bh/pA6rXWIV7EoNwyUlXGEXkqpXVD+H2j5abQTP6kjddG42q3Ye9+e9P4j6XSceXrhnIR
	 I7NqR6/8mKm5+8rHgdrJD5dMnps8PH5HniaucEsCXH3r03tmRm2qMcrZIg+Ij83KLtSMB
	 fbgWcM/nfcjlAwfRPlAMfGHYmpd54FvpUKBk8PwBUzh+QmJPxclwgxvqp0tP5jQf77Fjh
	 zpO5rRnV3Wtw+EW0fjPM50IEFKGf/FH20vxQKyjJmDENhiuRQWlJZFIHRLY/sP5aflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oT4Jbe6Fru25zhLhLEJ1T9RC7Hvj88zj5H1iBQsA278=;
	b=XsZbkCJmYx3ZDp44qCiEzfID5rHi/g82Uj4emBEZFDqmvMhZSczB9tL6S4qMP/H2U3zV
	 WggAEY54cdMd+2G0KmTZuX9sM2pXc1MG12imjIh1fX+xSsTUdZS2Cj7caLxpbPgnWxIcM
	 qNStzk0hBqxYR7IPQCBfgxCOHAo/ZJMBIgjmqGQsfc6UQ16mQcjnpJNCQwoUkMn6tdT9s
	 PzXhkCUnc1v9h7JFwucW1FHXe7/VQnFPnaFaIf/EVEcH+i3+qIKAKPcEFJTm9T05XComM
	 JHxw74stXsS6t1KuHu2ivG9pFYzUbOFokoa3HkPGUC/2Ro6fpdRY2xPkgqXUjy/bPGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MPQtbUF;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE0608556B
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 14:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFBE0608556B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MPQtbUF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso25772745e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630853; x=1794235653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oT4Jbe6Fru25zhLhLEJ1T9RC7Hvj88zj5H1iBQsA278=;
        b=0MPQtbUFiIYqMYA5nkKT3jgVlsrDXFMLqLQG0cAkdVprvoGXa7fmPw74/hlGHHIpD1
         l7A1+FXZkEpL3a6cu9WXmcdZkGxQfHRoDORVZVhJkQK7Rn7tcfJhI+ZpYku2kh0YLmbO
         gRgmqtPpjxfZz5YWZNfSJ6tOOJiv6YBFcIowVZtBOmM3erF+BLvsHVrkKly9+baLFh+E
         xKoYCCOJbQjQCDqZHIHY8jOVQy+hHVb34aO8HF1o+uGDjG7iI7YpEg6ui4POZgvy4ZTC
         FMG5AbnqovPt4OotR/0vRTriJHvIlbm9/JVUjwJAu2R8pMQg9H/WQcRJIXD8uqXparxJ
         XASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630853; x=1794235653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oT4Jbe6Fru25zhLhLEJ1T9RC7Hvj88zj5H1iBQsA278=;
        b=1e9VfuEqiC0VveD8wwrpVaz8JcagUYYgKaNExHzJ2JwKtNoIusWr+NB8dUAGciGL5U
         NFU5wIBD2f7+kFRHfzo8bEhFg/FjWHSjg5kHj7Fv5KMxF+ZL6QyOT0a+xDAWURQ4Ag85
         2AGzFDjweN8HSKH3MgjdgWSlPw5VnEH2K0lBilGb8oib6nC9zvkPrK5YwAnYNR9soous
         vVdexYKHAX5LkZkbExm6/O/dRFdvP+NjIOhgVZ2eLh6mgAXA2X86v+SiWwnuh1uxDkBg
         1+Wg6FyudlbbJgSTKER80Dfh6yk8WCLjn4b5j9ar1FIGwJwiqJtKHCYqUg8vFwn0ulm/
         TakQ==
X-Forwarded-Encrypted: i=1; AKwUvBzS8TdVlfhZYwmOBqKb6DvMPvSuz5payPOefJXJjRdNMVPwHEM13QpKzQ7TFWtL8xoOe1z0B5jMdypfo2+Y@vger.kernel.org
X-Gm-Message-State: AFq9FYLLSfD5sfas0Eg0XvS/lVVHC58WgWZ+GZ5ihMfl11CtOrkb8rvT
	iVv6D5+EVsOSNsjmUmBwmzQI1jIi/u++zSqyLCxZbhMpBKmMmSObzUp3
X-Gm-Gg: AYBFou2AitLazUtZUY0E7CH6YKK/pmPMGVTZ/v7IUhG0YiZz923ti4gZ0ZEByGEEj6U
	gdctDpzqVRHoQ8bZP+XmEvMDlT+rKafj361L1OCKyVgA4TtXKLtSmRIFVvjKvqjWpQFtGxD+rjM
	UeqYaLB+ObawqwT5AxDkzP0H8bebg7+KXa/Ex/lL/3kHSID4o4Nh3/O6QTKWUIniI4WZYT1aYUq
	EhxtgnXmKmvXEJIcfu3CufYu0WELx5/Cq57RI6KQRxj4TtRgRWVM5vo0F/GqKfajaCO6vGmds/1
	G88cnW9jVWLj3XbSv5et12CDGn2iy+BrP6F1hcgHigihPRtnYnXG5TPz4OfC5pylSUE6t45JRA/
	xKPT5+t8l+phueiLqj6DG1tF1NFtxW6bCQ+FRP+xGqcj6E7opVX4BHtj6voTHkbD6/qR1qWuXkW
	4dfVctSJT4skGfFRSqEeMyW1eqMY2AxCvAV7silUjXpsvCykrXZKb233hnXNh0bp/5PLh6fGa0x
	ZoJa+Tbfu4Z+mYmY5HtCx5Z6+MY5VaofnVjzP46by4RwtimjDlG0upa1VnHTy+DYF4saoWaTarQ
	q4iDeT3jLxlIdhngRb0EU0shBhD90cVb+lKvdpes
X-Received: by 2002:a05:600c:1387:b0:4aa:2339:a375 with SMTP id 5b1f17b1804b1-4ac1793fa6bmr245939905e9.13.1793630853040;
        Mon, 02 Nov 2026 06:47:33 -0800 (PST)
Received: from penguin-ubuntu.lan ([2a00:23c6:6410:5d01:8464:9a6f:2d42:8827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm254289965e9.0.2026.11.02.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:32 -0800 (PST)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	gnoack@google.com,
	utilityemal77@gmail.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: [PATCH v2 1/4] ipc: Move MQUEUE_MAGIC to a shared header
Date: Mon,  2 Nov 2026 14:45:57 +0000
Message-ID: <20261102144708.920232-2-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102144708.920232-1-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
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

Move MQUEUE_MAGIC from ipc/mqueue.c to include/linux/ipc_namespace.h so
it can be shared by code outside of ipc/mqueue.c without duplicating
the constant.

Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>
---
 include/linux/ipc_namespace.h | 2 ++
 ipc/mqueue.c                  | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 12faca29bbb9..8a15ffe38e9a 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -15,6 +15,8 @@
 
 struct user_namespace;
 
+#define MQUEUE_MAGIC 0x19800202
+
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d1dd36a651b0..0f00e4efcb60 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -47,7 +47,6 @@ struct mqueue_fs_context {
 	bool			 newns;	/* Set if newly created ipc namespace */
 };
 
-#define MQUEUE_MAGIC	0x19800202
 #define DIRENT_SIZE	20
 #define FILENT_SIZE	80
 
-- 
2.43.0

