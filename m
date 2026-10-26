Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048446;
	b=LlPUT+6PSiPL7/TOZKiUzByjojW2egwgls+qgEWdJ1Ecl81e1GIzSGGJ/20KCgJX0Djy
	 i/4gRv8Wuil9JyuDRCk1j1XjxUfdVFpL9jjcd5oOk9HYXPH+4t8nvlCBVjeme9WVmOEZD
	 wekTxnDpqU6Twg/xjSFDeFy2hEc7LH/P77w+ko+Kt6e3QULrCQa2msYLFbGt7sZ4CE92V
	 Lbo6cmZYn3OZ/WQp+1mBVToZgADDJ629VUDmGjAw0d7US6ISCLafpzz4H4OYqxAoBbaCK
	 FhD74nJwQEvaXRH5YoP/hcmnkwTmWrL8/B/cmBm2n+HTpGnyHcGZYdDTUe2t6mciVXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=plPByLH0WDYUoStKPLOi0ErYRPbclMSdD3QH5SvQlLUaVQYUoT1PeP4USTy4vHagkUJ3
	 9UG0BxtFrP5XdeIvVJo+OLGgtUDbgJ1gCTrHiY8GlT8vFSoGlshxqw7QAh49vk+qIR3AY
	 sVqclrcszUSs2UiyoATnnanU0dTfN50o6caPqb3Bag/EbzkK+2rVG3ZHTuJ80qczZj9PY
	 JaSCRFGBMmqkQdg8oX/dQUusIXAUc7I4u1L9CWfP56RrffHKjxGid/N8e0QxWn3mp9mak
	 MQjzu+fweIG8ZosFrVHRvJfIlEikGp8CN6oVZD4b8i8Z41rMspjau4WVhYDKhJjnSNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630EB60A2600
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630EB60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917a707f37eso34947336d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048435; x=1793653235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=BLwKQn6Fi5H8ZbNI2H+RkZ+vtrmfkK10wJfH2YotYolD3P5zkZC3dpJCYhVG+yQkkU
         gzEHqfsnYt9XIvRLmAmzlWl9usdArchsDaEoKilvn+8SiGMMZq1/Tl6kyR++mInvc1Yt
         gc71x3LmV7nwBV8WVEXKU0Ct2RSn4EbLqln9jvCMDUV5v3szTXev9NysLHxFBKpSwNud
         ZMup73VzAooVoTzafh7y5/dDaRrX4d71IDmIpePvKC6ndbxyc083TRla7ytJvbP2KDRg
         j+YpBK2OurtSgIyO+4X701KGgtp37/+F7f4C3BCRMSWGRkuvLA2bQeeoF6z2DvZKcyEe
         ZVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048435; x=1793653235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=1i2FWpr79/bfZLJ86eB+w/kJJzMNvKPHTiaVamrIa7sja4cUyRD4tY39AyyJjSeWMa
         uCi2/F2TLMcFhGIKHWoGmf6g/Qd+9J806Z/PEqthCfzxF6IbXn63uX/4bU/ThUO7XBxf
         d6a1Fa+tyKHCG/LMtqiKQ71clrinAvaMxbFaMzoH3ojG2rQLVYViNxoRhsRS3snnCXss
         YR7A45ahckrYeJARuxkhIPlqQ5IyNzTQh7+QtZblLu/h+h1dUM92FRuOyoHmxjKS1iQw
         g6AJBVdxqKuIOKaUdgLPRMMuU0e7BEqFmi0IBAZnz2VNgy+AWHPSUGyooRzyU5kJgFxs
         piXg==
X-Forwarded-Encrypted: i=1; AKwUvBwHGxc4hrx+dl1+aTbQxN1uwQ3ZMCs6UZJUqTjUVtmhNyevnUYgk3C6COZ/eiXoNSIMKmQI2g5SfhAVMb3f@vger.kernel.org
X-Gm-Message-State: AFq9FYL510hKXnRsT2DIFtbfEUZZ5VvX818zQjZTPm/cuc9F4n6F3Ign
	/jlnIp13CbtPUgamCfc4IL8HD8kyeOmtJXD2/zEAhoCEXSXEdz7qeST1w+gPx92UBS0=
X-Gm-Gg: AYBFou1Pj/7XZApbdbF39EHDCMQiJqSH6r62es75iMjdbV8VsBVLiI8yNn0Qw9P01DS
	wP30sNvCuD8lfijvar8Wio7RIJMEyz8m6Kqpqvd8AL8dfedUOaTYEPTGLijmlVrNHf8BXkQBeaZ
	kh4IcAd7nWa8RGyW2SmlJOYRDhbLeFWc6pWanQ+GwDuyLVxEllaSpO7MymFSTWKMp/SoZ9ByZlN
	AkDTHXXZFxXYn2/BBr8G/Z9qp07BMzHtUg2wtyCamMXTV++QncGEomHsYeas6MVH8oPpaQ2lJ8R
	2WkRaCmsLukfwHeI8plNFeOorI/aZKh6ZfjAQO5xnxD9oEQ5Gvn0bkhIZ0Pi/WrY4SLE7KPaiNy
	UCKxCYdG/oZSxiEpyhhO0zf+R3qW0K7pA6tQpaV9D78KV+orQtWRdF6QKzrKl8Mw8DLojF6zRta
	M7/I2Z3TvWjwtOdAdlZjfbaIFDXg3CE1L2xH0wq9Df29j6WwXHDtZ0tr3GaUE1naPEdjpBoMtXc
	LzYfBv4CdOVl42aNe/aFsHbNFRwFJXgab8YhOD8ZJiIrIiOl44IfzSCLBLA8EaQN/QOlnkfkW92
	JKobW3L8vfvOjx2eiw==
X-Received: by 2002:a05:6214:21e4:b0:91b:8fc9:417d with SMTP id 6a1803df08f44-91c48e7fca1mr138560226d6.35.1793048435019;
        Mon, 26 Oct 2026 14:00:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c96375sm82875786d6.33.2026.10.26.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:20 +0000
Subject: [PATCH v7 2/6] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261026-b4-setfcap-userns-v7-2-bf8a576f7259@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKRP9p7Y4tKjH9ZoGRozJ4Df14LwNX7qnG5PhuVi/E2OgFp6a281oSYOheOdJtkwSplfOhyguvX
 7Rlr9blxsvwY=
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

