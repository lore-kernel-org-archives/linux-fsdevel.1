Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694202;
	b=RFfmVnVSgpoUonhC3eNp2J+7DzywRNs5I336Gx0M9hk9A3lnAbAK6/Pbjva/y19wvS+8
	 8qU22c/9jvWsVWDBH4vs5Akjcw8HV6X5Cjb7uCu2U8Lv0bon5WeWziL9iC51oYxR4elIH
	 2Xm9jpmgeJyCBcLHRJN2L0OcxQGwjYxNgXd/NkNtIfeVEnWWwWcjBwWhnOICYmnhg88kw
	 DxEFRI5JscwZwh3RBYfN5vGCpjMbSZcfOjWxK3ta4FZ6k7PVryfnmkzq6Fz0BtZA5ACsY
	 zJyijWCBzQ3qUs1EN6ewhS70keLMNPGqa5+xLw+x+H4VoqxL5KxAWWPIOytsKInPNEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=xAsF//+00WVPT0MbzOsCGmqlBKburBhhnj/haRWZqp2R/fVFEDKzcNobdnk/qdsFcBHA
	 BtZIdfUTOzxwMySui2ycyUKC3cnmmt1UVrwKxpdZghyYx1dDR8oAjzmzPBTjWVU+tjafX
	 lSYoGMMq4UiQeTatN+td0pdy439t6Kr+lwhKUIEmW0FS+uXRZm9bh2/Q+MvZ3jOY3/1Ey
	 XnxUCeihGbYuvjjhMojUJUZZMrQKbCV8P/T/hGHYIabJpPdhmxg+hL2uJcNIPeRuaYpN/
	 99/SAUt5+PP8VnFf90RO+pmbbxLvCOjRH0h73i174J+UBNq2auqs64i2XfhWCP6+zRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Da5IpzFB;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2A606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 18:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B2A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Da5IpzFB
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5365b48238dso281861cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694200; x=1793299000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=Da5IpzFBl/t/AuZkBwDpYrEDlzxgAK075QWTOy5vR1dT92EbXvug/V9As/ptgfozcZ
         haeEAtO5IhBylFrwbTHUXL33EmAsO4lrjP7FSbLDlR9PB7WyyVPBZ+Ki5Ta9U9XvfDoY
         0qGlZRGo+InLkKZN2ZxFjlM6p4sJ++iSDUdWJQXQ/6ZFGfZX2XXLHux7sdPhD7VLUTeu
         OlCTJLBRCTRymblSDrRXfDp37vI2Gk0pemgrbTLE5gfokMHuYueJMV5yJ0uGGUAh5lVN
         IenLUZ475Zh2NUlpOcAu7pdEmzhxseKJFKsP/nGGAo5J0eivIq2xRfhH9qyzmsVIzuOf
         uZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694200; x=1793299000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=xdtq+4OU5rjRM7FVJttC4WiyT5HrT5hkyuzfnXEgRQCPxMbH4KzuOGlVuJfNk0nX6a
         KZNKDKs3hiR/GQeKpm4N4S/Jmxcj4mhDVUDrBYEL87DCV1yDVE4yV7tIl53GZxZvpTy5
         aNKuQbPmU2+sxiUouT/ymtMWrDVtpCzZBfd/J1h6Mry/kU9ySdxP6UEn9DGcvGZCkXOC
         j7DDYw74Kkx/+Tw+Fpc48MMGT1eyhkFg4MrbYt/4janaxoaO03uMxJzevj4ohtdBvpGk
         WQQo0jRWF5tmAiFW7yyZbPvjLeckyQ9I986MIwp8wD8I2vPBzZ7PYenTv0CRlbGc7orS
         yurA==
X-Forwarded-Encrypted: i=1; AKwUvBwTiIGT3k//zMVJOfDIged9VlA9xow14GHiyeNY5fmGdxwYm4eecDM0qkxjmC3iVRJSxD6nECW5wlC7Zyu1@vger.kernel.org
X-Gm-Message-State: AFq9FYLj0BqxUN+BZTGB1+Q2Za0GhGBLIOTodw0pb/BeWkobMZ3slOq1
	L8xeMd72rtMmBAjYVZ8u0II0nAWYrFTjR3bVnXJkWbwl6aWdLkinkjcjLadVy6xPWm+ldl2+9Tq
	M5g7Gfrg=
