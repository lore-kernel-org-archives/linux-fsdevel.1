Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892412;
	b=BB7NE5cU/oDDPlEhIIYb2huzp9/99tvjrn5TWdHP8j3L4o4AVRYdk35n2Nw7u8/oC4ZK
	 /6clN4h1/HnTAkSIFtKOE0Twz+s/XREfZawUjjssOPfAeErC1WcKChUNhSDHQUeFbGmk0
	 CZIClcrWa2F7fcZEMVQc/uNMZmUruRa17mPEVpHdvlMPLRhbof2RSadTsV2a1aawFIbVL
	 vLvD4F3jsz+HHynoykQUIjKEdkXE+rtSCupsqOP4+bZ2yd8XOR+vv0eLXJMfX2seSorjC
	 F/s59JtCbWzHnmlxWKaA9TbS72ks8Zwu5sCmbo0zKkqAHQmwInugNE74b/Ocvwvrn8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=yvZcI1OHvptU4XKngE+vPkGgXMoqOQWT6+3hFUnC0vo=;
	b=KMofDVpxHLVoyBwTbrt9Y21VS3cezfEIhM/l5PkO6ch88K/FVAhyJv8K1wxSXHYuF0Iu
	 cEISNTXaaKmbXaG7hMKToszYEtgxEb/fmDu4AeR3OfqToNme9J8FmFVmC6aJPTj8/fAz5
	 PGQ5VBmp1R9fQ5D7dLEueg/k2nH+HaXgvtvWIANcnrbhgd72CJyDN4BngivoftfetcrQl
	 89HomGans3efS54JZWqwrRIM+kAUX/Ma01aSJp80S7wXsWSv/ry71Pw7KilbVSXJPPKEu
	 j6cXW4rKz2aMGRvAI3jscIGWLLADi/7jYVs6xmTs/v27zc5eEa0p2hQj7bKpyLSur9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="pk4W1Xq/";
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D6606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=pk4W1Xq/
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso20431136d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892411; x=1794497211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvZcI1OHvptU4XKngE+vPkGgXMoqOQWT6+3hFUnC0vo=;
        b=pk4W1Xq/MxbbrDdZkB98M+dpWr6t6g2F9KY03jGQa6P4pT3bfHqtoHts6Ok+J83YOZ
         xcByhrUYXlzN9aP9MriichOfvdcwgypm8Be9NnwqNoNstD6Sv3XngSB1pg0W+DrQ9VNk
         i51VgtNr4M+u3qBaqBHc9y9EX1BL6kxX66FZN0G0eq/aO7xdlj1uWGYFdjPASEgRGUzX
         GCKZ3ekZmd43Xp9bD/sajhlX2mm5fU4KRwF5kt4/gMS5jZO3qJ+/7Mky1xON+6Ne/wAq
         cK9QuzmLWaB129g0qaHdHDOL2yl6kfS3yq2YofBtYpphIFbDJvrSLEnOY3qhyD0ytkap
         R2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892411; x=1794497211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvZcI1OHvptU4XKngE+vPkGgXMoqOQWT6+3hFUnC0vo=;
        b=jIynHde/stMcfGk7gUvlk7rnZj5U+N7gdDSlSJA6hRLjxq0Svsk3FDBpF6GP2hN9Fh
         jEHQerPeCC0W/hEVpX9s7o8rdi+eXXwUoBaIEjHuZTv48z3Z9wZa2moNOkH59C0xc2aZ
         VBxn5voo+R6kmxbUYOHhukCK1Br78ufRXgmiuyTXoWCTWebZCcHqbRLQiU3pVPWRRgM5
         6hzlvWJppff1kDIpO6OBifVmQfm37dW6y/fwiuxts6QYVl0gq1bQUAwFw7r9XQziFQcR
         Or9UHTl8Qc2/8JSGOpH5VKBvuT/qJyHTxwQk8ztyLHoCYCzNb7ZhIcCvUI7KpMIAMRf/
         BfFA==
