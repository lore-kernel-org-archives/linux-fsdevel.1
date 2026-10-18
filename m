Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54F3F9A13
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344724; cv=none; b=GKWDOdWTHcbeYOWikEDg/FLE6K5eNiypr7QHcN5mRESK8wuvy8yQsmsPC+2lr/TdAR5aEeS2yVj3yGzuWMF/IeSGsKa6xZvb2Pt4bNvzqaIytFJcpbFfyQqjkXRLGga4FBQ6e4VdNAfelF5LuXB0pmHagvP879/Y3mwVMPAR5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344724; c=relaxed/simple;
	bh=zPspISpYWICNVbBVaAWDbDSuQ/FH00gZGsNDounQARI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tTV5ouoEgPoH/lMK3vxgue/owuQOTR904wRDc5v+Pqv/0Lj4bJ0QhRSs4wl1AwVnGLlez2YTF1NM916LZRhalRyJrg8ME5RfTHIgCSpqAQdgM3LfkWpGmkPGGcMV9WK47+v9tbDWcP+9q8cjGu9DVmkKncX4fAZezMQU/dQFnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=oh4KBMFW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="oh4KBMFW"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e4c00d71aso138187285a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344722; x=1792949522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gvhPLq+K4mlbUmYX70fdM545pGYioWzN1Cy4PqDCQE=;
        b=oh4KBMFWaWPI5LS8qIQcR7drG2PaZ2UzA+glxdp/YzyvOuC6GctHrItr6/RhIMPKdt
         4VfK+QxPhGya34/qtjvV87adrrD9/nPC2UPqW7OuEEw2kkN/xTHQuZMUA5uNI/APjR2f
         jBMgQg0RcAHWo6hpSrqg8092D/Xw1qZhyIgCwpriHh5tnj7YM9O8Z+yEN0a3SnOEpNNc
         EibML/WAKtHUHmDKqhnZSSCCYa7QycGVGC0ScmFtQw5ZxT2b9uAZehxUfQqfQH6wnRkW
         FOUwiP0zgmw4YIsHoL7HGJbohxbuQlgbwcZlaJ5fC33pcUx4LbONB/pHYjL0IHC/Muwb
         M0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344722; x=1792949522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gvhPLq+K4mlbUmYX70fdM545pGYioWzN1Cy4PqDCQE=;
        b=DMos5saQKlweFgb17VrNSKm30x6lUm2jqOF7CBrR1UxBIvVXNozGmRBkPrTV6+qeEv
         L5g/3k8nAfmyY65JqP0hS3bxwusSBYX549iFZE3En+fBhuj/BqnNvUeqcExqyey5gp9I
         9HkKJElmwzoyvVEpLl9Le6Jyw2FR6mZOue0Fm08eS3s9iIwYzz8ISBkW4vrP9+BwatpO
         HBVJvr6f3qpnjEqprQP1rPbk3ljYt02MF0eZ5OyTy3R3mxS/NZoREpQCchMdXm01JHPT
         Bg2LAtUk1IXQF/Mo0YWPnqIcp7mgh7b8FMZ+BxRcznIXxcCQNEx7ndadhGDjxRLolPWz
         WFrw==
X-Forwarded-Encrypted: i=1; AKwUvBw60Vqgl4tVO388AQTbGvf2PbulFXGmBjEiilWvl3ZijlGBX25WGCMyXB14u9BeOs5Lq+PBAB9Tl894tAwa@vger.kernel.org
X-Gm-Message-State: AFq9FYLeuliTTaEwoteuEeF0y4Kssxhtn0rKovEuDJ7AeB2TYI1Ftjyc
	XGINROaKsWfKmh8uEbbewjz1akOEDh5D0cUhnGOscoxIknEUMx7Od2VSM4jfeP6EULU=
