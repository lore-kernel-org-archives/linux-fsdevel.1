Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029314;
	b=VphkOobahN1U/ADTbfZz6VlU3zpR9ZUEuqoEtiAxW111+pzUM0gmcnLBd5r+zZsvHDj4
	 tjgT7vPHxG0K/9nZLBHOm8kEallNLX53n35tSTe9iAPqM1v/Ysi/OxfJwMyIChm6owVCd
	 CMmLl23P44g/uJ8hdlg+0Z0JNWXPoekQP/gn9teqnHYKQRArAwUjzXY12KwXD2ZJFrVQ5
	 Tt/x4Ac99HvDJLVTF5S0UZMkTC7AH49nuZx9lTd01Gx3QOGqKQOHkeTcMgOHO7v9VIHy0
	 NA3rN8UMcOj1ElIF8V65ynMIoHWSQRFrKs0xfYLgvsjk0qg9RIR2+Vsnx3Op/QmWixA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
	b=qNBun+mi7iai6HxSq63+TzV0jzHe2sqZ43eUmV45lUrYLcUBE8m2fjQ3zKGQ97I5SpFs
	 kPXLj9L1kTQCQQ2A4+VwvkiKdwADRIes8w4b0RaI61o/EviIVR+kk9l412ewjm8VqF0yb
	 jqixZQm/wpgNK5YmvOBEWa1N53J0Z1AiBVxqhpEn3fc5Yrsv2s5T+vveYZw5u19qzxIbt
	 DN3SlLa31WCNxD+oADQVjOHIBm0RueB5EZ63hdagSmCRsgBpuKeDVGARnjrfPc+9pBwHX
	 A389m+GU9EePrH0qidVS3Tc5fo7cyWCJhAsEGPEMlry1FzR4qwAZRPteITNiE4k2jxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CYj6O+YP;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515760A2601
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3515760A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CYj6O+YP
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac8a2ac52bso511437b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029313; x=1793634113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=CYj6O+YPPqVN/NThuARpJ4glDPKJXXwRCkZ4XDkFYkLb1aWNH6l14wUeUEXiwu6j4Y
         aJ8b8atBy6juKw8fOdHlamAAQO9IdrWiVayomuMiJ/n0v+An4iyePBOXrYydFmJHF8AH
         ofg3vSCej1Vopgl2ON2ysgzk02M5NqqNX+sMfjxqtIIVEXyNU0PbZgCfMMfwozwN2knn
         y4tLGGezXDIHbx0kPzQvgzKOEFQv1apl6bkQX8Vd0af2U4vpXA/tKjrfDtYEKVL7a4T9
         dAVbqDbG77mL5Q1HVQmnWU3Rug+j+u5bsnKr0nBCSBFEVvuKePH4z/K70HMYnb0uBVX9
         oNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029313; x=1793634113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=FRoQ0YK5DkRWmixD3f7pK+WpbD9Y8dUh8htb3ohsvTJWjU+wEsVu9R0GkH8qYcKW8D
         fUJKyoltEdBY0t0FYSK+g0EX5eZQx7ZS80pvmqh2ibwFL+XO31DvtUt60wU6oDf+G3Dd
         RC53Yws0MP578RtrazsFsqCZrD4fA1kwxqxf162EN22LcgnQMNGtSivjZuiWj4DmUBxQ
         9rG3qYrsHimiaQhb9Ju9VWEpTGDzWoyB4Vq9bDDAoYslaZTZh3j5G7HRBZj20VPhuIk2
         VGCJKvLU6/fpUhXTiRaadhA7qnZJSvBNbW5LMI22F5Qv9Fe+UPRWWSKMu8fItQnSJYNT
         YmkA==
X-Forwarded-Encrypted: i=1; AKwUvBwhrrzH5/Th3nt232edK9SE9w6gU88r4cO/nIdZubo3AZ/ploTKY0Wy6+zp4825pGQgMwq6dO0IwGV30TMg@vger.kernel.org
X-Gm-Message-State: AFq9FYI9nPq42jKYp/0sykeGs/uWhWh/o9HebqDGdhZmxUu10NhkVbgF
	tJrSgZYCkuttNogzKrTv5DIWnSSf/YSLfbAiGfneeAUuwCAepx+mcJKTpbLHD8XcUP8=
