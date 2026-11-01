Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512857;
	b=zcPFYzSEWGXaDNzRXeMU+lLDLIp0HxbTaj5wsOTlbeQ2x7pqA77gP9jc/RFpn1fDspeU
	 rmsa+n39Ln+ZdJqgHLwskNNuaAYd+yLscBlgeH+hcYXzEX2zqATbNlQTrxXovP/BL4Jmn
	 5PMlCSB182N90u5v15XF1XnLeSTvi4nGRpQQLMR1LRZYPgTgCT04H8QxwfFaFLXm+5158
	 sAjNzNYTePYtklPjH9+J0p97vhk/ViEQlrRScRnLvz3Q3DdDQKPNx81zG4DNDQFDZIySd
	 BZHjPBeI93MAAdEDUorWlFQzAbDgc7tLy9LVqEOsDwUNY7tPDXHahfQx951VQPEc20A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ngY1AM6TCdnkDJjcM9h3JQmf4MV5UDS4/IP95R3sI9o=;
	b=RyxLDOCFCucuOkfox68GbwQj3kfddtnbbdN2gLiJd/jEBkVF1ng02sjqeRberUFRdTAv
	 WbF1+6eyYKNNrpFH1/Zu4uNVCtlKgfJvKdX2GVMGKV19Gyi35Qn92PnWWZPa58gKQ6+yF
	 ogpdRp6k99LaZvSLpMNsDgfWB2uRQSmrP5y7MVbjnm5pfjRVX3I3talSRTJ1GZwn2nfJU
	 Rk9wo0tJtntJJAigQMQksTefqx8O0uzVC49BMTuPeqovLOWDHk9CNyP9uYgXHsKglKX/x
	 nE1tpspMqBHj/XH1zZ2nrIpFEMH2256YvK8oOJq0+wi9cMJm+G31ZvGxtbPXWXMPPAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6TlEyIR;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5860A260B
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 06:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB5860A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6TlEyIR
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so994626b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512856; x=1794117656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ngY1AM6TCdnkDJjcM9h3JQmf4MV5UDS4/IP95R3sI9o=;
        b=D6TlEyIRqGM2XAa23eofqa3q7Lo42j8/q3/nekB+0rPA2aWfq3E2pS3PvCv/7D6EBu
         S6AgjhWGbLPIRVbx7+1FVYZ9hubuBUKsMAco96wsAQPMNfdTM2bo+DEgPAiDieJK2ZNs
         GcfNf6pNekEq5A4ziv0n+xlKEiyaFPQBK4myysj6qKO7U0MbXfcLldi7DsnlGNUJU7VR
         ZptS1L3RVIHPQg1cvJGjqhIUiw9DKPPcc3XHPWcDe0/vD1j+7vKU411IqMgPFeC91tmd
         muwaxvoHFiXjhuVeUVx6UOtS89ab9JYVEcwSYnRpxxgGREivo82kZuuP6QCLMylsN6k/
         J2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512856; x=1794117656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ngY1AM6TCdnkDJjcM9h3JQmf4MV5UDS4/IP95R3sI9o=;
        b=QsWVPi2CStCH8+eAr7mdy60KXfL0MqCA/K9Q2+ZExGCLBlXr2VXkEHN1N+ZRlcl+Gf
         Zb0HMW+s8mGgfnt3uVCb60U60AHcUqoIo4Pgin5OdA+VI9VHVTALhGkZXmrr/JYR1W9w
         3o0jF6lQMiNNZLMboJ/RxU55ulKey9ChJLIHQ6+bAut5O8ED0B63pi2oDOWUVIJm2qE0
         scCChKy7IY8ywaG7THp5NQMZ0LhV9suhr17dZWb6YRiDTSvadOMXRTyFNF5+Y+413B37
         5DhvPj7R2q5Om9JjIcoR8BDOPTFSRJUM7LODuvKBx7zcQi/kZlF2UNHpBKiPEdaFLz85
         QiLw==
X-Forwarded-Encrypted: i=1; AKwUvBxha/BS5H0IGboINgIaQtEN383XVPv2SddotQ6rIm1kfgkstmoT8AOshmLSD21/0rjL6u8JJNJBbbJTjqGi@vger.kernel.org
X-Gm-Message-State: AFq9FYIOTSqJo02VBA7y7gwkK34DgxkfEoEIAaIHjtmQpwMKPmUy0sP+
	kSEKfTm7txSCguDucfYGn3u68+7VwqvO32RtG5vuTngnsu4f1K8eo+HE
