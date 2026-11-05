Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892561;
	b=MD/OUPur7nqfHiWoflXVb8yRiT6Up3D2MGi4df+b9gAmnR6RlywPYprKU4CKmiD1nBMO
	 my1wdIfOZabiUQGOzbg/f52rUyzOpyBTslB+jIAsDA61yigvOlrtXJ9LImpg51TujzZR8
	 PyH2FVsQ+COIcBT6Kr9EkFGks5Whpjj0IDEoqL/BGw+6BY+t63V//c4E5e8mvQa8UA5jD
	 +KqZ5I/HIjcMzvPcWs2an0t5bFMiYR4inZ5P2ZI7sCmaHP6kQrn0LCZXz2a/wl89YKbMF
	 1BFhaVgYgzQbiaao3jpt0GZIsvvlfuOJPA0RaDPssFbQPuCNUtDIQ3mSnVQYxwNs3Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=KC1P9xd8KeLFJ3ASyqlrJ/hNXCN2H3jOINElMkwNYZk=;
	b=z1TX1Q6W3JRKcCem7cZKVefq/gUT4RTBIjTtpWAjgCDPK5lsb0D5OoTSOURzTwu+ad7a
	 c5THFBXLOkrtqwqfaMKqJYjEA+zlGJgPtyLpg9mLylrrJgVwMfVgtE8FsROV8sjvVm17Z
	 FQINseo8WySH0nMAC52zoDic6dsw5+xVj/Gy0XeIu0Q69H7uLb6TaOwYTtkgExfcUKOdO
	 0U5roFX4Km4E23SjvAOLK69jey8dratSuIeuVd90BSJUleKWN+9nzYz4XP2+HEPsMFM1e
	 YvjyQc/14olyvD9OnYv6pkx41igYwzYWsi8cJ5RJ4ZsrjIL9k2flo524qyn8TdyfkoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=M4bTNF3C;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C1606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 513C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=M4bTNF3C
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53639b8903bso11361841cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892560; x=1794497360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KC1P9xd8KeLFJ3ASyqlrJ/hNXCN2H3jOINElMkwNYZk=;
        b=M4bTNF3CC3/yhwIDRY+8iGLI2VeNi3jCab2rq43jVt7L6wnonBA9EqnUPaRi/X+Be4
         yGTxbn5RodRsBBBJGNNcP6/B58ehY0IefqFkl/sirjyVL+wSPcbaijY37uOFTOPMbkkV
         lhXZe9TlmiQA4qGN4txgi7n6dPz3g0Fm40vt8HugNxcJlf9et+ajzYdLudKJerR7TVRp
         pgOhCbsLgI8hWaVaG0fMBOyKZxpbpwHuE3tC6L0EEcsokhrGrAE3oWwKgG9QqOwPJuby
         txzaGXJXLWqK3A7fS0my2zPYjSiyA6xWiEbYxtiqiWQjkOvXBHwv7ut88tpKROV5t3d6
         oIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892560; x=1794497360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KC1P9xd8KeLFJ3ASyqlrJ/hNXCN2H3jOINElMkwNYZk=;
        b=2bD2qY6VxeeUor7knvwxj/3JFjeT7xmns3uq2/2AcvpPcCX1GC9qgJD9hwMvp610Iu
         3WuJOCIeuQUHVEpAqiwEtOT0xPTWHW99qMxcpzPdp8BLFOcDt9DTdtCnkOy1LGPaeiMD
         NOjJNEZOyLD3DflAiGc8S8VMOVdpQ1vYO23R9GrBb5IhIkSwlUIPtfITwLIt6XsKvNWn
         n3xPP9dpOQq2hb/kaIyrNvVExhMKI3nV9wturL+lQnv34IuU5C48154FBoqekNdlsJ+x
         NQn/PGUlrQKJYburjQNCNhgnOkHMsvgj8NB16A8F/ro8v/qW8BXTe8Xp/9nhuu4VCduM
         46Ew==
