Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892107;
	b=B048md/CO7G5HapsZsfDjKHde8rUZ1pmi1CMytFxj3LB7/3qDF1je+q09hUyMV/NrLal
	 XcjZxdiIsf+MXTbzfqM1RzDqHWVtuTCpJsZP1RnyV+SYKQG1QaI2Rn//Bc/q+tVKAe2eL
	 FvnoBvs4ozGxvGGh7tjOn7sSKfrC/5meY46IcxDzfb6jC6GFFGMr7+hmKDFTcc3OeRCbs
	 N66DUJvmoUC6Dp932Cbn0Hkt75bHxtWl1DOG/tv3yHAXdSXnpyrZZUefGySC4e/DzlUfK
	 w6m31ARf0BftGgysxdJhoNlzNlGY5jmkLc7Zf6fNYcT0j2Y5lFDx3DfZo9b1+Z7lz4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=tdXoQ0OJtdssGpQSd2KrWswUSI+QmuXShw8y6JP9/is=;
	b=pqhuleFJRUDmyOaAwX7z5XC2XlBhMvgFLVqXzSWkxt32Edq8hSCV44X6tJ8/0xiQZ7HJ
	 rZt+QvYE+oTBE0pXOaLU+aHYXkwJ+USBUsZ0i7tqw5tjsNK3BKHIO98pZC5bpWTFijSdd
	 4ygKCJZDo4wrQTHN6qqs1unfp/fSNu6PhtczcfkKVg2AQCy4BhnRtv0eoi85lwXtobouE
	 N+V96QSjvnao8Km6SGFzEcoaoBXn2qcee3C89Dn+OOn57GBstDKafhtlVTethAySfit0J
	 j+UiV6349x/8YiAYTpPTvU5LIHUNwLeYkWaNdHxl1YBLbeJOzSjOr/EWM/jWr9w3Adg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=LM66gd3w;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9939606A336
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9939606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=LM66gd3w
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b305d38bafso20485527b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892106; x=1794496906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tdXoQ0OJtdssGpQSd2KrWswUSI+QmuXShw8y6JP9/is=;
        b=LM66gd3wSAf3b5KsYgD7xIOmppIsJwWyRtBCd3az0I1WlXvq0i6mMRR6cZlBJhpRnr
         k05RU97FSMYsKZDSkbgwHK2tDlfYmieObK57iBJ8srHER9xLfxBQQvhPDHj2qcHgkihK
         BuhVGvSHZqmidjUQYtAPzAMyYh1hq5K6hlsdeTbrcW5o9rMvPXIfJ4HkCBPnrzDkCRi8
         n0cX+aV9kaHj5xlXSw+7h4Tf2H8yK+J70CqAKynl0V3sHSzvFOU1BI1ZAoZR3MGpn7hn
         KEeYTX1R0Ek5CqD7tUve+7K/MT/334CmpOFFf8LohjTWVjYl3t7+TybcfShyBLjMGBO6
         FegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892106; x=1794496906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tdXoQ0OJtdssGpQSd2KrWswUSI+QmuXShw8y6JP9/is=;
        b=XuLR738eI+0L+Eg92LeA744C3OlOWAj4+QqMV55HZrTAFuPL6y3OD3e3TuVeNFyDLP
         cePJys3QR2brQwcCnCW1OuXQkVyHSWx8mCgy6RxJJ/opt9IuXGMP/dW/9Dz2MsbMywWl
         zbNPo/Rx9xmZkJHyLiXzGkK+M6xwUx/y6ADgT3gIwKkqsXnBHDsbCX5M2tn6TBmsIBS1
         HlYde/dowJdmaChEIvsUVIP5sf98C3o66n7u1N80ntEnO2xIqq3pHlValjlWA3kvR0Sn
         QqyK/SgdsSlA9iO64PBhulMbWDbvsri067vyr1I6gf/eYgnEe2WAMwzHpwBbRMtYZMDJ
         yW/A==
X-Gm-Message-State: APuU4Z9PjVBJnizGpimSIXY1ePgHq122Rl7hVWxthEEKwIG1QkEpj4+Z
	gr6BlXhJPQwRv8BHXKLaeHCek/S1MnH4q1IySf2Op1C8EjHGlzuJ2JjQKGGes0hLuWc=
