Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CF38654F
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344743; cv=none; b=jtgy6r+pLXVglEG6dI/dKHAzJc1qiF8FJ6FePZXnnt17ZStr3dTNq41x9MWf8kPFLzzlO8ipbrkCWXV/3B5yEtHECBEmswFlHZ9exejpLJf1d53bBzLrk3Atmjk2isElOo4DsSYK5jeUf4oUMKCpoC53BvPnbSPSuwxk8kfnHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344743; c=relaxed/simple;
	bh=VuhplGOEcquV18uiiK4/Ap3qkFtEFAfeXJoR+tCujYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrMm6OqrLGZRggcmZUWIrKF5jkxD+RvERZN9WUaTpI+zkbNrK2pSYDp7ltdX8zBcg8Ur+mAWp8bgpqjcuVG80HqprawrMy2dCeJYW4e6KNdE+N6uzFHUO/WztHYRuOD7teBqrsPx0pAsdY0wogD7p3bZ6F7ITO7TEEy9eSvvPLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=A1h8DTFO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="A1h8DTFO"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93ece7a73b9so205998485a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344741; x=1792949541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTYMw8Ue/2nfIYqwtO0taqjwjGSVkOQsjNTmpCNugZ8=;
        b=A1h8DTFOhCqvx8rotBFvDkIP7T05A4ZGeAs2KZ2yAUITFvik0ZChp92Dao7UAFGyv8
         JbX/V3HZxUNwWCTq0o3K0DQ9BziMwBcYyKvYKDKe4gV8Hgrn2OXX3Tytw7C+gMDedUC1
         d9px4hY3+AzxKtV4kcBh/Aa7MGcxlYx3NHacYkRD3cHp0pq4nYLNkXiZYgoZfbtJH0En
         0pmw/LF1E/SdDjoS8yz2IhBR+zf+PAlyoxm0RLmY33OQdSaYKLByToZsgvmVNDrSpkAZ
         6PRkhgACPI2/0uN4h7BD2bBXzvrExlXnkIACev/cPEoC1ZTVsyxkxwOoM04orGXaxWmd
         /MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344741; x=1792949541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTYMw8Ue/2nfIYqwtO0taqjwjGSVkOQsjNTmpCNugZ8=;
        b=xJAdQiYXizBxx8uLh6bQPDiKh/X/0q/3ZUOZjROF9ynSoQMHjAgDXG5Q/7yI6M6lgc
         6A9ZSGnbhbCOZL+FuWuTvKhI9YIKpkKmQSt0Ok8g/664GLmF3WYujl+T9JjO/pPdPcmM
         sTnjYyVjytond3aqdmFWAIVcRnfuCO6Ld/wWpV09oy8eWhnfrRvz24zcw6qgPZVCpaIY
         dhyQa0KBnaWtKs1fd/tNzWkosLWFLk8QbTCB61nMkyyJ+5rxSjRi8Ne9UKITfy+3ZCvI
         zZ6auRlZEPAjWYdfeGqVASPo1Qsbxv4/gDULjFJJTSGn/F+UhjqhHvEehXt9BpFSGV7Q
         z0sw==
X-Forwarded-Encrypted: i=1; AKwUvBz6ea5I4Wi27bbajrLkAxZZSNRKG59brtZaUZPHv6Wx4ud5eCVqhPRVHB0ntFWC55bOugjeieiVeLExUegS@vger.kernel.org
X-Gm-Message-State: AFq9FYL0Gsmd6DVEYBkF/I6VOKh2QGkmjPxrWTzJs9mTscSRnT2OQPCU
	dB/fgi/IqiIAXFfrJb665xMKvX5C/Y4kbcO5QPCZWbGsHwZoIW22uczi5Ufnegy23Mo=
X-Gm-Gg: AYBFou0zxMsbKFW0lxPqrpvRJB0HAzh8E860lfqmUbk/lWiFpx/R3Wt4TtHFlHQW8f1
	4BrWzjYWk2+HusNEyEFmqG/GRZpgR5ZRT49ZR7bTPZDDczpxwDtKTJvQWbhJUVctKuaqxomC09/
	fIvgqI22rW2emawncKK0sUfj5uC1bRqPCRaad2zQQg570RV7NhMNLcEbs72QUvkC3X7BEd1Qxb0
	WY4MXqWqU/UhJJAExDqver8CYI4+mFnlDIrKZi1KxWyxriFF7wTCSepGN35XiT8H5hK63KIeMme
	kjrz49QEI0H2+fgfmeJA05yopuV0wSQSPahF3dKLHExiC7IoDtLsDCN6FQz9HqwQg5CY3i/0OwO
	L9730gE6bZveOuqV2dYcgnNabVD6c/JRvMS4j6c+/HZmhiBOAXfjtnSuyDwn7duFTjkXd7E5Jt0
	Jtjrjv5ps3SVNmQettfvzM589Ijb191QRXqb4tEvNtPl27olr/MLe0sFtZIrQ6nATYlaCYDvJ8K
	w4al3pZDZ6utrlB
X-Received: by 2002:a05:620a:6405:b0:93e:c12c:f146 with SMTP id af79cd13be357-93f29e1a3c4mr926687085a.80.1792344741648;
        Sun, 18 Oct 2026 10:32:21 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bd2158f7dsm68879786d6.6.2026.10.18.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:53 +0000
Subject: [PATCH 11/13] fs/resctrl: use cred_ids_allow_move()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-11-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344715; l=956;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VuhplGOEcquV18uiiK4/Ap3qkFtEFAfeXJoR+tCujYI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLNRA1AncoNnP9T/8AZep1DvvZ6xZrhrXQzAtYpQpb4+LGe5QZwUSuG+P15cUom979wTItt+tJL
 27wFY3xY5egc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rdtgroup_task_write_permission() makes the comparisons of the cgroup v1
code, euid 0 included. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/resctrl/rdtgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5dcbb0a964e8..d032ea9ca8c6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -732,9 +732,7 @@ static int rdtgroup_task_write_permission(struct task_struct *task,
 	 * Even if we're attaching all tasks in the thread group, we only
 	 * need to check permissions on one of them.
 	 */
-	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
-	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid)) {
+	if (!cred_ids_allow_move(cred, tcred)) {
 		rdt_last_cmd_printf("No permission to move task %d\n", task->pid);
 		ret = -EPERM;
 	}

-- 
2.55.0

