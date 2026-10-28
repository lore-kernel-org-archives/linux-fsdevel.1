Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205407;
	b=F09WoMs5ZnIOyVYu+P1JTFNOA9GMLvRDdoS0dghHyc37cEf0xljzyaOJo/C3NBjXbwgT
	 2pI5ldn4A0xQgd3rps8Q7At0gA8JU7onm6EuZve7Tdjn9ZkIjUfCyaDqfq+jNQB7bI5GM
	 3T8y6iE2XOFDiazXni9Zg2oV+PraH0NIcKr1IXljyB6G6s/cpQxBg/8pJuac40qIu+H2z
	 V+LKjidO+Pa3exNIeedD1E1Jk+Fkl5sBTIT4oIam0MvBVQ6dTqihZMWReGieDh3liuvLH
	 IU547eozlvRBv5RKTUJzXkKmLFOsVIuLCPFd1+3vLlKikODAF7XMavkSz1+x18sKgNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205407;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sNx1QVfFA/ZK/0Et1XWEHddPKNj15243wikKTKwVp28=;
	b=lPS7ACF3iuG9KHHB2CDJdiRj8FZPf0jScVJ/rGa38GKTOL775SPEwFr/STsMSBYVsoST
	 PozW+fhk0MJYU5oh8pB3bJ41dNw6MdHDPbuZayvcX91iPy5tglJr/JGK+NcOT1GnbF4VD
	 XJKEWBuWO3pCtg03AiRB0MlHFWp3HkLFFTo/9BdnxGNxznInGoO6dtBqnrUYG76e713KP
	 VDHbQo+TPmwtsUCvUz8I5gWpfrh71oeY9/rTAe0jvm83LB7Y4+irLcEkl4LSq3/lgMhA5
	 p4KFe6+LsYTPioaOPFonIN03V9a1ZR25TjlPDGerrJ1Z9ZjRteAxJwKYamKqf2K2dMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V7Dwphdl;
	arc=none smtp.remote-ip=91.218.175.25
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5C606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E5C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V7Dwphdl
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xHHT1wbNVKpwdkAZwfE9VAG1f54FPg2lW4wE8grLvY0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205404; v=1; x=1793810204;
 b=V7DwphdlNUrb7HQ9UntSotg5HHwADmCPm4QduMHd9PGerBFTwaCE2qrmjTW+W26Eovm6nrhG
 FmJCwAInt7cd/aaNJUeSRhn9dG+d+iexOWiTcz4YTLmmbeoQizL9DCwzDk3iTNM3AiKL+yl1qAN
 6HCbeIBynrt/1RzH2LaZehyw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 7e004241215dfaea;
	Wed, 28 Oct 2026 16:36:44 +0000
X-Mizu-Trace-ID: 7e004241215dfaea
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/39] sysctl: store message-queue sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:50 +0800
Message-Id: <267402e8c5af753933af0c34f56f244d0d9a2a4e.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Replace message-queue bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 ipc/mq_sysctl.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 0dd12e1c9f53..cf0efc168ce6 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -14,12 +14,6 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 
-static int msg_max_limit_min = MIN_MSGMAX;
-static int msg_max_limit_max = HARD_MSGMAX;
-
-static int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
-static int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
-
 static const struct ctl_table mq_sysctls[] = {
 	{
 		.procname	= "queues_max",
@@ -34,8 +28,8 @@ static const struct ctl_table mq_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
+		.min		= MIN_MSGMAX,
+		.max		= HARD_MSGMAX,
 	},
 	{
 		.procname	= "msgsize_max",
@@ -43,8 +37,8 @@ static const struct ctl_table mq_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
+		.min		= MIN_MSGSIZEMAX,
+		.max		= HARD_MSGSIZEMAX,
 	},
 	{
 		.procname	= "msg_default",
@@ -52,8 +46,8 @@ static const struct ctl_table mq_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
+		.min		= MIN_MSGMAX,
+		.max		= HARD_MSGMAX,
 	},
 	{
 		.procname	= "msgsize_default",
@@ -61,8 +55,8 @@ static const struct ctl_table mq_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
+		.min		= MIN_MSGSIZEMAX,
+		.max		= HARD_MSGSIZEMAX,
 	},
 };
 
-- 
2.25.1

