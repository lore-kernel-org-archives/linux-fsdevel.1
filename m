Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E784A49BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010892; cv=none; b=tbCssy4EMqIo3TdmSfdrmbiPQ7mfW4zkV288ahjGR3YFzZjoII8/DRf0nazD8ZhHxqLHUARP6DGGyX3SNcg9TIeabLr//AAIPU5CqvrnEg7kaaihhjaQQaBRGViTTTAPthbwcJl6PH8B5MYP0S72IHsOxmm85O8fz8G41HUKgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010892; c=relaxed/simple;
	bh=jEUw1PTUbIUZFfIpYjNRGDosaCJoj/Pmupxim4Jwq8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pP69LVROcrdWbASIyCZnshdEF7yQf9VBXepbDsTgknYFbQZk+OZOg0poWFm2HhJyHL35BOYW9CJKiRpt5TV8Pn5q72LoQ7905g1/eQxKlyNHn5k6oFVXDjQCkeeMqS54L7UauCISL78gkh/oGkwaLPUiW/L2WhCj4BTNY6QTHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HoxgpLHf; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HoxgpLHf"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917a20e9efeso64975516d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010890; x=1792615690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HI+CsvyPZmneNEA8y7Xgdbvza6UQtYnY4BK0sCY6U6o=;
        b=HoxgpLHf00CImmsbXYSF52krlH9TVhbpPGiFIrp3xTdU5lqiSdqXv8/wDuE1HMq2n5
         E1mI2fEJfE04p0p/OFgNmI+5QvZFWkGx8PKUhzePk5jXshOzforLwNBE3JfI/6OAbTfw
         N3SIKxXts5esh7hiDhXuwqfCXNzW7wtZwwrttmnRRtwALXUHKhgt5XtMmVsAhi5ukpzR
         3WhlNuIgxHzHqjp8O908UhwtC3Fy8hYEeuMLdxIVQs3qxoGf+nDUi1VjdsgaFKCSkN/G
         lBQ4dxyXrNL/E7RRkqaAcJnDgSKhSKGJCh7GszlpQld7OFPx3YVaTCcDbp4F7/AwE+/i
         529g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010890; x=1792615690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HI+CsvyPZmneNEA8y7Xgdbvza6UQtYnY4BK0sCY6U6o=;
        b=XPyCV+lIho/87HU+ljB7rbAISMAslnhKEhQhda5ggUTF46xhg+o1dRua/9c1mMkua2
         g0cee8rZ8pJv5+3Z9jRhIvvcsPOrbCB/9NXR9fXITpdN3zSfzJn/R7Lb/GheIGsIFago
         0q7N1uM6fx6EotyHif16ZwNTi9btkhinBv9OwAiteNToaU12xy/hVkaFPIFlF01SLua7
         fYq2GLPu5n8WI4y/9gCdAjlO/ItVoOAWiLRGuohBJIjX/kA6z3qrSQcBKOw89vFSKJM+
         O7ybXxZAMPtbFtuuoyy9hu8NFquU0wDfYU7+BPZEX9Qr5RKhNwkdPOJ6jFMds/jNKfCC
         +BZg==
X-Forwarded-Encrypted: i=1; AKwUvBzGhp2QCx3wjrC6IUqZW9IxlwsgNymZ4WAIYLaHyndNjcYhdboLvPthG0ICjm6OC0W4LgUH2VVqeYq6UV6E@vger.kernel.org
X-Gm-Message-State: AFq9FYK5B6mi+R1YkinUyMzkAtvfqgEfA2ch4FwhrD7CkG04TDZf3m+l
	iYHL+YH2gXwk4av1pTZM14uS2WFuLZNgH5Wo6TFfJ/Bzld3QKZh0b7H5LcpG2FzM0fo=
