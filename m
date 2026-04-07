Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52137BE89
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592148; cv=none; b=YR/QEO0l/uSVGF+jwq5jtYopD4oVOJVA1agiaP0EBAZ2hhc/jlerPicp2p7If5HvZuE0qvugHbulurB9P4ygph2nUsGSAmIC7aRn5MAA3hh5PwMTHEFjeOUams39mE6tcm9RR8KwZk4ZTz/y6amvSCzqR9HEq7l86YPWXMFLsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592148; c=relaxed/simple;
	bh=2CMcW2gq2LmD6OBr8KShORwyqyftbdR5TuaGADyZZ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmN0su9k1+EnhIIAMhjLBP/o4DlL90KHsE8zvEnqsudndUPJLxXrtJbc6G2DPyas23Pk5X6udTYAD+KK5rgQ2o9ERSVNtL2YujSmqnFCtVq+EA5KSk0Ly2FDj7GT76ZAv3DXvjTPxWucQ9nbMu2e+HyD1qSlnOFEQdhpRFZC9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enO869OX; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enO869OX"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64eee7b83cfso4378907d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592145; x=1776196945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+Kz9KQLBOk2gZAk6F760LWdEiRy/BzHmk2mLo+ys2U=;
        b=enO869OX6+lKrCmPv3YMb9cY5TbheaTdV1u7lyE15BBCMX6+/kAW7K9mixbvUXkDOk
         Mosep08MeJflR2syvhe+4O/2FLii7ORtdQxHAafrfgnnGcly2EBeLZ+Za6bth08mGIBJ
         u7hT40BbJ5hnnkMsz7pBBCRmcP5a+//tdvHNZtznHKMKPqWXzOPl6qWDZQ0MmH0y+AnD
         Fp+xamww3eMWMeZ/mPXIkGkLoKupbX3ad3AwuUe2TBzWhQQ2GbraTTZjXkhwQrJB2FdO
         I1WMDga0aCrUD5X6hM4FnP6EE6kpUC7GYL6Ex7Ab6uO8qWAMmYI9Cdn1cGz3DSEiiKJP
         V7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592145; x=1776196945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+Kz9KQLBOk2gZAk6F760LWdEiRy/BzHmk2mLo+ys2U=;
        b=UaSy9Sk7QOsXbvRuBanxECrT1YyIdUEEqt/cyAS6KX4t3jEGnC/cuRo9nopH964ICS
         cTZi3efVy+4bmsgE6yPgPQLFCD1H5ZI7M60CF9utMA8x/rZn3iU2K/RoqN4uAmCKz5R3
         16ukHxDWxwRt6+U77eKgpAY6AioOdt0aazLmLnf77tUmYMf0CatlWa3oCjjOxRyTJ2DC
         zHegdMY9qwIVpjbXY/pJIx7vsQR5+8qHZGaWz8+++yCSWw2IX5vO34G1IhtOLjgJJqHx
         4F1HgMl+vYqefbBSuj/cSBpZhsYZyA8BqGUEgonyEPLWFQlsZ6vyT9iJsaawiayP5v1U
         5hWA==
X-Forwarded-Encrypted: i=1; AJvYcCUQRpyglotAlXa+RoUCKUieu61anTwkThpdKYx9tPn2sA2zYwKtmu92M6dp/MDNP9L4kmva3FOdJy56Tqf3@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8TN9uM032leW7SNzDwKTDqJhhZKqaDOyIZEyzotHMJkxDNgC
	ETfZct8eBgLUjUXTnNxdRBkXuCA01YCgPc/H9QJj8TDL+VfbJNmpCCE5
X-Gm-Gg: AeBDieuYcVBm2LSMP48Gm4QVtxl8hGmX0dh0X0amuBy3Y2ttgggB/c9KJFetJMA1/hX
	S2uHXsM5q6siKDa7aKoUFp3XzxtoJ4AELlvm1MkxABtgI54YEgVq46wjgyfABl2eOnK8oxB4oaT
	+bmSHHdkUPjxX0z0lC0N2OJfHxaHa/hTic61OSNxUWuMT5bRKbc9Ukt7EcQtrePG8ciZjhr+OkO
	1JYdA/wklAU/oTOt6wpTPD20FOfR8n3Cba9w4+GpyRdNY87Skf1jKS62e2Ht+4v7FLu2u+yfTUd
	zOP2OFBl9Ku+DUmPBSBCqY3bunW30RtAkGZXweKRV1Itp3AN2JSRoQ0m+2/6pPRelU/43q9ERvI
	/G/0X3e3A0xCZNnhSSd6JAHytZYGGmR/9DsIpGJiR8Ylqdg4sRM9wwkp8VRbzraROeRkSW9KneU
	nnz3c48In7NBtH/W7wdyxp9o+snqszppIgfoQ0Oj7IbAkluupAyBoEY/E8v/ZE8/f4Bw/gKS0a