X-Gm-Gg: AYBFou1+u6Bm5Q+xscwm789kpKAiexXmxvbffBqMr2sTK+lpkptrulpI3Ii+CSvnFFw
	YxAnSsNW6WsX7GrNKoAiZzc7Wc1J6I1eAKChzDvdvzS+N2XyhQETyh5AMSeLTz8JZunpz1GePd6
	hkaT73owbE/63dpHDLPHRkAw1jopaPqsgUkav+s1fEtgcbqTnR5U2wUJQBcBKWZ5lMfdVgF+ufH
	fWd5sCj58h0mo30ATDFgGkJaNND9za2RdhP6WP62V1sOtN7HsyF5JXABFPhpQyN05l2gWSgeQcq
	HBZHLnMNIOsSlRqN6e0D8YIgG6Tt4eJFCasSAlccn+q1TU2HOXcF9YAD9Ao3SxMM6dEglzkmOr9
	4OC3RiG+zavgqph8KNQZ3yi+T4Vy3U5ppn2KjpUG9gJ7oLokakpBLgG/qg8GOi8XfCY+qEO3gXF
	PPU9ft3OI19NRgkPqc/hpONBQlxQyvDlgXgDyz7KJKORpuAZeRh2l+0KIXSB+rj5P3B/iKh2+Nl
	xxeIRSaVTEWAWBA5c7UlK1k/CxiOJxJ2Iy6cXFoWrRtOYkwQAXJrnzMCuZzUd0/0BZJaRCR
X-Received: by 2002:a05:690c:698b:b0:8b0:e13c:2852 with SMTP id 00721157ae682-8b19c9c4694mr214787b3.7.1793029313228;
        Mon, 26 Oct 2026 08:41:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e10d50sm33046137b3.21.2026.10.26.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:39 +0000
Subject: [PATCH v6 3/6] userns: check the opener and the writer before
 mapping uid 0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-setfcap-userns-v6-3-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029305; l=6694;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tq4QC700hpQ0XsVb6nesQjcXMRFBl8Nnhz0SoKNdw/Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIHWuNeC+fFqpHEHcTDItz3zq3ggZ98aAqBYR+ptz1N/S3xRGyqaUX/sgV9U0ICWu2ng2kkFmLD
 k0bQzwL2stQw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

verify_root_map() looks at the cred that opened the map file: it asks
whether it has CAP_SETFCAP over the parent, or, for an opener inside the
namespace, whether the creator had.  Two things are missing.

The writer isn't checked.  For every other privileged mapping
new_idmap_permitted() wants the capability from the opener and from the
task that calls write(), but a map that consists of the single line
"0 0 1" takes the unprivileged branch, where only the opener's euid
counts.  So an open uid_map file is a token for mapping uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  fd = open("/proc/<pid>/uid_map")
  B gets fd by inheritance
  or SCM_RIGHTS
                                    write(fd, "0 0 1")
                                      opener had CAP_SETFCAP -> allowed

And the check only happens for a map with an extent that starts at the
parent's uid 0, and only asks for CAP_SETFCAP over the parent.  But the
root user of an ancestor can be mapped into the parent at any uid, and
the parent's own root user can be the root user of ancestors further up.
A task without CAP_SETFCAP that unshared a namespace, which a privileged
task then mapped "1000 0 1" for, can unshare again and map "0 1000 1":
host uid 0 is uid 0 of the new namespace, and nothing was checked.

Find every ancestor whose root user the new map contains, at whatever uid
it has in the parent, and require that the opener and the writer both
reach the topmost of them.  A task outside the namespace that is being
mapped needs CAP_SETFCAP over the parent, reaching that far by
cap_setfcap_level().  A task inside it needs CAP_SETFCAP there, and
ns->setfcap_level has to reach that far: a task in the namespace that
gave up CAP_SETFCAP would otherwise map uid 0 and get it back from
execve().

