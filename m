Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892390;
	b=F2U0Jdk7f72zHBDt+lUnDVVpwXCOhzA/Hai+OlvuDRWftVgdNh8WogtRrS2OrF8/yl2t
	 /nEhhbcidymBM04HZ3UL7/MYr1D+Ain3iFienH6CyuMHKc622dnj5rb1bhcJmaeYR52mi
	 /CIEJMiPZiZJsQCXIIny9OGPIsAFv3qyZGyKl/uvQSZJzd/k8x9xoe+39lizXr4DL237H
	 SiWmt/3MzX+hYidJ37/NQ6r3bbQ0A1YKZyDMk9bnvaQr5dM4CEhlbLBQlrIHVN7tdgXwG
	 gjLVtoQwZ2/l3Ezrgwcwl7soOBy4CK30BYLGO70zNPZCxMI/haVBj5WqFESSv3ZlTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=iuLAwp35PBDjYx2Cj9dSWG0y9bMdUsF9G4+JLTOjrbo=;
	b=o0y32NBN/wcKnJVsxrmt3+GQUO4qvVAnklAobws52lbKWLJ1+oyPbBbQntRDoWbMxtNF
	 fvukpCPqf6ln3gyAkexjFyz477AG0LeYhS+DAd5FDvAwGbnzovc02gSIRNe/LJNvIO98A
	 qgpdDk+cNUy6H/gkBhV9JG0AnhpM2owUlFXl0HGipnKBeKw9VnzC5VtGRLlYXgSQMcGMN
	 Vcs3nFPg57de6IgZWPwWkqn7WVGya9o1bryD6ETUZOrUYeLxGwji6T5PifBkmbiaMyPHw
	 xY1ghFElPPWgvxWRR6lwRKxw1bNxU2QdQ0px97WLsQY4DTfdHRmSQV/RnrFq/QVxZDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="nsk/voxd";
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B401606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B401606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nsk/voxd
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f3c895a0eso185002885a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892389; x=1794497189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iuLAwp35PBDjYx2Cj9dSWG0y9bMdUsF9G4+JLTOjrbo=;
        b=nsk/voxdixVQx0H64S9lBemE+BdbZObDvDYakFK8UWK538sizArt7zmrQEyKyWfKor
         DcxBoNeRXiQ5NhVc6PHSZ9puJKLQE4DXdlwW+BIpb4+qaz0bCjQKbUMElNii4TqPMhNt
         cpbUch18esPd95IX1YA5gdhOLLNAjkt7Tb+PGb1NrbUNhJgLtgAS4SRdNoEHSXaGCMDZ
         GyocD//wZWM/UGYYW2Om5wz+EOevnkf13DRLYiGlyE2x+4/Wb1vBkwOxl/XUW75rEuVo
         UVfr74bnA6UQ2sHO+DTax06e05e8WLqCMg12QH5LxeksXM8vWEqu8j0OZOA0eex6fUPY
         Md8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892389; x=1794497189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuLAwp35PBDjYx2Cj9dSWG0y9bMdUsF9G4+JLTOjrbo=;
        b=miyaTPQB8QjB5Oc8rOMuGZV+FZBgOstUIzf2cyex2NZ0h8C24Pxwlrv9Q9Wxjvb79v
         u+RNgYtay4OQw30KFVUOYUb7/Yc/HleajdFShe7NzrVScHZkOAwPA1mUWx8lMKAN/241
         GK9vx+QdsR5K5rPuX9ex6JCq3Id0jBH8tu98pveIEAgBK+x/k2Q/tTGml34OKJ/uxujr
         izeddliv6UH8K1NCtJS3rpn2u+dS5Im7pKTjHTpwIV94L9K9ZPjPFsqIfYdL4yT25pyB
         LbUXgBcqtHpJvMRz7OPBhmOWkvpriDdfHks/2So5afANvzpBRi0t5pBvyCSwYmQ+H5Q4
         rwug==
X-Gm-Message-State: APuU4Z9wTI3/v5qaExLddBg0RyXXddMuC2VYF9Mz9f/NTlOgfgDZHN6J
	p63dPE2R+HQznhrDNd9rXX5L4qW5HshZm7p5Faen2EONVyj62FQxbFkA4uvG52q4s8I=
