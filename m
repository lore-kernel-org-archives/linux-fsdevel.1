Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3B3E7BB2
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344730; cv=none; b=gZqRBLhyLOVM52OEvuK+HXxDtbkIjKSC4k35Yn6Ku+0ldRhROiiPt8+fgqQr6GmrkoT87iqm80lJgFR63bzWtMdcRoa+A8tpN8cIDl5IY0UKYAPiwsdWdeBjs7m62jXLL0U+JmQ3eTitNhof+m0XNksEwSWBmaNCBjvuKXhnEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344730; c=relaxed/simple;
	bh=Jg5GmXznOlPYSuEkiCV8w3Ra1IGLFI5Hd3M/6KyUrEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mi482RrQNW4f9MipHS6EyoA19vA4Apf6q0yWxDeq4qPC2UNJTrkB/On5p41/4qUsScve++Neb7O/jOdueALYJAKPRwnSveXHAGAb2LMplitep+whmxSzytq7SDWG0K8H8CutuCj9Tl27soXZmKUQDDaxssFadcXLOlaD5dtrsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=O5nTO/wZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="O5nTO/wZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5365f9bef55so6166051cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344727; x=1792949527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ospxx2BkClEH6ACvwXOMAdeuChnoZfZGV7wg2yWb6g=;
        b=O5nTO/wZf1JUeRoTt4peElpSBxfiEtoObUUwL3pRqH4/LFw0dwjUV7XF/88/FRm8Jh
         3kc5E4YWf8afFtNQMb11K94fkdF2vC542zVAhfIn1Ojvzcs030ytCaBgd1RyGqkJxrJ5
         QSGxQaWoxxoAP/b38iRmkpEWAPasbWnleIxsqa+ufx85Y/FEpDLxohgbUoBLHaYjRmAQ
         YI6fOWjkQ19RSDDbWQEHChF8EV+jYNp6W0rPxS0QaDbVCB79zkgIAUyDh6jSGAVdFuy+
         pQfno4UOG1/kCsURRtsqMGeN+0O2flkj+g2JqLi7o7uUARS9JT26CRmDaq3+RvnePFwH
         W5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344727; x=1792949527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ospxx2BkClEH6ACvwXOMAdeuChnoZfZGV7wg2yWb6g=;
        b=lIbodZ/ebfu2R/RL7P2nYzHFWiRhmmN3lhi7ptBMV3uf+n0jQrYlkDCEoh6aoQ0Q1S
         HPQ2uAL7vS9gW26bkS2k5tuWrTJsPyhQMJpryre3YcoJNidC9/uGRMjQXt1zeu5xgoIn
         lZVA5GR9l6lZCnaIDQh2IChfFUKZmGyaX1ebjhvEKFz6pmUyNN/xAdtwHOJqiaT2fcBc
         2PwKDMnMbGHFnWeSKxN2xIXM6JVcQt84CiggBcTt34RtJisddVoendxTWZgWP7CWjVlE
         PJ0x6iwQ8lahvTaOhsCE25W7N1y59cmvEEFe/20X7/QTvaBaQwy3yh8qLZ9/5b0429sZ
         V0hQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHh/SUt30574b4QOLZHNkHhdYMK4zYrXNoUGtzU/i1JcT/ZJZAczfhZvEzI7gQnCgR2ZCrO6pxXRuuo19r@vger.kernel.org
X-Gm-Message-State: AFq9FYLSB3JIqKvF2quJIwHOe4nfTMDFyUPDQy8aQSQq3Km/QkxzGwzA
	Hx5d7aH6Txy1BlbShAD5RyaNzTTSC1zrMuNHulzVjXi11WyLip/sSB/w+AXT+szPMUU=
X-Gm-Gg: AYBFou3EnnpjEE94R2Ba7Msf/Izgv8v66e3pTdhKW9xmPePYEt1CtGwxXI/WjHkkqTC
	PaX6AtllwmQBhjtw5FvfREPIJ5LbAoi3LEDTgObJo+EeSnqGwsxhpg26UUq5QdNo5CjLLKdWDt2
	dGpJGOs2Tp80JC4rPr6DRwksOu92ZQcL8r2wARC1QyCQpcjT1sipPK79oFpAWy6F20Mv/fQAWV7
	yb9XgltONAFgYmqQeFNu+gN2VMfcJBFJUplmpfUiB6ytLSsAKFebKTon6slqW0T7do6ndpwz8QZ
	OuSh2DoXV033EMWVSCYUpgn4He98RoUbZOuDScbVI3GkS40/dHDf8z2J7BPDaIIz6GBfiPGr+YR
	EdHuibQuwn3yNYmjSxc63xXINyCMilmKCQsgjZeiI8LkcKeGm+r6RGJtk1v0yLB1SUNd+ghzK+o
	+vqSsH1ExNYdE4PTqqRderHAwVeVp24+5GPpDynPKL+kEpPpmSehZSxScuTZ0Og0NB1VvOtufT9
	7dbi8Mag2mJu1E=
X-Received: by 2002:a05:620a:4726:b0:93c:65e3:df81 with SMTP id af79cd13be357-93f17ec7a80mr1470685885a.13.1792344727138;
        Sun, 18 Oct 2026 10:32:07 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f32218251sm371796485a.11.2026.10.18.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:47 +0000
Subject: [PATCH 05/13] sched: use cred_ids_allow_sched()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-5-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=690;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Jg5GmXznOlPYSuEkiCV8w3Ra1IGLFI5Hd3M/6KyUrEM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOAY3g0DN59kHth4VEdFwI3I320GLDR/UkBOLylEaRRh7A5ovXpTMHVmfacAy9NlqkIQtfdJWB0
 8sMqPNvqLIAI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in check_same_owner().

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sched/syscalls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a6..a361a02e1d02 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -280,8 +280,7 @@ static bool check_same_owner(struct task_struct *p)
 	guard(rcu)();
 
 	pcred = __task_cred(p);
-	return (uid_eq(cred->euid, pcred->euid) ||
-		uid_eq(cred->euid, pcred->uid));
+	return cred_ids_allow_sched(cred, pcred);
 }
 
 #ifdef CONFIG_RT_MUTEXES

-- 
2.55.0