This only affects maps that contain the root user of the parent or of
one of its ancestors.  A write by a task without CAP_SETFCAP to a file
opened by one with it, and a map by a task whose CAP_SETFCAP stops short
of the root user it passes on, now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 87 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7bd3692c2f3e..db078dd6406a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -881,15 +881,55 @@ VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
 }
 EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
 
+static bool map_has_id(struct uid_gid_map *map, u32 id)
+{
+	struct uid_gid_extent *extent;
+	int idx;
+
+	for (idx = 0; idx < map->nr_extents; idx++) {
+		if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			extent = &map->extent[idx];
+		else
+			extent = &map->forward[idx];
+		if (id >= extent->lower_first &&
+		    id - extent->lower_first < extent->count)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * The lowest ->level among @parent and its ancestors whose root user @new_map
+ * maps, whatever uid that root user has in @parent; INT_MAX if there is none.
+ */
+static int map_root_level(struct user_namespace *parent,
+			  struct uid_gid_map *new_map)
+{
+	struct user_namespace *p;
+	int level = INT_MAX;
+	uid_t id;
+
+	for (p = parent; p; p = p->parent) {
+		id = from_kuid(parent, make_kuid(p, 0));
+		if (id != (uid_t)-1 && map_has_id(new_map, id))
+			level = p->level;
+	}
+
+	return level;
+}
+
 /**
  * verify_root_map() - check the uid 0 mapping
  * @file: idmapping file
  * @map_ns: user namespace of the target process
  * @new_map: requested idmap
  *
- * If a process requests mapping parent uid 0 into the new ns, verify that the
- * process writing the map had the CAP_SETFCAP capability as the target process
- * will be able to write fscaps that are valid in ancestor user namespaces.
+ * If a process requests mapping the root user of the parent ns, or of one of
+ * its ancestors, into the new ns, verify that the process that opened the map
+ * file and the process writing the map had the CAP_SETFCAP capability as the
+ * target process will be able to write fscaps that are valid in ancestor user
+ * namespaces.
  *
  * Return: true if the mapping is allowed, false if not.
  */
@@ -897,42 +937,43 @@ static bool verify_root_map(const struct file *file,
 			    struct user_namespace *map_ns,
 			    struct uid_gid_map *new_map)
 {
-	int idx;
 	const struct user_namespace *file_ns = file->f_cred->user_ns;
-	struct uid_gid_extent *extent0 = NULL;
-
-	for (idx = 0; idx < new_map->nr_extents; idx++) {
-		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
-			extent0 = &new_map->extent[idx];
-		else
-			extent0 = &new_map->forward[idx];
-		if (extent0->lower_first == 0)
-			break;
-
-		extent0 = NULL;
-	}
+	int level;
 
-	if (!extent0)
+	level = map_root_level(map_ns->parent, new_map);
+	if (level == INT_MAX)
 		return true;
 
 	if (map_ns == file_ns) {
 		/* The process unshared its ns and is writing to its own
 		 * /proc/self/uid_map.  User already has full capabilites in
-		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
+		 * the new namespace.  Verify that it still has CAP_SETFCAP
+		 * there, and that the parent had it when it unshared, as far up
+		 * as those root users go.
 		 * */
-		if (file_ns->setfcap_level >= file_ns->level)
+		if (!file_ns_capable(file, map_ns, CAP_SETFCAP) ||
+		    file_ns->setfcap_level > level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
 		 * user namespace to p1's.  Verify that the opener of the map
 		 * file has CAP_SETFCAP against the parent of the new map
-		 * namespace */
-		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
+		 * namespace, and as far up as those root users go.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    !cred_setfcap_reaches(file->f_cred, map_ns->parent, level))
 			return false;
 	}
 
-	return true;
+	/* The file may have been handed to someone else since it was opened,
+	 * so the same goes for the process that is doing the write.
+	 */
+	if (map_ns == current_user_ns())
+		return ns_capable(map_ns, CAP_SETFCAP) &&
+		       map_ns->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
 }
 
 /*

-- 
2.55.0