X-Gm-Message-State: APuU4Z8AomyIGaopp3RU7NT6vUb2TbK8eXo1qItKSS7SJ9kGomkIAhSZ
	4jgINk6wEQewjNZ0uYd1hElxD+qMOLcazeMnUbjueFIEb5OxdZpd6kzQIZwkNahoeuFq70lRl4p
	xoLQxUxirBg==
X-Gm-Gg: AYBFou2D0WV4F5hBgzwZ7XtF7cM0J86CYgMwFYzJnBT1/Pt+VPA3+jXd1iqitUaUO1B
	FjalGoLJMmLZV7UH2tD0HBl6RQ2UytafvSgxsNA86hoUhd8a7xqW85rO0/ODqT2H3+1mWTeWnNE
	o2vEHb6Yg2EOx3e2WP8frJY/j9a80Cvg6EQVY4OipTm9LgHMb7MyZmh8Zej+vo9zF+wI2ZPOm2t
	4aw5+lYm+Hpx1suLzK3fcXDfyjqvJkg9ZNl1jd5n8N/2YGBmZxBEWGQr+MGssnkwnMuXCXvJOhv
	upc89txi0BhKsz8gkwrH5nkAFyWa+dwJAE3nqIJGxm3Tk8h8fclo5fViK3vd4il09P32bgWjcH2
	X0gbsaIkZa7x92M/ayLT8cuNfrfmcA5xG+GEI3GPeR9BiNqZ/cULeYj5hKciP2eiLRCvIjh7r2x
	7XV881h04tap42gBo3XCkjh47h5p4+2up62rpk5UFDolb+iL+C2NDFl2W9+c0u7KzLBJ/wVe46L
	z2Jo7FuCnNDVLzGLSo61IReYShUaBH3lNdOhzyTEhP3Jjfu5zoCdn8dfPtgpV5vnwuQISDxL9+X
	kCe16uZ1O7ZJWO1TDxZGntjsyHTJk1NlUPZDFrF9aOwHeQ==
X-Received: by 2002:a05:622a:298c:b0:536:6c22:e340 with SMTP id d75a77b69052e-54c9b42d7d1mr43109361cf.23.1793892560388;
        Thu, 05 Nov 2026 07:29:20 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10ff4bcdsm53469321cf.29.2026.11.05.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:29:19 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:11 +0000
Subject: [PATCH RFC v3 79/90] tun: use net_may() to create and attach to
 devices
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
Message-Id: <20261105-b4-cells-v3-79-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=1289;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=UXbdA9UCvz4x1PWOKgL33Jk7+yRkjhiRV3vbT8d950k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPFDE7PYNp80VBVXSR1Y9WyTzPU9AUwmHrPnOYrC6PaDVqonKcEf7Kaa4IZUHQQ1zwUpErB/6KZ
 SR1Pg/wC+4Qc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Creating a tun or tap device requires CAP_NET_ADMIN. So does attaching to
a device unless the caller is its owner or a member of its group. Convert
both checks to NET_RIGHT_TUN.

SIOCGSKNS and TUNGETDEVNETNS return a file descriptor for a network
namespace. They keep the plain capability check.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e601..0a2f864a253e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -524,7 +524,7 @@ static inline bool tun_permitted(struct tun_struct *tun)
 	    (!gid_valid(tun->group) || in_egroup_p(tun->group)))
 		return true;
 
-	return ns_capable(net->user_ns, CAP_NET_ADMIN);
+	return net_may(net, NET_RIGHT_TUN);
 }
 
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2924,7 +2924,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		int queues = ifr->ifr_flags & IFF_MULTI_QUEUE ?
 			     MAX_TAP_QUEUES : 1;
 
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_TUN))
 			return -EPERM;
 		err = security_tun_dev_create();
 		if (err < 0)

-- 
2.55.0

