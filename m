Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891809;
	b=1U42PlnoPltMr8CArK8Y0JpfxG6cWEd9IwzCxFME1bIDjA/Hbrx6FPtsHbKUxPTDAqyO
	 NJpU+AqwMPBf6WPusP00aujXWwDeXU+4rLFYnaug52h+ij97Gb8tv0VVXYtjp7PABeP+4
	 UZ7UGpwEk/JICPUVe4+otIv53W/3NLdd4gCNrlbrFKv+a6Y1HZKU1NO8j91pRuIPOm+hg
	 Nj5yRP5yKh7oeoU/UWvza7ms/Q7MF8DWUx5A8kuaXzqFeFdyY653tQ0NVZ6lDWWJPMJ0+
	 KCTplTueZDwBVCKX4AW2Z35bWs2POTxpkFFl3xjTyCpt0n/2eqIcbqNK8dwd4d3UA+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=A1+EzI2C4rR2P4U3wS3ZQXdm1AB4fWdiKiG6izgArRA=;
	b=bALzFv/0wjwITnDn0ddcO7ymJLUUxHXLZNCkkkf0Jey/xPbhFc+y+7wm2u4sBc/Wug26
	 v/2shZJolx8WTx92U0gH+VGOY65sLMAz0mXOKQmgipZvzcbGqEaFuE1XAMLQIZiS3InuD
	 S7PsZOkSbCzh1v917920DNxO5XR4Ii30R4Z9mhQLmEvci4CStSlmmkU1xL36AGCAqg2/s
	 wX6GUH+32uDyexW0tIEwXfgpCs9FrGw0dKhpRnULGVNN2O7eyNu754mxtSoJUSRtrBU8i
	 BoA4mAyZGO0yFbr8VysDMdmApqtFLvjF5Kn5gt+EtlwSg4Cn02qnuiSpa3hsmVO2fdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NxVm8+jp;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC6606D834
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61FC6606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NxVm8+jp
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53381e53b80so20681031cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891807; x=1794496607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1+EzI2C4rR2P4U3wS3ZQXdm1AB4fWdiKiG6izgArRA=;
        b=NxVm8+jprjQ3eZAwrmRvkKI8KS9OU4vNds4h06Yv7rMVrb7+EOemFbTznPXDsqhPXP
         bdO2A1VzWEiQzirKvFsPq1Lv6FXDl8+c/z3u4nVLcBGj3YWI53jUN0iqKSknDuW26UJF
         RnjbiE2V1zSLICH7I0DiqKaidCpQYE7VS7UCVtZyJHD/WshduQLaD/WTIAixouqfZHR5
         LFEVkqSg6gFZjbwFEaRVi5ne+DU6yzM3Nrcdx3+8AxgKrW6CJDIH6AdGwNhjPykIwWdm
         ICkM99YszXC7hdxb3MfU+cYUG2rd+HH0rDETJsNHmhdNqmfmkkmKb0pVdUE7v+Wbd7WZ
         nzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891807; x=1794496607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1+EzI2C4rR2P4U3wS3ZQXdm1AB4fWdiKiG6izgArRA=;
        b=hzsY84kP038BeIDExkdGEshigny6Y/Jrps9uQrdfi9O/2oEBClV7nPFvPVxa7dh8jx
         B6i/2NYFokwBUF7xZ6zkJBZGRgHEL4vRqoyLFWp9Q45qR7kNzQGzMCrqhUwiiCa0QfmX
         nJ05jC3wluTxmHHMMMdSObekqW92F5ej8B0b6PTFvNI9P3iaRDemQB5xnQaD15zuotoD
         Eik0y/WZYyYR0sECLMoGBVDfH1ZYDRGymFlacdxlJRVFA5c3IS2lcmVIl+6DgjVXDk7C
         vXR5f1PEWu9y96W4dDdh+lssJZJdWrq0WebHSNK6TJJUuiUjzN7iQvsny1uwAfTLl1PS
         HDWg==
X-Gm-Message-State: APuU4Z8ujNbbks3A0RpHtZIR2FyAabkhQwjHisgckBQz//vnL73X9Jh/
	vtTEviBosJSSzWBV8rbfZqLicjksW1ILZhtrAxhajxIxf3hd7vE/e6h13Hh6eaHc+G7LlU+p68S
	BJD/rhxo=
X-Gm-Gg: AYBFou2OCj67TE8crdVzL11lku3CNemAciFSex6iK51cNwj+7f4MQ+XkT+XFNQQiYSP
	hhKZukir0uH6PYbVRxaCQsHpBZ/aN4HenecNuf8fM+LoOnLOCsVifzlUVBYcU0K10G1e2Fx0AlZ
	xWetyeFzcaqoXlGrSUv0+OGlHPieZ1nicv4n76V1Zhr3TpeVHoyaQ6t/7Xgnz47HTJE6Bw2sEkI
	d2yH/bBOSS1kwPyYM+/qAQP+Cd1zUHqScdCTTqlI3rR1Mb9w3q4q91jRXAyMYifyvP7KhqvuDcR
	SVW2YV1wUg7iteYqR3JGhbjHFHSqyYz64ynhUttY0rhq4xeb0suTapU4qyP0dm/CHdgb5ovc0PM
	ChG5pyvVpDV4LiIrtrCv4GzY50EEk+SK79okt/LbluqQ6j4IaGKHPVS1vnMvhIRXIh3iMQB36We
	PVq8Rkp7OvNFvM4XW3LsgP4BwzpqS17ju6iM9XpGU4HWZ1OCJsG8O3hNb1LNygJ1RJ9IZBseQSU
	Lnh+8Y8H9BqUh5+atKKRE6kMpDcREbWJJ+xORJ+f71MLk5rNRY/1oWlcMP0EjIrYIopvdQW7M4R
	wJfrWIyWAH0HMHZRiwIcc+0Zlt541s0DsATsLsz35QtoD2VPl1P2WEVpnUtIM+93rMM=
X-Received: by 2002:ac8:5d14:0:b0:533:4da1:b5d1 with SMTP id d75a77b69052e-542b659318bmr320363151cf.23.1793891807168;
        Thu, 05 Nov 2026 07:16:47 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm53851701cf.20.2026.11.05.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:16:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:37 +0000
Subject: [PATCH RFC v3 45/90] ptrace: keep everybody off an embryo
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
Message-Id: <20261105-b4-cells-v3-45-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=1292;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FR8qGkDwydJpoGvuCIpFwA9/kCan7AywQK67vdaDdYc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFLjGaUDAQB/Qp822KzeUWwYbUGb/meJVKZg0XfSemj/I5zhF01GSoh6Yo5A/qRnIz9m2EZkAw3
 CG1uFxhf5JQ4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Between its creation and the end of its exec, an embryo is in an
intermediate state. It already has the credentials of the cell, and it
holds files that were placed from the outside. But it has not yet gone
through the exec that turns it into something the cell is meant to see.

Refuse all ptrace access to an embryo. That covers PTRACE_ATTACH and
PTRACE_SEIZE, and the files in /proc that are guarded by a ptrace access
check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/ptrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 8024d80f82e3..c30e15d39c41 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/capability.h>
+#include <linux/cell.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -324,6 +325,9 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	/* Don't let security modules deny introspection */
 	if (same_thread_group(task, current))
 		return 0;
+	/* It is not yet what it will be. Nobody has any business with it. */
+	if (task_is_embryo(task))
+		return -EPERM;
 	rcu_read_lock();
 	if (mode & PTRACE_MODE_FSCREDS) {
 		caller_ids = CRED_IDS_FS;

-- 
2.55.0