X-Gm-Gg: AYBFou197KRVdj1kPd7fiUQbR6RY2zt+aJU0Hs0gNxNwSkEYYs6rTttJNbRCZ5woYoX
	v+kLdkJsEQEixE/air0dM1ZQb5AvuEpthaFoDDGAbHBr01hJg5RI1hUplN4PPKT9C7Kz2hiO3Ha
	YCbV46RFWgfbu6LLLKb0h4B1H/KvhPKGL4CAOpVD4N8p8NYieXra8YMLiQEYXSnZ35m8HW49WJz
	5H+MegzapWv723IDnGdFnIeUwouJ6wegTrRpro7Qn+SVb19mu65ZWGizW0F4og8sXMLvErISCY8
	TA5wtYdrTXggQtHBY6HfGiedJ4guU2riZ9nM6G/DhTe7Id3Ayx3GqvtxXk9/XyHgCz95yL6He+h
	eWO61/+EPI8im1g+4UzqDFdCl8Qt0sLfD5Fx5ZGckDVyXTPJ+AwmSbf/zU2fLyZ5NJbo12SSRg8
	0i8mGsMCoUjiV+QN8qlaASWPIfV9iITg1a/vjttBeTOis2MeG9VbLxysqTWC7cLykvzMJ0ZsP67
	nT5+TIs7/bzGDqwMGUkFjbypw+x124WNuHVLswCWHxwjcCN22hdIXJuD/B9nCTVe87YW6tpn4t7
	lzOtArEqigc55fyOzu4QWdCGueHkH8DMWc9pCstur2MHYQ==
X-Received: by 2002:a05:690c:d81:b0:8b0:a28d:6450 with SMTP id 00721157ae682-8b2b674ae44mr145055817b3.40.1793892105486;
        Thu, 05 Nov 2026 07:21:45 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bdffedsm41762827b3.45.2026.11.05.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:21:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:50 +0000
Subject: [PATCH RFC v3 58/90] cred: let no id count across cells
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
Message-Id: <20261105-b4-cells-v3-58-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=5577;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=YRL9PIkUyk5gNQ3+3Udiz5r37G/0gHdcwpaRJf5Tna8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKPZ42+uYoQ/lM8DV2cOBFp67IB8JnwRWFq8idb7j7v4AggH5KqsH544xoqHvRORHX/Ikym7sKR
 EJkacmW1OFgU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A cell with a single id runs with the kuid of the user who created it.
That causes problems in both directions:

  - The pid namespace prevents the cell from naming tasks outside of it.
    But the pids of the cell are visible from above. So every other task of
    that user passes the checks that compare uids, and can signal, renice
    or limit the tasks of the cell. The authority over a cell is supposed
    to be the cellfd.
  - The parent of a task that was spawned into a cell is the spawner, which
    is outside of the cell. With KEYCTL_SESSION_TO_PARENT the task could
    replace the session keyring of the spawner with one that it controls.

The ids of two credentials can only be compared if both belong to the same
cell. All the rules that let one task act on another because of its ids
are now in one place, so the restriction can be added once. Add
cred_ids_comparable(), and make every rule call it first. That covers
signals and SIGIO, scheduling attributes and nice values, I/O priorities,
resource limits, ptrace, moving a task in a cgroup v1 hierarchy or between
resctrl groups, and KEYCTL_SESSION_TO_PARENT.

It also applies to euid 0. Some of these rules let a task with euid 0 send
SIGIO to any task, or move any task in a cgroup v1 hierarchy or between
resctrl groups. A cell is a hard boundary for root as well. A cell that
misbehaves can be killed and built again.

The capability checks that sit next to most of these rules are not
changed. A capability that is held in an ancestor user namespace still
applies to a task of a cell for now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cred.c       | 28 ++++++++++++++++++++++++++++
 kernel/cred_kunit.c |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index 3aa1b1e3eade..72df625f8c99 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -577,6 +577,10 @@ void __init cred_init(void)
  * Where it says so, a subject with euid 0 may act on anybody. That is a
  * capability by another name, from before there were any.
  *
