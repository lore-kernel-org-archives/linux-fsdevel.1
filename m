Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048439;
	b=z4ODaOPE++i+zdHaTSvamEQE0zeOntIAWCfA0YfpCQHCL4qxr4q9r2wTu4juBaAolcV1
	 266+cFk76P1QGTSfrf9hBVcPnx9i6fVeLg8PVZjIxI6PKBdc+mLWx9E02gVIWIHLMqJhM
	 RSnd5LaY4+zP/PcR1B59JYQ4ioHD9AXusD5AiV1j23Cnqy03Inb3ZUQqQinLqTmKav3zd
	 trZK210v33ggNhm3vrMCOLJhAWvID06lVel33WE9KqPtUmatYhWgzaAMPO8GSKCXBlsos
	 che8SrT2vwpPwLDc7/EuplW+rdFWqGfqkqIGwcyg4NvCwPwxE87Y0OGfVGTqE/6leUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
	b=5tcte7hxR+PiLDAh09U2zwzWYHaRYrNYsK7lhB2vlaCaKZsT1KUda5ymec5rY2uK8GSe
	 cJHuStIXG3K40VdDk0zLrm6NJwy9YRLu61l9QM3zE3pXWJeRneOF92I/MQs5Wkd47G1YZ
	 yQLBKmRHIGAvYyYmPf2LIUhF3ksDYi9+pkULL8iQJxefRZhYpnaHhzHXDOEQZa3Pmi2Uf
	 6W0cCBjlmjqo17ZHCIuaJ9DKZIh4qFCL/W3g2T8VI1M8ZWuK9/06TzhBZG1B9Xj88prVu
	 RZPp7SVXAm2TovAkBquXobe+5aBk2lW9n5b3fHnL1sD/I+Amh88FD3VnIiNFHVCjH1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TzI1kkl2;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6D606A32A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB6D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TzI1kkl2
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5363316fa0cso53507441cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048438; x=1793653238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=TzI1kkl2mSfQ85YGENYPjutjEUP4Qv8DAFPCYXLDw3acvuc7Yif+TIOnqtHKvf1Cwj
         Ei5aFdW5PntrNNsTu4iWxmh2Z+zZgwfdQoxOKem7ctRp5/KlmH4qA+6tfc9iDdcg85Qw
         Z1i98M5rPLaGj12czaqrzKeNu2d/xmiIsq3hDFoym2VQMz9s7XswkzmKaX1njPEeUgoQ
         BEYv4eSNujQL63kJJdAtSCNN1s65+zwR+IXHFqWv9vxtzB0ljnOfe9JYuJXNlRvUO/lf
         CrvqK34ZBYkfedtyAc1hqwTDexKJUllWpVbYCaRZfprqHaZdiH6Tg1PDUdhnWcy/my/T
         XJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048438; x=1793653238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=YChBGnQbMhfGniAyRlLsdqz3BmtPTsbsiLs0QaCUONjc3mHajFIuHJm+qwx1OGXXnH
         tqikpuNDg9JkL6QmcoWMkQf7Ppdip/RQY3b6qCh5VFyX8kDyCM7jmTgMFpr/4cGCy3vx
         RMt4BJYmo8Ttrll3Rs31JMS0opamWbpV2vEDo0cRZJH+uBC2mpCw3n/9/tF8gwS4g0jD
         0bAdrAsGE49dQmqRSb59lrRZaGahpAyf2UOlGI7/zkQPGzo+a1OYdw+7vADhiyzXVd3M
         /JQP5B3JjT/tJ1zUmb/1nP1Kj5AfxKKYip4iAT+2H1idza8JIbVx3msh9iv/vk+UaiR0
         aiRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjVdlyxHEPYhor6k46AIMWFOkqKGOwwCA9G4ePZdxAi+Sh49qP8m/LFt80p0jBuvowe8sro5DXKRLqOCPN@vger.kernel.org
X-Gm-Message-State: AFq9FYJPBjlMCYTC9lMY5sIv9QSVbGOTOR4KgWVu4j9Fciun0G435D4P
	bNVMSIQDaLYUQGG46tSI+s2Lwxkrpes0ROV/WbyMp5Cf0VqQ8KdlWLNEGbAzH6RCYF8=
X-Gm-Gg: AYBFou30ky6Uh9lDHxOKtyhoAm+xdCxgGKa7Sh9ts00z+b10XW28CowVDB1GozBP7aj
	5NtFJkeLYPkmrT+62kDbFCyH6UA4OD9GZmoLjTEy8OX4GaJgOlmeyktqFuy2jAQMSDtpQi+cBRp
	ynuoh0tvX0ajg5NLbt2ioKFw+uSPh5W4jZUU80bzDvgLlI5mMmk2W4baYYFvcxNiSveGkmzWLui
	yCVLvaJRVl4uEve/EWbkidc5Hy7M2IU87m6MdAcJ8myJp6LkyaqwhSzQjz03VNa3pPM5y2DHjJ4
	u76R/nnOiEYmH+tYKXjT+DHWngixwxL7xMa6s1u+hT96fo3Hk1QyMQjVtXCDY8Do1FingD1nuzR
	8JFC3Gb4hn+zG+yh9WgMnIYZ2jLSAt2Q1kSu7aGLPs7xJ181jY1HVBV3wTYW6vQDEuUewk8gtvN
	s7wwkLG2t4rAlWGSz5g3xjRLnF9YnRukzFpEFfHkVlZdvH6FFeocP+iYx/2Pgn1oNSP2hmk7+1F
	6pabm4qMBT+ZM3Ipi9bCoKOEhWA7+xG3w2pAtPwRe1kQOcYj/rlsul1s5Bt2HUBXV6CD2n5
X-Received: by 2002:a05:622a:5594:b0:535:cd9e:bfc8 with SMTP id d75a77b69052e-5383b6e775fmr128967861cf.77.1793048437994;
        Mon, 26 Oct 2026 14:00:37 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383973f314sm63147121cf.24.2026.10.26.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:21 +0000
Subject: [PATCH v7 3/6] userns: check the opener and the writer before
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
Message-Id: <20261026-b4-setfcap-userns-v7-3-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=6694;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tq4QC700hpQ0XsVb6nesQjcXMRFBl8Nnhz0SoKNdw/Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM9aieuT++ilR+Qz7gxmzZu8MAed36/c5amF8PT3lZXNvhnW0pB2ZVMa2WNXF9bqnonpkcmUG7V
 pCusIkYSsVAo=
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

