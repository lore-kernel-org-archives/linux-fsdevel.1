Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116348;
	b=ZDGktsxIGmzc/OLzqUUfMmhJXpBYlf7nKlQufc6cN2DEgwoEEw54vQMpM3by2MhHIuno
	 j2MagERln2np6yPe75M4icp/yiFALGH+ElOUow/Ug05/j0lUZZ4eSJbheoAz/0NLrhddI
	 wx/GkMn58KI0I4E32VR5vdyJPkGTwWHdDaG7oE1NIkA0y+k0GngTA5WaZpTdd9MORjkv3
	 DXNcT/WLfcHHFzP7LQghTRLhvEKl6V6fE2kNWVhNqV9VR9etGavm60VjIJy8ap82omzi5
	 1eVU/fup/5JMskAfOMCQ+nLr7Jjoz4y8S2lIzxxNZJpwPWYPPkuV94ZmxsT6tX5jdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kkWfFph3Jhdo1iVdBmUApUet/72n0u945LBk/dYhnBA=;
	b=PEne8zYbn1lBU1SeSvk/yI3wV3/K/IssOY9hmOlWhotTA033THHoj90u/Gt+Z5WpdHcT
	 2fRzzTXrX0L/qGX155N7vyREUF2OU0s0oomTJT/91nSuQZ06MlxPZUYDF8EBRnuKCjVIr
	 rRm2euR0FHU73IlpUpOxqG3pFfDHhpR7M8zNndPXoV64ml6N3CQJg27rdXZG4e3BE6WRS
	 UcgUnpYEQ9E5+pEN8FDMjDFVoV870fNg7GWgJuAw0dg5tjv6JIapo+LsuOihqF3wbsiGs
	 03yvLnhaQJAEQyZDj7ObL6N63wIpcx5bwX+UW7Ws+gLiX8HtRJkNhOIM23h+ar0RmUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IoB91lPv;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D560A2607
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F2D560A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IoB91lPv
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383435e46f9so47442eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116347; x=1795721147; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkWfFph3Jhdo1iVdBmUApUet/72n0u945LBk/dYhnBA=;
        b=IoB91lPv4+0E46pwWXJEikB5UBE5/T4AafBf6GBrpnOXuM8DKUQ3evnbHa78Tam3kp
         WMlraqtjgChC6CMQPdKaBU0HLDnTuYBqdse0YWL9YDn1vicMe2Ovx30Ud81FIATAmASK
         iXdfxpbvggSi2NpQJYtyM8bQXc+srNd9eZD8Gohec600UTEOTY6rYcGTUvfuQWgqcURl
         wy/FeaeTjqJ/ox4CLJ2DugivOuXOVWKjOelVCT56pWk2rwoR/jF/sk9aRievllod4Hg0
         TUktukFD9PxN0SlMyAfVKGVL/i8XL7SC+W4O5QS3RnaSwLkMeo1lmncnuYxqI9L4IdyI
         Hv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116347; x=1795721147;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkWfFph3Jhdo1iVdBmUApUet/72n0u945LBk/dYhnBA=;
        b=Ujb9zjlhM3mjbmuxh/4g1kd3SfyWXSDZy1jJIPpAmToIF50LGdbfrV2CRjYPJ6nQUG
         eEsLfAXypw0kyGv+Adz6jsahxj3CA9yvsnr0GveyXr7LUWkPxDxFPHJ6GJ/IEFJKtMvv
         xd22bGLtXanqsSPQh6iovXYH9UbQ+ZEgTs6ZV1dUiTFh2VRlN3ErBRVs4tq9t2VFdIRP
         hLWG/LT3YXjHoY9Non9NiU29HxXiln3y8imS3EQxVMm0r2QzJSWH7yoHhS3DoqGaQC2V
         Aal0vcPNa2331UkzSGmE2nO6BhckJD0n4RIzZLxjglNO9Ff9sGpcloiCjO1tkPYYK1nW
         dURg==
X-Forwarded-Encrypted: i=1; AL+hErEeLtY0TFnXjKRSQ8noEzgH9qhs/FTBBWSylvCx60dQz1jbqvQ6Cv6kXKlf/mT1Rtpaw7aXY7mi2CQ5cLQq@vger.kernel.org
X-Gm-Message-State: APuU4Z/ogdY9PamvwrVaR29ppzwBS7wmaCd9TE/c1kSpGrEnt1HOyQO1
	ynU34Teqa8aZSE/VWHJ6aLNbReKQuiANoRXCIeRFOR41ohEw7kxIBjnrXurBwA/5a+tYOM/Ps9D
	hIItVLavGJA==
X-Received: from dyvo18-n1.prod.google.com ([2002:a05:693c:41d2:10b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:820d:b0:36d:394d:e690
 with SMTP id 5a478bee46e88-38570b34f2fmr260461eec.40.1795116346621; Thu, 19
 Nov 2026 11:25:46 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:15 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-5-irogers@google.com>
Subject: [PATCH v4 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Export cpufreq_dbs_data_release() and initialize .kobj_type.release
statically in the ondemand and conservative governors instead of
assigning it at runtime in cpufreq_dbs_governor_init().

This prepares for annotating struct kobj_type::release with
__must_init.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 4 ++--
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 02bfd46543e9..146a2353b1a2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_groups = cs_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = cs_groups,
+	},
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f3bd3dbe7c41..f8b5aca09b6b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
@@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 806d8fb4dff1..1026712bb79b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
 }
 
 /* Governor callback routines */
+void cpufreq_dbs_data_release(struct kobject *kobj);
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..7386d043c665 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -374,7 +374,10 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_groups = od_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = od_groups,
+	},
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.56.1.708.g77570a6a1d-goog