X-Gm-Gg: AYBFou2YdDws7Gua4FGNA1TsIk9yrsw/vEfblIzPotY9N73bd+tOcGyELYU0wxGog19
	9ANSpJumahZI3k5apX1WgEBxEavEHx+5H7lnKD5j9m0wx8/xAXhZQaIeHnHk7tVPWIQj7vBPeyn
	XC6Fl6DHXJQz+t+ikG/Br6x+fAx0RPxCCsyzvGKC/EiHNK1kmhI5ztyDNnZrvISNWbzOenxnUFn
	l9snrYq8y+O5XVxIXP0ghxUTBoJDmfrtohraPmLuJI1KfzDr8h5cwLKwZ3MGsw7U8K14LqjYl2V
	xyg5YdQF1AFayfrhLTbbGF9snsjlKqBzy2pByFL7K3JwzIow1oXlvog9JtPo2aDVddEd/mmgzwQ
	Mxk859dG2KcF306wQ1PCNOtfDZj7ONBO4T+3+S0RIcQmdJAwsaGOquIabs/mj8JQM8MwBk8KPhS
	couh4XUY2ShcyGKTCvAtPki7kGQFl+13ed44jX8zeQzLFU5aj6nMArbk1jxXARFyqGD2U84qFUI
	ASQ/ZRZfvgmWSQ=
X-Received: by 2002:a05:620a:2b92:b0:93b:d7a0:d9e3 with SMTP id af79cd13be357-93f29dc5685mr888692285a.61.1792344721642;
        Sun, 18 Oct 2026 10:32:01 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f2f045ca4sm405802585a.29.2026.10.18.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:44 +0000
Subject: [PATCH 02/13] cred: add KUnit tests for the id rules
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-2-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=10192;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zPspISpYWICNVbBVaAWDbDSuQ/FH00gZGsNDounQARI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOdNHuocrwtBEw/CVuAhg871thZU51pudEwvmspRf8bSWW8jVtxl7bN7ZnCbzqog/1Gy6jvtXFz
 YYN15lmMMPAE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hold each of the new functions against the expression it is about to
replace, word for word as it stands where it is used, for every
combination of a few ids, 0 among them: 729 combinations of three uids
each for subject and object, and 4096 of the twelve ids that
cred_ids_allow_control() can look at.

That the conversions which follow change nothing then does not have to be
taken on trust.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 MAINTAINERS         |   1 +
 kernel/Makefile     |   1 +
 kernel/cred_kunit.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug   |  13 ++++
 4 files changed, 233 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62744835f86f..a0eaeed0319d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6941,6 +6941,7 @@ S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/cred.h
 F:	kernel/cred.c
+F:	kernel/cred_kunit.c
 F:	rust/kernel/cred.rs
 F:	Documentation/security/credentials.rst
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 2a64282749b8..8f7e2fb7b389 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_RSEQ) += rseq.o
 obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
+obj-$(CONFIG_CRED_KUNIT_TEST) += cred_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 obj-$(CONFIG_USER_NS_MAP_KUNIT_TEST) += tests/user_ns_map_kunit.o
 
