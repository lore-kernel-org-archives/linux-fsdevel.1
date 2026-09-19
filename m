Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577973D9537
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820962; cv=none; b=TLX9dCpjls5EhvkcxEVBe8aHoLFM2EKUljfPMh7l6i119YBn+834DxIs9JOZ/EiGobHTnqeCJupyzd3qVdQ1Uoi/DKkYTRys+QjoJsGchhAR5T662BBxB0E9cToDbSuXmEmiN5lkcrF2jgJLTnZ8GNd0zFWgRqpyghNTqHB8UGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820962; c=relaxed/simple;
	bh=FhGfaaadKfzqjzMrtMZhUZWMDMTEWbLfalyZGog9s6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc/4trVyFMzQoi4AtceeTp2dE8g6ErVSNtPC2DFW3Z7DFlbjU8egaf1gtCZypB/agF0CcCuXgA40m9Ac7ypBGuUg9iuAxFgnakfo9hU8/eiPS8lqtKB/pRinrEdjoxH/zGZ+JYp4aQOEBmAQn+RYmtJEddLPFih1TRQa0KoNNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmMpPVn+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmMpPVn+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so15020225ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789820961; x=1790425761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPC4j42sEiqe2ttq3KiBybhSYel2jntiYfyU4eCdyfk=;
        b=WmMpPVn+Tsy63lN3cuByXt7Hf86Zpif1GySU492uFRiydzb1NZU7c3/Z9HEtEE/v4N
         nSLVDBVhImQiOLM20iyZFCbVMXeuD34mz5nEXGdn83WVvJb6pJr6LV/XCTYOJegRg2Mz
         quFeA5wG1uKrTKWwOtHysu54P8p5HmmYYr1g/rJuX1GwwqnmJcklseS9+TnRKkewwAqK
         SwDBzqVf1UqDzNRgtQK8cKRIOiG4lUxSN4bzbNya+OG4EvBb/p03dXJ7GauL22GS+Uhq
         WaGxk/PF87Gl5nOEUeynDUJ7/eK+SPYuK9yCTYB59sDS6IE0Iu+PRh7fDJL1BCA8ds+x
         2+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789820961; x=1790425761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPC4j42sEiqe2ttq3KiBybhSYel2jntiYfyU4eCdyfk=;
        b=GM7esMIJybFrZ+mZSVyJ0zAReuNuY/sELC2fMg9kfb1VFDlB2JBwffjB2QYQUo6beN
         RNmA1voH+UqSLz+Vzq4ZkMfyOQ9b9WnwJd7vNirw4CFnQ2lCMh8AxSx2VuiVEeUU5SM6
         qyFmzzFXcDNkYmD+Mz3azWkzht7u7SOG9LdrOQOdXH0K+eIbDax0YVsDD1q+FSVwPKRa
         QJsIAPynblO5LhJ8dBTW1fbtvjJx5vO3DkZgSMAUzRu5f03QtIuhIYvC27g2/8e1UyeY
         kZZmYvmW1TbICJkarRwrpixlgu2cK47XajCNT9y9yH06/Zd+6uMAOySIGxfOfxBXjhwf
         tIZg==
X-Forwarded-Encrypted: i=1; AKwUvBytYz1gcjJET24/hXqUOzkffamnOvi3SGZl1QvD4G2YL2l0ge0eKs6thpv0IWAhe7QZRDg+IyTqqe28zwzY@vger.kernel.org
X-Gm-Message-State: AFuF++klTIOAsUPy+qOd92frNl/V+bFqeyTifuJ9fOsuq8nwqziwBu2X
	qDd+KyGsNQzhHF5rtkabqdjMyQZOo1IBd4K3htbMaYZvSns7j/HfzqiU
X-Gm-Gg: AYBFou02QMITsg5cw7B5lnY866Izb77nuok27WxnyxVStXPNqp5Ba5wYeANW3LlGcVP
	8Py+6JnZIfitUqKxPpy7bqWq5VvHnqfOZFR2wXZ2rZRUOqz728rsCzFFuuWKi241KztPzoDJKCz
	FBJXEC7M1/Bqi0RmJnuLyFiKt+vA43nYB+H2AWxSThRcEKROJIRmxh4WbH1glLOY/NoecGIj+na
	3nWg//INsO6UIgch6ZQIoYWtGbo8pLoQ7mwSxWo0euuByrl4MM98FRnCdSJbUZSvvXqSh5H08fj
	TiiX6lVYEhxqKG9uJlLdkaZ3a7K55Is46cp/Zsg8TUW2jBWE4V0ta8SMvZwcmGKL2/VjnMx7pcC
	PQ25jadaE+siPpp1pqggDYZknzMYCMpbwoRtXGswICiBjBGbVV18IVR1jFtf63st4Wib4HG7FnU
	DxgzXNdZ1ai3MfBVcW7S2oVmDjmUhUeRCcYP44PKO1aXQ8CaKsXALO0u7/zQi9jAzNdElCbu+xB
	5zkJbM=
