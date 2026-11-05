Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890688;
	b=v7rOhqpRuW9o9JeF9gQye+H9tiZnT0khprd5/154vZG9tV/JefvrtgXVY4yWHGIVMwye
	 m1u14IwyiAxIEufwWYyXAIbbuQGx43knWt5zFrHW+wPSDG4nOLM457Ou/xVPMF05zUBbP
	 GzBQaJ5tFb4FoxJ72uglj5NPrRgVEWgqXLuWw4yxPSq85K830qkJpIC1AoxD6T9Xd+1Ss
	 dXOqXHvacQufgWQi/bBnwlSqjtMl1oH9oChvH2ibipu/Th6cZ1q7g0HKA9Amfs3BYJ3dF
	 SU0aif7lTFwwyCpTBY8v2IBgUtY01iXmbf8rQigVUQxpVYTcNmpBTirVjIdwIibxEUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3+YAM7QhpxOQ/TxDpr65kj3A2GM5uW8GyQy6B+dSiS8=;
	b=fOWtehHU3Z36qo1T/VFd/vZ2y66K0D/zfbdLEswanq+NMqbBz2P6xGnqiA63lsCSWExM
	 JXTj0tFLEMJRAPssV/wm+T5soNHLB38q5hAmDTKMwD2gEp9EuFpjwXnhL7WX/bP4dxlMK
	 SPUqzsA+ARLQ9sYfVu/yUYWfNrJ7KZWfsTfkQohb8KDnbQ6IvPlLq1k6m92rHrpuc2zRK
	 m8XMktIC24BdzR2W/p3kfiVKPx6UFPzZX2tuJTz7QaEXWdVes5b1lDFaP0+igDhgU83C3
	 qt3BrVWZWJohdA3oVHI1UVtsO+7bw8vBTYD7iqE+fcnSidCGC9wAUTIWgUSV0fOTL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=T90a4boE;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED1606EE9F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DED1606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=T90a4boE
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8470d7d430fso835597a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890687; x=1794495487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+YAM7QhpxOQ/TxDpr65kj3A2GM5uW8GyQy6B+dSiS8=;
        b=T90a4boE8/5k+6Py5Zee+HbM/NqK2it45xZu3y4/mLySHnqTCAgdEb6GUyCTW4VC+Z
         QABdFZwxycsgl/fG0QNyAl3YdzF5xXR4jqgZSO1pYmKWKjxAlkhb9FiIjA3Jq0MzWutG
         PK8oFB8Va3ij+78KaMgatz2RhWq+Kx2XTMXm7QTYAYguYewKUV0MATZ2ke2LF5/Vdpor
         QCh1lnK8wmAfcmBJefdN44mXkMMPFwQeIiA9eGBrQakS0JXCuNEfbL8eYgDWe4wuKN1P
         A4vGpzTO5AXkBQ5P7cAbdYse+chm5isMlVkFXFBMi23uJtuYW512KcPiNP6dUlE/9T9S
         Yagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890687; x=1794495487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+YAM7QhpxOQ/TxDpr65kj3A2GM5uW8GyQy6B+dSiS8=;
        b=NPBwBRrAaaoa5tlboqKKigp0gbuybhb/L/Gr8uJzaC8qWQHIycGt4GxVvWtm9KURtM
         lTBGAOt+ICupLgLxQQlZv4pNWB3yiXcAdpQoC/wAAF0VNMj/I/Oo7YJ5Ycho3GcBLgE0
         du/PFmarj85tjGqcmmSfQQanHbaNZuOxkUPmwJa98KpuNL2TEqr8iXqoSkdK58wlYDMu
         9i+3OeiG/wL8x74e2l1yxfR0Gb0d0DFBGWqopZE6Ulvi7nMAkhyxoUjiNfcMXLFNQ9zz
         vQrlPuz4hnH5ihcPdNfNctITdn8+VhA5n8y1Fwe8zDGag5lGvcTyqPfZOpNn2pUZdzMK
         84dw==
