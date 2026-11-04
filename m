Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802313;
	b=vm4CzX/N+/ov1A4/xIJ+jyZNII83PNE4h8qpyO16boHJ2dvxvALi0JcFYTyo/QJzG0cA
	 kWyS8Xs+TdgQyL3qxQGTNKw04SB70RiOQMDORKLqzEnzIVK+25aDWbBPl0mAfPHlTZPuA
	 18qO9cVo3+4smvIREQlMPCV1UpdZnF4vI3K0NXHCfU5VUt8hfuLUSB7jsdFG0wNZp6l7M
	 SrJhKmv6CLsZHf1YkXWbcqWFxiEcQGnpbbx7xjY8QejftzIyX4yon5nMi1phMMXbu/Pac
	 1dhiFZK20DLVUr+/lFTRw041lMFY7FeMCI+/AdbnOkYfbOQ+VvX/yIdjqjKnvchHoLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hG5TpvKc4RXZNEF5W2j4YHWwCvUbIigtvZnxNoygjVI=;
	b=kUTTK8EaMqbLv27GtxsLHnBdVgapXtCw5GIZ7Ahfu9hT8xAk2n36kn2cMxraChKOLa+Z
	 1iUnTirDJHNBk0No3+Raodch9bBh6sCno9I+iXJ/vjcV1VGBQuXqJy1oYUKX/1fSPuys+
	 vMIlw69qj9vltkzz/a13ATYloAAeE/emFbQ9uWtTyBJuPIDfeYBgyui96Gt2g2L8N6m/G
	 RUYexdViqffj36vPsP+Kc4zH7kw+ILPQQOA/ajz8XpWgIKu0F3xPgpOZswZhVjH1HLPft
	 q6pyrBhoR2E8KPjGKXvn8kVGHbM15sAXZ/G2uurrO27pIJ5MfM8sZTUsPAGHDLwI1kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Me5us99O;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07EC606A331
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D07EC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Me5us99O
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f079a63b8so70957285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802312; x=1794407112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG5TpvKc4RXZNEF5W2j4YHWwCvUbIigtvZnxNoygjVI=;
        b=Me5us99ORyikGlYv32KXXwL+de+2DN3/mIdVzQKsvY5g3V3q9glYRRmjw3EbJzrJwL
         6o+1aefKoApCTSMWYITTEgfkkX9OrVom9BZiuJc6HIver/ePVrBAyvSDKusN/sqWLAoR
         LW/PLyQW/pYMUV/nrLqY02Rwy2Gs765GuqLR7BtR3GRoM/N8ZLElpJhW5WKk1WtiAtLt
         qvU3T1vGe0lUiGFAo7ueOSNKUEdrDOW8qeHJeqWxB/7So7I2Z2CfFiX24nl6K/TmJl10
         wED5NLEW4WtPF/joR1Q46CF0ro+Y6jz+bxk864OcPZ/E7SVAWH2GvBSY4s9G8IzQkA9I
         nWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802312; x=1794407112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hG5TpvKc4RXZNEF5W2j4YHWwCvUbIigtvZnxNoygjVI=;
        b=NDAoLBnCxVXL7h55Uqae38Umx4D5TwS4c13UMg2tMes59dIiYorIgq0JP240kk2zG9
         m5Dtg87+Sr4KzuAtDXFiEJl/1ajJC2jPghyLym+Efsjf1NIYy2kHNUuhKS6Krni53mYI
         iH0orOUX/cmmkE4wSSDE76Jo+YKbvaO0zTf87FTAh/TSQATvqAiuSRuC4aoXsAYCDfGx
         tbOSPiFa0hYgC7Z9VKOsI/ZKKEPhqlwbEc8e6iK7eguf9YrVJfFnGn1KqHgpeusRu+l8
         cDEM4LkJZsDMBS7qUlaR4jJ7U+z1EEtAP0v2b+ghuWcWB/7yzRSyF+LbJ2LmLBRXUzPs
         Aqzw==
X-Forwarded-Encrypted: i=1; AKwUvBxbBWEqjn5np9BOrHvJpgCBM7nBYIVC1LH5FAW+KZhW+AOp2T2rMhmm0nLVI5rx+4afr7IEh6vJg6bQvWUi@vger.kernel.org
X-Gm-Message-State: APuU4Z8UyFrBld7vEMpM29PQ4NE3313r/atZ6F9Zwx58FitI2yXEKcia
	oV1vp6/BkE7RD5V3GikXqtOJ+cM3gNdtPy429EQnZXOBG6Z1BMfhk1s/SV2yKjd98Jw=
X-Gm-Gg: AYBFou2iOdt7sp+eMlSTrlSKVsJODk936n8rltupplqPPiEWt56cakk3yXVnkUHl0Fn
	WR2fnkDGpj+TYAFS1TJ2XjmacoZnSyaq6uq8MCk6WsC9yJdVJor1+ynCUaQHslh0jZdifXU2kHm
	23bM8wRqKlrK7rrjqkaxkHuFewPJMtdHiEIIAo6CXYr5bUOQyRLZ0ZkeWUbp1akYaLVsTHMy9OO
	fKwTDaHsY/8ge4txSMwKWCguM5+zeLwtCiwK2O/K5vE3u4yUcUl4cIk6oNhFxty+9EPnagMQQSN
	K5q/5ruWdpPw9O8k+cPjicXgUcm48M41qLb0XVB4JXXFCvbhzt9bYmTcx/x5ygbp9K3lUxhZSIJ
	2Wk/jrLBYbufyFyDH97C/tOnStk9SZ/tu1abLN+tzeRsGwT1+fZUi/kWbxw2PNIEF/8hro/Dig+
	fFGWF83UVo3HLMBxRJl5JS6Xl55OrZfaB+64FTY2RhGqOqcQKA3K1VN3HcygBEC+RPfu+at6VyC
	RR71idZuV6/N7B4i4PVYjqa5ELwpIDellCSYXTxyCmUkSMUZgHYmDAQxX+ZeVDilsPzwBa73aU1
	7+BgpKq8d5l4+RJW6OTsf8f3RhKrPK1bgQWODa/f6vSVow==
X-Received: by 2002:a05:620a:19a5:b0:940:f224:5a85 with SMTP id af79cd13be357-944217ea7f2mr2751408785a.71.1793802311660;
        Wed, 04 Nov 2026 06:25:11 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d483d762sm211949985a.27.2026.11.04.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:38 +0000
Subject: [PATCH v2 11/13] fs/resctrl: use cred_ids_allow_move()
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
Message-Id: <20261104-b4-cred-ids-v2-11-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=938;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=spH7I2p6KlxAWtKZEKyVCuKK4ojI0D9bbJfweH6j3lY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH5hz21Zf0jQmKY+SmyRld9bkbHzoU5X3h1MbybRG+3C4m7r9/TrMSg5RPbgUNqsIz2rKJMNin3
 xmVcg48bAeQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rdtgroup_task_write_permission() makes the comparisons of the cgroup v1
code, euid 0 included. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/resctrl/rdtgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 57ab090072c2..6b7b7daa9fd3 100644
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

