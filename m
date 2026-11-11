Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391337;
	b=nWomrw9cKJwgs6Ccf53N2nDXP/AXgudJju8zSF2fhClig4hctoBk+l5s3l5Qx31U7jva
	 5OcEpBXh1p8TL4sJcVxSEFNIC99aRJ15VCJRgvjKwweyzrEqwOJcGCo1/abp4cM/zx/yd
	 ni/aKTzDjXiXEvyj+SBG8GLXQw+/isGG167vM9VW5NC8YFg+1/ioSb058V/EffEBK0yNu
	 H4jBk4+pyrdyVrLDxGNB85jHQu0AiyYfI5Rp9veKdVTzSY4I1zjEhaXNY0aFPj0+doNZ6
	 MXKSx3KD5uPL38oudPF61ioV9mWwPxJ9G+tElVEt9bE8vL1LG9gJmNB4KpciwuZk04w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h4AVeGPggLSUFeJTT3dwsO6oUDmB9dp8f3J2h1ds3aI=;
	b=Frwwinm9ZlWpVgs+UiyQGEPIFBwklEyTzi/3M7q3aneRIhK8zFWbLKUL9AUrSECCjZUM
	 2yX48likO/660Hf/Zp9FhWAbZ+0Y0h5D/1uq3NSofhsgNabVennEbzYVj97AKJIHB5EU1
	 5b9fLXgCOi97ajBp386liCQL2rmFpJu6tSopPsm3MjQaRkFezaY61E1mNTBsAM+Gcr4so
	 VNtEk5SsZUAA6LWJHX8pQYDdyptAPFJCAJHdKKsAMzJDPegH9/uv/u/rHj/oaS5WudOtw
	 ztEmGYvC5tO1Ky8pGvDxUJE2t9lYMZU93stughiDIMRSLXmc8kMaQCvUISZo7yXmWfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbZRW1ql;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E76606A326;
	Wed, 11 Nov 2026 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbZRW1ql
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4961F00A05;
	Wed, 11 Nov 2026 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391336;
	bh=h4AVeGPggLSUFeJTT3dwsO6oUDmB9dp8f3J2h1ds3aI=;
	h=From:To:Cc:Subject:Date;
	b=ZbZRW1qlJiOojFLzHjuxEoj4UfngzibvCjsvMqQR7C86NTKOjihLkfEbkvHph2Cop
	 nyjN5vvT2ibj1Gb3KaUgLMK0FW1yuXAMA5DewTBrkTsPJ/pnqm5rphoxEIMMOTZJFm
	 GtCpF+1LBUW2f/1r2tmxesW8Mxo4jcRqIpvT6D18bHlR8yapslRM9HNbkyOiGGX5g0
	 7MwYbERL85wy6zamfpkcTy28jT8/o4UCowlLIb/QtnJQqLe1kE4ExH8OEPhtQhD9Kc
	 /sPGHDBUpxIiwprkx4/DoWWo1urNGrNoHFu5nf6aWWqWvPoxCp9FBeaTdiH5ha1t4B
	 e8tG/IB9Khnzg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ebiggers@kernel.org,
	hch@lst.de,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH] fs: constify inode argument of inode_state_read_once()
Date: Wed, 11 Nov 2026 11:01:49 +0100
Message-ID: <20261111100148.3665035-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Constify inode parameter so that callers can pass const inode. Callers
do not need a change.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---

Notes:
    I will have a user with const inode in fsverity
    https://lore.kernel.org/fsverity/20261105115532.613467-3-aalbersh@kernel.org/

 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..c5ba625c8ae1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -877,7 +877,7 @@ struct inode {
  *
  * We hide all of it behind helpers so that we can validate consumers.
  */
-static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+static inline enum inode_state_flags_enum inode_state_read_once(const struct inode *inode)
 {
 	return READ_ONCE(inode->i_state.__state);
 }
-- 
2.54.0

