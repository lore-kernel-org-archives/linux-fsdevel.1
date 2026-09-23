Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066A53B344
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174992; cv=none; b=Agyp1XX53p/HmtgZfOY272yT3OqOZWJ5J+/NssfpWqD43A/zKUpDLnOdIGdHS/7uGIrM7+KysT3sV6O7U3srZj5wmz+BoUAhPjWRWKRD15VZRTv/u+3e3qasE633oZXmYQ6umiB+Imy42lDGTCJjEZ29MVVS51QnQAFds3hdvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174992; c=relaxed/simple;
	bh=D7CW/L5x2Wzbfvs/Ry3HQFjuRxjKXKVxOFbyRvCgGRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkFgQ1f7z1vpPHLV9s57YiYUqiwKPqzjwqyWKlaO0DGs1hSUWCMbbGx2BGZW1Tq4mVyZp4CiFyWTQp6UhVOwOYH4T4PfnQdvziT+bFmqmv2wbSHIDR1qV8aei8vGf0ymTaEN7gcircZ+9Xj6Fmz6YgnqRE5+ISKbsttNbki+axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKG+MpJL; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKG+MpJL"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so658686a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174990; x=1790779790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxVNMYiWuEb3uiOivIQYfnI77XxUaLJxdPfRt2FjCgs=;
        b=NKG+MpJLYc+AHT22Yc4AL9pyNPXqb8U8akuel0SkFCsJrRVlUC53H5YBYZOWqUr0vT
         91hBD0+J34R2DYsoWF2XNLoUlULxxp9FssJrevk+mWkfHXm7hlZdA+e8yVhMaw91Vgyo
         kMgd5CiKtaAYnmjA7+Mj5a8KnwOQ7G6zoavKfWry4AsjzCbjBDyLjFnzWFWJ+syE41YE
         gs+PL0HtfErNhf/cHFVZCtJ7GJ7Ek12e+hBkk/I/MlzzwXegP+9HkUxbs00WMfimN9fj
         yt8P6ZUwq0tX1en+byzEvURWv3UKIRBj+6mcx+iGaTJoUnvSgaAafp10RgaKYtn9IGWx
         pNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174990; x=1790779790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxVNMYiWuEb3uiOivIQYfnI77XxUaLJxdPfRt2FjCgs=;
        b=EvKkDldxyF3a9HeCovA8zh60JheCm7AsEfumLVo6hCN/nZiyIpIGLiUJLXINSpVjPB
         LUiPigafSG6L4ivM2DlRqnngd/0F5QskexF2af0DGtPvsTKXBZMhOC+IcVR8+b2fSfZP
         IFt73FrRdQLzU65RUtojNwv5xkjXG3wgb50sYceWcZ+B79dUzXGnbz61G/7MvmIkSR70
         jACPXKgrdM8kQ879LnAvEUfEic8w0t+x4Bg+t1IaW3DC668dRWh8muMzsISlfToLZXO9
         1Eb6MI3kqPwmQkx/KFBMtUIiBPR/9D2lAIk+yHXnw84N0ETC4vQp623b4Fh8c7nP14LH
         ClUA==
X-Forwarded-Encrypted: i=1; AKwUvBxLzUa6N/9Wd023IhEU/4QImTS4MqUxiP2tntPxl7/QISVQgTliIpUO1EM7qa4GY1cswkct3ci6sCV5G+/w@vger.kernel.org
X-Gm-Message-State: AFuF++ml/R6D7bKuoWfZBzpJG9DNgxSjM9EHSZKVxcPmQ7pLOLbT4hLI
	DfFVxQ7Ll8l98YXB/MBi2uQxPmNH5tmF9w9iqKyMFpgynfnv4mDEodrb
X-Gm-Gg: AYBFou0sWJ1FcFWLgslJoB9HJ7uOcGcr+ra1hdbW0HrzSq/GNGCibLG8IQFq8YFDSLz
	GGblQTKICPuTrmPQVdQgds4KqbhNtDXOfldotC5e+RpU8RIaYZ+ypZiFH5H8aqpslZkOC5UE75S
	nc+7q93yFiZMbMYCB6e4itlnNk0eUekJQ4/xQ1tsLHFR2Yx6BHaUT+xkfpD/sHcmwxbKZMDs7gp
	BZfwNlboAC/LKb1hUVE95XJHe0qB+6eEMEryg99n3uFQnxuE/kxSataiZNGGSUgPRe3DHaIG9Ym
	WGllacrEIcBOJPaTsUQhDBTcfija46Wqat+6AthNi81yQqoxRVaHX3CHRdKgpO7HLnO6Q5xys7I
	anoF5BMW1+9dKdTQN6QsmCsrxZvS1Zp1t/0mTINcwAYAUv0W5HzEV9qaVfZhGQNddIy3lDxio+p
	PSt8/ZKOPW2k3a+m/z4PT+qJL2zUPCUtkOe0nFN3tIClmAzAxFLsjP0HFDF/HdKEdwuAQd6yIrh
	XT/yUOfEEHrVUW+SW2pyA==
X-Received: by 2002:a17:90b:3811:b0:39e:6c69:9b91 with SMTP id 98e67ed59e1d1-3a07e69fec5mr2606939a91.54.1790174990257;
        Wed, 23 Sep 2026 07:49:50 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc4109dsm6469824a91.14.2026.09.23.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:49:50 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] sysctl: Add jiffies converter entries to the test module
Date: Wed, 23 Sep 2026 22:49:36 +0800
Message-ID: <20260923144940.3712965-2-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lib/test_sysctl.c covers proc_dointvec(), proc_douintvec(),
proc_dostring(), proc_do_large_bitmap() and proc_dou8vec_minmax(), but
none of the jiffies converters.  Their int paths report the sign
separately from the magnitude, which is a shape the existing entries do
not exercise at all.

Add one entry per affected int converter: proc_dointvec_jiffies(),
proc_dointvec_ms_jiffies() and proc_dointvec_userhz_jiffies().  Each is
seeded with HZ jiffies, which is one second in every converter's own
unit, so the three read back as 1, 1000 and 100 respectively.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 lib/test_sysctl.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 909cfcf76dbf..7718cf4ffd47 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -15,6 +15,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/printk.h>
@@ -48,6 +49,10 @@ struct test_sysctl_data {
 
 	int boot_int;
 
+	int int_jiffies;
+	int int_ms_jiffies;
+	int int_userhz_jiffies;
+
 	unsigned int uint_0001;
 
 	char string_0001[65];
@@ -67,6 +72,11 @@ static struct test_sysctl_data test_data = {
 
 	.boot_int = 0,
 
+	/* One second in each converter's unit; all three store HZ jiffies. */
+	.int_jiffies = HZ,
+	.int_ms_jiffies = HZ,
+	.int_userhz_jiffies = HZ,
+
 	.uint_0001 = 314,
 
 	.string_0001 = "(none)",
@@ -113,6 +123,27 @@ static const struct ctl_table test_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
+	{
+		.procname	= "int_jiffies",
+		.data		= &test_data.int_jiffies,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_jiffies,
+	},
+	{
+		.procname	= "int_ms_jiffies",
+		.data		= &test_data.int_ms_jiffies,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_ms_jiffies,
+	},
+	{
+		.procname	= "int_userhz_jiffies",
+		.data		= &test_data.int_userhz_jiffies,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_userhz_jiffies,
+	},
 	{
 		.procname	= "uint_0001",
 		.data		= &test_data.uint_0001,
-- 
2.43.0

