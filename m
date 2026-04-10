Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D93D891B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833821; cv=none; b=PostwlKwhVjnPR4a9iUjTQS7gcojPtCRkDwQ2IuQC8pzlaijRgG+f8pC4K5xnb7xa8/GPqADzzZ2VnKHA2V822/qHmT1CszJDFrN76NbrdDU9lZYhYhBYL+uMUcsasUfC17e0Gck02NGlSYE5AZ7ivxFL2H063z/J+Cre21k7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833821; c=relaxed/simple;
	bh=eeKKmdEcnUe4ATSCumsaoF7MKusPgU9rj9DPYfi/GZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ad/u73545Z/P1r66DWa4RepLIZ4IoLsLOq2RYZcMsBJwNqXzc8mYSJ4OxRZ93w3C7vcQrtHBy3CKUPwja8LDAZHz4Ky47f5qHiRB9GE79fmCX7AW3j848oXT67OXYNGScqvfBMOBQfWebNQxMR2T3nDQLeB6+gX5U2UOowmaQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptK4RadI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptK4RadI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso31902555e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833818; x=1776438618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5tBWZIfM48yI8RtqbTHFRPEDxWlEomagza0DDkSzOQ=;
        b=ptK4RadItfUWHfJh2wCrCe+4yRVMoLsh+BE1YFb7EpVr8ezQ+bEYsTwCJwieQf3xZf
         FJyZyOCQu+V5iYjKvmr3cAZMOl9zW/Gnb7QR4zdivhHKGv+LnBMxZW7s12k+AXCpPW21
         QGo/hJPrFBZIXaUrt1XqPzi+ddcov9t4SKOCa6ic2qn1kwDXG0vh5dS0T04KlaSZTXov
         DS4uSpHJ83dMelzjmyA4qleJE4sUtgF8nLg13Aw9gHHSB25GsZvv5JymN/d50nAHqzkN
         eihaqwHeYXnt/sa6C/LK3wBMMketYjm+ltjU5rlB9I59Ve10ryhdEjMiztBqawNlzvKw
         XwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833818; x=1776438618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5tBWZIfM48yI8RtqbTHFRPEDxWlEomagza0DDkSzOQ=;
        b=RkxzG8kSZgyMgmmjhglN+22X5hkvz2pwJRVI5n1PSz2gYMIs2fKeaqoLMPjkW5bQ2g
         15/HjElldan6Ad6sAhMdlGX8YukfZFgkj45ZpM23Kt2kVdJJa7bhKgQb1TI1jwgylhcS
         EkWI41fLfs4241lL051Zs7lOrrrkR+aeQBD74eAzKO8LVrNCbCW9J/X2oB2Wzpu+oS50
         A9DMxMRci62QmEoZWjrWovIVnAw/efRNXMXTbfFjuYW1F516Wsa0Y7On/RmMbqWSMGp7
         tL1D+MGBomPlDDtH7f17cFo4tLwFgb+S2AhpPH/YPjuq8rklTB9UTxfovE81AVmHcJJ+
         qbOQ==
X-Gm-Message-State: AOJu0Yz4clXLc5n8TxpAwXG5clic+2UsjY5enGsg/JMblCc4DrSpCnJ7
	H9MMgt1whSH63akgN2WWYQKD9Oxe9H+TO/k71utxZ0eo2wS+ixFoVY1M+sMF3Q==
X-Gm-Gg: AeBDietecN8AxYuNwk1RBL9WUP6Y0jRyE/pvK2/05zwJC8U7ITbmyGAvbHaf6uSWxQm
	PlDCnKlx87iepP5092tBoyNGt5K+WSakpjxHVaks30z+3g5e7yjfkvoSVaLdd84WkmQsQvqpUdL
	CMPtp3734EJxKqPFDsRssLGqgMtGX0VHsnTrGtCHRzBBaBygRgCXk0a28ugrYrbB68nVZr1OqNj
	poPO0kNBs88OGMapf8WjKaLQaTY4VEPfA5+PuP4OYNCpliurx1WWFuNdiaE9IUr5VRNsemz8JAE
	ynMUcIA9Orx8v6yLGv0zSMIjfz+x+nw0RXx9Qk/Kk8VorSktSJOC6p0F9nrUS3mHmxD7yAjcNkD
	5RjepKlJdWjM2Be9XYvLNwOGDX+704R7rwMHUi0WD+KkloSl4i+Hw0CAIo8eA7GQHhABe47mj2Z
	bn3FhLbnELkkU+Yrvx9Pk6oSIGzJYr3JmUxZs5sTy1wTYssalpN+j7FsK/r1fHbglw0urVGvXAJ
	6zNKfjg5So=
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr34120995e9.19.1775833817773;
        Fri, 10 Apr 2026 08:10:17 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d684b55fsm22526985e9.26.2026.04.10.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:10:17 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 10/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 16:07:46 +0100
Message-ID: <20260410150745.309076-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern 0x55555555 is used in the VMUFAT system block, so we add it as a magic number here.

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---


diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..7a3ab866ef48 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -54,6 +54,7 @@
 #define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
 #define QNX6_SUPER_MAGIC	0x68191122	/* qnx6 fs detection */
 #define AFS_FS_MAGIC		0x6B414653
+#define VMUFAT_SUPER_MAGIC	0x55555555  /* opening bytes of root */
 
 
 #define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
-- 
2.43.0