X-Gm-Gg: AYBFou3dWHqmZp577tqNB/l4GUkOLGNGPJ+UiAKyRJKrskUwMyvCyiJlk70TJA/zZSK
	NFo2FP4MiHswZM5jEm/+vhpAqMzeQE1myc4ydvGTvrEhM9SWz89CwBBywSOTKB0NYwKQ4NBmeTr
	tpAM3O3Mm6RL9F+0bDiVRn/+0di3Te0DxoGwHi23d47F27oAPmFvGijU64C1mM0Cuvp11MI89Oh
	twBxjnSGopnaORnbegvVWpQJodHaCV8nRpmLaH+8D0HhzOWls3hGQzqFeQdDPv+TllIBBqsSVRS
	NKm3WhudJ5fqg/5Z8Vqx1hhUdG78Te3FhBd96cLhKZv4ToBBvLnhLAalqayJ2I2niYfny8VZmmr
	0+EfPjZXrKbRaATuozmiTubK0tZH+mwTiQ8r1bvXfrUh8ytwQqEIEI5SMTHllU6EWmb6PbuJcRi
	qieEXSgi8vNho+Dydpb/SFmOqvIl5XtF1U4zzuShK8Rzdzb+Gum8EtnzY9YH4OTsUd/vmHLtXHM
	Y67jVjvJZGICA4RUX7bx+OhAWveJHBhhuiRQt9qRnITkK6oLxrd+MvYpgetSujOh57Y7JlQ
X-Received: by 2002:a05:622a:1813:b0:535:f9dd:cb8c with SMTP id d75a77b69052e-5369b68f86bmr96241071cf.19.1792694200389;
        Thu, 22 Oct 2026 11:36:40 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab6f5c9csm33898881cf.11.2026.10.22.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:20 +0000
Subject: [PATCH v4 2/5] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261022-b4-setfcap-userns-v4-2-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM/ahjV20208az5IZRy82VEqyZ0IuWu0b9yg2I1rzhGFwGftatKCP3w0WLLSTlI160zk3va7lOg
 pPLWLMlVn9Aw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  A task that is already in the namespace has a
full capability set there and can't be asked any more, so
verify_root_map() goes by what the creator had, now ns->setfcap_level.

But setns() lets other tasks in, and they get the full set as well:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      ns->setfcap_level is A's -> allowed

or, if A's namespace maps uid 0 already, B sets security.capability on a
file.  Either way B ends up with file capabilities that are honoured in
the initial namespace, which it could not have written there, nor in a
namespace it created itself.

Refuse setns() into a user namespace whose tasks can write file
capabilities for the root user of an ancestor that the joiner's
CAP_SETFCAP doesn't reach.  That is the case when the namespace maps
such a root user, or has no uid map yet and its parent maps one.
cred_may_setfcap_userns() checks it, and cred_setfcap_reaches() is the
comparison it and the later checks use.  Then every task in such a
namespace is entitled to what its setfcap_level says, and the checks on
the way to file capabilities can go by the namespace.

An idmapped mount can store a root user that the namespace doesn't map,
for example a "0 100000" container whose rootfs maps 100000 to host uid
0.  That is a deliberate setup and up to whoever creates the mount, so
it is not considered here.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace that maps the root user
of an ancestor, and was created by a task whose CAP_SETFCAP reached that
far.  Containers that don't map host uid 0, tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces are not affected.

Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undurchdringlichen-35666eb62cff@brauner/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  6 +++++
 security/commoncap.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 026974a5111b..e4199b03668b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -224,5 +224,8 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level);
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..7bd3692c2f3e 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,12 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Tasks in the namespace may have CAP_SETFCAP that counts outside of
+	 * it, so only let in tasks whose own counts as far.
+	 */
+	if (!cred_may_setfcap_userns(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index 4f49dba65426..8a9d998b1897 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -158,6 +158,64 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
 	return cred->user_ns->level + 1;
 }
 
+/**
+ * cred_setfcap_reaches - Check how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ * @level: The ->level of the ancestor of @ns it has to count in
+ *
+ * Return: true if CAP_SETFCAP of @cred counts in @ns and in its ancestors
+ * up to the one at @level.
+ */
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level)
+{
+	return cap_setfcap_level(cred, ns) <= level;
+}
+
+/*
+ * The topmost ancestor of @ns whose root user tasks in @ns can write file
+ * capabilities for: within @ns->setfcap_level, and mapped into @ns, or into
+ * its parent while @ns has no uid_map yet.  NULL if there is none.  An
+ * idmapped mount can store other root users, but that is up to whoever sets
+ * up the mount.
+ */
+static struct user_namespace *setfcap_top(struct user_namespace *ns)
+{
+	struct user_namespace *seen, *p, *top = NULL;
+
+	if (ns->setfcap_level >= ns->level)
+		return NULL;
+
+	seen = READ_ONCE(ns->uid_map.nr_extents) ? ns : ns->parent;
+	for (p = ns->parent; p; p = p->parent) {
+		if (p->level < ns->setfcap_level)
+			break;
+		if (kuid_has_mapping(seen, make_kuid(p, 0)))
+			top = p;
+	}
+
+	return top;
+}
+
+/**
+ * cred_may_setfcap_userns - Check whether a cred covers what a userns can do
+ * @cred: The credentials to use
+ * @ns: The user namespace
+ *
+ * Tasks in @ns can have CAP_SETFCAP that counts in ancestors of @ns, see
+ * cap_setfcap_level().  Check that CAP_SETFCAP of @cred reaches as far up as
+ * tasks in @ns can make use of theirs.
+ *
+ * Return: true if it does.
+ */
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
+{
+	struct user_namespace *top = setfcap_top(ns);
+
+	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

