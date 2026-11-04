Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802303;
	b=jDZlrzcxRr31ofJUkj4U2ruDjUtBPUJyvM5XvgYKjmhU2qAqgiowcktR0OY/J6plQQkn
	 XDJ1pRHJ03iJhRIxm0+LlBFLErTpWwjYZ/nlqh44Aq4ZXoa2FtE8+W2uiT/I9TDv99Tdo
	 NqS2L0XHRQl8DdG7R672RqfMHd3UyUv+S7kiZmN9ShyZ08GfCh8gB7Y7p2q6ot7zVsdQG
	 SKyxt/PDBpkGIYaX9uqMGG15ZHGYBBVyDja50E0cHJBvrT5P/jgq8SZoMRvXv+kEPqQOt
	 +sjxTM2sPgqcCWU37w5FW+6SHa6SdXyYvUpUpM1XR0rkoUq3gXOvqMOQ6mwLQfO2h4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=o/jpNxRKXj1HQ8M8q/J1Wj0lnd4CYnsGrh81DKTgUlM=;
	b=jMmxxbzyaYffpZ/f/ntBmLaigrCAXNZ66uuTTQqrVNgWIGGqo4rv0CwoytEej2QVIKcX
	 UzSTjd34XcOQopOA8SoTVesZZXKvLJaJYvOLh9PIZOYpDLUYxKdE607Jq4h0kAedFcXWK
	 6qA3cwnRBt6vpQNtgCvN/XzYWl1gvCx0BGgK69Ycmc18I8q7TGB33Y7rKLdfyLdu9unc6
	 8XH9omMNRe5i1Pre3c992PtONxRoPczyX1/xatLe+u1Lj2gps416o8atqZ1+D6YvN3hvh
	 4+52dSb7+6S56BFvguCDNqMtKR03zOxQXcalDW00KPbCL77S0Vb5hyOdHyu14dWVwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c+usujfd;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9084606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9084606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c+usujfd
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-945ae2daa3eso95548985a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802302; x=1794407102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/jpNxRKXj1HQ8M8q/J1Wj0lnd4CYnsGrh81DKTgUlM=;
        b=c+usujfdOWO01tiz/rUVaQ5eBw0bEs1yCRFc+ArT91Laf+Zaw282OhwIDIjNsukvoR
         xYSCht4CqG+2bAaXsoDnty1REY4FONwm1nuUPPT0uAHnFNcRV2pQExO5RXhjbFXBMQC/
         LZcqWzbXOVf8kZct0Vj5PQNpFzfK/EW9r5V8sjv6nqtCJm4caAnJ5Q0c0oNczNVKA1Me
         Key8Gx7+8EkCLQ//vDsrxTqIbJIb36+m1ieRGlvzh9h24N/0b25KNcCwonV5BQfk817t
         evF6UCKdCZqo088cjNDUX0/Mf/gGtfxFU0S3u2rioqWYEJ3Xm0CCUl45Dmks1P4g6U6k
         pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802302; x=1794407102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/jpNxRKXj1HQ8M8q/J1Wj0lnd4CYnsGrh81DKTgUlM=;
        b=uJjNR+b2EpGepcUdCSkaRIkxWU+Zw/PBx44X5lgPNYX5pir8DR0QOg0OMmVx+yx3Ni
         8hZP4UthazXWSyw96AfF0x3+MUHiDPe4IoVV4W8ZQ2JhO+PwyAXjzr/QQothBo37q9MA
         CjrJ7aZBqPjSaLEQsuvCX59nF4WKh/QuU3fhWZ/Y+1WpaLmA9pF0deR2VmohVqwCDemD
         uCN6nhkJkNMuk2PTMRJUUtSnE0qfICh3MA0zhG2xcUZQ+vG6iWtexKokhKEuFsEVe0W3
         I5CWB8SXjtbD762XfetNohPMaLNSKo83cgv1SCs9zqNk6WAPBelhz3rGSSgcHLySI3pU
         TJwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt0rc2X1vDCl7AXYxeVYQA+/bKDN6JQ2Sd2Rl0U/PRIWKRvlsAVSx7c+Nq+1SWPsDKr0da23n7MCwcALTL@vger.kernel.org
X-Gm-Message-State: APuU4Z+s/fNN9FebZE9Ja0Irv6xbOGSQt6AA5jHygdVepDfyDeGVIoDo
	dv40ARwTPSYu53NNA8A2sgynLXQ+BMK2wUBJQqvvcZnBo6fnmm3rkNZ7OXED98enyeo=
X-Gm-Gg: AYBFou0DFKk5DqY+MQrxw+BJR+QoyVV2Kkhftrh66H3qXLY23tm388p2JBSBUms6hZj
	d4CcEkEVhlGKvZ0EkN5KFJHB2oU2ddBEk7VjpA46EVt7R5HDnMFGdX+Qz2kfMASWJc8cvT3uM9c
	0iChA4nADvogUhQwijq6XAFPbxNK0btQyT5H7kp9DaZ5MzKgS1/+l0P/Ffln2QXfqKiDFkX7V1M
	Xos48420w4zA7+ceD4Xefg8CqYNJVnubY0H6jXnqBRmtF+e/1iOpDYzyi+XOTmIZLP5JbUo+gzw
	eihGBgJKmobmMHrzJNJsAmof3+6xfocc3Gs+DrpQb18IeKihnw3ZT/Ksvf0Xcq4IBPOR+qTwWv0
	Xk97EcJajEzw43C7WWMepZGTgQhDUtfcwohzjV7zpesEkNsEJFrkKtM78iUhwX1JCYPXNoDgsSq
	5AqrLx/jHEg7ivs2gPz/lCRBSilWjpR24Tfb1uOCIcZDC+cteZXnMZ/H+Hl3ybYTUDRPH2I4+3d
	P7URI3L98GgdB7q9+BfgB2Le3sIurwYpFG2xLPlPtWMVHCh6oMzLEZ9QWfjOOLoR8MqEck8VwEu
	07+RRYA1wbjHRNk/ViH615zZLztjp8wrotQ9xINy7at9aQ==
X-Received: by 2002:a05:620a:6ccd:b0:93e:9292:1b96 with SMTP id af79cd13be357-94421585b68mr2812746985a.3.1793802301529;
        Wed, 04 Nov 2026 06:25:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dacef6csm20042246d6.5.2026.11.04.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:59 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:34 +0000
Subject: [PATCH v2 07/13] sys: use cred_ids_allow_sched() for setpriority()
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
Message-Id: <20261104-b4-cred-ids-v2-7-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=771;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VPsh6fgJJw5nz3/M97zkeRfTLM8beD7v2X2dOB0rRnE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMcbR93y0W1SyelgwjZFfc7apeyUd8ZPOJlTVOf9soBY1axMc2lMqQ4PGxDU5zQc7JH4yMXmoNq
 E0ZCmG6VE8Ak=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

set_one_prio_perm() makes the two comparisons of check_same_owner(),
written the other way around. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 755bfa5ccd92..e43491a9dceb 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -220,8 +220,7 @@ static bool set_one_prio_perm(struct task_struct *p)
 {
 	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
 
-	if (uid_eq(pcred->uid,  cred->euid) ||
-	    uid_eq(pcred->euid, cred->euid))
+	if (cred_ids_allow_sched(cred, pcred))
 		return true;
 	if (ns_capable(pcred->user_ns, CAP_SYS_NICE))
 		return true;

-- 
2.55.0