X-Gm-Gg: AYBFou3eEUMvb9v38X5isS61duBdgicSa7aga8tLZe59+S4cM+A25zFaDNHi/h4zEb9
	CW6HiDuNF77rMz+jeWVQqmStk5v+6Zl/osVJKI5TSuAaTBEMHbCZsyGNrqetfPj2x4igxSWqgJY
	b9VWkZ2OJNVPFIx95AlNGXbnk9c2Qb7EQhHdQWf6MjgGrsEvN85YQRlxbO0SaiUGU2NdYGole7M
	ZMwjPtseUhyON0FVzW+HV0NIzwgxQwqGoCXBNmZQYavGPVTS4C4nFHWBw6ye0cKmkcGTsmAb/8a
	sy/+MtdkyTZcurxYnHtm8X0s9OpWxpZ6HQvZrpVlPCreqwzILbpXg+lG1kqzlwvG6WC7ACbII44
	AcqZorpWPg/YygrHP4ynTP8WecFrSOQIESGCvYn2BChtNRPWIOtT+s4idxzYpV6OTicTeunERH1
	wPPcbFUPlMvQoVg9Jaji3yJsMcxZ49A8QQTN9CaVXfyPYP3v9ucI0ih8396IUsh9BKcJgoy3ml4
	cXTbRWIBGHjCqiPyZ1LZe9t52sMeWrvSscMS5oQdEpp91tKZt6BfhHB94mP85GNM4nepY36lxro
	gWQJHoSDdc/N70dFwolVH+5TU/XMXkLF+ONbZJ7Sn1XHVA==
X-Received: by 2002:a05:620a:4405:b0:93b:c537:fdb8 with SMTP id af79cd13be357-944214cb981mr3271449485a.6.1793892389177;
        Thu, 05 Nov 2026 07:26:29 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48694cfsm486703685a.36.2026.11.05.07.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:26:28 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:03 +0000
Subject: [PATCH RFC v3 71/90] umh: run no program for a task of a cell
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
Message-Id: <20261105-b4-cells-v3-71-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=2124;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Pf+Jj3cvINuUBr/l4xv2F2v8xHRXyQ0s4zXq+9EnCQs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QChPl+V5JBpEIDdNvt+SLkvCjzRuPQJcnvd+ZjpPZz24M+Vh2B7p6Ykq348UuKkWJ9xXz94phE+
 yx0NL2zDsQAg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Some things that a task does make the kernel run a program:

  - socket() for a protocol family that is not loaded runs modprobe, and so
    do several other lookups by name.
  - request_key() for a key that does not exist runs /sbin/request-key.
  - A crash runs the program that core_pattern pipes core dumps to.

The program runs as root in the initial namespaces, and the task has
influence over its arguments or its input. None of this requires a
capability. For containers it has long been a way to attack the host: any
module on disk can be loaded into the kernel, with whatever bugs it has,
and the helper programs have had bugs of their own.

A cell only has what it is given, and here the host acts on its behalf.
All of these cases end up in call_usermodehelper_exec(), in the context of
the task that caused them. Refuse there, so that cases which are added
later are covered too.

The original request then fails. socket() returns EAFNOSUPPORT, as for any
protocol that is not available, and request_key() returns EPERM. A module
that a cell is supposed to use has to be loaded beforehand.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/umh.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/umh.c b/kernel/umh.c
index 512dc018a50b..e812a0008cfc 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/binfmts.h>
+#include <linux/cell_ids.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/umh.h>
@@ -406,6 +407,14 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 		call_usermodehelper_freeinfo(sub_info);
 		return -EINVAL;
 	}
+	/*
+	 * The helper runs as root, on the host, in no namespace but the first. That
+	 * is not for a task of a cell to bring about, whatever it is it asked for.
+	 */
+	if (userns_is_cell(current_user_ns())) {
+		call_usermodehelper_freeinfo(sub_info);
+		return -EPERM;
+	}
 	helper_lock();
 	if (usermodehelper_disabled) {
 		retval = -EBUSY;

-- 
2.55.0

