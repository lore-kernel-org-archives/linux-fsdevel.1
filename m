Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B350346FDA
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115895; cv=none; b=g+4rp5Iwp3t3UmAeb1ozOsj7TZc1T004ZXySRloNUhWu76zCd49Wb9ScaHuqf1yh84Qq21xb8f16Jw57xZHyjFLx6Bf4NW/MxregxLu3heJxbmx1psO0WV7z0OT25KlGcxJe5OIu/BoAAOJTVz0yQEjKiT5wookmbeFZCy74+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115895; c=relaxed/simple;
	bh=LI3SMXsnBn5nSeznTWFsUVVpxVDKbB9pJnDUUCkPN10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUabq3FcwV0/r+5/L7GWL8aHV3MLJbEWIhTDZCZ+K6PN5XJlPXa/t/2b9YDde2jA2vnHbrnZR8l0zVFpJDQvznSHs74AiZJHeIFw2rvyTYwiPadjWHeSIboriIGUWLuep7xG1aOJH/QseUmQEdDK6PpotiJU0eGdqAf7LaeleD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Dz+r8qj7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Dz+r8qj7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb20bcff5aso252689185a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774115893; x=1774720693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob8Y//wo6MRj/M0Dz67mgrBX7aDHTN1F2suUDWyFSyU=;
        b=Dz+r8qj7MM/VFJu+GfI+Ha9dNj+jry+e9m7vzd1y4ZgEEqbSWeqS6cVq1orp5u+efD
         8Zv42dZDNsvF2Ej6rJnPULMJgCKVqwNSMZa1B9E3EyMIUEqrz+v8MeuFmJxCtH/x1ny3
         w62Dte4tlaW2+j+Qk5wPWS3AEjbZMnJROiB2BkxKGp/UkVclDOdPodfHQ5ah7rRRGyxY
         yrgMfUHAd4Ii+pTMg/lkNe+PGpJwOhPGGMBgkdYHbH5MECgWW2jlR2THUJwZYJyKQhlL
         8RqgUfaEHfXgOUyrZ8GQuFAPqmTpBw6FiP9rp8xhnxWRWZzXJn1bRmFuJBs8g8HTJd12
         S94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774115893; x=1774720693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ob8Y//wo6MRj/M0Dz67mgrBX7aDHTN1F2suUDWyFSyU=;
        b=P3opOVx8dMr2RVtJXAeMwJLYfI+aiUDHeuWSSGA5uicf5gvc0G/H/v1Tnh67BFlSe5
         HDiglt5Mu/2JbnW9y9+qxWuLbEAdMAjuLmuqnsbPihrcVCd2h3xtHDui2ZBJkq5lpy4y
         eCPsAQWuPYI3la9ADoGJa8tzL0C5hnI61etJ82V1eqEeT8zenFN7k8HMneQWezjUN0gG
         X6qQX/u2k0X/32712Rj54CKG8tWbj8m2mM9nMMbMO6BIpNYgsuA9p0hS6nL0I/R1SVxe
         4il1wcRFClg6vrbKAG5AuHf/oluBbSpvmkvIDZUUJSLltoBx0HU9VtwUX+zrrKCMbYuj
         g50A==
X-Forwarded-Encrypted: i=1; AJvYcCX9xGbA8LUAwrFm4QdeYIejY+fqLYzdNoNoZg2ppiXmzYNIgqFgk+tJiqsyUJpiLhBh8w4/HQnTrRX+rp3L@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ58Gu76fpwxr8eXwr2MPU0aqNcwizGHktKJf1rQAAHRIxc7qw
	S2IveOFgXUQBjyLoRCetwAL4Lc3+r5R06jlmBZkjgOLK5JtK/vpKJoXjifL1dZKcSs8=
X-Gm-Gg: ATEYQzxjq0v+j7ccGvU/S1JIBrx8aJ4VfEVtHzO2yznQqI5C8USIezvBCaetUa0PkZZ
	jzZWeB74/WxcVltzF4pnvVn38Pw34ZdkFnbM4VAIUJcf3n23FDm48rEGRSNrmKlFJAHiEUEf4z7
	IVlGouPSSvDtWkMmNWR4ubEXaJ3VOvHbXEtwP/cEglxFQ6Lf7mV6N9F/JtwSeX5maipV6eRNnsx
	qU2LOTOED9aDmPB2MUW9PPxWqBqvYIfC8W4DjAsnisC4DTojvNsSOoyRcjL87FAJAZh/HB4TezS
	k5KXX5miqe6VkJCgv2Z1ZzR3T79ArdF71lGoFqug3gGR55JnU6X5iEpk9h7vVPpUqtn2xQxbkWH
	hLfsM0TlDmAnoFGxZPxhHBy9hcYgNI2MBUbNXQOcFUYorfNc8vTWsCE2zdVHDlkGFjRKJ3GZk60
	Iy6K2V+F1vZKkhlhTVindWntlyTV5Q2aCWx4ox9nkl+wyLVi0+hElfwSzEKGIEjG4Nyw==
X-Received: by 2002:a05:620a:aa03:b0:8cf:cf2c:e021 with SMTP id af79cd13be357-8cfcf2ce4d1mr751287185a.7.1774115893390;
        Sat, 21 Mar 2026 10:58:13 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9089ca9sm426515985a.24.2026.03.21.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 10:58:12 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: brauner@kernel.org,
	linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	jack@suse.cz,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	pratyush@kernel.org,
	skhawaja@google.com
Subject: [PATCH 2/2] selftests: liveupdate: add test for double preservation
Date: Sat, 21 Mar 2026 17:58:08 +0000
Message-ID: <20260321175808.57942-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321175808.57942-1-pasha.tatashin@soleen.com>
References: <20260321175808.57942-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that a file can only be preserved once across all active
sessions. Attempting to preserve it a second time, whether in the same
or a different session, should fail with EBUSY.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c2878e3d5ef9..37c808fbe1e9 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -345,4 +345,45 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Prevent Double Preservation
+ *
+ * Verifies that a file (memfd) can only be preserved once across all active
+ * sessions. Attempting to preserve it a second time, whether in the same or
+ * a different session, should fail with EBUSY.
+ */
+TEST_F(liveupdate_device, prevent_double_preservation)
+{
+	int session_fd1, session_fd2, mem_fd;
+	int ret;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "double-preserve-session-1");
+	ASSERT_GE(session_fd1, 0);
+	session_fd2 = create_session(self->fd1, "double-preserve-session-2");
+	ASSERT_GE(session_fd2, 0);
+
+	mem_fd = memfd_create("test-memfd", 0);
+	ASSERT_GE(mem_fd, 0);
+
+	/* First preservation should succeed */
+	ASSERT_EQ(preserve_fd(session_fd1, mem_fd, 0x1111), 0);
+
+	/* Second preservation in a different session should fail with EBUSY */
+	ret = preserve_fd(session_fd2, mem_fd, 0x2222);
+	EXPECT_EQ(ret, -EBUSY);
+
+	/* Second preservation in the same session (different token) should fail with EBUSY */
+	ret = preserve_fd(session_fd1, mem_fd, 0x3333);
+	EXPECT_EQ(ret, -EBUSY);
+
+	ASSERT_EQ(close(mem_fd), 0);
+	ASSERT_EQ(close(session_fd1), 0);
+	ASSERT_EQ(close(session_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0

