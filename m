Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802290;
	b=O0yNim4WKES/iKHw3fBOtHPYx6w+IMxnLS+pxU3WrmOCG/LBlzv7RAneF2+RZ/jiQF7N
	 jO4XCIgZrkmdeoDIJLmjnSxHoZcwMEU4aRXorVuLPo9/AGy6Az+o1TfNiEDE99hfFA67K
	 K1PU4IxeHwcr48awbwJQHD1Ap4Oz1S/aKh9Mkw93VhI4f8zRN/FcBj8dkISHOGROkX6vJ
	 yPeQYnJvoSjydQdq0q3neI6fcj+CwVa1SfjY/vd2Bzm+lR+NGS+02Zz518Wlixk7z9rVb
	 zAxAVgf7LSkkf2I6tlFLJAdIiaEbV4JhVZRfR0aXtvwJFLE5bvD5irXhoOJ0CUL4QHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=49oPa45zrh2c1m1GL3JZQ3LJ8IgKAaLTpn11OJ5t0GQ=;
	b=NOMW4V3GdHqeuGyrr6GvcFSs6Yo91Z7q9WQnkQtamU4w8M6KgIwqtUjoC7I4RxvJf285
	 NoxmcGFoAkWJEvrTWwDkcerFYEu7W8WrlAtafD+OdpNcftBZZCcnM7rMO1f7l/cuqQQU/
	 LugtJ1kTvIFtsp2Fuwa0KPj8CcC5sA5GTnTarV5NqymIIbwlg13pbXVxVQ2qY+zqVE8F4
	 CU2jijDC2lS+7q+wuRAAddYdZEDet7QQDPU/NK4ansXVygn/+3znkqlMjqPju/goO0B13
	 rooOteZyQSZbtDLc0cghGH+AZldj1/pT5G42AkYoBCpIv2CJQxhEZ4rcyJkx7dWvPGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eImnh9c5;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FF606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 551FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eImnh9c5
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so191377137.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802289; x=1794407089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49oPa45zrh2c1m1GL3JZQ3LJ8IgKAaLTpn11OJ5t0GQ=;
        b=eImnh9c59XVrGWdrtf3pvi3k1BD+yXh1ZM/l2oiUm/0atnDUtExsgRKGGWZvZ1E+dJ
         An91u8qzbU2Bq90RBsVykntNa6QkYcff1hrkEN2VPEZlcSVzJxqQObmbHNlJktEt8yIu
         JoUlvewYYyNEZitAyXiLScsjJTqS6iqa2Yjqc7HjYqQjOV0y5+RPICxrcbHLIGnbV1oe
         tuMrf/LmL4+WXgbIyGWiNLdmxq+QEoMde0SzlwubTZey/IbSid69F4DNKH14pC5L1FF/
         aZrd8ElfywePmHHAvDZ1tzQbjHzOa2CdmsYDdX+fhx0CzGSY11E3wYHgU5tMS0IkLIiE
         0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802289; x=1794407089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=49oPa45zrh2c1m1GL3JZQ3LJ8IgKAaLTpn11OJ5t0GQ=;
        b=aVDUvaeDVepZ2j7bKq8fImbpHVDdOgAvdFpq2Wxk/zAoYFFBSY4pf8nRGO6pbmz0YV
         OeGPOlPJfWO1i0FaHnYG0tDZ+p+LidOU+3H1MnmUndDJbleN7M83UaJ2TMuXYbiYBLG8
         u9V03ee/yghGE5HzLYfq5dxrkOdpeA6AWxAurJYQdPU3/MRobijBZDEZjv7+nNMzoNeI
         HXKzMuhNoQtogs8rpslcAA2UTQXnbVrVibh03orww4ctFX4q6lpp4+D0oR3D0QXcKXGG
         kY1WortGrwBqU6P3vZOkXFt+/NLGfo1XgFPv5+wqUEo+at93jsbV238/YwDZW3iIQnAr
         okPw==
