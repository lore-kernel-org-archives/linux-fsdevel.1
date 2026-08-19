Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750E484251
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156275; cv=none; b=cmx0j7+X58JHHKyLes1hn9wQDTckvr/TaJ2Y8qJ1PBCuRMJmE6fF3WqnWbWsT2mxDyaMvt43DaPDw3GlFH8rNSIeUtexp26Dsz2Xypg9mMYKNqUpbeOQPI9KU9ju5QT2CFkz7b81LvDUJizMWxaZ70C6CzcldQer89OHS2PWX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156275; c=relaxed/simple;
	bh=OZf549FkxxPX+i+QG2ASg8HqZabXQmWI4HZ/faJlp4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ec41tf0Zyw5JGiODJ2MJfw2me7JmchVndYRDESh3OiV9zu1PQuIuDMkRAWaajfSMuPkoq2oSybhOky+YzYf3hhweinnl82wgh9qN4ewTIEM0h2akvJ4LU4zseq3lMkwvCwCFV++8lqxc5xqugtM5ira5Oq2TnMc1PQilhx2wA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgOnAlvp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgOnAlvp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf27856f9cso11735505ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787156273; x=1787761073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mj4zN9ORZ2PeadgzkcCELtPYWY9u+BqffVguOSrtUbc=;
        b=qgOnAlvpv3cRJULLhFqVVb9ij8o5yVp2wk/hcdUG7fdfkDJAhKhisI7tjMMLC1BgrX
         KINow4OEv3eboblaEg2h8cAidnippWeb/t2eKns+XQqezyFOdntxzChmaNyKv377YOjs
         qgCuLpcSL4bQSYqwxCtW2oPkMXsZo9flDcpf0Wfj9Z6CWbt2R8tY+vovkKMZnddamoFq
         KNtKB+s9EhBa92h1djVh48HGSAyoQXpdG18FctWA+yBptAMt8FU1b/LLBNDoB9DadwlW
         6rET2Js8i/BkkqDBYHC8vWi9Fkh1vQE9msqv4wsxCSn5xCBln/7TpGI23KCvPBLDSKe3
         tfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156273; x=1787761073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mj4zN9ORZ2PeadgzkcCELtPYWY9u+BqffVguOSrtUbc=;
        b=WodgUJXwR2tP0QQevKBwY5Q7QTZ6Yr2iX0vr20OWZFvqUHlFS/Qx+Z+SempD8W66Eo
         8zWYlJ6VObQkd3R/Q2J8q/EBbvy5ivIrnOvehGLfwucWGhDSTk99+QQrO6RlVigJqRhg
         HpHmLE53F+UTgMXjubVqr4fHTzOqogkBqFaI9xIZvUdmn9nOtnxnVy97uJ/vh9afrHqn
         I+hPZIieSDahmnmYGJzA1BVdb8s0g7rCgrM4Y8ejiWtjOm8ZeJT7pPG257xubAjkwoY2
         vd167uniQUMtqQmLOB9Kb57iMOQ+YdlXiyK0RUVXrS4P2kN1GSriXAmFVo8InYbOiZyT
         5c/w==
X-Gm-Message-State: AFuF++k4qUPCRHHSvWGfbtaCka8mgWZZn0pxa8TqhRgk0YmMgn8EUR6B
	MSMU8gR7SvETaFOzkSMKbqniaNdnbPEy1UUbuRR2WeBwG8LXU+y6UNzO
X-Gm-Gg: AR+sD11kQdIS5ZjIjSmK+N6F2tF9KSiLyj29BWl/oQaqkfFPbyv3ahr1Bbtx3Dk9sf/
	sVePGJQtPf3W0LE0q5qgOIbYbpS/n38aSWXRnHj3XGPy8B5OjIKsa1kKLRGhZkiTPO39YeK4/xo
	8Y/pAL6gdNTLFgH69wSDxFemSAZdGXZCv0R+oLW7QXq/2C62FZp8XjOFIVOojJ1WpCPUTJJ7vsF
	ijsN+eWDxFD6ZP/EQLDyzlH9cZujieQ7vb0GihFeepAtLHEZfIBjkGTayrNijFw4fX1uTzaNDhy
	BkyPW6NoCt9kYwj9J7qFhuQpduAKULnCdcnBPObdMKyiqUgBasHnQp0p9Ap+W5H/3jztvrRotf6
	Yj/Ps9sP9mFFSifW4uTMkxsboiX1Z04qsO51pq/Y6Jg6I0Dp8IRA51yLXNGUB+aw00QpFQcUq/p
	esHKtp06AYEz3qxbS2e8mAAXZnRk3XelcipX6a8cMdlbJ9jbO/jw6cYOeNWxQK67KUzemrGBXD2
	zIDpzHhiMY=
X-Received: by 2002:a17:902:c948:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d60198022dmr94325525ad.8.1787156272868;
        Wed, 19 Aug 2026 09:17:52 -0700 (PDT)
Received: from localhost.localdomain ([72.255.58.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm15794202eec.8.2026.08.19.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:17:52 -0700 (PDT)
From: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Subject: [PATCH] selftests/filesystems: Add .gitignore for fscontext_ns_test
Date: Wed, 19 Aug 2026 16:17:38 +0000
Message-ID: <20260819161738.3517-1-mahad.ibrahim.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fscontext_ns_test is listed in TEST_GEN_PROGS and is built in the
fscontext_ns directory, but the directory has no .gitignore. The binary
is thus left untracked by git after being compiled.

git status lists:

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
	  tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test

Every test directory must include a .gitignore which contains all the
generated objects, as per the documentation and convention.

Add .gitignore to ignore fscontext_ns_test.

Fixes: d64ba78b749a ("selftests/filesystems: test completing a context from another user namespace")
Signed-off-by: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
---
 tools/testing/selftests/filesystems/fscontext_ns/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fscontext_ns/.gitignore

diff --git a/tools/testing/selftests/filesystems/fscontext_ns/.gitignore b/tools/testing/selftests/filesystems/fscontext_ns/.gitignore
new file mode 100644
index 000000000000..a632905257a3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fscontext_ns/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fscontext_ns_test

base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
-- 
2.54.0

