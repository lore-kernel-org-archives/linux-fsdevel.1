Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEE386550
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592172; cv=none; b=Z10DiDQMoV93OxcLlvYT3g7S/ooe4gTC0Exuxx5v7bgup2t0bemfS+3J7MCLRDudjHttQVppv4tZvOGrKZaDUU1vIYvZ43uD7gbKLQUotknv0kteJBLSLVmVHOiI4eM1ewy2dST/CO3A/xxGpOWOcw4/90cy3bFDNVYTBnPGNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592172; c=relaxed/simple;
	bh=XHuhaYzURLOJm9gSsZkdpKJOAK5ycNWjARx3XgxPE/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHLhth4k120PsuCClccSjA1j3FxsuvyWIrz+wYVq9xQcxyyx7+IiWtorLebnpq15+pfG/4olSSBG+6gQx1QfXTH9Bz7gOEJa7MpUgpX3CG1Bn9BVTBiUeCfEJFzuKtueZMLyKw6X9KC987D9a76mpYSUduxrbvgEzEkgRAIMxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmaOt22z; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmaOt22z"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65006c99d38so5987582d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592170; x=1776196970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN3rsYPwNB7hPZYQqrXuOahpMQZ8TstAANGpzM3WXKE=;
        b=rmaOt22zeE9CbIilAHym9/X5Te8R/qxYL6w7nQlOQkmvBjRLN0w5xZ8iFCSdtD/n/x
         nNKdupK/g1PGuxTXvzJQM29vchPaIsn9b4Cc0G8tovyTKj9kG+tPEMI87kPNbTRk1roa
         JJ2lttoUpU3lsQjverDyNwwxfYG57nWK5YrbKeHeZ9SQTTWPimzXsrDP8dzfeKGgx5Vq
         me1nZeH6u3OAsT4fL1XIvHbxnvsbKpl6MZkcS7BYqQQyrE8u/PPOS8CUUSIztPmv1xCT
         OU9/T+hLbO5OopzhEyZpC5CZGjr+Q5RnTvkLpYuKnXiuX6/1nniNnePSvZoJ5guo578k
         4lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592170; x=1776196970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mN3rsYPwNB7hPZYQqrXuOahpMQZ8TstAANGpzM3WXKE=;
        b=lQ19wWtJZlPlNTLGmmE1CydcJyY50IYwQ8wmwIyCsFoEhuNQ1BJzFHC3gi198osrJs
         /ILLtnJdCG/heRCFO7ZZzllqN04bGa+z/wGV5ufWs5z5OKinMLzExVo/O4io+wjmR6Jl
         0u/iyC+FTM/lvWnjYAUf/pbHUa7u7uTUEVyrfEexmPS4HIdm+jeVxEVK+hd1mz2v1PYF
         VTtq793Y0eKYzWvxjLMg3dgvqaDD7yWdunWHGFWgzg3d9I1gJlrNJmZZZxtTDX6OM9t7
         jPVBoIVc9u4zU4pLghJHS9OLxuLStx9L0Un6DqGDLEEUGCr3EYsEyWUeAovv6aTIujrN
         stJg==
X-Forwarded-Encrypted: i=1; AJvYcCUcqAirLy7IlC2pej6KkT8/O+WjAjMEK9ui+WF3hNW3RUFsas+5gV5FQpCSUXTZasZ5ccvK4hTJNQ7b8HtN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt33dRmiGu41tsBYfcTjcguN7fNKcjcED0KwCFTTtmKUVlJri6
	vXU4kAw+oI+ez66K0TF7o6/zs4cex7r2irMfOWxkIBIQa3Wb8K003rN5
X-Gm-Gg: AeBDievR1T0gUr4pQQraHkHZmHGvkO03B4TSYkCSB6GNEExrFowuQtq4hmb3icYr91I
	GRrBiurQUaevYfvtwDdgXob2Zg7ZLyxnR6JVT21yqR7xAVWRoVxDhMRf5cf/JOvQyzFy1Ft5P2J
	AtvQI9anOgU9mgMFa5KSaKcXbwYALoPxQWD6VyAK9Ngt/k8d9jXJjN1MFtxe9WzjPpO0fxPRlan
	B3wIE4pclvd4ji46aAsyKcElorwFjyjwOaWxexZeM5IkK0f/oogyPapeuE+ppM0yXVCO8jYuqx+
	XD9SaAKo/uW3neNgkinmS8O9H14UyLT5OWRJ+6+ewcCMyuHmnVP510xB81ejiM+60xeu95owjth
	wT00nlgc1LwMBBzTNEc1aQSORYaj/BPKa8kFh31OtVRaU0occNRpWQsL43ITDLse35kepZ5CUQN
	onez/fN0qNO/0UZcqZB0G5v86PwB8Zpymc3VOrM6cjSdZHsBx4g0uA1Dp8ywmAHJAuImHS/yaN
X-Received: by 2002:a05:690e:1409:b0:650:8923:5640 with SMTP id 956f58d0204a3-65089235e7amr877472d50.64.1775592169697;
        Tue, 07 Apr 2026 13:02:49 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:49 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 17/20] tools: bpftool: Add documentation for landlock_ruleset
Date: Tue,  7 Apr 2026 16:01:39 -0400
Message-ID: <20260407200157.3874806-18-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_MAP_TYPE_LANDLOCK_RULESET to bpftool listing.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1af3305ea2b2..48bf6ee36fa4 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -56,7 +56,7 @@ MAP COMMANDS
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
 |     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
-|     | **insn_array** }
+|     | **landlock_ruleset** | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..0fe391a3ce73 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1478,7 +1478,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
-		"                 insn_array }\n"
+		"                 insn_array | landlock_ruleset }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.53.0

