Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521322;
	b=L2t3QAdqgL892eqbueuyiXod+iSQMO/dn87Ub0AGNYUmsAGTu2smfnkjD1kaUd8CH3Pb
	 FGK3yLHKgffDsYoaTSdLoU17OVKw2A16jcLgT+4rz7UnsBZZu5KX3daeCNICWR2VyQxfr
	 XB7uIdR2V6R+lwjFekOjotw1UPb94IPDTRfUxmdCBebCQLd47pBFdt64Jt55UTVncOWZI
	 QfPi/sT4Ku4LfKoBlPqQej6GkwF2AAjvnNIt5eRIClD+J2PSaWUmzcqAV2dwgKUenZ0Ky
	 Bhvz7mqyrMejsV3RHJvIKj0zEjYgAVjI4/C8zuBWmkz5my2Tc2wpTmMG7hgUlRwoSYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=XqAkjHYN3eMjIwu0a32ICbFY6UqF/GFsU2ycOn3Tbio=;
	b=SjCm5UQ6lm7epmzm205+5s+7htvvJ4m0Ap6HX67oCRrIMR8HUfAUJ/TfdAbItxkPvW4c
	 0p8wS9P/meUxzDoezbylT55urlqyR2hOrn9X2d2nEDdBYZ93ABsQKZ+OQaRY324sTAjMr
	 MDZCV8iZ60GN/twlwOC3oe56HySa9pVFbkac8uCZ/YNjp+owlWKPmwbolkV07gsKAby5q
	 AcQ4FmXDQS0eie82BI3/9NyvndOxKUlxMInod1sWB7pp2Ni7J01P9vP2v+b05kCRc8TYU
	 TIhKKdFljVTkR1yHbpmwrE9CvHkEqbNqDWS4RJ8SdzqkjkD80OLOfOqwSmGRx2prxvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YnEXSXtb;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EED606A338
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04EED606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YnEXSXtb
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e64d52949so33854885a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794521321; x=1795126121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XqAkjHYN3eMjIwu0a32ICbFY6UqF/GFsU2ycOn3Tbio=;
        b=YnEXSXtbfYsnbj7F9jAM2ALsO2Qgi+dReIapBOfkqWZe6l5uod7ly5CohVXj7C3uqV
         fS+IuqAa4rTKOE+dTufL1ms1K5VXMeDJQXpdl00JK69gDVAwT5vhGmnCrtCbUQjiQmsS
         obFzdasLK40y6vddLtSv3IfFz45nTQXoB7O9KY7ynWlgvKGYjEvk92fHCnVh+/4ED2b+
         b5+TtMOuvENhlAP18DPXlVILFLDK2QIE+PS45ewp+UmyY9LsovMYUWQ0+dCwys1TZ41C
         6do+7lPsHMHlbWT78VKfItcs3QoORD0d4iR7SgEramJcvrFdjLeCQOlgkKgTJ6GMR27F
         RAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521321; x=1795126121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqAkjHYN3eMjIwu0a32ICbFY6UqF/GFsU2ycOn3Tbio=;
        b=1ats9aYWYKcIOzs775x/dlzFC8Iv7SPgTpTl9gtCrmRSw9IZeQ90S9RncJddUo75IE
         qiRUPqym5kjZa7xpn9uI/xW8KruJTB6In8ZrBvb4e0r/NeFSUlWzUEVn9jKZZ1+8lzrz
         71KLGy+pAy2+7HTvdXUtk0n9Xpqo/ZRR9vwZATvJ4A5jyzih2/HGKY8kRQdl8Jj4uv9r
         xmV8lMeku9ilF55V3d8VPNtIOLQqyzY2uFSVXmKItWpyMEpl2muw2yfI88nYeWuEu8QI
         3p701nymJLikr0l9aunIK4raLhin5PuDc/hYKV8hsYcqHwN26JHrLj+v7KMp8cH8vs6d
         XOMA==
X-Forwarded-Encrypted: i=1; AL+hErEScEyNZ4RHg4SA9xjPoVNDcTmMSCkXuhSGY5AIYeasdG4lIvPyleTEmraui09mvHy6tQ/WZDKd6ey2AcXZ@vger.kernel.org
X-Gm-Message-State: APuU4Z9ano41U3VABxxIpq8w47YVNGf1KCfID7vBOmgn4HUQNtOzSNQq
	AyzFFn2s/Y+d2xfl7Hds7laQYESFBxk3l5yIeMQILHtA0g2ap858XnIX49erEPLmJpo=
X-Gm-Gg: AYBFou3zT8ldB5wgZNmwNRuTrLtH8x6Pi/Tbjgw+nQ89ChZYpcmUBV70oba4pKk3MI5
	lPbvFiqjgeMizC+ehIyHTPGhmU5jUqY5F+Qs1bSgSx9WDEj6QZ6sE/eaqJbfw+OPsukndMpdqYt
	DQ6iGXgHoKePI5paFHnqEnX0eS8TgG8YyHD1wmtx0l7r9i3KLZAyY54fR82SdXnOhqevhnbfizu
	1LXAphnOM1QUhqoDqXraEd5qi6mkB1Nm7H6F0lMesPyAnuW2sR/U3GrHbdq4haoDWN02KWXc1AW
	yc6lyij3y0iZlW9qK1g/pK6UsnzYaz+q9p49x4iJFQVO3dAW+KvQtFiD4K42sLNen/uAvc/3otP
	2twlDVIwUNU8PJwBHIy021W02P67mOmzNj/sv4OHNCl7CWeFvirQSjJNG1dv0KQRJY2wPKzJ79d
	+0lFqAR7Ud6We1hDcyJsxAAnE+VXfN4TZAReNYdL0smF8egNyb99krC+HvsFs/0kQSV3Q6mvD9w
	GQVmXoBxiLcm6B4SKXR6RalonKt/vuXu5U4x5Vo3hYFrmoqG8DYoVBsUPoGWyJXWor2/TgstqDh
	2y9ZsrcvnrfKAiZB5x/ljJitFhDTCKaY1/4cvYX9V0HoLQ==
