Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773037;
	b=4Ewdm2ylN8BdqeV+VBRM5Cw96ZrN7VIcSjuxnDacQXsmJLJ2FP9SXUVQ9leughPJO705
	 HdrrSVImBKtuI1ZuVwRtyx9XTwSQhvtTeiGm10rJ8yNpuXspGX+A4BaHeOfe4LFM2cupa
	 w4iUZm/inTULr5xYTveqxSCYZmBvYYAjM4b4Xp8FY7rDbBPhjkuzz9budnRs7ByO24Ukj
	 a9pAzphBzMQ6aXlBrtT5Ge8XZn/pi0mB1J0z/9HlmQ/t4rbQvMlvC997BKTnml04rbDda
	 /OGoh6pEmOvGvdX3oSy25613TyTbA39vsdaaOAu+oGXELU1z73/h07NbsvKvtDSv7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZubeVwcSSrwC4ZpOURNYhfBws2gj2pZEaNncuu+HoEw=;
	b=fIzvkR0fqfs2jFUJZXOzSX4dx24ODpsntcmQL9q6zEdWsuC47s690WgroRh/m5X2wkJx
	 13+60TkYt8zZE2aRw9+pta5hfKbC3lJJuscD9FoN3829/mJqKKbMaUkWhQxptqHq/VKlT
	 EM8Bpe7CVyr5K7Nufjt7moMFCA51NN9mDXVnMOlnwv4YmwxfO+pP40Lm2i34DZyOZVyE/
	 jiA5nG3CBC6c8l4cXoL+6/dNTDAzpVQx1qMEdpBColhwSdOrl36i2SmQavqjFcuRulaUL
	 2siKgSWpQySJP8KYFI5XFxUqxwfZ0BHhqq+gWY1ZFWKA8sYbh673KGO6dPlHjggraTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kzFXO3oH;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F0606A335
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5F0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kzFXO3oH
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93c5b7f5bfaso211585685a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773036; x=1793377836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZubeVwcSSrwC4ZpOURNYhfBws2gj2pZEaNncuu+HoEw=;
        b=kzFXO3oHFdI0Zozf35LOrS50VMKKJq977g8DdM6fE+VjJmEDNHUpBQ3WfrKynMFhr/
         Q9Cmvc/8hLs2UK/jr6dm2Yldrs/+Z0GXJsrZC0M9hNpgOvNFRIPDxo5rNyE9tm0C4D2G
         o77PkCjuo4Zy+7BX+GyNtk0A4ioANVhIVb3t1J0Rx8yJpzg41ayOHjagydpzN70KdiE6
         41mcjqRQCh8IomJfCswQtQxBoSC4+QvvquaUlMgAQ/0LC9Ye3xyNQ6R+r+fyR6RYoPFa
         BsJRm2y9G7H4nNV/EsDowbvpmfb+D1j3hyBPnO9xv8j3E5vTv7B60DgWxhqJUySuEq3h
         +uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773036; x=1793377836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZubeVwcSSrwC4ZpOURNYhfBws2gj2pZEaNncuu+HoEw=;
        b=bLuNjHBm6FWzRT0qNzs5dJryrYS/JemCHkFC0koBQFNjWDFEOvoC+eluF2tcWc+uGT
         fit7n4K1jfo4CSGuk5f27C0HBUzGkQq6UkxxGoKq29uoC5aQuW8RtMQioIuUa0cp3T/E
         /QkMPTJysDcOCJX4KMstfUrOAdfEddgSwNrIroCR+658P2AWRKoAJavPBHXzqr6eaOpg
         3aDGnF5sQodvPXS+OiFSuOC4fm058KBimmyXDOVS19VEqqQ5sXI6tYMF7xIdgfEVUWaT
         URLJL8XleieEgiHSHOHOetuwOleROV4Zedq28mBBxllftDi5CfzJRvoRGiaA1xAVCbLm
         kxyw==
