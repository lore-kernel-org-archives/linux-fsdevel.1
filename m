Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFD7E0FF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003309; cv=none; b=RJ0c14P1BvXFjb+md0s0dF+jiHkh7z0u8hA08XXebAJjwYD56SvIyjJ6meUS5WUdv7tHV7YEldm/KTFFkLjAGrbp2N17hfVLgAsRcQK3Y/cqH34Q69oPZ60Bp+6H16EEbykbTeLbm7KK2P9i1f36U5GQ2wn1CFYKywqRUUB1gqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003309; c=relaxed/simple;
	bh=nt2OPfJr2A+6voG3mvjcDolBFXkCYdVhtEbTUQY3tSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzStT1W1VAyxyK0QO0Jx84W+dpKjKsLkPbhdCfvmyWt7YmQ/55ls3Wpv8zNZ7QJw6r3wbdD5CDINzgU0ZKfo8/SVwhHZg53dIBhKjJKze5sY1bqjy+d6yuyjz7txrzI3tmO8Y4WSa+lkAIP0//tEItfyXyl9DUmtL67SbMbvN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=Yhw9p1cd; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="Yhw9p1cd"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2addb31945aso46498355ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1775003308; x=1775608108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8tetMUp6n642BPcIc1AXM/henp9pQA12IUGi6Zqs5U=;
        b=Yhw9p1cdCVXmygXl8tgkFTYuTC84BEiFVHpnNt5KQ1HB/DA09FV0u5CjZoDa+I0dK5
         is2WMgr3dvu+PEkjx/ogcnS+n1ayGIipYeH4Dqy7/ud8M4ObzW04omPp8qiYFOF7XyM5
         pf0xVxi+jTzEyFDHOUlinGgrU8OVWXH7gPYa3dzUtg7rJSMZZ73Vj+SokaPV0L23MArK
         muGccG/hmdj5CnZHx70KoVPSIKgkQozLiJ60I1VISGqVKo0SvMHFqhIYxTF4ZSQt7GxC
         RmGbuYM5OTjviJyZIvzsaRtHK8TcNpswPGx9hVKdHmuq5EXnvA70sh5xcLfCi0LCeUOz
         ZsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003308; x=1775608108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V8tetMUp6n642BPcIc1AXM/henp9pQA12IUGi6Zqs5U=;
        b=cycxKbfQNJQGFGgT4CXW4bYS1yCbfbI5z+6QdMT/34K4nc08nKbbPETx109NBCVhoE
         dlUITlusTf6mdsqFHoqudOlNaUXkArCyYRZ2r7/AXZnIMGVgazEALfFmtStN19A4Annb
         lmdU5euTBKhNWcecFYGF2hiIO5hF65zi8qynyee+4acEaA+oajybVZESwWZiBjRvoBzU
         ZBp6Tlvk7a8D15fm7w+kWG9cO1IWL+7TZu//ZJ10L3+zwcAb3NdvcPAiqzMq1whgeOFR
         2RXKs0QcDVE0tV+GzdEYGSNX1th8xrnr9tCi9jmuY/xBF4XbVD6rBstX4UXw03oAkw3F
         2/YA==
X-Forwarded-Encrypted: i=1; AJvYcCV75xLNaxErKKNDALFEtw2NpFsLnQRJlnSPemS8ES8sHHo/gReEvAmpLsTwEkt94euXRIBWJHW5/RWH9GbB@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNMSKH1bC+qh0hHTLkg6iLmYcpAdaRvo46PcxGZ961PqLM2ks
	Zdp5atwCJAZZc+/DdhMUXpK/OSl0cZZez8xhmDDYEJBcjqg4CHuj0HbJhMzjQZ5+G2Qf
X-Gm-Gg: ATEYQzy5IjdgY6xByyDRB5GfW5pVl6gx6S84l1w6C8fhHLLhYJZxUIER64ayQWSwN7H
	ExJniYlyE5BX/i2WPMSX9APNUtARkThD+fP1oCvWf/j1VcQXkLEaQfJOl5VFPcZEaKK1HwPuH4X
	HmGcyTiLj3xtqOcS3fd+0/uQE2z0WbLkfM3X4Vfa8aim2qxN1GmkVhbmEpXp1OVQOSmHpGH2kTk
	T5F/cn7GOLIDWn+zVh0HVZ+wPl5D8JmWBOLlucYYN/m2ROX3zTnaZ1dDGW7ugwj00oOzJsKv59l
	6VbW4W+ZFz1ApjY9tSQPr06VRzEHwFxDav6H5MtBhfm66lce46KHyPqWNJSRR3YiW3D8QGKB2H6
	BFg4zO8glLvgjUdulYKKNjgQxLK8VNznfJtnSwghBX/6yof7Q20wvjngr0s6ZrEeZHzDu2EDtBR
	7uDXY0M29gMJqX78H5o7IozAAl9a8V3ZTqvyPCJYagoArGKfHwqthP2qwm3JXwX5NfSiVD6zIHP
	9z1A7OzsUO21wwxf/DhTNPFCw==