+ * It is also the one place to say when the ids of two credentials are not to be
+ * compared at all, in which case every rule says no. They are not across cells,
+ * see Documentation/userspace-api/cells.rst.
+ *
  * These functions only speak for the ids. A capability that does as well, and
  * the LSM hook that goes with the operation, remain with the caller.
  *
@@ -588,6 +592,18 @@ void __init cred_init(void)
 #define CRED_EUID	BIT(1)
 #define CRED_SUID	BIT(2)
 
+/*
+ * Are the ids of two credentials to be compared at all? Every rule below asks
+ * this first.
+ *
+ * Across cells an id means nothing, 0 included. A one-id cell runs on the ids
+ * of whoever made it, and authority over a cell is a handle.
+ */
+static bool cred_ids_comparable(const struct cred *subj, const struct cred *obj)
+{
+	return cell_same(subj, obj);
+}
+
 static bool cred_euid_is_root(const struct cred *subj)
 {
 	return uid_eq(subj->euid, GLOBAL_ROOT_UID);
@@ -607,6 +623,9 @@ static bool cred_has_uid(const struct cred *cred, unsigned int ids, kuid_t uid)
 static bool cred_uid_match_any(const struct cred *subj, unsigned int subj_ids,
 			       const struct cred *obj, unsigned int obj_ids)
 {
+	if (!cred_ids_comparable(subj, obj))
+		return false;
+
 	return ((subj_ids & CRED_RUID) && cred_has_uid(obj, obj_ids, subj->uid)) ||
 	       ((subj_ids & CRED_EUID) && cred_has_uid(obj, obj_ids, subj->euid));
 }
@@ -633,6 +652,9 @@ bool cred_ids_allow_signal(const struct cred *subj, const struct cred *obj)
  */
 bool cred_ids_allow_sigio(const struct cred *subj, const struct cred *obj)
 {
+	if (!cred_ids_comparable(subj, obj))
+		return false;
+
 	return cred_euid_is_root(subj) || cred_ids_allow_signal(subj, obj);
 }
 
@@ -671,6 +693,9 @@ bool cred_ids_allow_ioprio(const struct cred *subj, const struct cred *obj)
  */
 bool cred_ids_allow_move(const struct cred *subj, const struct cred *obj)
 {
+	if (!cred_ids_comparable(subj, obj))
+		return false;
+
 	return cred_euid_is_root(subj) ||
 	       cred_uid_match_any(subj, CRED_EUID, obj, CRED_RUID | CRED_SUID);
 }
@@ -693,6 +718,9 @@ bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
 	kuid_t uid;
 	kgid_t gid;
 
+	if (!cred_ids_comparable(subj, obj))
+		return false;
+
 	switch (which) {
 	case CRED_IDS_REAL:
 		uid = subj->uid;
diff --git a/kernel/cred_kunit.c b/kernel/cred_kunit.c
index b3a54e8c565f..3921e8f2716f 100644
--- a/kernel/cred_kunit.c
+++ b/kernel/cred_kunit.c
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/cred.h>
 #include <linux/uidgid.h>
+#include <linux/user_namespace.h>
 
 /* Root, since two of the rules know it, and two others. */
 static const uid_t ids[] = { 0, 1000, 1001 };
@@ -31,6 +32,8 @@ static void uid_combination(unsigned int n, struct cred *cred, struct cred *tcre
 {
 	memset(cred, 0, sizeof(*cred));
 	memset(tcred, 0, sizeof(*tcred));
+	cred->user_ns = &init_user_ns;
+	tcred->user_ns = &init_user_ns;
 	set_uids(cred, &n);
 	set_uids(tcred, &n);
 }
@@ -169,6 +172,8 @@ static void cred_ids_control_rule(struct kunit *test)
 	tcred = kunit_kzalloc(test, sizeof(*tcred), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, cred);
 	KUNIT_ASSERT_NOT_NULL(test, tcred);
+	cred->user_ns = &init_user_ns;
+	tcred->user_ns = &init_user_ns;
 
 	for (n = 0; n < NR_CONTROL_COMBINATIONS; n++) {
 		cred->uid    = KUIDT_INIT(1000 + !!(n & BIT(0)));

-- 
2.55.0

