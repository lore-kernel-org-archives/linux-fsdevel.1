Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615063;
	b=CRmAXHieV8A1SnZQi2LFapNGQGb+ZoRTe/qL9azuEh1UWqomCnROAxClkDNVPMGVhuLE
	 Mo/L1+72ax335ewpxTNq7qLlxG9nfm/cS8stts9gG83u8bNQHwYUS8I7S7k0IWD5qr18f
	 IuGnM5G0+VzphyWaY3diOh/wljlrlaUydP8jJBU8X1CpMX0+nhrKAluZD2gy6zhPEkSoB
	 aY5nzRuSDjqKKWmd5gCfL3+cYEXsRpozYwmSIGzCgF2Nfo7swcqyP+Rs1OvVTeTDTkjnC
	 urfq2BFDTtH0sOKLm3iJLEsr2V4alroTZJpRVWJLmd0AqmVXL1LpPKCtR+sj9g7bTiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=Wc+MSGgLsEgRJbOaB4q30hQhXf0w157yKAAHJm37QolUFAygQJpsqtYnPlqwVCl3DVGd
	 vXGoeL9ZJPvg1sfqNMjC2HNengTgaCuew4WfRcsMDsFAxPM9y40K/JaVHlFyhEUekrIit
	 uGyrNIYJdExT3lX1tcpdhwXx2OBNNZJfWSrbpsLJSXjfD5kWUIvdoqez5FefyNttV+Y7b
	 GI5+k8st2ORg4H9BqdQllsmH8X3L5+ILdwTVH/JVulPw4CB9qO+2UWpd6P+R8dqMttbTI
	 7MYfM2nSrsr7mHKNIZV80pmAvId99Jp7I/4GG1cjlYoD9QeUY35dD0kJ59Y3qX/KNVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mNl8cqV4;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9944606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 20:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9944606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mNl8cqV4
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c19fc50abso8551526d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615061; x=1793219861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=mNl8cqV4R/oYmQC8R8wfJ2B5aJT/dlSx4Vh7ZGrIPkhrIK2xxjJDH3dVYYzvI6y5lX
         U5xDAYo8aaA1OhZBdaHgTFzDnUlRS2lpGvVeDMtAoQ6F/ByMQ7siq9/Vn/HDjTD7etSf
         0ajUiAtOLr5GAV7e+yuln32DfgCP6b9TCQVzX3K/KfNDlfBQmN9hdqL1ju7uf87uKIvk
         xBPH42PPhvmjGOYRZ6l1G4RBPOGgNR1DIszGrI9K8MFXzUWnNqZAPKG7vJobgE+Xs5Zn
         29JRu0S6CjCtZEOIwMBRKgslmFEjgHk+riOOURXxXTDqGgdEIqxakZlmWkdHIb2P9jZ+
         nDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615061; x=1793219861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=k2BqfakG1y0plNANAqTsk4j7sm+ryPMFW8hpJxgf9f0o2TZpJqC42Rwc4tRJCkfrm1
         k8VpFjKX+jxvgaP4sSRngwfGDmhcoln9Z9DoA3M28tIVnEUrsKlLF6xAJ/vQH1hHj499
         W3r/W5veIsXP8gHDDjBX+c+HWCFU83dMEBX7x1gTrIwy7ZSBZKxvSgMIh0qT7+sIuCd2
         5nK2YwwXgg/o9l9JUYbidKnPzBqTDi4rR5nk0xFUCzmZh5Dg/KD21ze8qYwOSSEZ7UAB
         UqumjBInquX1R2ZHwo8kb2sWiKTq2ZtnddYP9s6jKhXCFKEUsMXBxj4grKx028t0X0Aq
         j9RA==
X-Forwarded-Encrypted: i=1; AKwUvByaWNckxojatOjy4Tx5vVxQvaGMY9KAJT4Co2AYHzWC0Kh0gJoFQfHyZnf/+i2OyIL+WixEmZiqXpgIB8zM@vger.kernel.org
X-Gm-Message-State: AFq9FYJqin6f5kbcjwWoyatwjL4PtvP3AX45Y0P43RjD9s4ilM54Pf2Y
	rfd3NqvBUeui7kLI6m4WSj/cgmqFM6+XC1GNQjlUJPqVhSciUaBGgUnzCDuqr0ff6hs=
X-Gm-Gg: AYBFou1NiarStbkER8M2C+Zq4BoHGsnXJ+WYonFFkGsoxsQ7xMA6RIiniqef/PR3yDE
	e5VNTGHhSVNrE7N1Pd31PykTRHUzVUdS0LGKMJhyW23yvKOqUpQFOMTuBPjVr+wknzFg6czkKCB
	zad+Z1ZNmFvAqmUD5mXbuxIh1Sl+BJR33K9xm5Ko8xHfLd0mBBeYogfcmN9XeYO04+JeQJDEvOe
	IdZfnS4hUYfqqNFg5rT55MtSbwf7d7NvPKHR35GodMoQ63FWq4EUjreCs+heYU6RU1aQQbFCCsR
	UaKqkKsvBGUbeS2Y+FIMJs67f7cfg5lUksnDydbqTzA6oq1E7WBVo9bCIP6ck+OLrPcGz1p5YzD
	F/BmUYsIPWXNtWVmaI6O0ANu8EJEjazDFBoK2/whMZMFdx5ZP1dK4eWp6STuk6hcsg0VjOXW4WX
	M7oYDnyAOP3NtHEy59g0nyw2IsjsxoffoWg9j121jYTI7P3QlqgAf0rbXaK3pxMozgVFsbA3t+p
	i/Ouyw0Zi0KO3g7nyGLiLK34KbClOaBxTSKzyCg1SWyD/0Qlx8he7W5EiG/AuPGtOuf6ksL
X-Received: by 2002:ad4:5aaf:0:b0:915:4229:17a3 with SMTP id 6a1803df08f44-91c12ed418dmr52373626d6.25.1792615061400;
        Wed, 21 Oct 2026 13:37:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c3b500sm33488216d6.35.2026.10.21.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:25 +0000
Subject: [PATCH v3 1/5] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261021-b4-setfcap-userns-v3-1-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKbSKM/tdvHe5/+I2XkJlJrp2g2fCVDMwEPnWI34EErQ7FG+MOuQ4nePzXiBN8cxRMaO34b0HLL
 bJup859UUTgE=
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