X-Gm-Message-State: APuU4Z9hcqEEZ8m4Pcexv5w++ZoHvPZWTn6HArl2dF1ZA/XzOu9WfdAw
	cjltBVThO7zLjmEu0OMtjHxUvTAQ0X9T9BASKK0DpDEF0oWChv1PKaWcjmLKEBYENCrHYsmqfkc
	SOoydo7U=
X-Gm-Gg: AYBFou1Z/EoDSd/SX6OhmiT0st7nyVPZTtPR7wU4kJiqjJEL0fMiVnuXHpu7YBNXUuJ
	1J5u+gJRd17Vb1tx61IgwhfBN+Ar6lp5z9KvFkavh0scMJho/t25EOkPExHi0S1diXX09QOl0ec
	Pa1Km+quXTCMQa3F2znMFwOETD6N5JHuCl/aLaIsjwTcgmnTeJhsxXTCETafOQ3yI7JXGjzJGsV
	Dcb91SL2ZovyuJJWpdgrFgup85aQ+VaNA9o2LreHPyuF79P6rqrlw35veNvPbGBzW8T1A+pjW6I
	WG1gTnd1FN24Dd0FZRWfUZX0QSJa83vb55sNMM6bTdmf7UVB72AeDzt0dIjcC6TaItzdAhD2aeB
	tl5e4OTqCKByHew4WwdskwgOxY5e6epHSGnh67g1bmtCOfxqQXfLb/+Ch4lo4crQOEpBjTcSHU8
	2v45ddiwcig4IZFfksivdgNvmag4GvzZmoqw/u9/7BP5oF+OBDB3RKsrLzX0ZF4wu8PT1REZwoi
	AUOdsbKV43Q0QhlJ/LammifVQHFhyMPnGe3dDRqx4P7Xiw13VBYrvuWmvcEB7yOIGDxLHq100E1
	w7RHjaMrUQNKF3uiMI06ASu5I0o0lIvFTQLIQwF+1pOu4fo=
X-Received: by 2002:a05:6830:2545:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-85d3661cd2emr14377718a34.28.1793890687113;
        Thu, 05 Nov 2026 06:58:07 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3eb980dsm4803319a34.25.2026.11.05.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:57 +0000
Subject: [PATCH RFC v3 06/90] capability: give the owner no say over a cell
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
Message-Id: <20261105-b4-cells-v3-6-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=1426;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=UoHgXP5JDNCC6gM9STTkRffOMdSK9X/MpGRKf5Ijsns=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFP+naGFhoYNlRnMYE7wnS1fYAQ8Rx4sgYuZBeymHDBcNvtDLvOZbEaijiKIlDuCqnll1mN2z/c
 N/iQX/tbeRwE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

cap_capable() has a special case for the owner of a user namespace. A task
in the parent namespace whose euid is the uid that created the namespace
has every capability over it. That makes a uid the authority over whatever
the namespace owns.

The authority over a cell is the cellfd, not a uid. Skip the special case
for the user namespace of a cell.

A capability that a task holds in an ancestor user namespace still applies
to the cell.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..8af343c78d35 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/capability.h>
+#include <linux/cell_ids.h>
 #include <linux/audit.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -90,9 +91,11 @@ static inline int cap_capable_helper(const struct cred *cred,
 
 		/* 
 		 * The owner of the user namespace in the parent of the
-		 * user namespace has all caps.
+		 * user namespace has all caps. Not over a cell: authority
+		 * over a cell is a handle, not a uid.
 		 */
-		if ((ns->parent == cred_ns) && uid_eq(ns->owner, cred->euid))
+		if ((ns->parent == cred_ns) && uid_eq(ns->owner, cred->euid) &&
+		    !userns_is_cell(ns))
 			return 0;
 
 		/*

-- 
2.55.0