X-Gm-Gg: AYBFou2oS1bSFh1tIRU5V8LWaPYvtVFI++20vXNxcB/wORHdBvF7crY3Be8rG41VbxM
	Uq1/W0vVO6d4scY1px7L/CELCq0L8/uV1qjw0vT8wt1RWWI7c9P5VkgNedp8IUsdIrZ/FGEBL4r
	on+YjihRnrOlNiPp1SfDJAAmh+sAzCvca7XC64b405vepIFaAXNtbznlZxhBfxD/QgN5rAU1LKT
	lgsjq8tbHfJ40ewGCoRvcdpCIbXwljp7xhrTK+2/TrN08eP8wnEkECa7wElWGcxNsnAXVZuSawF
	DCQTF3qR4Rm3Tlz79XOOBhTYamWsEpi8C2P12mzMPujSSMKE3bxs+TkB43YCuIl1Vf966Zp2UIn
	B5dj8IaGIZi0+a5qhkNZkqJO2NS5S1PY2USipWh+D9F94xT1rJy3apV4kScuhJx/4VT81eA702K
	4HfSTz6bRKUQbuSVPxsgT6dvJ5w7nZ8u1OrhU9LM1v+e/KxCM//vYX6a4ZaKFiC7/mWzkqDd5YK
	dtFFO3fMdxug+aZ6zpQI90g+Q==
X-Received: by 2002:a05:620a:450a:b0:939:ede4:a499 with SMTP id af79cd13be357-93ebd0c0349mr2772049485a.5.1792010889608;
        Wed, 14 Oct 2026 13:48:09 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef4f49861sm587646285a.4.2026.10.14.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:46 +0000
Subject: [PATCH v2 1/5] userns: record how far up CAP_SETFCAP reaches
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-1-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
In-Reply-To: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=5135;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=jEUw1PTUbIUZFfIpYjNRGDosaCJoj/Pmupxim4Jwq8I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI65p6wQznOE9Cf+NXVo7SxIvmUwzj/AdxXnb54k7JXQ7jLO1ZcwvF8MKhg0bK+dC3mxYAgn8fi
 /0m3i57JAqww=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

create_user_ns() records in ns->parent_could_setfcap whether the creator
had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
when a task in the new namespace maps the parent's uid 0.  A bool only
describes the parent, though.  File capabilities belong to the kuid of a
root user, and a namespace that maps the parent's uid 0 shares that kuid
with the parent and possibly with ancestors further up, so what matters
is how far up the creator's CAP_SETFCAP counted.

Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
namespace counts there and in its ancestors up to the one at that
->level.  cap_setfcap_level() computes it from the creator's cred.  A
creator that holds CAP_SETFCAP passes on the setfcap_level of its own
namespace, one that doesn't gets the new namespace's own level, and the
initial namespace has 0.

verify_root_map() keeps checking the same condition: the bool was false
exactly when the level is the namespace's own.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h     |  3 +++
 include/linux/user_namespace.h |  7 ++++---
 kernel/user_namespace.c        |  4 ++--
 security/commoncap.c           | 26 ++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 622137f66f09..026974a5111b 100644
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
 
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 91232053775d..f3753b6b6d29 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -86,9 +86,10 @@ struct user_namespace {
 	kgid_t			group;
 	struct ns_common	ns;
 	unsigned long		flags;
-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
-	 * in its effective capability set at the child ns creation time. */
-	bool			parent_could_setfcap;
+	/* setfcap_level: CAP_SETFCAP held in this ns counts here and in the
+	 * ancestors up to the one at this ->level, see cap_setfcap_level().
+	 */
+	int			setfcap_level;
 
 #ifdef CONFIG_KEYS
 	/* List of joinable keyrings in this namespace.  Modification access of
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..a5a94367600d 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -125,7 +125,7 @@ int create_user_ns(struct cred *new)
 	if (!ns)
 		goto fail_dec;
 
-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
+	ns->setfcap_level = cap_setfcap_level(new, parent_ns);
 
 	ret = ns_common_init(ns);
 	if (ret)
@@ -921,7 +921,7 @@ static bool verify_root_map(const struct file *file,
 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
 		 * when it unshared.
 		 * */
-		if (!file_ns->parent_could_setfcap)
+		if (file_ns->setfcap_level >= file_ns->level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..a51b9d51d96d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,32 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace of @cred or one of its descendants
+ *
+ * File capabilities belong to the kuid of a namespace's root user, and the
+ * same kuid can be the root user of ancestors of that namespace.  Every task
+ * gets CAP_SETFCAP when it enters a user namespace, so having it there says
+ * nothing about those ancestors.  user_ns->setfcap_level does: it is taken
+ * from the creator when the namespace is created.
+ *
+ * Return: the ->level of the topmost namespace, from @ns upwards, for which
+ * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even over @ns.
+ */
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
+{
+	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT))
+		return ns->level + 1;
+
+	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
+		return cred->user_ns->setfcap_level;
+
+	/* All we have is that we own a child of our namespace. */
+	return cred->user_ns->level + 1;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