diff --git a/kernel/cred_kunit.c b/kernel/cred_kunit.c
new file mode 100644
index 000000000000..b3a54e8c565f
--- /dev/null
+++ b/kernel/cred_kunit.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the rules by which the ids of one credential allow it to act
+ * on another, see "One task acting on another" in kernel/cred.c.
+ *
+ * Each rule is held against the expression it replaced, word for word, as it
+ * stood where it was used, for every combination of a few ids.
+ */
+#include <kunit/test.h>
+#include <linux/cred.h>
+#include <linux/uidgid.h>
+
+/* Root, since two of the rules know it, and two others. */
+static const uid_t ids[] = { 0, 1000, 1001 };
+#define NR_IDS	ARRAY_SIZE(ids)
+
+static void set_uids(struct cred *cred, unsigned int *n)
+{
+	cred->uid = KUIDT_INIT(ids[*n % NR_IDS]);
+	*n /= NR_IDS;
+	cred->euid = KUIDT_INIT(ids[*n % NR_IDS]);
+	*n /= NR_IDS;
+	cred->suid = KUIDT_INIT(ids[*n % NR_IDS]);
+	*n /= NR_IDS;
+}
+
+/* NR_IDS to the power of six: three uids each for the subject and the object. */
+#define NR_UID_COMBINATIONS	(NR_IDS * NR_IDS * NR_IDS * NR_IDS * NR_IDS * NR_IDS)
+
+static void uid_combination(unsigned int n, struct cred *cred, struct cred *tcred)
+{
+	memset(cred, 0, sizeof(*cred));
+	memset(tcred, 0, sizeof(*tcred));
+	set_uids(cred, &n);
+	set_uids(tcred, &n);
+}
+
+/* kill_ok_by_cred() and kill_as_cred_perm() */
+static bool old_signal(const struct cred *cred, const struct cred *tcred)
+{
+	return uid_eq(cred->euid, tcred->suid) ||
+	       uid_eq(cred->euid, tcred->uid) ||
+	       uid_eq(cred->uid, tcred->suid) ||
+	       uid_eq(cred->uid, tcred->uid);
+}
+
+/* sigio_perm(), which had the uid and the euid of the owner in @fown */
+static bool old_sigio(const struct cred *fown, const struct cred *cred)
+{
+	return (uid_eq(fown->euid, GLOBAL_ROOT_UID) ||
+		uid_eq(fown->euid, cred->suid) || uid_eq(fown->euid, cred->uid) ||
+		uid_eq(fown->uid,  cred->suid) || uid_eq(fown->uid,  cred->uid));
+}
+
+/* check_same_owner(), twice */
+static bool old_sched(const struct cred *cred, const struct cred *pcred)
+{
+	return (uid_eq(cred->euid, pcred->euid) ||
+		uid_eq(cred->euid, pcred->uid));
+}
+
+/* set_one_prio_perm() */
+static bool old_nice(const struct cred *cred, const struct cred *pcred)
+{
+	if (uid_eq(pcred->uid,  cred->euid) ||
+	    uid_eq(pcred->euid, cred->euid))
+		return true;
+	return false;
+}
+
+/* set_task_ioprio() */
+static bool old_ioprio(const struct cred *cred, const struct cred *tcred)
+{
+	if (!uid_eq(tcred->uid, cred->euid) &&
+	    !uid_eq(tcred->uid, cred->uid))
+		return false;
+	return true;
+}
+
+/* __cgroup1_procs_write() and rdtgroup_task_write_permission() */
+static bool old_move(const struct cred *cred, const struct cred *tcred)
+{
+	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
+	    !uid_eq(cred->euid, tcred->uid) &&
+	    !uid_eq(cred->euid, tcred->suid))
+		return false;
+	return true;
+}
+
+static void cred_ids_uid_rules(struct kunit *test)
+{
+	struct cred *cred, *tcred;
+	unsigned int n;
+
+	cred = kunit_kzalloc(test, sizeof(*cred), GFP_KERNEL);
+	tcred = kunit_kzalloc(test, sizeof(*tcred), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cred);
+	KUNIT_ASSERT_NOT_NULL(test, tcred);
+
+	for (n = 0; n < NR_UID_COMBINATIONS; n++) {
+		uid_combination(n, cred, tcred);
+
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_signal(cred, tcred),
+				    old_signal(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_sigio(cred, tcred),
+				    old_sigio(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_sched(cred, tcred),
+				    old_sched(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_sched(cred, tcred),
+				    old_nice(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_ioprio(cred, tcred),
+				    old_ioprio(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_move(cred, tcred),
+				    old_move(cred, tcred), "combination %u", n);
+	}
+}
+
+/* __ptrace_may_access(), with the ids it picked by its mode */
+static bool old_ptrace(kuid_t caller_uid, kgid_t caller_gid,
+		       const struct cred *tcred)
+{
+	if (uid_eq(caller_uid, tcred->euid) &&
+	    uid_eq(caller_uid, tcred->suid) &&
+	    uid_eq(caller_uid, tcred->uid)  &&
+	    gid_eq(caller_gid, tcred->egid) &&
+	    gid_eq(caller_gid, tcred->sgid) &&
+	    gid_eq(caller_gid, tcred->gid))
+		return true;
+	return false;
+}
+
+/* check_prlimit_permission() */
+static bool old_prlimit(const struct cred *cred, const struct cred *tcred)
+{
+	return (uid_eq(cred->uid, tcred->euid) &&
+		uid_eq(cred->uid, tcred->suid) &&
+		uid_eq(cred->uid, tcred->uid)  &&
+		gid_eq(cred->gid, tcred->egid) &&
+		gid_eq(cred->gid, tcred->sgid) &&
+		gid_eq(cred->gid, tcred->gid));
+}
+
+/* keyctl_session_to_parent() */
+static bool old_session_to_parent(const struct cred *mycred,
+				  const struct cred *pcred)
+{
+	if (!uid_eq(pcred->uid,	 mycred->euid) ||
+	    !uid_eq(pcred->euid, mycred->euid) ||
+	    !uid_eq(pcred->suid, mycred->euid) ||
+	    !gid_eq(pcred->gid,	 mycred->egid) ||
+	    !gid_eq(pcred->egid, mycred->egid) ||
+	    !gid_eq(pcred->sgid, mycred->egid))
+		return false;
+	return true;
+}
+
+/*
+ * Two values for each of twelve ids: uid, euid, fsuid and their gids for the
+ * subject, uid, euid, suid and their gids for the object.
+ */
+#define NR_CONTROL_COMBINATIONS	(1U << 12)
+
+static void cred_ids_control_rule(struct kunit *test)
+{
+	struct cred *cred, *tcred;
+	unsigned int n;
+
+	cred = kunit_kzalloc(test, sizeof(*cred), GFP_KERNEL);
+	tcred = kunit_kzalloc(test, sizeof(*tcred), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cred);
+	KUNIT_ASSERT_NOT_NULL(test, tcred);
+
+	for (n = 0; n < NR_CONTROL_COMBINATIONS; n++) {
+		cred->uid    = KUIDT_INIT(1000 + !!(n & BIT(0)));
+		cred->euid   = KUIDT_INIT(1000 + !!(n & BIT(1)));
+		cred->fsuid  = KUIDT_INIT(1000 + !!(n & BIT(2)));
+		cred->gid    = KGIDT_INIT(1000 + !!(n & BIT(3)));
+		cred->egid   = KGIDT_INIT(1000 + !!(n & BIT(4)));
+		cred->fsgid  = KGIDT_INIT(1000 + !!(n & BIT(5)));
+		tcred->uid   = KUIDT_INIT(1000 + !!(n & BIT(6)));
+		tcred->euid  = KUIDT_INIT(1000 + !!(n & BIT(7)));
+		tcred->suid  = KUIDT_INIT(1000 + !!(n & BIT(8)));
+		tcred->gid   = KGIDT_INIT(1000 + !!(n & BIT(9)));
+		tcred->egid  = KGIDT_INIT(1000 + !!(n & BIT(10)));
+		tcred->sgid  = KGIDT_INIT(1000 + !!(n & BIT(11)));
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_FS, tcred),
+				    old_ptrace(cred->fsuid, cred->fsgid, tcred),
+				    "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_REAL, tcred),
+				    old_ptrace(cred->uid, cred->gid, tcred),
+				    "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_REAL, tcred),
+				    old_prlimit(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_EFFECTIVE, tcred),
+				    old_session_to_parent(cred, tcred),
+				    "combination %u", n);
+	}
+}
+
+static struct kunit_case cred_ids_cases[] = {
+	KUNIT_CASE(cred_ids_uid_rules),
+	KUNIT_CASE(cred_ids_control_rule),
+	{}
+};
+
+static struct kunit_suite cred_ids_suite = {
+	.name = "cred_ids",
+	.test_cases = cred_ids_cases,
+};
+kunit_test_suite(cred_ids_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the id rules of credentials");
+MODULE_LICENSE("GPL");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b24a2c89b84..778d8ea50bda 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2772,6 +2772,19 @@ config HASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions. If unsure, say N.
 
+config CRED_KUNIT_TEST
+	bool "KUnit test for the id rules of credentials" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the unit test for the rules by which the ids of one
+	  credential allow it to act on another, cred_ids_allow_signal() and
+	  friends. Each rule is held against the expression it replaced.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config RESOURCE_KUNIT_TEST
 	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
 	depends on KUNIT

-- 
2.55.0

