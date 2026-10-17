Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB43AA9CA
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255869; cv=none; b=KyRx4e+YdulxZ+q6R8idCgCQNx6NA1U0v491LTBezxEXGDiTXV1m+KBCxWuLHqa6/0vkNXRfMl2BTPRjwItqHpFYatCpxtdsPyLnV3k6+vZUqcbo1Z28AIY6IXcIgT8wK3+mQ/D3F0De92K+8F4nD0YApAza8qPVHY/GnOfxNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255869; c=relaxed/simple;
	bh=Drud1aITCIgS9zLpb0Jw3rnTUV1w7110x1Ghz3/vhzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnn6Ex8d8rFcfb4atFTT/YnjqVL8UTO7aEIN09vfaWOHrhPUNw2RVibWjnqamTqHjzFNcjtwx7a8YyBAbMXZL7MVWoYHN7vQx/d/eHcP7+ygOG4WfxE0fq/h7sMv2Y6raYywPzLe7/+0VSpVxYzlZ223apXCOEAtygmOBep88+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdfFO59o; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdfFO59o"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c169ae1cb26so342485766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255865; x=1792860665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mshVP6NJlRfasFPIJ362oVqpM5P4HZf/7dtAIJY1Aw=;
        b=hdfFO59oSCwT6GhlClUhodohE7hxJ1SB6/4/qR7xUcfjSlNszrHDDe9LxIdZ0LGaGJ
         ZMK6M+CWDIa1KEa0iY8ErvUKYXrIufG+GRhHk9KXCR2nqKImCqX2xkEjGB/5+DuQYY+6
         nWNmADD5BMDSW1MOqG01ABo1Qg4gDouVPiavwVu/cOPGt/F9pEMZ/VCUXY2fo8Em4C6a
         4HNcHSoyg/SXwoMbgzkYTyYZmzHJVFNivD9KvtRoVjXt2ucN6gs8r8MeC4Q6J0xjezwS
         k9VMABhG9Y0Jo7GoZCgVeIn9WAKqdp1WkWrNdj7sqPC3BSi2E4D/AE8jVKmGxLW9hWna
         xOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255865; x=1792860665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mshVP6NJlRfasFPIJ362oVqpM5P4HZf/7dtAIJY1Aw=;
        b=B0agIGCbUH7DlBi0/v5Q6D9lMLJ5kFUqkyJjJEfMDY5eO8GVfmhNjf9qo1zM18jFNd
         AYR9hY3VXw3nxY91bdExQUSmnE1CrD2gPABM5aKi6P7ZfLKtMaaQCtd7a34vqqfk0AH2
         qn7kupq3HGruujOD5onEP+EEz4T3+pCLvBiuL8jXtVF3sHN/DUsJ1L7d2eqTCiEWv96n
         ukdPfiinqobAu+HtaMm+J6IQw9cZE1M3PXvVdUGN3rZ/PR0f0vDmyfXjefqH33hTNC+m
         +wJeSnRZX48QlTZVljBJmVELOs6SPVsyQ62lRJafidqELB3rO7guWdTV9JOeDkP3LZsM
         kgAw==
X-Forwarded-Encrypted: i=1; AKwUvByeU26iYcM5PVAars6/VRO2alPianqS9RQK8P5/5qfhCBa/th4JDFdGXBgWg1HeUzQZYgzOqgPO7rCkTxT3@vger.kernel.org
X-Gm-Message-State: AFq9FYLvaxyRHL/VCIwN4nqcCZHEIOUXHUzRsOXcEopgSMNKfwGJXxzk
	8xzUXQM6bjOM6tM0hFkOzC8WcDsODHWJknyJmD2wLPw4BuzaID8WZE6t10jCSg==
