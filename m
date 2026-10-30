Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371578;
	b=UhXXgmqb6i5VdH6YBLjjkg+ipkRiUdwxFVayAv2B5r386vPLLOsRoRhei8YJ+xnOR8Ha
	 /svZgvJ0PUzZeJ+BdfAD12o7ww338qN/OakW4CnsftGzX1CjMeHy0L7EETosQF0zZQQAE
	 7edx6zNL0oM+eQ7Iah2aiKhGjN54NLZn8IX6PSNOpWGwKVeBs0luH9mEARV+toeZx/xuv
	 9MX+f+zBKv4AysItbVeTt8QdxCL7PqLhVzIjhr1osZO22NRCI+K3jLpuTI06TZ/GIROqO
	 dEBC0yX17WYvTzOSGhf1hUBfB+3EdAiewdLjfI1rTnfGO5KBrA0DUp2lYIsV0lmt45Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tDfFuK4DV2rycFo6z7Q9L1F34BxLwMu6adMyDScYC/4=;
	b=WtHmZ8TTmKtFxvRrOFLLvbPYBS4pdeP0TJRrzRyAZNxaRgsyivZ/agd9dcSpJArcuerD
	 xc43i/lKo3eVLpkfXz8NIgwcCONfIp6wI3v9bUUnAwGfZJk3meiHvENQGj6aX7JpdDnF/
	 pfUzQi9eMs/Nfs+pOVUftNWaP4JlPFzn6Faer5KAHF2JRLf3FiGl0q+JhSb8tKC5o5VU4
	 HrCrHLITaBotCzzY9ByG3dVxhH2CLN8i/kyNm+XhKEiOWyczppgo0oxjRlqVeP0sNY7Jo
	 nOQRK/WDi9gr711vVm/mT5Kk3vqVE3j0PBAwinVcqXoRKsDSd0wKyZP1mXsmWJOMhTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=O4WW95Se;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B8606A332
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50B8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=O4WW95Se
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e6eb77f0bso72842385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371577; x=1793976377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDfFuK4DV2rycFo6z7Q9L1F34BxLwMu6adMyDScYC/4=;
        b=O4WW95SevmpjHHb5XiB0io5AtbbZDYbaVZJ606c0n9XTJRdScukJQsuZM5S2fbDwIl
         yBeQEuBfvt9oo3tch1Pjx7Saje6imj9r0arZFN/b4XV8PrzsjTqLYvZHXaL3vCD4jpNP
         2u3i4MXzrXBO5KpfxD+X610uRiyzOQ8sGuNY0XcCEpjMHqtjGiJPkjUNAdeQrQZ5E33L
         wv2zVwF2cEQ2VtdWybyRbJ7RjwcybPbwNm+FSDd7op4/tmluQhi9pngp3vg0E0mVZ5Sv
         mO5GxHPsbj4QerIXp/NkntAhaZD8Wbk207JvtdPmQp9DGDKcFYCYeGk4sqMPA8bY/yqD
         fz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371577; x=1793976377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDfFuK4DV2rycFo6z7Q9L1F34BxLwMu6adMyDScYC/4=;
        b=GNg3XofxAMpuTs8pcqn1A9f8eZ6QdFvNnH9rJ3YCZrfUhpqN0M13aNDFG1KSfOZ6Ho
         VBUXCgQiaojgsy6X9Hyz8xcF7vhuLOXKHhsWoyy/yHPXSz8DbYesafI/j1ETbdpGXJir
         PX9ZoUKzhWDJk+s42A1Y0tj9ClOQROAXxravXoItxoC5S68SV95571NRJGJboyr/d45r
         nXjuMxUNAvPdr1xFYPYebKNmeEbfLLYSqUiPo10Ya7WS5PRdbqGMjWTrmIwER1UcXwSh
         wZj1dXDSCDD+sCFybR2v3FLzAES8Qpgi0EEuZlQN9Olyq3bhRI0fDuCUq4NRbWvesFwU
         KyVA==
