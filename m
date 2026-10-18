Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600ED3876A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344747; cv=none; b=NlzYK61SvNAOmCMCiXt1jX4EBXavIdJwMviwdYq+ZM8mNmpY0C4UskQ6aJEtxGIh49DkjGhNKFhAGC3B/zIXgxOVfcWv7kpKF2Y/DdTrCcV9OkrvAYdXHpVtPPPb+sPtlWmz1WQ4qVq4SmWSV0TGJkkVlebDs2xnjTZQ49bxE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344747; c=relaxed/simple;
	bh=DDf+hsKD+njkHbTRX0z2pNAboCvX+xbQD7r7N1v3wsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5ZkMShr58BCPfbtYcbwleZIDMBFweSdXurfdLaAvGD3JaryKTHq6Hav0j3IR04LB+cD0AcrmWhWxuDdAaU1ZuMP9VMWY2UNeaf+rUApTDPGwsLMIkIwtCdspq2hN/jF5y6NKlR51MOXv3gHzdSV1FRHFYNkh8vvlmDo8Cy1JMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RooJSzQX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RooJSzQX"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91bbce8b00cso24827966d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344745; x=1792949545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIT6/NixQImXlRC4TWm710R6s6U78F1MT6/A/k5CzXU=;
        b=RooJSzQXWMziB5UeuxNcSxvgB8AqkuqS97YMT+3gC6tKR2/lnnrKC0MJG43cg6EY83
         jNHIibj/ps+0AcFluE7cwWiuMNfF+YBH9agj/xdeP8scinSjHLsdklcOlyUbJcklfEi3
         w4Of7Fpy8ktKVLbdg6VPNfvqqJda4ryqxe0EvHkrTOsV8a4i9exZEalCOUbeEBiVHA48
         sdRAe1kedyx7j/jqmWeQ1Y9JhvCyOCwzVNAQGbG6h//oD93SDtENl110osc8Xlcny759
         cW0zlM/0WJH8039f52jvy6+LgWdfnIRcZ/QPaSg8CPld6/ZIG1H+aQE2gOxZsCHgKDwB
         hCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344745; x=1792949545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIT6/NixQImXlRC4TWm710R6s6U78F1MT6/A/k5CzXU=;
        b=ONprHa3m4WiHRka1ArFWuMmSAGviQtvxD4A9Ty82i2PkM//M3r7qCKN1y8++rLKnMg
         HC8KhkB1/6smXmfN/KeA0fXZD/r7y32/i6twIevOu6aQj9lrCzZsNlhIwjF0sfxUS8ml
         9ft7ETAebQnf4m3o7sfBhWOYUvYEwkQ7Zuv1Ud4YJTdpJNcqTQhrL3UQXRKV4x2ndVfg
         DJ8sXAXa96kVbKBiM/UQtlFMVqz0iYRV1DAamUbVt6YIB1x+b4ACHY/zqGxFX/h2dVQL
         zlfosbd8kkNhfYLnwDfzcuchuyPPsCxkf4tPwXdg29fPDDZw10kXPcrwl6aJrYfu30SH
         yJFg==
X-Forwarded-Encrypted: i=1; AKwUvBztXDZWjz7HfddVXHq0WO1eNgQkswDe3kYmuJ2x7OHCWgnJ29zjMLxUOrTobn40JlEUsRjWG5ciYE+1g7TF@vger.kernel.org
X-Gm-Message-State: AFq9FYLJFyyZ0YdktSeS/mAXcKyj5wGr3d4vpc3wPJTc834egrDQJfk7
	VGAr1maLVgbCUXF4X6o5huJnchZx3aE49sUKq/2pwdFJZiunsqlKJwlmNbXtpXpzvv8=
X-Gm-Gg: AYBFou24s81fW20yoYSrmTcRDqSGH9DcCEIhtEW1HlvWqgduboEMmBWA69KL2fVUr1S
	JNqUakTbLEnsUPu2Yop3qkp8of+lqu95l572cAijsW17VyvjFWkA8XH4URlEa3jhReC6e3XU9Lq
	z/nr3Hcyt87nwBTCVZzoQOPaYy/gTHxZq6R4hLZZjBsGsBWISjxbaxk0DBsW+4rLMqPSK8qk7Jq
	4uCOaS+lfBgtd4HB43Ki3YP1lXbqX+1Gp1HdvJ4lgq4B8ahrKKDROlFf5O5wjQ+pkGtof3Qd95V
	nLPFVXnb1o2l66tCB8CiklpnrKuuFqFvpoBzCi6tL/2AJvX7crat5FEvBVhG591b4x25Nt941BY
	emVdBTNJs/ZxwWtkKZqzSka/ipm5MjYRgby93B/j4/HUnHclJO3GmR4v8HTk3agMXWr1hITQhR9
	c9qicYe9QcW7PUfp+XfBAY83fTvMekD7FqsQlJqYcG2I3KEo7LmfJUFP/uTrJi4JQZrqZcKMwn1
	2osET4ef5mbtfo=
X-Received: by 2002:a05:6214:4488:b0:91b:8c61:6e9c with SMTP id 6a1803df08f44-91bc91a0620mr137773836d6.4.1792344745282;
        Sun, 18 Oct 2026 10:32:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb5c985sm76919046d6.38.2026.10.18.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:55 +0000
Subject: [PATCH 13/13] keys: use cred_ids_allow_control()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-13-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344715; l=1062;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=DDf+hsKD+njkHbTRX0z2pNAboCvX+xbQD7r7N1v3wsw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEbulJ9N31iyUAPdo+ORU8Pby+Nj2eZrjvPJsp5DUHSYsGpNrWt4MQGwNMuGQwHcBTuz3Sbrk0h
 D9nQdRqBYFQs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

KEYCTL_SESSION_TO_PARENT wants the effective uid and gid of the caller to
be all three of the uids and gids of its parent. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/keys/keyctl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529..c69448ddb743 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1691,12 +1691,7 @@ long keyctl_session_to_parent(void)
 
 	/* the parent must have the same effective ownership and mustn't be
 	 * SUID/SGID */
-	if (!uid_eq(pcred->uid,	 mycred->euid) ||
-	    !uid_eq(pcred->euid, mycred->euid) ||
-	    !uid_eq(pcred->suid, mycred->euid) ||
-	    !gid_eq(pcred->gid,	 mycred->egid) ||
-	    !gid_eq(pcred->egid, mycred->egid) ||
-	    !gid_eq(pcred->sgid, mycred->egid))
+	if (!cred_ids_allow_control(mycred, CRED_IDS_EFFECTIVE, pcred))
 		goto unlock;
 
 	/* the keyrings must have the same UID */

-- 
2.55.0