X-Gm-Gg: AYBFou06TkiINcpw51Br+jh9DOc6pY7KqHLEUd51TxgjaowkSsmFLdKpTRYMs77hVBL
	RiC4bR5fribmrhMz59E8XqjzB+WnZWx89sk0ZTR+utFNKT4F++OqWV0lmRM909hDr5IWmc6Mx9+
	SZz5YKwkKkEP52EPjnjguzV4ls6IwVe7TUA+AC7b2h6BiJOIXVUUGVUK7kOHIxGNosqx09vtdZF
	sii21AZcLkZ7EdPYQa0Hi4dBozbolHH8sR8nC3zWYLCEzEAGd8tnpktg9AyM4q+67rwiJZoT807
	KtI/HGPHfzfRm7H6O+M5YpHZ6h1bnF+q/vgnPFVJFWg9GtbQvnZq+F1rgnFNt7hta08ECaQ0ieg
	VqI8UKEq3xh3Eog/0LfFldeK8gbFpmv+1s5wiuhrrwlXGeY9+WiF5NzSIKnMNAsaYuuW/rTsG2J
	MS9eyNDg8HTiar7OZqt01meF5PGVCmaSJpA7cIOiiXL63aA6CbTfBjV14y4Ooa9intsD4wR3Net
	g07LHX5SJxT/qdVNELwKyNJ
X-Received: by 2002:a17:906:99c2:b0:c41:825d:ed8c with SMTP id a640c23a62f3a-c41825dfa20mr232515666b.26.1792255864717;
        Sat, 17 Oct 2026 09:51:04 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c42554cf6cesm58268566b.36.2026.10.17.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:51:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] selftests/ovl: fix detached layer mountinfo expectations
Date: Sat, 17 Oct 2026 18:51:03 +0200
Message-ID: <20261017165103.2450042-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_layers_via_detached_mount_fds was copied from the attached-fd test
and still looks for /tmp paths. Detached open_tree() layers are recorded
by d_path() as upperdir=/upper, workdir=/work, and lowerdir+=/ and
datadir+=/ for each cloned directory. The test has failed since it was
added.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Link: https://lore.kernel.org/linux-unionfs/20260924112858.51392-2-disgoel@linux.ibm.com
Fixes: ccc829b15d48a ("selftests: add tests for using detached mount with overlayfs")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/overlayfs/set_layers_via_fds.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 7a293544233d7..83bbacb2550f2 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -686,23 +686,23 @@ TEST_F(set_layers_via_fds, set_layers_via_detached_mount_fds)
 	while (getline(&line, &len, f_mountinfo) != -1) {
 		char *haystack = line;
 
-		if (strstr(haystack, "workdir=/tmp/w"))
+		if (strstr(haystack, "workdir=/work"))
 			layers_found[0] = true;
-		if (strstr(haystack, "upperdir=/tmp/u"))
+		if (strstr(haystack, "upperdir=/upper"))
 			layers_found[1] = true;
-		if (strstr(haystack, "lowerdir+=/tmp/l1"))
+		if (strstr(haystack, "lowerdir+=/"))
 			layers_found[2] = true;
-		if (strstr(haystack, "lowerdir+=/tmp/l2"))
+		if (strstr(haystack, "lowerdir+=/"))
 			layers_found[3] = true;
-		if (strstr(haystack, "lowerdir+=/tmp/l3"))
+		if (strstr(haystack, "lowerdir+=/"))
 			layers_found[4] = true;
-		if (strstr(haystack, "lowerdir+=/tmp/l4"))
+		if (strstr(haystack, "lowerdir+=/"))
 			layers_found[5] = true;
-		if (strstr(haystack, "datadir+=/tmp/d1"))
+		if (strstr(haystack, "datadir+=/"))
 			layers_found[6] = true;
-		if (strstr(haystack, "datadir+=/tmp/d2"))
+		if (strstr(haystack, "datadir+=/"))
 			layers_found[7] = true;
-		if (strstr(haystack, "datadir+=/tmp/d3"))
+		if (strstr(haystack, "datadir+=/"))
 			layers_found[8] = true;
 	}
 	free(line);
-- 
2.55.0

