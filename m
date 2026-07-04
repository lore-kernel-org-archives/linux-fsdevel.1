Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65211F2B88
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176447; cv=none; b=egbw1XzUwCVFE31a8X0rfFcR3iEXGsIfW8yaEqxU32KBX1+8flqElG/j+EE70mlw8Vv0kIXM0USRFXDe+JhmIdryxSaoA/IzlFHpSj40WOYOmdKTS9kIjm9k1IBYGmqZa75d61YJkcc5X1Q5NWSM0HizE57d3MTDHzLUvp9q7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176447; c=relaxed/simple;
	bh=WfMU2urwJqwt+ljkL3l90nyQNyUWmMUFUVbvWRyAm2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIfY/i12fUPzljWHR0vG8ehub35fLFk1/o5mDmsgjH+EHkrjxQnKZB0r1LX4sYSl7usRKx6WDN0QzuOF+m/hXEBydbC8TcSZiZtlwQymmhEB3j7WFGFFLmQIOGq2GyXQADEdVivFVaSQrr72FtYO1sPYXaWdINoRqYlb63jynfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZJFcthH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZJFcthH"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84780c95e2eso1094693b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783176445; x=1783781245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/toZW9ACpEDlU3/MZ7E+GMiXFZ3Ph30hMbw/9t5kqk=;
        b=LZJFcthH1MjEBKq9EyDWZJ1zmd/nKQERynnnNg1ZMz6YOISDLULzfVvqS1uwtqMLMn
         1YYxf6AqgM1/K+G8o78Jl4dXoAj2aVlGEBQCibOOvY9veAATBNSLaVBAwk87O7YnfKq1
         xwlKIAhM7Kto1wGu4MDzrPNz4oKdfah3ab3R9jMxKrlTkQRhrDTxO4DP0T3m3OBBBBje
         ET2djXwRWWgFPWZ6YKp9mzJZAOO82EbQRX/rq41JFBYaXv0V9pSbdkSq+BcgJ1u+mRrg
         TVLghgUv5cNWo+hmtkrufP/JfsGrCaAJ7zokJA6jIR+RM80RiMY0dYoAdDm3F5ADYe+0
         44TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783176445; x=1783781245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/toZW9ACpEDlU3/MZ7E+GMiXFZ3Ph30hMbw/9t5kqk=;
        b=FQsQ1AeQwa0+SgtrJJrQHeyQJ/yHqw4jD+BhClAwOYHn/BTv1cApXi6YpzlMNNfLJt
         k8Oqf+4srbJK2R1Y1ho5Vgu20thTWLucdwVpy7Vr8djA6TeCBxOqiCENFtWctGTe5Y3K
         kqLbZx4YF2uJ8YcGPEguB9UWocVvGGOFL0RYso5va5KSiW1oMqKFMz+laocIeYYp0bPL
         m995/KDVawZ/6sGOCxnAhP+AbtmeryojuG3TaUe6ckI80lSev/4WnwLl3gQFMRQ94Bzw
         eP0g73OJ5EagtBoxLWpWNbMFbkbrfZEWKZqDJ8jhJ22ZXpHDZ630BYmlx0uDL7XuebMr
         9kFg==
X-Gm-Message-State: AOJu0Yz3NYuWKX0aDzoSAdxIhyOa2KI35FuMABNa20nuHILy95Z2BRx4
	Fij4knJRa95HYqQU93OdoBDK/+0a8e4JP7PHBsFZk7tl/VV4riYy1mE7
X-Gm-Gg: AfdE7cnMjQgRVCW5M/Kc7riyFsrun7PgeuvKdCnXrtrNErkiPbX7PUgfYZtE0u+8SVa
	p/8P446WVqxGSfHTq9L8t3WH/ffdf3WB9ddm2shboxRl28zC/yV7M2ZHwcAFuhnjSgQzW43ZcZP
	i3FibQt5s3QGRBhPXp7a/QKRd/LfXnKLZS5ben5FxK2dU3JDDytPm9qB6+mwy2YzHON9AA1OxPA
	pz7mvK4XCwBgCN2QXHo1G8X+L8xIwd6WeCMm1o0TgpCE35Me65pP7ya6vaw6rDaLqd+aSj1ml1K
	LByqoNF3Uz8sAoNQMAAFVuSPZRdtxf1zhpZ2wKS2uGewrif8TtWfSleBINLb+KVKJxRi+2YnUe+
	mo9lZlS1SlOoun+ytVNaceRhhIiWegbuSdYmoA5ereAF5igIqF2z3g07ZOrsl6o5V2qFTuMYLkr
	GPKCfX0Rqj5Q==
X-Received: by 2002:a05:6a00:8d1:b0:846:169c:d815 with SMTP id d2e1a72fcca58-847f6fa81f3mr3617443b3a.60.1783176445109;
        Sat, 04 Jul 2026 07:47:25 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:8cdb:2215:c871:e5f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dddf8bsm1315445b3a.61.2026.07.04.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 07:47:24 -0700 (PDT)
From: mdshahid03@gmail.com
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] ntfs: dir: use kmemdup() instead of kmalloc() and memcpy()
Date: Sat,  4 Jul 2026 20:16:54 +0530
Message-ID: <20260704144654.126437-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use kmemdup() instead of a separate kmalloc() and memcpy()
pair, simplifying the code while preserving the existing
behavior.

This issue was reported by memdup.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 fs/ntfs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 4b6bd5f30c65..df94603ec102 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -959,13 +959,14 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 			 */
 			private = file->private_data;
 			kfree(private->key);
-			private->key = kmalloc(le16_to_cpu(next->key_length), GFP_KERNEL);
+			private->key = kmemdup(&next->key.file_name,
+					le16_to_cpu(next->key_length),
+					GFP_KERNEL);
 			if (!private->key) {
 				err = -ENOMEM;
 				goto out;
 			}
 
-			memcpy(private->key, &next->key.file_name, le16_to_cpu(next->key_length));
 			private->key_length = next->key_length;
 			break;
 		}
-- 
2.43.0