X-Forwarded-Encrypted: i=1; AKwUvBw1pyeFum6mwQ4//+py9QAXfOCD8ElWPPdz+9ye3QGwNX0yxtRSgci1QvDxGkBysPKlWGw7zHFbj66Ev70r@vger.kernel.org
X-Gm-Message-State: AFq9FYI7QppQO7EM8riAUmTBbyP/O6XeshvDhA4PAxBWgvEtmZTg+5wV
	CJm44xs4ZObQ4HasF91AfNsTYqd4HAPA9VOj7ihAMQI5ZkdwjmUjklBNkULh4h+jv1M=
X-Gm-Gg: AYBFou2cfEi95/zf2GJz3AvazQboytawhVG2WNMiFlUFK4um2FsaQwDPjy2T/WVWoEq
	peS4/3/CUtYBKRCJRMnT6J2r8Xzg7CpojW9h2evRkfV04Evqw1p1zcej1wg13g3AIDvwI2JKjjG
	mj9ewdlvXUZYBUx7gXtK2yQbsrFgs3wdC43yvqXHMal2mJmIZD5G24/t48qLXSxPBFWIqFIEnNv
	18AcQe2VFvEYSqdYdvNlczcyfCf9IdmIvWP/vJFzdsT3sW2qxpnd082K10vCtjk7+zyVJzq3tZA
	xD3FHSSu1cuTGs1fSaDxK59B7Y5+9d1sDgSG3IfvbuUSJ0kyaWL9p/UyDVfcd53wyxMH6yecwxk
	8WMEXZWFPH31OwIQr21n/agA/Cc9BceFUOs50VnAqS6PtEqVhbDbtGNkQ4beN1IJH39PMT9NiRe
	5LSeCi67cWL7bGamnedLx3WzjcuUKm5mdZftwhVApgrKExYFul/myu0dGP/v5vH9KlRR3mNzxrP
	4ts4vymmx7jqLS/QvrxjJJCW8OCHfqgu/gO0Vx/k76fg6QVnlITFBmlXKDZnXx8wcAANh8O
X-Received: by 2002:a05:620a:4104:b0:93f:5304:422f with SMTP id af79cd13be357-93f626da712mr975867185a.9.1792773036248;
        Fri, 23 Oct 2026 09:30:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b1c97esm56189085a.30.2026.10.23.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:10 +0000
Subject: [PATCH v5 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
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
Message-Id: <20261023-b4-setfcap-userns-v5-4-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=5344;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=/O9bS0ON7NDi1eFWDO2d4FUpDMW0l6ZmsSOp/+5oH7g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLOB40AYzMuO276rGBVj32RlrfQWWtaiGFlNBPbISDKxkkHMnwLuii9VlVvai8rH4pvQQQF0Obi
 z9qaMTYNE4QQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

A v2 xattr skips the conversion when the writer has CAP_SETFCAP over the
filesystem's namespace, and belongs to that namespace's root user.  It
gets the same check: if that root user is out of reach, the xattr goes
through the conversion instead, and is refused there.  Otherwise a task
that unshared without CAP_SETFCAP could mount a tmpfs in its namespace,
write a v2 xattr on it, and have it honoured through an overlay mounted
from the initial namespace.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 8a9d998b1897..3551ce9b046a 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -216,6 +216,29 @@ bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
 	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
 }
 
+/**
+ * cap_root_level - Find the topmost namespace in which a kuid is the root user
+ * @kuid: The kuid to look for
+ * @ns: The user namespace to start from
+ *
+ * Return: the lowest ->level among @ns and its ancestors in which @kuid is
+ * uid 0, which is how far up file capabilities with that root user are
+ * honoured; INT_MAX if there is no such namespace.
+ */
+static int cap_root_level(kuid_t kuid, struct user_namespace *ns)
+{
+	int level = INT_MAX;
+
+	for (;; ns = ns->parent) {
+		if (from_kuid(ns, kuid) == 0)
+			level = ns->level;
+		if (ns == &init_user_ns)
+			break;
+	}
+
+	return level;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set
@@ -671,19 +694,41 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
-			/* user is privileged, just write the v2 */
-			return size;
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * Only write it unconverted if that root user is within reach, the
+	 * checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP) &&
+	    cap_root_level(make_kuid(fs_ns, 0), task_ns) >=
+	    task_ns->setfcap_level)
+		/* user is privileged, just write the v2 */
+		return size;
 
 	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