X-Received: by 2002:a17:902:db06:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b269cee6d6mr12173595ad.35.1775003307800;
        Tue, 31 Mar 2026 17:28:27 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264264fsm157057825ad.2.2026.03.31.17.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:28:27 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Date: Wed, 01 Apr 2026 11:28:02 +1100
Subject: [PATCH v2 1/4] selftests: move openat2 tests to
 selftests/filesystems/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-openat2-selftests-kunit-v2-1-ad153a07da0c@amutable.com>
References: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
In-Reply-To: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>, Aleksa Sarai <aleksa@amutable.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=nt2OPfJr2A+6voG3mvjcDolBFXkCYdVhtEbTUQY3tSw=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSeSVv8bStjLYftrEeNjZlM/PbZv4Lz7nHO6usslHM7k
 5bUUizaMZGFQYyLwVJMkWWbn2fopvmLryR/WskGM4eVCWSItEgDAwMDAwsDX25iXqmRjpGeqbah
 nqGRjpGOEQMXpwBM9a9+hv+xj+o6XU/PqS+6Z73BaddJszPveN9P3MDNnJF8Zoao6B5mRoZHfW2
 nnoovaOPav/e1oMjWH8GLf393Yn4WU9vr+8k524wPAA==
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

These tests really should've always belonged there, doubly so now that
they include a lot of other generic filesystem-related tests.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
 tools/testing/selftests/{ => filesystems}/openat2/.gitignore           | 0
 tools/testing/selftests/{ => filesystems}/openat2/Makefile             | 3 ++-
 tools/testing/selftests/{ => filesystems}/openat2/helpers.c            | 0
 tools/testing/selftests/{ => filesystems}/openat2/helpers.h            | 0
 tools/testing/selftests/{ => filesystems}/openat2/openat2_test.c       | 0
 tools/testing/selftests/{ => filesystems}/openat2/rename_attack_test.c | 0
 tools/testing/selftests/{ => filesystems}/openat2/resolve_test.c       | 0
 7 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/.gitignore b/tools/testing/selftests/filesystems/openat2/.gitignore
similarity index 100%
rename from tools/testing/selftests/openat2/.gitignore
rename to tools/testing/selftests/filesystems/openat2/.gitignore
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/filesystems/openat2/Makefile
similarity index 91%
rename from tools/testing/selftests/openat2/Makefile
rename to tools/testing/selftests/filesystems/openat2/Makefile
index 185dc76ebb5f..f36dedccedb6 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/filesystems/openat2/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
 
@@ -13,6 +14,6 @@ endif
 
 LOCAL_HDRS += helpers.h
 
-include ../lib.mk
+include ../../lib.mk
 
 $(TEST_GEN_PROGS): helpers.c
diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/filesystems/openat2/helpers.c
similarity index 100%
rename from tools/testing/selftests/openat2/helpers.c
rename to tools/testing/selftests/filesystems/openat2/helpers.c
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/filesystems/openat2/helpers.h
similarity index 100%
rename from tools/testing/selftests/openat2/helpers.h
rename to tools/testing/selftests/filesystems/openat2/helpers.h
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/filesystems/openat2/openat2_test.c
similarity index 100%
rename from tools/testing/selftests/openat2/openat2_test.c
rename to tools/testing/selftests/filesystems/openat2/openat2_test.c
diff --git a/tools/testing/selftests/openat2/rename_attack_test.c b/tools/testing/selftests/filesystems/openat2/rename_attack_test.c
similarity index 100%
rename from tools/testing/selftests/openat2/rename_attack_test.c
rename to tools/testing/selftests/filesystems/openat2/rename_attack_test.c
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/filesystems/openat2/resolve_test.c
similarity index 100%
rename from tools/testing/selftests/openat2/resolve_test.c
rename to tools/testing/selftests/filesystems/openat2/resolve_test.c

-- 
2.53.0