X-Received: by 2002:a17:902:d4c2:b0:2d8:de9f:9a44 with SMTP id d9443c01a7336-2ddb1c15766mr80621275ad.19.1789820960541;
        Sat, 19 Sep 2026 05:29:20 -0700 (PDT)
Received: from RyzenBox.localdomain ([137.59.96.253])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm5978411eec.25.2026.09.19.05.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:29:20 -0700 (PDT)
From: Omkar Chandorkar <omkar0926@gmail.com>
X-Google-Original-From: Omkar Chandorkar <gotenksIN@aospa.co>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Namjae Jeon <linkinjeon@samba.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Omkar Chandorkar <gotenksIN@aospa.co>
Subject: [PATCH v1 1/3] smb: compress: relax trailing flags in chained decompression
Date: Sat, 19 Sep 2026 17:59:08 +0530
Message-ID: <20260919122910.2382-2-gotenksIN@aospa.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919122910.2382-1-gotenksIN@aospa.co>
References: <20260919122910.2382-1-gotenksIN@aospa.co>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In SMB 3.1.1, clients such as Windows 11 send chained compressed
write requests containing multiple payload segments (for example,
None + Pattern_V1) when transferring zero-heavy or compressible
files.

According to MS-SMB2 section 2.2.42.2.1, the first payload header in
a chained compression transform MUST have SMB2_COMPRESSION_FLAG_CHAINED
(0x0001) set. Trailing payload headers in the chain correspond to
subsequent payloads, where the specification defines
SMB2_COMPRESSION_FLAG_NONE (0x0000).

However, Windows clients do not always explicitly zero the 16-bit
Flags field on subsequent payload headers during chunk construction
(as described in MS-SMB2 section 3.1.4.4 step 2), leaving residual
bits in the Flags field.

smb_decompress_chained() currently enforces:
    (!first && flags != cpu_to_le16(SMB2_COMPRESSION_FLAG_NONE))
returning -EINVAL if any trailing payload has non-zero flags. When
this occurs during large file writes (such as copying VHDX files),
ksmbd breaks the connection receive loop and abruptly terminates
the TCP connection with ECONNRESET (-104), causing Windows clients to
fail with error 0x8007003B (ERROR_UNEXP_NET_ERR).

Fix this by relaxing the flags requirement on trailing payloads in
smb_decompress_chained(). Conforming chains still strictly require
SMB2_COMPRESSION_FLAG_CHAINED on the first payload header, but for
subsequent payloads, only reject headers that attempt to initiate an
invalid nested chain (SMB2_COMPRESSION_FLAG_CHAINED). All payload
lengths, decompression algorithms, and total uncompressed output sizes
continue to be strictly validated against the transform's
OriginalCompressedSegmentSize.

Assisted-by: OpenCode:gpt-6-astra
Signed-off-by: Omkar Chandorkar <gotenksIN@aospa.co>
---
 fs/smb/common/compress/compress.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/smb/common/compress/compress.c b/fs/smb/common/compress/compress.c
index a4123c8f1..434743005 100644
--- a/fs/smb/common/compress/compress.c
+++ b/fs/smb/common/compress/compress.c
@@ -130,12 +130,19 @@ static int smb_decompress_chained(__le16 alg, bool allow_chained,
 		len = le32_to_cpu(payload->Length);
 
 		/*
-		 * CHAINED marks only the first payload. Requiring NONE on every
-		 * later payload rejects ambiguous or independently chained data.
+		 * The first payload header MUST specify SMB2_COMPRESSION_FLAG_CHAINED.
+		 * Subsequent payload headers in a conforming chain should carry
+		 * SMB2_COMPRESSION_FLAG_NONE, but clients (such as Windows) may omit
+		 * zeroing the flags field for trailing segments. Do not reject
+		 * valid payloads as long as they do not initiate an unhandled nested chain.
 		 */
-		if ((first && flags != cpu_to_le16(SMB2_COMPRESSION_FLAG_CHAINED)) ||
-		    (!first && flags != cpu_to_le16(SMB2_COMPRESSION_FLAG_NONE)))
-			return -EINVAL;
+		if (first) {
+			if (flags != cpu_to_le16(SMB2_COMPRESSION_FLAG_CHAINED))
+				return -EINVAL;
+		} else {
+			if (flags == cpu_to_le16(SMB2_COMPRESSION_FLAG_CHAINED))
+				return -EINVAL;
+		}
 
 		src += SMB2_COMPRESSION_PAYLOAD_BASE_LEN;
 		remaining -= SMB2_COMPRESSION_PAYLOAD_BASE_LEN;
-- 
2.55.0

