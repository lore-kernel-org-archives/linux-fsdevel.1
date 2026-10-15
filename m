Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003411FECCD
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074982; cv=none; b=Ob5FakQNIPHV6etsDRA+tLw2pL8fWwleCDV7F6E/L1jsMam7CZgIcTHlIzWjbWKBuLVnwNAEAIoGXFyTM7/OGQc8YuQcoXjcgtx4jVLxB1Fsp2hyzB3+GHzQvgj3HUqEBgpka1xm+YDKlrjIn1XtZe6zHJ+XP91MchPUog7pbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074982; c=relaxed/simple;
	bh=cr3S0fc0B+d4s4410TFDyz9t5lQJBVQmr839dmoJJg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGmZDaPP7CehtuiBEpUVV90GzDjIRIMoSftjVV/1i5Y2bCra0tB2a2H7UyZvlDq9gFYbowWwVotxkkl/YOqZklmWTaMGwDN2Npn5IxOdVJkvphDRRtZZtLxUD2wb6gXw8y01TA3gglimVMqsdzXLv7RMpUqTDG7eLSs/eM4bmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxXrCac0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxXrCac0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2dc8cb0decso240223266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074977; x=1792679777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1D/CBoDLBBCPU7yD/PF9ehFu9YYnWQYbgYSvQ1WgZzs=;
        b=RxXrCac0FUk83/vvZs9dW+mEaq7QEhy4sVLfFEfm0Tx8/yK1nOW2e14Iamb/4qJs/n
         eFK5O8r2w5tnZBP4Nkp/a6FSW/mXwERnB9GB7/fPBF3c9QG7gHNzSul8se76KtVhrJIa
         RaHjKm1Yo4bGEpkWe4T1OZxmamIiZ5rGdn4SP1kKe2XAK2tG31hh0UfdJ5VQQwp+1w11
         TqrzbsTRxkj1SEkbRV9AZLomddPZJs00ZvB+JKmu76ucX/0ZqaQlANbVizNW0siCoOdm
         EX+fjNf9GzD3HJxH/PNoRO9z70OOHY407jIB9HYYZpt74x0TAfUYMFl4+KoUIcpQSzpj
         t+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074977; x=1792679777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1D/CBoDLBBCPU7yD/PF9ehFu9YYnWQYbgYSvQ1WgZzs=;
        b=DnJBl7tdadyMDdxgyruDTj9iRq5KMlLhS3ASEDCn5K+eIFYfAuEF56QrXcPTwAWcht
         4ZMlKBmzffHL7pGtTblAfCjEu9Cjyta8KJSyeZkkMPDZvYQgDqTFNIytxoatdk0o2510
         jMOcDNw5+lP7bp0d4ZNds+mvuwCEnsKi9+QtViBz2Ab4DBTURhXmBd4Hrz2a5djdwgaI
         0wkjKtKDmdoe0c1L+m9s0E/9UiGRJXyBH8PACQZuucOU6y7BZRqofpyoxtwHUTdjEs1+
         snXubusQ5hQI8BTA2+ysJe4M7UcFOmMXeiUy+9pdJgFm0v6+FLRVcaZiuZImZ8kbFNfT
         mEBA==
X-Forwarded-Encrypted: i=1; AKwUvBxNs5E/rHOSYjexfmLJ9vtGKNPO/w6wcr0N6euyHm1vFa1nU/yGH/Juf/+blyb/ola1MKvnRTJg0qbr3vb3@vger.kernel.org
X-Gm-Message-State: AFq9FYI60UIjjZsBh1+FRcHZqH/ildOF1ATe5hH2TzneZDWSKM/MBMkC
	cImnTjxzTbhxkXoLqymEmWx50Z70dkVXyy4Eh2wnmJq+KDzO85lPlbsOjk6YEnkV
X-Gm-Gg: AYBFou1tG0rXR8H0b72uWJ9hy+vixUzVfYQ+mfVwUX395rJ+xJ2RzKNp+wUx9TsVhAx
	NLTvIoEGeU6cdupQ9V145KFqOWminUvXIPJHlfjdhw++9s+uMQqLfNMiqlQx8YjYNz/0iPizNkg
	9Ewvnk7CTr5PbkTMXX/pgGO663N63VaONEKhYQz/MPZpcldhY7h4grQovim1nVJloFnR2C2/wRW
	Bvn6EMG1FI3AiKWumiXHa2MniNWQTnpBo+7EaQIYH48ZJR6f1A1RAV+q2FbdDRoLOKeaHoAeOv3
	gRcMKXVT19cdB6kTmXgpVv2KnOhehDalpZMKQeD2kkDJ6Es/yhsBiOTHRKGhdFFwNNhlTKALeF2
	oXX5jzewrY8dVXYRKRMjnreatg6taF27XwdtG8JpIsWvviOnU/jUhZLhe71yrAT5R0yXYnWG4Ww
	2NyK5I6hIcT9VhNAmxJKSZyg2c1EIk5kRIqzNKEVokROjNjfIkIeDGeyIzNXK8osNjN9993bM7M
	gBxjOkjiFoc8ivsKeflHmUUNnV+LtdIMPuj
X-Received: by 2002:a17:907:94d0:b0:c2e:7da8:f54f with SMTP id a640c23a62f3a-c31aa0ac6efmr1960955166b.38.1792074976795;
        Thu, 15 Oct 2026 07:36:16 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6be6bfasm133575366b.2.2026.10.15.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:16 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/14] selftests/filesystems: create fanotify test dir
Date: Thu, 15 Oct 2026 16:35:58 +0200
Message-ID: <20261015143601.2095784-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015143601.2095784-1-amir73il@gmail.com>
References: <20261015143601.2095784-1-amir73il@gmail.com>
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
index 08f228765a930..23e5c229974e7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -40,7 +40,7 @@ TARGETS += filesystems/fat
 TARGETS += filesystems/file_stressor
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
-TARGETS += filesystems/mount-notify
+TARGETS += filesystems/fanotify
 TARGETS += filesystems/nsfs
 TARGETS += filesystems/fuse
 TARGETS += filesystems/move_mount
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
2.55.0

