Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802305;
	b=1CabDQ203JNwin8ejNbAdtzx+VEpaAOta8Z4b5scLsfhpSeplgesNnksJLAoDwUgfP27
	 Fn2mneI9zinvD4RKqRMiO//SM8eJFHbxdn486XRWXGqhFIV3J4nvbutkqAX/O7n82en+C
	 ovnHlLWoTEjDp0U1lMeEWwj3zpjHlro4XYp4Ay8COq2rLFtW/IuNekANTwp5dqFnkLPcj
	 LEkKX5BnVHaOUUwSoqoqHPY1LIPLDV8eWK0qObGL3iiipJsJ64/ijBDTqHOlgAIxhE5+6
	 FD29lExMtkogeeZFNMSNv/vobon7dpjK0mMOE4DxzqASjcFAXDzxYkc1k4wPtktKaWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pzxWQSDPM+PHVvsLYVB5w6iZUlMeuS6dTc4+BOVgaWE=;
	b=ZvcHh/V4F0JE2K06+ffQxFNqh6p84gH9eQ+uj53vur4VWD5wyE2vDDAZMjYZXxlsMfxf
	 +21OGGvjoXyAiEkdU8Ww2/bcpML65p0V3tY7wdxnEZ46WV5m73m2E2tGpDDcTzx6zyfec
	 MbOa+1iHdq2JxHCO/2jwAkzMI4rFTRN9VOX8vx5/e2kOjXNH4Cude50r5wl6qm5hjRmP3
	 Wtv083q8r40AT5hKKCPzdKVAS6fpaA9AzlzwvXnWt06gB6+5BTqVGg6mKWKaKwGQOlKrZ
	 Sbdz3RlGBTWR5rgybJSFl0CQaYlyirmnyzTCBQo2vKy2L6U6k0i1fL9BfWjlE606WtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=abpmhxWR;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA5606D805
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBDA5606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=abpmhxWR
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-536c8f958d7so5604911cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802304; x=1794407104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzxWQSDPM+PHVvsLYVB5w6iZUlMeuS6dTc4+BOVgaWE=;
        b=abpmhxWRH4LQzMV0jAKf8jiJ8cYZX2nqFZh/9yAXmihk/QVekTm4snUYAlMFDRVOny
         QNJXywiJD1EIHCgwX9PxmS3bZm36bzo66QuX/QVOkIIDheVR3RaX36MnVygU5uJin+gW
         /t8TUMPOzpWxHKGIeNfl8lKxKPYV3/8RrWd/4mxUy0g+bntqMz2hQMZy93aD5QPvEyh5
         5iy8Zh6K9g3PrErFoU1xS98FjEmypiz+xd1XqbOLTzSDRzeosxFaUh3SL9KWfSnK5A74
         OSyR69eAPyF2C5e8jbiu+bCdsHBDU+H1chxhVWzhgZp+KTqJoUVrFqj9XF0JvmGcYLrQ
         801w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802304; x=1794407104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzxWQSDPM+PHVvsLYVB5w6iZUlMeuS6dTc4+BOVgaWE=;
        b=LLNSZzgEnsvckFmj4hj1J0QhKiUHoFzdwCmB9JNzdGownZwId7XrHwZEup6hSIckvP
         QBFy4LXsaTeTTm0i2NeoOG99SQ4mE3QoVjeJ3jQP4gDNVNo1v05+FZz5/4SfVYdllhNm
         5UKPDlnz3MCUbM767lOa+w8gATjSddHNwA/Av1tstK6MqA1/tUDjXO7Tai81Bxevdf31
         Ggsa/Koq1a93lybb36zouVnV/sNIi2hG5wU3Gb2bqV6j111cuDmdGdmxEdr+0Yqeuy7p
         2REk62KQhElRNjo4tcmHfLXzcX6FE0T4nk/QCKE3XAtRk2xZpOlNfyr1H/BapCt05ybk
         ufxA==