X-Received: by 2002:a05:690e:ee3:b0:649:b31e:8f48 with SMTP id 956f58d0204a3-6504871787bmr13350525d50.22.1775592145445;
        Tue, 07 Apr 2026 13:02:25 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:25 -0700 (PDT)
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
Subject: [RFC PATCH 07/20] bpf: arraymap: Implement Landlock ruleset map
Date: Tue,  7 Apr 2026 16:01:29 -0400
Message-ID: <20260407200157.3874806-8-utilityemal77@gmail.com>
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

Implement a new BPF map BPF_MAP_LANDLOCK_RULESET. This specialized map type
is designed to store ruleset file descriptors, and uses the exposed
Landlock helper functions to ensure that the ruleset isn't freed
unexpectedly. This map type may only be inserted into from userspace,
and only with a file descriptor referring to a valid Landlock ruleset.
Updating a Landlock ruleset directly through a map is not supported,
as there are no fields that can be changed, but you may add rules from
userspace as long as the file descriptor is open, or replace the fd with
another. Elements in a Landlock ruleset map may be deleted from
BPF or userspace. Looking up an element is supported only in BPF, this
is enforced with the map_lookup_elem_sys_only field in the map ops.

Reuse the existing fd_array_map operations for inserting and deleting to
avoid code duplication with existing FD maps.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/arraymap.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 33de68c95ad8..f0da17e0e23e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/filter.h>
+#include <linux/landlock.h>
 #include <linux/perf_event.h>
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
@@ -1458,3 +1459,69 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
+
+static int landlock_ruleset_map_alloc_check(union bpf_attr *attr)
+{
+	if (!IS_ENABLED(CONFIG_SECURITY_LANDLOCK))
+		return -EOPNOTSUPP;
+
+	return fd_array_map_alloc_check(attr);
+}
+
+static void landlock_ruleset_map_put_ptr(struct bpf_map *map, void *ptr,
+					 bool need_defer)
+{
+	if (!ptr)
+		return;
+
+	if (need_defer)
+		landlock_put_ruleset_deferred(ptr);
+	else
+		landlock_put_ruleset(ptr);
+}
+
+static void *landlock_ruleset_map_get_ptr(struct bpf_map *map,
+					  struct file *map_file, int fd)
+{
+	return landlock_get_ruleset_from_fd(fd, FMODE_CAN_READ);
+}
+
+static void *landlock_ruleset_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct landlock_ruleset **elem, *ruleset;
+
+	rcu_read_lock();
+
+	elem = array_map_lookup_elem(map, key);
+	if (!elem) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	ruleset = READ_ONCE(*elem);
+	if (!landlock_try_get_ruleset(ruleset))
+		ruleset = NULL;
+
+	rcu_read_unlock();
+
+	return ruleset;
+}
+
+static void landlock_ruleset_array_free(struct bpf_map *map)
+{
+	bpf_fd_array_map_clear(map, false);
+	fd_array_map_free(map);
+}
+
+const struct bpf_map_ops landlock_ruleset_map_ops = {
+	.map_alloc_check = landlock_ruleset_map_alloc_check,
+	.map_alloc = array_map_alloc,
+	.map_free = landlock_ruleset_array_free,
+	.map_get_next_key = bpf_array_get_next_key,
+	.map_lookup_elem_sys_only = fd_array_map_lookup_elem,
+	.map_lookup_elem = landlock_ruleset_map_lookup_elem,
+	.map_delete_elem = fd_array_map_delete_elem,
+	.map_fd_get_ptr = landlock_ruleset_map_get_ptr,
+	.map_fd_put_ptr = landlock_ruleset_map_put_ptr,
+	.map_mem_usage = array_map_mem_usage,
+	.map_btf_id = &array_map_btf_ids[0],
+};
-- 
2.53.0

