Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979904;
	b=Xszt5it+C/GFHTXewQls/itcvXu2qjYv9bUO2/UlUct/v58QmA4jK/e6X3QZ0Fo31Z2V
	 ls2U5Ax093/JTqeY6L5qhxIcjSPZORuefyl1V5CrQ+4mI2DPGpyzZXmpoSyerL1fOQ6bN
	 gddGmqNetGh8fMt9ncoazE6cubeVtHx0z1cacYDfKgLroyIoyxD6Nhmq+/hN5T0t6uo5F
	 uLyH19sC+lBBhRcmtFMQvjrFcNKukdoB8cFHiA7cVZPg7ntiJsxJ4ZayBX7NcrPftjVJF
	 PE0osaMjSn0F16rNuUr4ZKNPh2AYMBBD/e3k+Ns1wlycrBCYnl+S17Uo0ihzNKum7+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OJzaqNYQam3G1mnM1dtOnV/6df3rTe3VoR8V9wQk5ak=;
	b=TvlvBBJF+mJREBVJUOUdx7RJqOUa8thS11fz8rGmqHbaU+kIWzOQau9f7Q3Pya7GPRAL
	 JIaHA1jEo5M6ptGdxOd+2vJuDmsHz5lk/T93ah0Vo/0DmLulw+y9Xo95BGP5nOKD9mvRl
	 sinzUMd/t7utKlitb7+U72KhlOuKnz3vZKutnHbmsuFXrDXI952joas1xWGTGzHVlMxVw
	 wgdY9sSFgMTreMLoymnMqKHnoY9DbDdJTDZy+RYXGmxPxR1wVA16/r6aJ261AZFqvr6Ic
	 ebKsWGEefUejjjfqmfGRc3yMsaU0le72zqRP9G9UFz6IuYefTXxV2R0BEFTlO+t3w3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BVNzoBqP;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A8606A31D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 01:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 704A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BVNzoBqP
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-369fd8abd71so571721eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979903; x=1793584703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJzaqNYQam3G1mnM1dtOnV/6df3rTe3VoR8V9wQk5ak=;
        b=BVNzoBqP3fDN0Homwj5TbELiXSBF/6BGiC6AumkF+bgVwlaskN1zSKmD2txEKEN8ZE
         TJlflk6uKjqJ0VPFqleroermHqpa994qUManfiByxpJ2zSnlZDCGpfCA9NvceUe8qaG6
         Src3Sb9aC/IA6n99PLVg9DPxabxPsizmLIUhuuMBw2EqWag+RKLa5CxAVVdnIwe2DAHd
         /bGQOWyx7BOPkW91+aAxpKguys3il2O5BEtwZZzm9vkzu8dflLPEOIzDRTa6YVOT6PmC
         ScSI/RJ8ziFeeD1Zy4LIBMDxlYpnjFR25S6qFfGzfg4X7Vj2NOC16HQAwNLOwCIKjXyJ
         6ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979903; x=1793584703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJzaqNYQam3G1mnM1dtOnV/6df3rTe3VoR8V9wQk5ak=;
        b=EuTTahSG0I9a+2gURnzcy5Ak3Aek2ok98Xg03FIXX2mQuv9rYLBVr2BXbgNfML74ov
         J7zi77eekj4+sGb7HBo5CwIYdCe65m0xhfthDYqRfZt/iFe4G7pD/Jra0kj5K18ARehZ
         2HUofeQZUAXdBIx11DO+xSZig4wQSQEB0e7w7bqOQYFaH4/evsLTmWTiouVER1qUne3p
         qud42T8KjutQSSIetQRBJhMl1giOcEupLf5WAo5JQ90UIx2poGypc9G9WWr7VGGdD/6F
         0fFxs/W5Iw6S/SOqCtMIIS3KeYO4p9LnU04L2yWukCL6T+1nw0ZAAk6PbWtOijapn060
         47fw==
X-Forwarded-Encrypted: i=1; AKwUvByyyQ5QylJgRVOwBEgPQEiPrXXxzwi6h9dGjbQyXRNvUzT9Yg0IdLAGN9T9bNT8T0skkF/hzkgcCQBHL40z@vger.kernel.org
X-Gm-Message-State: AFq9FYL4g8KLVX/GA9FD+gnemG4Rk2OE7arOLow2oToVMhm4VYNmDS48
	2thVOkCX9dhP3ynq9Y8TQ6GG6EUQQrvCmQ0bFEmSR3r6BGctS4uHIuUp
X-Gm-Gg: AYBFou1vbzSlKc/h7CiS6h0TjX5rgBMmWoiir34Ti/RBiWGj4CRwij78QhhO4j37w0S
	TNDsRLeTaR+UOo9FNWqb+E71PeT3izzLP/CEoWFMBQAMlJAv3/SS35/CRXjVHp9gs+GtR4Jalqk
	ETFHtxG50Y+2nweKrn8noR1D8+Ejca1SAb+ioE5i13UIBb0Oy1CMYMEnMW8h20/Q1ubCSKkDT9Y
	/+N6VVw2ZGsLpfd/GCK7RZmI1VhsetP2bHzJTgsg7iVfclnO5uC1Sq+7rt8DraRRuU1O1Y0Ixwd
	DAOnbLwZuh/nxZux6vVu4SjcX8uhG6+j704qh63P/WtA2sMn9wVTb/C8xUNIEVMqINBwWl5J+tP
	gBYWXiW/sXwwJrWnOJzfluYsbR4YIWZS8p/bVxjSGVQoclRgsESrAGUMu2AWjPStHzOmiUcFgwh
	Eb8cGhEKf4LhMa10rTseZv9CHkVr+AeFknG87ZEJec8rXImS8Y0QnMLcQH5yUEwHAwhN3nwPY3L
	l3wG2hTKtKK0HGJTVHRgwPs3Dmn/U9HwkFVwVVU9FZLxW65CLLZ5bVCIll1xQYuren/4b5c2O7z
	2wZiipk=
X-Received: by 2002:a05:7022:ea48:20b0:183:3140:3ac1 with SMTP id a92af1059eb24-1a0ca49ad43mr2284534c88.24.1792979903481;
        Sun, 25 Oct 2026 18:58:23 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm21301850c88.9.2026.10.25.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:58:23 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	djwong@kernel.org,
	amir73il@gmail.com,
	dchinner@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] fs: skip copy_file_range write limits when there is no data
Date: Mon, 26 Oct 2026 01:57:38 +0000
Message-ID: <20261026015738.46230-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

generic_copy_file_checks() reduces count to zero for a source offset at
or beyond EOF, but still checks the destination write limits. If pos_out
is at RLIMIT_FSIZE, this sends SIGXFSZ and returns -EFBIG even though
there is no data to write.

For example, GNU cat copying a 1024-byte regular file to another regular
file with RLIMIT_FSIZE=1024 copies all bytes and is then killed by its
next copy_file_range() call at EOF. A zero-length request can fail in
the same way.

Check write limits only when count is nonzero, as the ordinary write
checks already do. Keep the other copy validation in place.

Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4da846a2bf17..c05ad2c42e75 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1531,9 +1531,11 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	else
 		count = min(count, size_in - (uint64_t)pos_in);
 
-	ret = generic_write_check_limits(file_out, pos_out, &count);
-	if (ret)
-		return ret;
+	if (count) {
+		ret = generic_write_check_limits(file_out, pos_out, &count);
+		if (ret)
+			return ret;
+	}
 
 	/* Don't allow overlapped copying within the same file. */
 	if (inode_in == inode_out &&
-- 
2.43.0

