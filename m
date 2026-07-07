Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A727EC7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395978; cv=none; b=NyvgGANNr9wbymnBn3Ehi08KOrQtEz3Kgyx9w6SdAja8Lu/8BlLNTOrctfyn0bRgYe4PyAtlh2bjfVg1WX9t2xFbwVaeT14N1vCUd8xJIUki4a8a7RJlPH9/gAOsUUPIxBAENZv3cv0IejvMR8chOCUvLq6pTeUKYPEYL0gp0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395978; c=relaxed/simple;
	bh=3/wwhEu28nkdVTDD/T5U9vZxv0p8SIblnza4bO+PVno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rfu1w/VdgRQFtDpQD59/5qiFrDK4IZZu+qx55/4RTnpe3c2k92vn+Qn33ZEgPmWi43WU9VCqVObSPOSnvdOIFW1d+bCEEmsNkbWVUfjofiS4IRrjtG+yD2ESEpxjOmHv0WGMjTUAWlZs42i5hfQZBn0S17VkrCRdvKw2T67rK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUKUEzps; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUKUEzps"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so3873962b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783395976; x=1784000776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxoBHu26cugQjl6s+Ybwegp6gdyBHcQpjlaT1Gt5g40=;
        b=AUKUEzpsiYBIVbLhgnYEGc7NA6UPhCae6ujSflNTHOYzY0/PHNsEKrGxgxcPqirj7f
         5Cv/LyD1FYVnfZGCVLop9NZ97Uy/X4aStTFHH6u87R73YtVL7D7hiKlrzjyT9HquD4pD
         3phbx9Jc+uXgTkhJZKqtvJocYo4V/3wzg7Si1O1NMWwhNiakkYeTbB80DmaYfrFG1stn
         CQGImk6ShtFqSNYBetzTwcpXv+98v2NPydMB6M7khzr5UnAttaPfuQ6moZwguiFn754U
         CNsKird+wfMskdthpj4Vl8rjD1AY9t7FIsdTMFDECMW6+ZhtEpFuPFLQc1DK/v8xmCNQ
         l+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783395976; x=1784000776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxoBHu26cugQjl6s+Ybwegp6gdyBHcQpjlaT1Gt5g40=;
        b=cQN620DEUqFaoeNfcm+Av0eNWRGke7Mn3KelGoq2Es848iGJ2IaON2onGd5ULCAQeV
         ve6OUV2h8yZH90CJ4hXrMn/AJbmYcwl0mQ/4oN18giWUzjXHDyITlcSYSyeYHmJLPXJY
         LyC6YlkbOtE0dPfHiNQevnSr6i+x4kNpVzK+zfXfCA3/RJGsyWxQtLFSqS4mbm5Befqm
         wbo9supUnwI0eGp1Ykw2B+LOudXTtz2gl+qbQIe0ij20J3bG1IDESn04+RunQEK5mKym
         /tB/4CEpGXkoE7TwfAeBIY4VxueakVG6jp4UCUKPyHlU1hMgjm0NXI0lKS27tRDqVDNe
         tapw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ/jgmCChQF0eMafRAo+mRD79crs7otBfSpA3j25O4VefjIBcsy7xKqMgecWss3P81H/dUtoNH/+beMImB@vger.kernel.org
X-Gm-Message-State: AOJu0YzWH133RDb12avi0u4uxcuJ3cFIvzS0JG+JywKNy72CFz5zQETv
	6gDnHxIcYJsOSIzOW9rCCYuog2xmeMcaN9TafwhzZPHCjfwcY6yHhYvZ
X-Gm-Gg: AfdE7cnG07Ibdk2mjmPXE0giEbF+OGe5YEtFshEUyBhNXkSFWL9nH1qeepbwzHhfBCN
	zcRAznghmd9Q13yVmjfZ03UUNZZkB7DdSI0c2rHy/i5kY+Mh8ShIRrGSXDO6JC/vIB4/XJGgXIQ
	tJTMsZ4uFRFeMpOZ9OLEZUmesjeApI93LVOmAiVQjR/h0s5zkqSzYj2zMaC1YWJmGH9DVgUIVsl
	LCvrZWcRXzvi+lNkRtpzLRlUYqYTInmRVnfmsV0d4iCZUOY0FeyNTdfh+HhWlBRRt0SjU2rh1Zj
	0Q646C8KSmtCm1hYOpdS5h4SSYo5Ymym6mP2YAcAsmCzLyDVfHvrwaw0YOO3DyTYKaYwUOZeeIJ
	dIApN5P94epIpS1VNNqUC+kgTWwzDlqSXDRzXRwzB2x7ihzx4n46gWZnKq7+X3/8Cj6DexyuI24
	vX47ZGEH+Z
X-Received: by 2002:a05:6a00:951c:b0:848:2f7a:2e5d with SMTP id d2e1a72fcca58-8482f7a378cmr909241b3a.76.1783395975991;
        Mon, 06 Jul 2026 20:46:15 -0700 (PDT)
Received: from localhost ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af6e04fcsm306097a12.4.2026.07.06.20.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 20:46:15 -0700 (PDT)
From: Qian Zuo <zuoqian113@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: gregkh@linuxfoundation.org,
	oleg@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qian Zuo <zuoqian113@gmail.com>
Subject: [PATCH 6.6.y] coredump: fix pidfs file refcount leak in umh_coredump_setup
Date: Tue,  7 Jul 2026 03:46:08 +0000
Message-ID: <20260707034608.912-1-zuoqian113@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backport of upstream commit b5325b2a270f introduced a reference
count leak for pidfs_file.

In the upstream implementation, pidfs_file is declared with
__free(fput), which automatically drops the initial file reference when
leaving the scope. During the backport, the code was rewritten to manage
the file pointer manually, but after a successful replace_fd(),
pidfs_file was simply cleared without dropping the initial reference.

As a result, the pidfs file keeps an extra reference and is never
released after the usermode helper exits, leaving associated objects,
such as struct pid, permanently allocated and triggering kmemleak
reports.

Fix this by explicitly calling fput(pidfs_file) after replace_fd().

Fixes: cdb61a705f5f ("coredump: hand a pidfd to the usermode coredump helper")
Signed-off-by: Qian Zuo <zuoqian113@gmail.com>
---
 fs/coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index d3a4f5dc2..2f1f66f42 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -560,6 +560,7 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 		if (err < 0)
 			goto out_fail;
 
+		fput(pidfs_file);
 		pidfs_file = NULL;
 	}
 
-- 
2.43.0

