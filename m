Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7835C197;
	Mon, 23 Mar 2026 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249478; cv=none; b=CVjbOIN94nFu0GwmcfacmZ1yDFkrDQokBEWSS1ff+rfddU49AqIp51eiGf280ldDVBzJ8hjw5WQWKvhGJzHPRHDHac/RChIm/SppHrSFt5DqEYpPCr8TYpcef0KeKKrAqSmWWW4RQmFH8NIE7wOJ1HNc6oiZAhqqmtZwALWYBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249478; c=relaxed/simple;
	bh=+sIeqLPi7G+ipGDdqlJ5a8VCtoEQVET4txp2PcionM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/bXmEuiD5DRUyNENJpucCz8emBe2YpT12UHzSGxTtVMh7EpAAi4emwj0dt4IbiJIy0EgTVP0ye3TmG0hB4A+z4KhnuXPE7avdJYz7Uy6g/+GO/gfHK/TPKpq4ZrFiCkNye7GqCZUMD9NeQItlLjenR7eDLIOnCT6Pq3Mw/scBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAD32uGx5cBpcQWGCw--.536S2;
	Mon, 23 Mar 2026 15:03:13 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: linkinjeon@kernel.org
Cc: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 5/7] exfat: leave room for the UTF-8 terminator
Date: Mon, 23 Mar 2026 15:03:12 +0800
Message-ID: <20260323070312.42909-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD32uGx5cBpcQWGCw--.536S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1UZw1rGr47Ar4UJFW3GFg_yoWDCFX_u3
	4v9F4DCw4Yya4Fq3W7Cr90yrWS9ay0qFy8W3Wjq3s8X345Gr4avFn5Zrn5twsrKr48KF9x
	WwnYvFy7A3WkGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiID7UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

exfat_utf16_to_utf8() passes the full destination length to
utf16s_to_utf8s() and then stores a trailing NUL at p_cstring[len]. If
the UTF-8 conversion fills the destination buffer completely, len equals
buflen and the terminator write overruns the caller buffer by one byte.

Reserve one byte for the trailing NUL before the conversion and handle
zero-length buffers explicitly.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 fs/exfat/nls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 57db08a5271c..fe3f5f9ccef3 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -484,8 +484,11 @@ static int exfat_utf16_to_utf8(struct super_block *sb,
 	const unsigned short *uniname = p_uniname->name;
 
 	/* always len >= 0 */
+	if (buflen <= 0)
+		return 0;
+
 	len = utf16s_to_utf8s(uniname, MAX_NAME_LENGTH, UTF16_HOST_ENDIAN,
-		p_cstring, buflen);
+		p_cstring, buflen - 1);
 	p_cstring[len] = '\0';
 	return len;
 }
-- 
2.50.1 (Apple Git-155)