X-Gm-Message-State: APuU4Z++EiBQxS1xvOb+i5BYHCdQyl17H5DvieorTEHzDIhw3jAm7Ktl
	VGqjv9FadxvimV5+sgJoXpnpLbeWRoFKU6Iw+H4HRgdqgY4eRFw2aDHKSo9pILi8N/g=
X-Gm-Gg: AYBFou0Bou6qCZOjSZPQ6cUvKDa5T7lI8vbu09IT7Ww1A9B6kgVbsdXqHeYFLckHp8e
	7riH7zmMhd1vqDi+uMh266s6VzPdjbZg8U2YnVQBFxaPaUTW1tskT8WKWFOaly9n8xjxf63Z1SW
	f2mRsCSgqTb5nE/UMD4GX5fV/m/f0bAJGbf8NtPltrHKxTn6oeIv9RLyH2v9dgA/lgnfvSe2z+S
	dd3FcbPJYWJUCFwOqlI7aa7QB4PhTdYrKJtmCz/gdn1uK3qVXWdvyQuzXjFbCcxVKjZqaNw5wAA
	C0gvXgzHJhM0LCxFyAcve62M03zGeA/LprmwPGbOUnM2UM0C/jTA2whzVp27cSdk1IMbXw6bli/
	zhoZDUfrZSTvt6HodOraOLjwdXp6nhwVNSWvWZ3om4UJJSgM4btXyN+bvJNljkxBBT4J16lSQ46
	4KVHAphXMNLmVQbIo+kPIEJxC85wSJBuVPXaaxEkya+jnCO6qxUpMFKyuhNCnfA66tifpM7gUlk
	Xfh84fdXvMBkO7wbDi7nctKW0nDOxK9+izZnQEoLIqcz6Jdw1xUXBsJBSMFTStgr3wSf1TsdH83
	vYC2TBW8g+WsEfg3wgPiLvDYg5RrsQnspacZtXfcXRgf5g==
X-Received: by 2002:a05:6214:d85:b0:91c:6164:af7 with SMTP id 6a1803df08f44-91ca4b24b3fmr316690256d6.29.1793892410612;
        Thu, 05 Nov 2026 07:26:50 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e013f13sm49939286d6.26.2026.11.05.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:26:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:04 +0000
Subject: [PATCH RFC v3 72/90] coredump: let no core dump leave a cell
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
Message-Id: <20261105-b4-cells-v3-72-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=1714;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=vsAAr7xKPl/M++C3sIDFJ1Y3iQg3sutN4v2VCmqUbEM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCheF1tyWQhKCTVCe18pjch5byqxfWFHdE2AolruBYMFlyUSfWizLvNPvbmapwT0izrRm3Q0Y42
 uVRLFVC6lpgw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A core dump that goes to a file is written in the context of the crashing
task, with its credentials. A core dump that goes to a pipe or a socket is
handed to a program of the host. That program runs as root and parses what
was in the memory of the crashed task.

After the previous patch, the helper at the end of a pipe is no longer run
for a task of a cell. But that is treated as a failure and logged every
time. A socket is still connected to, and the task then waits for the
other end. If the listener does not answer, a cell whose init has crashed
never dies.

Skip both kinds of core dump silently for a task of a cell. Whoever set
core_pattern may not have had cells in mind, and what a cell hands to the
host is for its builder to decide.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/coredump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 82ef9d115999..6b091807aef1 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -17,6 +17,7 @@
 #include <linux/key.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
+#include <linux/cell_ids.h>
 #include <linux/coredump.h>
 #include <linux/sort.h>
 #include <linux/sched/coredump.h>
@@ -1210,6 +1211,13 @@ static noinline_for_stack void do_coredump(struct core_name *cn,
 		return;
 	}
 
+	/*
+	 * A file is written where the task is, as the task. Anything else hands what
+	 * was in its memory to a program of the host, which is root there.
+	 */
+	if (cn->core_type != COREDUMP_FILE && userns_is_cell(current_user_ns()))
+		return;
+
 	switch (cn->core_type) {
 	case COREDUMP_FILE:
 		if (!coredump_file(cn, cprm, binfmt))

-- 
2.55.0

