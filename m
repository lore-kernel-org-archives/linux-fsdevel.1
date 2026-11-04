Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802298;
	b=xYg5C7dfeYvrbVcpPu8qguUcRpAxOTGgQIPyG89hTi2mMO58XwAZn688TNbuwZVY6Ypb
	 KqiSSLj8w5cZDSwzhNxdFeIn5vPofLybgLoW1keBMk9XPepaKyc8sTfQWmEzgNtJMk1ao
	 Zmm8V4b3Gsa+9fKb8lxbXBEFOaz2yZjQjYteF/y9oDZ+xHc/ddYvSfNyY/u8xoKB8lyan
	 VljmHWDVLwcVe0kH55tdmnvLB7M5F1zwmI4sIleym1i6F+0miWrSbPOq0bF+vYnGnzjZZ
	 S+VQy6dORBbIXZ8lWlwtyyItXXHMe7lYVEiW8zZsJI7nhZCvwpKeKgr19S8KLMwWVnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=75Vz0VFMgzVs9eRdW/Wv1i02haW1n/3TAUM+kue5zp8=;
	b=bYYWSth7RMz/vci7LAnwQZBe672HEdabs+9z9ri0MwqpkSQKdX/oDSKtOK9OKRJs/My1
	 JX0g+afd7AZHCQDdFz8T/lfcEhWTAgDwysXXxZN0Ljyqg85OvbXPWiAspiCfeHjHQ0034
	 UUN8UFWgyz1j6j0aXAmES4oRG09U5VAot09b6TtLerXoSmxZNXUtrncEKvNhVhj4mLwVR
	 efN3eSJkVdIHgXYcn2zbasxX4p0z4qBRBEkWN0fX5NgqJQTjhvRF7A3Gc6Cn3vwcqa13T
	 y9AA7foJ2dXRaCgl3Het53UV42EjTnlW8CWJtIxJ5EQzDso6MNiuoQDiC1hKfeuPIMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rxji3EH5;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22940606A336
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22940606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rxji3EH5
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f259cdc86so78749985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802297; x=1794407097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75Vz0VFMgzVs9eRdW/Wv1i02haW1n/3TAUM+kue5zp8=;
        b=rxji3EH5yfI/ldbhulzm1cTw+5TZyQV8cP2waUNn8q+wNrVV+28NppoAORW26kfIEa
         SH6E7SW9ly24vgOdPYYfbQPNkcHvtvIEfkdl0PmxsU12vLWPgkcMkQ9zMfhsrTvT+jMW
         ixdEwazm6rT4F3DMFmGjkDQWchbjqGjrKOhcnNFFVqHV+82bf30V3csZK5ubcy0Mi0va
         2INS79DQts7Ce74vvop+PC0V2xRv4EZ/k+DEGmBBfXV77LAh+i79iUWYmU58/FefxHc6
         5WD/MIzbwWm80tPER9k6ytUtqtoeL+u0jiF9JiobcK9BQXiwadzwrTNhYVhVfCUbZhwL
         7X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802297; x=1794407097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75Vz0VFMgzVs9eRdW/Wv1i02haW1n/3TAUM+kue5zp8=;
        b=orEgUjQsEqgmt7TvITIWTx9kdQiSkq1SF1eboKRRaHRvqtoYNqfZ4uffrPHqvM+AqN
         tjahmhcGX3322Wdg/LsCsddshWCoWL56RW8AUGaVqo/L0ab0foy5/z6XkON46c42jfvY
         HeiqXedhOvgLzfVok1Pq6kEDOFre2B+IxOxSbI7u0/UFbYat1IOiqVuydYxxWrPYwSw+
         ZjkAiLhy5f6y3KI5P7XxK3169txLYrTlJIFdMVuHvt4O5CH23m56zDa4a7aJ3M5e9kQJ
         lyKN13IK4iNRGiddyDCBU5qawdSo5F9qHXlA7UksqfJGBdoue2KW3GL5ILBcfnUTeuxd
         XblA==
X-Forwarded-Encrypted: i=1; AKwUvBwj0BStqqV+7dFGOCn8g3EDFHBAGzoo3bI6rgo+EbbulmrTF0/Ji9wlAul46BkwpzkhlrQDoVqnXmXRwZH6@vger.kernel.org
X-Gm-Message-State: APuU4Z/YSs2PV9c7rwI6/lnZhLNbMWNRsPTGoNBaH2gQu9799ABSnYDi
	YpKumJLEU87oZaNDU6qtvQI2J/3tWnLWYx/vOtxvcZ0hAesEqSX5239LSiTP66SjxnGSrUByUyj
	ZzZEVbfdJnA==
X-Gm-Gg: AYBFou2bfkxpumwlVLd8JvUU4yc60iQX4v5wqV3Nxo1nRD3ZrOkWk/6FneTKZ9GnPhM
	YSBjutMVqC/HFRIR82lg5MDI28M5ftdV/TeL8T929M5IsrVbfGgJptW3qmnXaw6PrwEZXGDEnNz
	hiHud1bOQZb8Pmp4B0ir6TRQLL/UmkWZzs+gvSyYdffhEaz+dTJJBzcTNJLMXdg1BUgE6t4aBky
	FNEjnPW5cng/jL1wuh/yYw/9UQUCagg24Biabq11pi/vM3wwMVVZs/CltJa5xPdFP7oayBeD/87
	qNLD6mme/4CZd+/1W3sMC3HK46yGbQxy6gLKZE5IFvXIZ9S/gi8ar6ulqnCMjo79LEALVEkmwja
	TSpVfD24i0aYz19sWKG318wyUtWuLk5rDd2FhA2+jnO/+QvHqWcpyzznnQUU+eQi7GLD66zcCik
	jnpHQTKoFfSPwHK/pJwM99K9z6yD7Ntx6fweyzhu43XKjvcqHWqMbhn2imRTO3hDg1IbZ6oZSZc
	VhEb9rrSdl24NEIPsjkBYKnuAMTF7FKh4C38agnuSbrMgTzqZSDH/DUxMZkShnXIKLBytHexfLT
	q0TBNRf+xeOkqZk4pNLlLVRoeNB7efG8UrWeb222NM4cZw==
X-Received: by 2002:a05:620a:2987:b0:93e:623d:99ec with SMTP id af79cd13be357-94421744cc9mr2734321685a.13.1793802296945;
        Wed, 04 Nov 2026 06:24:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488d41csm209937185a.38.2026.11.04.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:32 +0000
Subject: [PATCH v2 05/13] sched: use cred_ids_allow_sched()
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
Message-Id: <20261104-b4-cred-ids-v2-5-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=672;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ImeGFC9E0VS07fk/4WaXMGVI0o0kdEHLm780/RMXxek=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK+gnTocRhHrbPXZJVH+S0euTmf6h1wO9Ccxsz5BBpiCsV7ndeahXaddCx+67kv6vX2ni3ZY2Ml
 JvmpWkwNn3gg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in check_same_owner().

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sched/syscalls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd..31650000d6cc 100644
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