X-Forwarded-Encrypted: i=1; AKwUvBy3X7ocf9oEQMgbAcRZG48j5C6zCQO10ibw0gjJzBaX1wpXR1sRWDoqwAMpewUft3uwy55pAadKEaKM7eR9@vger.kernel.org
X-Gm-Message-State: APuU4Z+jMvyrokd0u3jL2/rSu1EACw+2fQLDC6WzUDv3iLuera36c/8A
	yL5mCF1b4gkWj0F45CyRV3TuXQ2Z7EP50Aeq1itf8K9Z6+szKCJkoVjZUWCjHU/eXft+246Qs/E
	kcaE4uqZOZw==
X-Gm-Gg: AYBFou0gV1fEmQ4uLfSuMa5gvR1fkJ9PiJdoPQrK8iFVy9ZNHjiddeUHVaa0USgq/jo
	cfPD24u8Frh+isVeMsh2znsL7CxXUqUQwOKC7wVY+QEjezYh1c3+G0a3OSg98tKwQyIiMlVtRXA
	Jh81/BcSbaDaKxvoAHQ92VV4EmUPUP0QYDPqWP5LhTY28+HDpgRHheHmHdEVYguvtIsXy/pOzua
	REtVGNI/QRBLMAdvecbO9TsjInG5cs7kbhhWR15lsfeMcR5T11i+kFbW/2frtZEFLqftOePuDGC
	mZdRbRdxiAy/XeRinMOGrJhI5MXgqorpbJ3Gzzaju6vFvJ0waZsirRQW+IRC88xXyd+lKDpXk6p
	s6LbUcOYPzS3ZdGGlL+tferWv7Kw4Oo4LANA+TTiW4xbIfz4bsW+CEa2NLhXGLFlL1Bn2YhV2xm
	vpBk8DOveJLmD+YU0JIFAWYqoomcRGu+ejXmFomOooC05XHXeQ0PFn4sSYakHziUU5tkLQ1g3Iv
	rUpcWIZtIg/Jt12lZhWH+NTskUdpJOU3fmhArJ0pEo+beIPrD5pDBrRS7qdtmLmsv0Ffj1dLhjE
	f73+WhHH7jTBVqzQGWkHyQJ5K7jq3SeuD5WXCM9mmep//w==
X-Received: by 2002:a05:6102:548b:b0:7c3:6466:3155 with SMTP id ada2fe7eead31-7d072d2ca10mr5409983137.33.1793802288828;
        Wed, 04 Nov 2026 06:24:48 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2829d28d0sm243565137.2.2026.11.04.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:29 +0000
Subject: [PATCH v2 02/13] cred: add KUnit tests for the id rules
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
Message-Id: <20261104-b4-cred-ids-v2-2-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=10174;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=PbbC82f2/K/HPbh7V3nbpnG7Z51PQgNDlIQfWE/UMLw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM9PgXsYeAdU1KKlNbIkGtebw+alIpoaAxc2AEKOuGKUYbcSgZ9jFBuaBmoMvz6zlks4Mg2Rp5R
 I06fiDBfw/AY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hold each of the new functions against the expression it is about to
replace, word for word as it stands where it is used, for every
combination of a few ids, 0 among them: 729 combinations of three uids
each for subject and object, and 4096 of the twelve ids that
cred_ids_allow_control() can look at.

That the conversions which follow change nothing then does not have to be
taken on trust.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 MAINTAINERS         |   1 +
 kernel/Makefile     |   1 +
 kernel/cred_kunit.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug   |  13 ++++
 4 files changed, 233 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..0bc2c39eb417 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7126,6 +7126,7 @@ S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/cred.h
 F:	kernel/cred.c
+F:	kernel/cred_kunit.c
 F:	rust/kernel/cred.rs
 F:	Documentation/security/credentials.rst
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 4ff92e24680c..da712b4399ff 100644
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
index 2d22638ec13a..c548e660dc5c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2806,6 +2806,19 @@ config HASH_KUNIT_TEST
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

