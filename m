Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B73CF68E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050319; cv=none; b=cLXim/A56tTskyBZf1gfa8M0lrnz6+Dio52p5vaB0AaMViez1u1japYucX5KSzjKln3mqTvHTOrSxWs+hSFyjS89T9i7CF9ViploUK+IXRFrHFFzexR1FBP/3HCdeYtOpvb+XNOY8h7JUzT3maf7/FTaYfYY98FjY+6lNLVW5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050319; c=relaxed/simple;
	bh=Jolj381UM3ySDF/esN0btWDA7yfk8G3H/175LYzgYjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpJSjBRu4jn53myWhEaQXNh5Rx8RejJy1s8/S/kXMc5eYxN9WHW/s+kPNDtZzBMhaJh7pyjdpLjNHwYg01wuRUkTSg9VD1IOOWpcT8/wjvLu6/XElLBaFGPXbR+936N6vK9odSw+1lLRrI5fdlk4KLu5ob0MqpAkl1ObKPzMcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEuhsKy2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEuhsKy2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so11219201a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050316; x=1777655116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CksereZCZQTLXWD//EQS5p9gHw4S4BoM6slCPMn5jjY=;
        b=rEuhsKy2dwOQXq0wLbk8dzFKQcz3iiJw/AJDGwR3VIxuYjQUKEAZl11SnBhR4/Qstk
         +upfICvCbKL0nn8jk5PnItgnXRc/RwyLImGFoPUmMZ9kXZKTL/j4z4YwXGHoRPaamKAq
         oRcFl4S4y5DQy991B1CPSqURyE6fwRb7ZmRd7Sh1DDL0VK+xz2t2ISzGyYhmGIcepBY0
         65F2jUwXlWxuQopVkFCAQUF/+6R5Mc1jPzD/sA1niHMv0eLlk/ucnFs50LKUvuF3iLlL
         /Oe33iKYiSQF8hIyikm8OP5p6dLCw0nXBgg7K4a0fdHRTDyHJRjIaP5XsD5INSigqlfr
         LTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050316; x=1777655116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CksereZCZQTLXWD//EQS5p9gHw4S4BoM6slCPMn5jjY=;
        b=BxzF7A5eSgSoCAOhFmQgYUiQRcL1PIgAh9A9JhN3siE904diPGd44Vw3PLTuU8vHXt
         gW6oR80InfarB8NvBn4+JgWn40vTlgloSJST2R5dQd61JfDsLuevqbR6lApOC2XqrR0L
         fT16dyAKbmXCwVhuzr/1AsyCTi4BKyE5A1KyLSPOAUUIyPwhzRYmuzPKYCf6j3VOqb3b
         PK8rRn8sVlFqfuOZlZ2iFwpMovGCdaVx9PaPq3oiSKv7VRQoyLQl2MWxPEWbb6s6Yur7
         YpRvznMmHehH9+OMJA5OFzy3jDPCZ0iu012ldWwWtqjjn+H8ZDaFYIcrK64XrR6PIB8S
         o37Q==
X-Forwarded-Encrypted: i=1; AFNElJ++w6cGoIqXEUbBnXz1WNwSl+ruCNyITuvBHHmlpkAAmxlrqZvyYekO2+wSJe8BTWTPywR6/KBbMbTFZ1zM@vger.kernel.org
X-Gm-Message-State: AOJu0YxK45YNLmFAEsznNmwG+f3BdG9b5zHeH79FmRELXoJUYlqJjt5a
	k+GEJ11OXKIHtD4ucsY2+V9nh1IZXTiqgCGr7kwvehhouE5brIxHJ1w9lzbLRmBw9pU=
X-Gm-Gg: AeBDievsP6qToWE1KYhD5+yKhXzWvt82Bs1xb6/D8VD36iF/oUTxnBFDwOmcmi9SWAI
	XBnOQeY914AeVUGojpkR/ujyXDva4fJ29IRsYRtM0VybZaRRvCJvdNPYXK8uD0+efLt/YNm8KaN
	BWO2G0qt+YJG69zFqb2S5th7VJ29Sx6teGurF6+Y2z6rxc8ggmWVNXOC4JgKu3MqJS6g2AMz63g
	jvPGnz5MXG/2Wk0UbWfs+J8ldF/rZoY86eZo2umIdCTSlJX0n3OcQ6EJz5uPi6YqtUokTaTN4xE
	uNsPIbTJ9ze925zsj8riQXDnPvEfNIjTw0ee+B2ObM+xJYGjaog8xTmZlPIhUwfKEiAHzoQoUeJ
	+xVj1XLNU75DJDNvyY6AKWPf6jDIbRdzWvDGAc+OP/uQiNWAfvbrFOjXR8sscYDxMDhW7peY1xj
	zcFNSzx5/2uuUwYhyDPff48GLF3Xbo0IKzoQpF8vTrRxUWH+zGHYjnIgmK0UXvLFk9gh4VQOMZy
	w97kf3tJFBKWjv35ajByN+j5zW8wl/Lch3uRac=
X-Received: by 2002:a17:906:8e15:b0:b9c:4fa:9141 with SMTP id a640c23a62f3a-ba419077377mr1522590766b.9.1777050316122;
        Fri, 24 Apr 2026 10:05:16 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e54sm807648766b.9.2026.04.24.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/10] selftests/filesystems: create fanotify test dir
Date: Fri, 24 Apr 2026 19:05:02 +0200
Message-ID: <20260424170503.2096847-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424170503.2096847-1-amir73il@gmail.com>
References: <20260424170503.2096847-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the dir mount-notify with two fanotify mount notify tests
to fanotify before adding more fanotify tests.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/testing/selftests/Makefile                                | 2 +-
 .../selftests/filesystems/{mount-notify => fanotify}/.gitignore | 0
 .../selftests/filesystems/{mount-notify => fanotify}/Makefile   | 0
 .../filesystems/{mount-notify => fanotify}/mount-notify_test.c  | 0
 .../{mount-notify => fanotify}/mount-notify_test_ns.c           | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/.gitignore (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/Makefile (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test.c (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test_ns.c (100%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 984abb6d42ab9..29be6601249f1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,7 +36,7 @@ TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
-TARGETS += filesystems/mount-notify
+TARGETS += filesystems/fanotify
 TARGETS += filesystems/fuse
 TARGETS += filesystems/move_mount
 TARGETS += filesystems/empty_mntns
diff --git a/tools/testing/selftests/filesystems/mount-notify/.gitignore b/tools/testing/selftests/filesystems/fanotify/.gitignore
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/.gitignore
rename to tools/testing/selftests/filesystems/fanotify/.gitignore
diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/fanotify/Makefile
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/Makefile
rename to tools/testing/selftests/filesystems/fanotify/Makefile
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
rename to tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
rename to tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
-- 
2.54.0

