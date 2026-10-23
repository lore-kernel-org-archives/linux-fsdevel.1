Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773028;
	b=uo6YvmxQqwCrDiJFArOix3qw3kuAXLzbiJ69gBcTkPlAQYwJbAMystUBhFYk86AF7XvN
	 39zATGlDq43ZipXdju1ZB0Bt4w9Y/CIRM9g6G2Im0ApEWxhlrYwHMFt/c4bW9tioDlrUV
	 vsFG+5pAOHlUQRJw2IRfwLyJYmL3TU0qRvABxQSmmx7WfEZopo5MlLJnKJXVSmgMPOxMT
	 5WogOrOoJZquPHtnvx9jV91GTrVqBJhrcYELUHW3eAfnQLXNYpo4OVGFUgGvuGapzjVcc
	 FH6w0AxZ6acZRg8UDnGTtS3l2ePlKlZWFTMfFWe524UgF2LnZybpKUIC0HIH+QJjIcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=XXfqk+OISfIZ5iU69iOzu9KWVYXeI2s0vNJxPQBQ27+UW1A4L31bjkeSFUgs1VLnrZ8g
	 TWNxKeD13OVAoWbvHMxF+lhqegPy9jyivsnqXXVnd3itWrYtFeYS5d0EWJ5n5YIDhhkr9
	 fH5HsIDGK4ptpG/sj1xXWaXcbYR57NO9NU2D/YnBeTuvUzv6TqqND53WxGRNKdS4zr++i
	 r7jqDLMsn0chKTA7kRBHcXb97Lby4oQE7QQ9OtcTUY+CKBF1t4dF3UMZKdzUh6KTeauEA
	 aLnrZ1BikhkX/bWrF1Jce1Uxw1k4K6ev50fbbrbA0Td2Pa4OzGbhGqqxhTaaA/gesWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="kUZKiK/x";
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7E606A322
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C7E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kUZKiK/x
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91befbcad6dso17610236d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773027; x=1793377827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=kUZKiK/xbZEF4FfAj2jy9vESHWp0r0+v0JYi16PQhPQSxkJdrjB/ZzAKq0tuVMPxI0
         d43gcmVVZNoyCoi4WQZRxiLSlXwwYeWfjAKxPd6Kb+BJsX8IZoKIp37uJxcOlXE6PqB2
         lzDWuVaWxKJQsR8nZNvfZxeiXozif1mXDKZ40oSS+/zdbtkEHkTDBmQNzZ/c0hWlZpnj
         n74gk5KPzTx36Vwop5xszcTe2kq6p6jO0Q+DXUTLSZQeoZsXWp82MfujcCRuAIntyeZ8
         OSilgolIeEvEiSooZVNwvoI1mVTq2Khe8EerLx+9FMt1jirr+FxjshZQNq+xEvkAuvQe
         h4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773027; x=1793377827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=zF/MCR7KSrQKcd3scFzditVBqootZh9A2VHieRlGayNxMEKoX0OSlzR7mrW0A4shpX
         ewYk7MDuRoVVIf2aEx8WtoaD22WZhqOifrLUgKI1Drr5jD/796g6ZFnX+q77gjQgagtF
         7shTkWDiJOhylbioZ4Fv2NNBe4qrOtjgRUrPBSQFwCMkehMfBRHa4MI1qs4fN8zpdzGT
         hX05UwU2vvK9eqV/nl4GUWyCDxsTWEDEvF0D5RfOD2XNJanhEJKIiG/16tS+hkKjBkKj
         848CycuzYGNiMDSwvM9KbKjQML+JzUJ6H5ivlduB97ApDnEz19wX5iVRS03VpNr+tIqv
         UoWA==
X-Forwarded-Encrypted: i=1; AKwUvBwVVo49Pc/NTaHuPUqPm7Jrk7mLuYf6TPJYLaQHV7u7jdkdFn9zPkiCPNd61yFyp2UVu5xShsyukwFY4gkf@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5X7JGNhYUxjvpNfv4VCyTtOb/3Cc25bPUp7xyPCivxGs5yH+F
	1UZL+9W+rIFoEasZm+V0uixUX6yp8VR/QLf/V+Ffui6BtIHBkTnrLJJ/vZQtd9awGa0=
X-Gm-Gg: AYBFou1tI2TFrIve0+L/U+dkMkXfWXsCJbEsUzYY27UNC+6HoVU6sB+mPC4+v5aRNXW
	c2PoV40AH3RG+KZkM+xWbzNCCVR+UB9kK4+UkH2wqXmgpzaHkSHwdBVFeDzMky5c98cU/5Ammn4
	lm/qYHKnThgJ4J96NAnjoS9rzRtCg/3QnIvPF4bX5tLkpzV8X41yTJySzjWEYOHWf7eHKmYPb45
	XZrQJR/WeGKbSDZqV90FiyO6Bbg1viA3aLIyuavfmNxq/xtnoyLwt2+F42hv0VRIhgPQLA7UbNl
	TWv40fINIC0IRSdrlFPt7Aa7HOUzCrZ6k2hPYSN3paMc459ZT6RlmhZcHGJl9wG2EvKFFhRTTCR
	JB7cZFkNhLGI3jHJRsYyJYKjPORpM6ikRcDMHofwSQnGuYUkQzAvk85/NB/m0V7LT1gBT+Z9enr
	fuzz//h7pE61Ym1xQtOJxx09BMH2+sA80NbG7pQDWCcrWojBhbBsBpSTXSYIcdPK6O8z84Hno6h
	yKdf3LY1B99sWUckxjMe0b9oKCjHb1xs+O1/pZZx7K761HYRK6KBv2yQE6uVqFBzAJAoHZ3fg==
X-Received: by 2002:a05:620a:1b85:b0:93f:5892:e5fd with SMTP id af79cd13be357-93f6f58503fmr467858185a.1.1792773026841;
        Fri, 23 Oct 2026 09:30:26 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b12680sm57600485a.26.2026.10.23.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:07 +0000
Subject: [PATCH v5 1/5] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261023-b4-setfcap-userns-v5-1-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEBTalhVY8lQSjDhhv+N+ALBQMAXX8ndn55BXbUWWRuAtchNVj3NXxJeTlGL32K8YWf0xyfJvib
 e6pgn1ZiZzQY=
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

Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h     |  3 +++
 include/linux/user_namespace.h |  7 ++++---
 kernel/user_namespace.c        |  4 ++--
 security/commoncap.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 5 deletions(-)

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
index d47ab3022343..4f49dba65426 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,33 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ *
+ * File capabilities belong to the kuid of a namespace's root user, and the
+ * same kuid can be the root user of ancestors of that namespace.  Every task
+ * gets CAP_SETFCAP when it enters a user namespace, so having it there says
+ * nothing about those ancestors.  user_ns->setfcap_level does: it is taken
+ * from the creator when the namespace is created.
+ *
+ * Return: the ->level of the topmost namespace, from @ns upwards, for which
+ * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even count over
+ * @ns, which includes an @ns that isn't @cred's namespace or a descendant.
+ */
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
+{
+	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT) != 0)
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

