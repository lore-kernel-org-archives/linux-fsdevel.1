Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB491489FAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712625; cv=none; b=QwsHITMESbMQ3tL+Vbo2m5nXcN+VnxyVIaFMq7UdaGdC9+zIqzCKmJaerasHueEwl7eqbm1sEtfZ66/Mm77xmjc9wmJHoHIg4XgHni1zTi7bjpAWp1HYN9x+fAFzbJYi7+3wOj9wl2v+Z1AM1gTfO+87x5nQrJVJVf2AaMz06lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712625; c=relaxed/simple;
	bh=cBA/NMd0/z9GQTrvO+D4QflQGZxBX4kYgyenikb6S2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMRTT2cAgBSz7ofq0E//8BA7V85MSpGeb5oc6TonKBp3szloUbdzKtSYjLtMMIjHakOTA3QtTRU2GiXVkZ661P2cV9g2cGzX5xtrTmJOWW9LrCvWtauISixX3NgWN91zLsyIROv/vgSU2bM972belaUgHpg2XSgw5cwkl3knFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUhGe86B; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUhGe86B"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-39e0e245eadso156044a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789712623; x=1790317423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJetnTDdcZBm5VGgPWiF5drHHNXShGNAwKGAhVIxvAk=;
        b=UUhGe86BLwMBtsHhaE9IIky8o++01PpMkxAVglW0abdpiHvIrp5pYOrrrAKWiADgbZ
         F5gbAz0Oikj8EN94Ksdkase7UMEvOCY7YDje0lkCD7fc0BmkdaEW3TGKYQsNURkKij75
         P0CSvoVUO9IuliAvw5WAoIGwAVYhzIefbnHfIg8tIiioG27R8HzPmIGaTKiJlLwH7c21
         yLqgDXlS+nK/QZ4wY+J1Wms7IoJxEbnJoFwPY42tzB/ShNrK/w/4vEk0x+nJ7NHAeJ4B
         ncbmtay+xff98H79XqL8/jbsPQpjYuJ1fJEDiRh490jISdu/0/JlenIymANHaP+l8/ie
         ugQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789712623; x=1790317423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJetnTDdcZBm5VGgPWiF5drHHNXShGNAwKGAhVIxvAk=;
        b=MknL8tP+NfjgiFds4EBZ2G+WrXKtfGOWuj5Xyj/hzNYU/HWTJ5wIJEiAyS+F4GEgBU
         pbLaAL9gHDmf4CYJiQa5TZFCIVd7OAkUPgqUhOHvSgMjc5Y8F/3Cc1Kt7JGPOPzsbBtP
         BPyYayDMxqkTIYSBiZ/e3jvFXYTFwPP9MQAzVEqIMrtMS2sQEfPor0aoG+per758D5EI
         J8hPI1eaUpXFICIpsYds0GXFU3BA5cXCLj2wARmjaMm9FVX1/KbJqJVO9eGTvyiPbyum
         d7h0IPgTfwLeClpMOsxxR+a8Rsp3JM+TsDh0Ox2oKoElCK+W3d889L0CBTVDYxbSC5K7
         +LBA==
X-Gm-Message-State: AFuF++mSH6NrsgzR4SNZZtEd0ydd4ptxsVE0SgvbpA37A/3lm7+zSpkd
	dUplfNXuRsb5pjMXTNz1v5DqLeHoTfKvjC1KmwujzvjPEdJGol0zfpr06sVto/al2ww=
X-Gm-Gg: AYBFou3m6FKpxGq1yMZ+jOgjvcSk54kQ6NkL9UnnaL6JE1/pAZdmKUvPEipK852m4TR
	CmWzMuJr9a6qpAbBBYo3M9OVcKiK6pqsDqNr9isK1TviXvoomBtOX2esQvO2CJUbO/MI7J/uS+z
	4+PoJ1bdQy7Mbf/pgPHY4CF8nIMtV1VMEi9Vm8ohO+AN0K5GO65KPFLizBICnyw7S/CcBAgSMiq
	q8Ivkg6mRLfkFqmWKiZVTdp20ji7C+Qi4jYRzOhxFhi6tPeB+fHp8fZrVj47g1rduImkNBUpyxW
	xgxNwMy/oY4PqhkAVkNHHosyP+L+vmQQyUxzYdzG4HMPiVTYN1upBBMFAEkqypwOpHSBeUL0OA3
	M8pE5+4M/eppYEVbANmJDp4yeZHXiIKmwEHk7jGoPfm/G9hi3eMwpeAHqEI/lv3FE3bevmaMA4b
	eAyR5n7aHyQ4GxsImNLcw6chlpaE4I4yASZhF8V9t3v1xMA1PF8O/hznhmIgQbd54a7tFgYZb/5
	XhC7h26sUHffz8cba+EM2ojV6HRTzOQipy1fR3XHwkPFxmpbHmCXM1sU+p6hm3XMS8Lb//LztAI
	4zaT8I74JDTfEDXLXyte69/d6tqjnXoJ+wslfhxfHKG8uzGqovAQsZcbTVooRmIJ
X-Received: by 2002:a17:90b:4c02:b0:39e:2036:8243 with SMTP id 98e67ed59e1d1-39e54eb71f7mr3149344a91.25.1789712623063;
        Thu, 17 Sep 2026 23:23:43 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2876965dsm2277262eec.19.2026.09.17.23.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 23:23:42 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Subject: [PATCH] sysctl: quiet unused variable warning in fs/proc/proc_sysctl.c:init_header()
Date: Thu, 17 Sep 2026 23:23:38 -0700
Message-ID: <20260918062338.1039303-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The init_header() function uses list_for_each_table_entry() without
using the entry argument. This causes a warning when building with W=1.
Since the code is correct, mark the associated variable as
__maybe_unused.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 04a382178c65..d0d76c31d330 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -206,7 +206,7 @@ static void init_header(struct ctl_table_header *head,
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
-		const struct ctl_table *entry;
+		const struct ctl_table *entry __maybe_unused;
 
 		list_for_each_table_entry(entry, head) {
 			node->header = head;
-- 
2.43.0