X-Forwarded-Encrypted: i=1; AKwUvByv1C6pLIR5/IhZdubxlLrzFLJnVAZY+WNJuawgVNya49rDEn/QqH1X6C5ev1M5j+Zu/te69yzj11MFIKx+@vger.kernel.org
X-Gm-Message-State: APuU4Z+28mLsHsNcG3vFtR1lc5s5hSvZ2SqICpXm/142JEv72i7hEPrY
	DCVkdi9kJTJEsmRIctsU6SrXc6C3yVQbZCpCk1qCxkJnVAUpyyKXKBlbYOU7vlzij6s=
X-Gm-Gg: AYBFou0KOJowPVJjKnKR+0fSC/DFHiMG0/vOsQN9zj5lvkrsSJQOI5uS8xLSJ7o27e+
	65FOYCEO+SsiyyYUdy+z4Gt2hI11/qDFjgEDeFjCCueom8wH/uSzfQ+7Hg3c0OAiSj36927Q22u
	aBbYiITjDO6T67tYrw2jwzF0AqZ2yvgutYCSbkQa8mcU46miqDwhuOWFF5sMe6FK9RQRwl8Z/5f
	FloeuwOg+xtra2OJ5T+E998WFCrWYkWwoxYC0i8IAzYBgRPP2OI6wymP5jdrKkgrfBwk7ZjZaMX
	pLsha+XP5I5uko8mIOF7gx4TDPQov732EECjG/mpeddr/Gs2YNVM4ALzVkK2tOyn2Ac/8haeqh1
	5LIb357CPnb4vahk8wP7DHNHL06f5VQhA0sWDtu2oszPNMTboVDnwt8xYMqcIp1FEOMirZEr47o
	/qVbzI+T3+OUn0868AAp9FXobru94VblZj8OEm8qFp/lG3CuZPD8RDP/qzZlB+D5kDxywrd8qUr
	LVgeB9XdNMnotSDyn3d5bDePnxjGpIvuqjIUMi38nAsDztLIoUfhMtzN7QMwhJCerappIiMEDV7
	KvJTUSmgXtAbX8BDTto/8ey6VttriUAvSgyHNzwNVRB5EQ==
X-Received: by 2002:ac8:6f18:0:b0:535:b506:11e8 with SMTP id d75a77b69052e-542b059d43dmr270409281cf.0.1793802303769;
        Wed, 04 Nov 2026 06:25:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb2f7dsm19989856d6.9.2026.11.04.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:35 +0000
Subject: [PATCH v2 08/13] sys: use cred_ids_allow_control() for prlimit()
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
Message-Id: <20261104-b4-cred-ids-v2-8-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=983;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AmRLLf/ajEZHDzB808RxO2+24TBUMQvXN4g91Lyjmbk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGpZzMvVaH4ibXmx5ousAath+mI0qxdFXNLVR2xSo9jo5cA9roD99j8rxu9C/s/7ztc5IbA7gAt
 1Ysj9JO0LIQk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

check_prlimit_permission() wants the real uid and gid of the caller to be
all three of the uids and gids of the target. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index e43491a9dceb..b341910f24ee 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1716,12 +1716,7 @@ static int check_prlimit_permission(struct task_struct *task,
 		return 0;
 
 	tcred = __task_cred(task);
-	id_match = (uid_eq(cred->uid, tcred->euid) &&
-		    uid_eq(cred->uid, tcred->suid) &&
-		    uid_eq(cred->uid, tcred->uid)  &&
-		    gid_eq(cred->gid, tcred->egid) &&
-		    gid_eq(cred->gid, tcred->sgid) &&
-		    gid_eq(cred->gid, tcred->gid));
+	id_match = cred_ids_allow_control(cred, CRED_IDS_REAL, tcred);
 	if (!id_match && !ns_capable(tcred->user_ns, CAP_SYS_RESOURCE))
 		return -EPERM;
 

-- 
2.55.0

