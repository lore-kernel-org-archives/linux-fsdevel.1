Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892282;
	b=X5IoZffguO6Iod6cDi5ocIUSQti5JR9Ogp8NjKOlTeVdVD5Odjw13vdDa5+NVZYOMhkz
	 AkLaNE/ipnn49StQ8GGCsLIPQKZzR/iKNOnw8x26TLketbFRx6uVV+YIHumc6Y5Kk6wmg
	 FtpaBWZrStvituTnmt5qBFaf8/+JIUj/SKQICH+ajzWl+kpx8rLJrWnRGsyMM4yrrtE4X
	 zhpe7Z8yN7V8FkuJ2PkaKMEiwsNXdJr/9qGiK19SWKwBdWCyKHDlVyxRA4bJqVVcUxbVX
	 gVWX83XqOZBQIvRLbrdzumrHvCk0fEzvKrDhV3G6ZMaXoBPMlSG1KDl7hbhgprdbPnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GVMBWY8D8FTfluQU1TgfP1HMPR7EJYqzlojf+T90uhA=;
	b=26mR+rvE1guidnljngDUoeNFo7V5Mb5RLtQ2Y6cCpDgEjQCEtxYkUt3tofV4o0w/gke3
	 mOLF5WsOZ2gSrqmTtdRtOK3Zj1XTuXftT1RefGWbCJWhaAWTPwjwUqvtzhr1976Ke6XhB
	 Sj3rfMrVknczbacuXrLbSSLer+jzN6DlUEYN0WkjRRr7QzjaIyuZq7q6BbBKUqOEAqIiX
	 bQhgE9pJSuCO/xqFgBCsHuxE/CpBgws4nLeBUNFrte16KC4CnVhauo6LSpqcdq3QGXxrQ
	 vA7V2crW0CEXPAJgFH3LXmOXsLFMLVaxgFJwtCDWCHK175kmXLGZ7fbjlUxKxdYAWdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eFsyHhKU;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE452606A330
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE452606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eFsyHhKU
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e515769d3so187240785a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892281; x=1794497081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVMBWY8D8FTfluQU1TgfP1HMPR7EJYqzlojf+T90uhA=;
        b=eFsyHhKUo7vAAywakMuEXs/Y8oQtA+QSN6W/MeINUEFmO1KRNIxq9Kb/Rch2JlZO65
         4gdfLfBsBS/Qo9VEIO+1V2U2hjWMy2GHaq/N3RV0NujvnlTa6zKeEA7zyjQ+3zyimXGY
         vtGpIaSay0hLFJ8ArWUBh51qkHopDL6BGCxdNFgckzCgIvzzH4uAsf+ExSG/hY5qlXJq
         4HXbq3o1xZ9D5aDJh69ckBBOM58i+70K+wxOeLC9x7Ax8rWGg3hR1EUTCfqJY7nqDWtR
         Cgq1dNCmnwbjnguhAdFmPqGjs0emXF3M3KZZ0bJ8nwSVvePPWD8iYClbGE3C/TLgvBuT
         vhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892281; x=1794497081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVMBWY8D8FTfluQU1TgfP1HMPR7EJYqzlojf+T90uhA=;
        b=hR6CO42aMCM45K0NAsyGNPYGtYIacw/Hpc/9qBIBxD7VdQvxAgw5+esa5IeZcROyvW
         8gG0hHGs8xmjfGdJPz0wmAI5CB3An6zt7RNAgKQ7tIBCcbZ5A3fQoZAFAlUKLdqlOFVY
         FW636lWGod6QF31PXZNnW3HqR3XOhlJfByuntaq6y+ubGZ73FidLEMziXsyOgxLCyr/9
         lLoXqZA6iSSKpoeLaPniP9sKV/rxl2RYgkJClh9notmJueydKXZ8xS0OXmqBlnJ05LrR
         Nnh/VxYzAcE3Q/NvDwYbp6cNsxgU3GLG1mW8kBoDN1Fa/qcWEg575yBZlowqZrvatq78
         EDJg==
