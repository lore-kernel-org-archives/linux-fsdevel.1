Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706E3859D3
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798277; cv=none; b=qbNC83NwPaomOo3rc588lT6m+FqKO10MS+TYyuDBW2VOBiIbGaPfeywaR3xkmTQ0w1+dmn0C5oriWCqqssb0Q075LI0fuCpVD1gKaYMgHIqWlMOeKQvtNv16jh2j0iJ1wNweORs0ZVy8/4SydvtelJD37kD/ABGSvWJZn0Bg6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798277; c=relaxed/simple;
	bh=klxxVnyGRED1q317T7p7fYo0Zj/3oMSRfd75h/qMGIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gITHRN73FQJojsjLS95ow4hNjqezE/6aaz77DK5NUpvvfHVoTrzCYUFGojSjHkAH2MBzs852u7qMJ+ne+lZkacRR22fHzpBH4UhlloETX/foJCtBIqqsbyY9aCnbtX5Nqv/pnY4hZ/wc0WBPSC3/OsB6UUTDhzpMurxgFmYFCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=SYS5Fqv6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="SYS5Fqv6"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba699316b42so448398366b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777798275; x=1778403075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zFTck5W930pgUh3AWU46ER/xD6QLi7A/3R3iLUIHZI=;
        b=SYS5Fqv67YpkTX6XMemVIQiwuMRq/A/t6z7DM9HWqE8SyD0h4z7O+BZ3Otw1HLjUcv
         WybZMYa6cEc2l33zL3pu8mhAbfgoqrJVCxbMINYUWP47+/uG1lk2GzrJDKmmgil8KRxK
         wzJ1HSoRosbzUaCsuV7PFwmgLPZpV+XGy3Ohc8tD2ioLOywZS09KyIcIxLZeqMr7t6TY
         jC/hnVlMO9ddDNjXy81Jc6eKjKiF/8uatXwnU9suR8giII63v6FOWQmKAGzkG3u+EZFR
         qkiZV+NQrLHQvU/BT7M1eWvEu8DPuJ7oOxvHSjMMfKU6+4iCMEEwtzfH+PPzs0RLj8Ha
         86+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798275; x=1778403075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zFTck5W930pgUh3AWU46ER/xD6QLi7A/3R3iLUIHZI=;
        b=QQrOZuW1d/wHbwUkdgB7RFbcTyaAzHAW8yrYM6QImjcU2ZwwtdGdmqMNeElbJaJKTD
         N0gupKipKdkhI0hQrayD0E9p5N17AVm1pltFJ+ASJWpTwwPN29dnXXzNyRzlLHsqXt30
         5iuVsD1XJ7JOvQTTcTDWH47TSXhUIpq4GCzQpQYpNpzEk63xeaCDquV2M62wnfsQph9b
         CzXYXMMcuaRP6/vuZYvhRePuHRP9neXxH8usoOkWGydueQnSkjwu82qS48EJBhDEYksB
         LAsUEITl2RYtAFKGtKBmNtVmrJ1YqPuAGSlivYbGTnyd9Nt9bycDt/ZoMyHe+bM0GoHJ
         9foQ==
X-Gm-Message-State: AOJu0YxQsBAN/APTf5/ayupkJFWt/uwOz6MuXGJcZyLegzYEflAigHKO
	XY0aYUa4fhT21/UvzKFFqGy3GehOY+pC9Ey+Z6goEhA2//Qt4O1EVWO7myYQc6Djyes=
X-Gm-Gg: AeBDiesgjPKIdFXn8luy+6/Knmk8ClSEg26/7qYqh+CMyIRbddObFXESxNUWlJZ+7Xk
	/bgjny1SxUyITuDnKahHs7eI13VaoSctPrKy1jM7wPBPgPU92QfDNq3VkrSlZsgcWWNC3C7P7LF
	27ykW/jQgnTobHD+eFRpgRFQ1QAF8Rw09HrGRD/4E/E4BZyqVGLNbXYxcoIo0+7PgtsPpZIBWLn
	7cWe28ir+bqzrBaHehWT3YDBQo4IsVNCmnb+7L0dhV4tscCufImIrCdU/ZM1uH2ZgSUb/MiwLU0
	Ft4N49LyfQITGPkpyJGwp0PdGsadlBEWGTyHQnGCEgBmUNC3iFlzEG6iCZXl662DTZ7aRrwGC+h
	YlsPNekD0eSTr9rqVzxBNb7u9Wsunu99CoCY6wlvF89aE50jbOr7+jBd+df5QfoJ7nCoAlDcQDx
	KE8BxfbAcOjbx4tcQjd00SzlaRniN/895bBvRsZmRUz0QcgaCuYB3D4AWrU0CAZ1baS88t5Pt6X
	W3oVCNl8g==
X-Received: by 2002:a17:907:d02:b0:b9d:c374:6e33 with SMTP id a640c23a62f3a-bbffaf3d8e5mr284088566b.26.1777798274826;
        Sun, 03 May 2026 01:51:14 -0700 (PDT)
Received: from m2max ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292c2sm2368936a12.1.2026.05.03.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:51:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] eventpoll: export is_file_epoll()
Date: Sun,  3 May 2026 02:49:13 -0600
Message-ID: <20260503085101.112698-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503085101.112698-1-axboe@kernel.dk>
References: <20260503085101.112698-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make is_file_epoll() available outside of epoll. This is in preparation
from using it from io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 2 +-
 include/linux/eventpoll.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f464f2f39e0e..9ea6a2bd3d87 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -334,7 +334,7 @@ static void __init epoll_sysctls_init(void)
 
 static const struct file_operations eventpoll_fops;
 
-static inline int is_file_epoll(struct file *f)
+int is_file_epoll(struct file *f)
 {
 	return f->f_op == &eventpoll_fops;
 }
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 728fb5dee5ed..7bf30e9f90d7 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -63,6 +63,7 @@ static inline void eventpoll_release(struct file *file)
 
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock);
+int is_file_epoll(struct file *f);
 
 /* Tells if the epoll_ctl(2) operation needs an event copy from userspace */
 static inline int ep_op_has_event(int op)
-- 
2.53.0