X-Received: by 2002:a05:620a:4611:b0:93e:c12c:f11f with SMTP id af79cd13be357-9494bcda704mr134303685a.75.1794521321011;
        Thu, 12 Nov 2026 14:08:41 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8fd141sm37251685a.43.2026.11.12.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:08:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 12 Nov 2026 22:08:22 +0000
Subject: [PATCH v10 1/3] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261112-b4-setfcap-userns-v10-1-84f6f7faa903@toxicpanda.com>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
In-Reply-To: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794521317; l=5741;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=mcBZ73PUvSuHn08UlyduFZr1I+2NFoF6K4vcZvzLTTw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGq5xWI4v4xhbjAJAjIUR/1GaGGmmWZyq2RbyWpoNXd1rJgDN9zVzST5hFkv0HFGwpAMlnSdHqO
 NxxyRO3irYwo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
namespace that another root task created.  Commit db2e718a4798
("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
from mapping uid 0 into a namespace it creates itself, because tasks in
that namespace could then write file capabilities for its root user.
setns() gives a joiner a full capability set in the namespace too, so
it can do the same there:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      A had CAP_SETFCAP -> allowed

If A's namespace already maps host uid 0, at any uid, B can set
security.capability on a file right away.  Either way uid 1000 can then
run that file with CAP_SYS_ADMIN, which the selftest at the end of this
series shows on an unmodified kernel.

The check doesn't look at the joiner's uids, which it can change while
keeping its other capabilities, and CAP_SYS_PTRACE doesn't stand in for
CAP_SETFCAP.  What gets refused is a task without CAP_SETFCAP that has
CAP_SYS_ADMIN over a namespace that maps the joiner's root user, or that
has no uid_map yet and is owned by that root user, who could still map
it.  Containers that
don't map the joiner's root user, tasks with CAP_SETFCAP and
unprivileged users are not affected.

Like verify_root_map(), the check is about uid 0 of the joiner's own
namespace.  The root user of an ancestor that it maps at another uid,
and a root user stored through an idmapped mount, are left to whoever
set up that map or mount.

Fix by refusing setns() when the joiner doesn't have CAP_SETFCAP and
tasks in the namespace can write file capabilities for the root user of
the joiner's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  4 ++++
 security/commoncap.c       | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 622137f66f09..9ebcdab56937 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -34,6 +34,7 @@ struct cpu_vfs_cap_data {
 #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
 #define _KERNEL_CAP_T_SIZE     (sizeof(kernel_cap_t))
 
+struct cred;
 struct file;
 struct inode;
 struct dentry;
@@ -222,4 +223,6 @@ int get_vfs_caps_from_disk(const struct mnt_idmap *idmap,
 int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
+bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns);
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..34becacaccd6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,10 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Don't hand back CAP_SETFCAP to a root task that gave it up. */
+	if (cred_borrows_setfcap(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..99a77fe459e9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,44 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cred_borrows_setfcap - Check whether a userns gives back CAP_SETFCAP
+ * @cred: The credentials of a task that joins @ns or traces a task in it
+ * @ns: The user namespace
+ *
+ * A task without CAP_SETFCAP can't map uid 0 of its namespace into a user
+ * namespace it creates, see verify_root_map(), as tasks there could then
+ * write file capabilities that are honoured for that root user.  Tasks in
+ * @ns can do that if @ns maps it, at any uid.  While @ns has no uid_map yet,
+ * they can only map the owner's uid, and if that is uid 0 of the parent
+ * only if the creator of @ns had CAP_SETFCAP.
+ *
+ * Like verify_root_map(), this only looks at uid 0 of @cred's namespace, not
+ * at the root users of ancestors that it maps at another uid, and a root
+ * user stored through an idmapped mount is up to whoever sets up the mount.
+ * A map written later from the parent counts for every task in @ns, as it
+ * does for the creator: mapping uid 0 of the parent takes CAP_SETFCAP there,
+ * any other uid CAP_SETUID.
+ *
+ * Return: true if @cred doesn't have CAP_SETFCAP and tasks in @ns can write
+ * file capabilities for the root user of @cred's namespace.
+ */
+bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns)
+{
+	kuid_t root = make_kuid(cred->user_ns, 0);
+	uid_t id;
+
+	if (cap_raised(cred->cap_permitted, CAP_SETFCAP))
+		return false;
+
+	if (READ_ONCE(ns->uid_map.nr_extents))
+		return kuid_has_mapping(ns, root);
+
+	id = from_kuid(ns->parent, root);
+	return id != (uid_t)-1 && uid_eq(ns->owner, root) &&
+	       (id || ns->parent_could_setfcap);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

