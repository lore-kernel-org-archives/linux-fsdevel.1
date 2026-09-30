Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2445C6EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756397; cv=none; b=Rzo0Fz+LYTog1W+95rCg07HzVvTiIXI5ac3cJ1ZLaZXMnptdSnCr3wOKTzat2ZSkMutSVbFpqnh+Cqz+zWDTL/B4tW8GVElQS1lvhC3RckAn2u5QRc1laaGr1pCho2FWBy0inQvhYNNLMcKBdHfSPwPpRi7luzq8RZvgKd+O+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756397; c=relaxed/simple;
	bh=LaUvIFoIJ5fl7EpL9XnQaz+5PrNsgxLnKPzAypfXK48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRnIHOJBzvAsJAq3DGYOy0XQ0OnhIJmYqC311eP+AM3xdi20hWVEsgABaPullioWFPDs39pKfpKFJlv5EH2G9cz1P2Szo0XlIFEYNUnYiAK9u6+uquFItSBIg+p0kcabzsTnwTOX6SMr9Msij1b/M7QbcMfXOXH5miHjd/oxOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIe2fKEg; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIe2fKEg"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-886a5cb66beso326177b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756392; x=1791361192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JaC0ZBcECLxCHu+CEPU7/n3TtHSKBoI07cb0c9RX1Xg=;
        b=fIe2fKEgK0Mm0Tyr9hvxN7Ozey11vGvdLAFfw0KZrbHY3cNecroXZFCGufUeISgml6
         t4oQHxTc4gy6xKPCpqPDL0aA+OMSFYXxLp6KAADq2dE/QOsGJw4AXxY3Q5NjCbcPtCur
         8Mcg6FYhqEXKwxoFB0Et/tSNstBNa7jHjCuYrju0gVaVpmiDQsBUVtJPN0XErkPcbaA5
         AZiA0qi/WWpqGCWNVrQXtOkIXsMMN70kvcdlplJkw2eLMNmJW2OpDndJxsq+lwPR1YfH
         41acTqm9PAagOOXz7QRImr6JB9bjAJaSNMbrS7iNYHG6J9lTNRYp8t5TORJqwXfy3dNH
         lsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756392; x=1791361192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaC0ZBcECLxCHu+CEPU7/n3TtHSKBoI07cb0c9RX1Xg=;
        b=qgQvKWOQ/WqNjDCTg3BW4dKSVcq2uJ4xDj1sZFpxA+R7w6c3Y1jfZ7oNqsXmd17NEa
         AOQzTkNra1TYVLKUt5xV8kWbvVgCowl/o7O4jwnEtPsWKr96aaIsz4rw1dB6zGnyuyjt
         GteVNVXB//l1l4076u7XkeIpFsmpjAHpc7LCCcrxWdfkUHnFX3hSGBNbRdiG2b7+n2cg
         tiAWvLUkEfqLFJIR7LU9OG6o/xl3ln/ywFfVuWy47kMeOYl3pzU+yotY+iXBRXgzP3kR
         6OFc8uDZ6Nn422H4fduL+p3SrxiJrOOOo3xeWgINWp8sy5JW4w3hoh3HjjVT19KdWWr+
         fsjw==
X-Gm-Message-State: AFuF++mQ70QUX6t5vA4wWlFx0YO08sPSY8smbU9L9/csaKfpQwvVWmtG
	XjYitJRRMbrLy+hLcXUIJ2mW5rLFaIdklKBuSNZNPtKfi7qPPMJm866D
X-Gm-Gg: AYBFou3d4uwsIg845ScRnMkJUW83+yfHloC+K+0O5DcJjdW2cE8Rll1lfevXf3lynwe
	oqN0jgGrIpBXy1Xxy6EMcFJbLmtAnKZ1YeiW3Sjt/kNTr4jSUAnHkNJkKClGxGo7mKFJvkizamV
	GhcojtsHi9coPiZkMaLfFQEMsynz9tlVyrBjW26LZveLSlFh9tsRiX/yEyYg2R7ihxh6oACWh59
	wN1/aB0Qo5PEX+ZGMmS5tMRbQ/YjplihWcWxfxfuP2MvQjRT0iFQXcpFcP89C+ZAp9AtLrYiWP/
	xkAETOBR1ORDiU+YlaYeETEo0HNE962hpoXbNP5ozvtR+jJDqx/um6fgeAdE8QvbVvC02dtfNWQ
	0iw/9KB2Sj4CDz+nM71DwiG95ws2bEM5TaBwOFCVxkuUCoPzmBB1gc9jrJVgElYXzhw22GXoacy
	8Nwy1KoZN3OwjSckouD4tKbAPWj4rS6/tcff6v3TKxdCJWxMUDoPXttcOpv4YyW00ayrTrbYyLC
	Ywy1hVMzqr5C3nHrOKfmVMp7ItU5FECS2fusPUcv7gsIgqdq5FAG6TulJ5vUiPrW9+Yu4i4amFr
	Ch+IXCefqQ==
X-Received: by 2002:a05:6a21:820b:b0:3d2:2011:d184 with SMTP id adf61e73a8af0-3de9e7ab1a7mr693074637.14.1790756391632;
        Wed, 30 Sep 2026 01:19:51 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:51 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 3/6] qnx6: release bh on error path in qnx6_fill_super()
Date: Wed, 30 Sep 2026 08:19:44 +0000
Message-ID: <20260930081947.511613-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super(), when indirect block tree level validation fails at
mmi_success, the code jumps to label out: before sbi is assigned. Reading
sbi->sb_buf at label out: reads an uninitialized stack pointer sbi, causing
a general protection fault under CONFIG_INIT_STACK_ALL_PATTERN and leaking
qs->sb_buf.

Use qs->sb_buf instead of sbi->sb_buf at label out: to safely release
qs->sb_buf when mounting mmi_fs images.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Use qs->sb_buf instead of sbi->sb_buf at label out: to prevent reading
  uninitialized sbi when mounting mmi_fs images, as pointed out by
  Matthias Goergens.

 fs/qnx6/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 3c880854c867..0a68d0eb4b71 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -465,6 +465,10 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 out1:
 	iput(sbi->inodes);
 out:
+	if (qs->sb_buf && !bh1 && !bh2) {
+		brelse(qs->sb_buf);
+		qs->sb_buf = NULL;
+	}
 	brelse(bh1);
 	brelse(bh2);
 outnobh:
-- 
2.47.3