X-Gm-Gg: AYBFou0vtqL3A/Bm0JnRsP24d3Li4CkHJeb4hyhF0wrNlDnpMA2jKOje18BLOHJO0j2
	RMPX+L1i2Io54FI2+bOIjPbrSuSHfGURzSX010FEfahCA7DnjXFjX009aMGbB4T7JLZByHrOe+9
	HA11G+x0eWhljP5QT1FP24CjzmQWmd28rzGA2eL6MLLgsca1m35YAbIgMYvgoQkUEBjMtvFH+d5
	tO2HejZNr8b1GJBEJlq6iMYuwShZ9gcoABxq8zt2zJ+wvZ4dq6R1j2a7vuoz9taexfbMqXXisFw
	3I7WBTFfe89x/DHQfrlF4QlBnPpfjak13qTq0hvqMf/a+9sh0UT3yWQBHUkV2GIEwpNtcGZ/Bi8
	8t0e6tZ8hfA+KCYORlvTGhsdDehnab41UYhvmsk9fD2Co1dQ+07DV/mVb1CgaZAxRWtnRXGcn2J
	cKiRkLl9zJ9FWK+8PYnZ82OUgdtQpqHSjVkx9TJ3V+OqIV/EdWz7Y+6oSTuPUEwIBfCcfVdJZMn
	+lwC60vz95N3ZDMs3n0VtFnjwlBZnDW0PbOUrbBdsnfDEdvbkR/FdARsnbPUeKLrWSoAd/H+fz6
	saH1XV0Ke9zfgi2UDHWHODPZPRH0/yxsQtk5wvtSy2aqP1XSYNocDiJQJn64lMnxpRtPWkfb5dL
	JMpyhSLrInxVTt+aXt7wBifo4wHxdWfBf4hTM8r4gwIrSFzhnfoLyPMJ2P8by0JyD8xgBTJzfq0
	pS2nhV2xb9Rlo=
X-Received: by 2002:a05:6a00:84a:b0:8a0:602d:3d27 with SMTP id d2e1a72fcca58-8a8317ddce4mr6059821b3a.14.1793512856045;
        Sat, 31 Oct 2026 23:00:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:9201:5fb0:4dc4:c510:e576:213e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d067cesm1062706b3a.29.2026.10.31.23.00.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:00:55 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v1 2/2] fs: use must_set_pos() in default_llseek()
Date: Sat, 31 Oct 2026 23:00:49 -0700
Message-ID: <20261101060049.81441-3-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261101060049.81441-1-sidchintamaneni@gmail.com>
References: <20261101060049.81441-1-sidchintamaneni@gmail.com>
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

default_llseek() open-codes the same whence switch for SEEK_END,
SEEK_CUR, SEEK_DATA, and SEEK_HOLE that must_set_pos() already implements
for generic_file_llseek_size() and generic_llseek_cookie().

Replace the open-coded switch (whence) block in default_llseek() with a
call to must_set_pos(file, &offset, whence, i_size_read(inode)).

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 fs/read_write.c | 50 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 86ce8cea10d7..b15522cf96cd 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -333,47 +333,25 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
 	loff_t retval;
-	loff_t eof;
+	int ret;
 
 	retval = inode_lock_killable(inode);
 	if (retval)
 		return retval;
-	eof = i_size_read(inode);
-	switch (whence) {
-		case SEEK_END:
-			offset += eof;
-			break;
-		case SEEK_CUR:
-			if (offset == 0) {
-				retval = file->f_pos;
-				goto out;
-			}
-			offset += file->f_pos;
-			break;
-		case SEEK_DATA:
-			/*
-			 * In the generic case the entire file is data, so as
-			 * long as offset isn't at the end of the file then the
-			 * offset is data.
-			 */
-			if ((unsigned long long)offset >= eof) {
-				retval = -ENXIO;
-				goto out;
-			}
-			break;
-		case SEEK_HOLE:
-			/*
-			 * There is a virtual hole at the end of the file, so
-			 * as long as offset isn't i_size or larger, return
-			 * i_size.
-			 */
-			if ((unsigned long long)offset >= eof) {
-				retval = -ENXIO;
-				goto out;
-			}
-			offset = eof;
-			break;
+
+	ret = must_set_pos(file, &offset, whence, i_size_read(inode));
+	if (ret < 0) {
+		retval = ret;
+		goto out;
+	}
+	if (ret == 0) {
+		retval = offset;
+		goto out;
 	}
+
+	if (whence == SEEK_CUR)
+		offset += file->f_pos;
+
 	retval = -EINVAL;
 	if (offset >= 0 || unsigned_offsets(file)) {
 		if (offset != file->f_pos)
-- 
2.50.1 (Apple Git-155)