X-Gm-Message-State: APuU4Z9YtzlIb6LCHdfx+j0J7LGuWDrdayPaElnkawteLDObiNpu+Psl
	OB/lNbv0jXsCDtx+/2FqzEu6ubaZPZiw/LGz0++/DPT+Fi0H1fMEGJe7L7g9gpF84Xs=
X-Gm-Gg: AYBFou24IX8GpvM44xBogMVUqCCnwYU/d8E0hq6u3fJeZ6bNAzyCsvMsO//hh/l0ob4
	QhV9Hrv9oTBid9gXE/AbR9cQppMKO2V8uOqCZdjkhugvoy7C1Q+SVVI9UjCUzarMgUo9vtVb4KP
	L+vX+3mO7HG/1Oh843IgcQD+W5mbyNUk/ceVKuRrH832Z5kBVFYB/7y7OliCq+gjRtv5Vr26q0U
	Zzd7OLBK8X/9u3VN/JO/IYZIPFymQ9IdL03hY6PagfE3gIU4msR5D32+n1ZFC4FJ4jXaVkNcpU5
	xWKZcVdQTjlnOV93J6Iz69nFeMkGX9nsKarBvmzq0ZHCfkBeR0NpkLRrbvFm93Tm2mhVniVc4db
	SaiS0CBRaVnPynZ9FJESx9wlUtM852S0z7Miqw0CjFfukgqJJRQHh6VstYQ07pX72rfiGi4/h9K
	C1/DeB9OCsfOEYZCHLourxwnPldGKRkkMXhhgTt9M11fXhRhoAqqJN3DpMjIJsvRgodcRcZHneX
	QtdCw+tShvvLYeM9kzwyABfzxviIJ4L8/x+xN4Gef8KFWdmZIcOWK0JYQeHd4dA6nAVQLVttUM+
	d+cw/0K83GvDta3N+8grG6X8mTTRQLntS5MFd9wfnaC/
X-Received: by 2002:a05:620a:4686:b0:93e:84e5:3c66 with SMTP id af79cd13be357-94421677058mr3210312885a.40.1793892280636;
        Thu, 05 Nov 2026 07:24:40 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d484499esm488155085a.26.2026.11.05.07.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:24:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:58 +0000
Subject: [PATCH RFC v3 66/90] capabilities: let a cell shrink its bounding
 sets
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
Message-Id: <20261105-b4-cells-v3-66-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=1570;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=PMZ3KyGU55KzKHRvscR9iQYn+d48zp10fb2/lLT/sVo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP3quLI3qgBXnJ/5A77Rnt8LhgQ1d6t9z3+0xUP3nVR8M3nlWbRwHg4RaKFQMsNfySEtdf8/kyx
 P/PJZtA8xOAg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

PR_CAPBSET_DROP requires CAP_SETPCAP. Without that requirement, a user
could run a set-uid root program with a capability removed that the
program relies on. A program that does not notice that it failed to drop
its privileges would then carry on with them.

In a cell no program gains anything from its file, so there is no such
program to trick. A task that wants to give less to the programs it starts
should not need a capability for that.

This matters in practice. systemd removes every capability from the
bounding set of a service that the unit does not list, and fails the
service if it cannot. In a cell that has CAP_KILL but not CAP_SETPCAP,
journald does not start.

Let a task of a cell drop capabilities from its bounding set without
CAP_SETPCAP.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 02e25ab18f56..1e0ef7465766 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1281,7 +1281,12 @@ static int cap_prctl_drop(unsigned long cap)
 {
 	struct cred *new;
 
-	if (!ns_capable(current_user_ns(), CAP_SETPCAP))
+	/*
+	 * It takes a capability lest a program that gains from its file runs with
+	 * less than it counts on. In a cell no program gains anything from a file.
+	 */
+	if (!ns_capable(current_user_ns(), CAP_SETPCAP) &&
+	    !userns_is_cell(current_user_ns()))
 		return -EPERM;
 	if (!cap_valid(cap))
 		return -EINVAL;

-- 
2.55.0