X-Forwarded-Encrypted: i=1; AKwUvBzZvsRLD6cg4jEq6CYCphMCkS1H8t7P37jsLluj1EPdq05EQ1k6zGFYIKO7pqzF+xQg3y20g04N94xtHzJ1@vger.kernel.org
X-Gm-Message-State: AFq9FYK5NlU+52ID1m0KAIS6kTbC6EQfiHLAx26tBOpyOrfZsh9p0Fww
	TY5JZXJpmv/4j9kA40AA8tD26SKDhCsVaFgVg3bz/01ZMgjPxy4PaH7tKW5nc51OIGw=
X-Gm-Gg: AYBFou2XW9/nL+5KRq4knPgiPxsjvX8ZfGRmr14i7uA7N4IlLFKdq5BfXud2IrvdwTC
	s9rULktZ5SY8fLPDUoL7/ZpIu+3k6r8NlCNxIFdIybfwTySIi0/Kwft6Zd3Y9Xv5SJOWxIr/MMT
	9YVsiYt0Qm9j3/CiXta20HvNtgJHkO2uk8nEuEDYXOSEG5advuJBXgsTaIoMjRaBIYCCx7Evex0
	ZwIlLdxsXxd0GOa37vawJOax3eaLz89AHVWF0Ek3syP1BtFp8wAJFEa52TZJty4oq51VpDq2bA7
	XUumJBd1gjDT3xSXsN/vYksckchwPkvduHyWYslordoxdga4LeZMb4ZF+nLgslMtFA5+skOXZ3w
	e0lme5fuxCn83MrnwWrnMRhrVtml+rSBCRXXIQrW5rs1OWKBzjAFvYqeBWrat9usmmy/RkwRLD2
	iVoyUzeqwe+HOciLegf7gfZXFVehPFPeja0E5EzQPlgqmguBamszqxDSCsZmItExsOGsJB9XEbC
	hXxpw6xmBcTWJO+VGdPrjAI0Wm9ScpuVNe0femtN3NsFgwwcsaGgzHGcbxG0Ksoeh4t4XaXUMZl
	LEJJHfvQHjgbg3OUvxMeZXUIY+lRqebpAztaDRyxC+wB
X-Received: by 2002:a05:620a:84c4:b0:93f:1ed3:a9d7 with SMTP id af79cd13be357-94421719099mr396848385a.27.1793371576775;
        Fri, 30 Oct 2026 07:46:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2ddsm158514785a.11.2026.10.30.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:46:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 30 Oct 2026 14:46:05 +0000
Subject: [PATCH 2/2] binfmt_elf: don't leave the alignment probe mapped
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
Message-Id: <20261030-b4-binfmt-elf-trim-v1-2-dbd8683bccf9@toxicpanda.com>
References: <20261030-b4-binfmt-elf-trim-v1-0-dbd8683bccf9@toxicpanda.com>
In-Reply-To: <20261030-b4-binfmt-elf-trim-v1-0-dbd8683bccf9@toxicpanda.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371570; l=1210;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=X/ASOFjcZWFCPphxCek+/PZuE8QILdbqMeZPQM3mC6s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIGjAMucuuZ7Y3nPwVmOqkc31/+E3a6jL83u12VI2pAeoRBg/AeoxSja/iLAsGBUefnVDd5aaFp
 WOqPTZ57jWg4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A static PIE whose segments ask for more than page alignment can be started
with a stray mapping of its first segment in its address space.

load_elf_binary() maps such an image once to find a large enough address
range and unmaps it again, dropping the result of vm_munmap(). That unmap
can fail, and MAP_FIXED_NOREPLACE only notices what was left behind if the
first segment overlaps it. This was found by reading the code and was not
reproduced.

Fix by failing the exec if the probe can't be unmapped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/binfmt_elf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bf0d4df16ae1..6df0a6d979fa 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1171,7 +1171,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 							 PTR_ERR((void*)load_bias) : -EINVAL;
 						goto out_free_dentry;
 					}
-					vm_munmap(load_bias, total_size);
+					retval = vm_munmap(load_bias, total_size);
+					if (retval)
+						goto out_free_dentry;
 					/* Adjust alignment as requested. */
 					if (alignment)
 						load_bias &= ~(alignment - 1);

-- 
2.55.0

