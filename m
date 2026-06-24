Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084C24676D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307781; cv=none; b=Rn6D2QdsF+sLO/ntztYJBaCCdW9RVtmJuvzV/ow8Px/8lWXAgBJDDpOvimPuHgkias4qGLGtshfQbIGLFZoCPmkzBSqdre2zz9UnpUVFt7a9HRvI2h6L4q+89k/b/6FHIfxWsO3eIXxTPPTmcmGg/7voyQbNguHKhOpHS+Ukrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307781; c=relaxed/simple;
	bh=Rc4DIF8k/idcserzYjIMZTLyU7qERMe9TUYM+fovfvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XxtT8o26NnncxA1jxaop65o7krZBawnqXrYh8UPlwEO+b9E2Ow+ROirXrNlsJGyVz5H69yrJ3qJEt6St+BcyxoH1vJemjDf0BvUC+IbpRpu9Ci8HNosHhr+5ePn0wTGzmSSWyHzQoyDBNuQlp5rvspdI2PXkyPITsjorDNMvvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDOdT3r9; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDOdT3r9"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69dead44101so896564eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782307779; x=1782912579; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCfC/ZU5qfCZc3KzXtYplF4sVu6iTJ7HNvnGz53FoDU=;
        b=pDOdT3r95RD/0cN4RIb1nO/8A+Vbgcvi8ikoPpgYMIRX0XOR666PapZNjeUBVb9DuZ
         Qjqs4unqs64gc/3MZGgxPUZEooQddUb0MOatwmnb2UsgekcyGWuIcbUsGmAYG7YbMVSn
         Hs10NxTWGRbCL6Wc+cpkCMnX3OknsSh9WHUNxbkStzPcgysR+rPwfR+Szmn266J9z69N
         XxicLBc5yUSwAhoqEmZgD4QsWBbQx9WbRCzmscP0xzkEqI28mr76cghkcSZXW5j6Wl/A
         EC9vMi6Y8LXGJH4Vc+DydQIPs0/txsRn9PWeX+fJQvwNbBYTwBQaZfc5nTCC2pVDktfp
         U/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307779; x=1782912579;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCfC/ZU5qfCZc3KzXtYplF4sVu6iTJ7HNvnGz53FoDU=;
        b=M4oxeJS2s2PPEZpjvjGkhAGPvJLkcUWw8PfVUylQUVMFnb4lUKc/pb8PR7+GO7t327
         w5rZnpqB8BJLmg5Gr9Ny38VpcEZ4Shj4NoMq8KzNXi0WioYSGPOC1Kz2mebTbkEU9dMQ
         COfeyZGnMmEj4I6M9glS5gV5ovnoqW2Hga+QDPPcICrNlZPLZd0Vms9zIxF8r+26+kP2
         q9TH83CbJLWzdYu5Js1AkPu0+4SvgAzqXCrERQCTK8eKSYn1cvaaDt43GT9rWOx8U68y
         PPqj+WY7NL0Y8Ow8xrGEaLXKMInFERRqjSGnF1gft+jWFyV2FZVsLvjSbLbLxzCJ+Uia
         bJEA==
X-Forwarded-Encrypted: i=1; AFNElJ8u2FOZRfEOZ36U4psGriMSkKtochzBnB2S1zsVWDrGsh4bs5O0RE/Nwlf2GxO0hUiuRvh4QKGGeY9UpoBV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Uy4K02RezrIlyLh1syCqbwEKPVjgxrbEi2rAldghUXoeDCF/
	OAAUhQ7CPymsLwGhzUuW+6/bVKSTMv2Nq/nqTsTUt337XSTWpI+WpaTyoGg7L2qZMpmGfw==
X-Gm-Gg: AfdE7cmr9F3Ax0VcEUHDZDQ9qXqDjgAn7qJiM5MZZqqm1BDDW/Ru/U4WNfUf7C+sJf2
	fPEAbdyemscEeiFgdhLuaPGZNcY3KKua7teD+HKDSfTyDjGZ9vJH7sSm0zSwVjKTlEg318fszws
	+2oX2geHKbRBNdbPlBG1GRqnj3dujERNuzP8NgrCpDI94z5jIz/Qgbgw6e7asHxtKrEWTZJpLnr
	VEFN4JTUtp4Fmgh9ehNpIS0JKWfr8sRRyOvmeeXrFgT4RJUL/DRp12U//1cuZm9hvXEkSDLAWFU
	bC5550Qg+WdcVF3Mxh3K7h8s7b6MI0MPFTe1tudhKc/sOdFAUHgetH15hCEwGfxA4qBFeLYK+ZC
	WdB/oi+fshlKQshRxWgFUELSyKieCI9Y2aV3c4WKrsET6pBwnmBgoJVVDrjhP5tH7j9JFDwcx7C
	kfnSpWq5C6292gcZnskIGnLfg8EqD/7fguzV39aeuJugj69/F6ayqccCqpl3cVLi6QtVIcKrPHA
	JfRMhffC4tKfzI=
X-Received: by 2002:a05:6820:1898:b0:6a1:129d:26ae with SMTP id 006d021491bc7-6a122f31f70mr2192999eaf.22.1782307778916;
        Wed, 24 Jun 2026 06:29:38 -0700 (PDT)
Received: from [192.168.1.9] ([2401:4900:8836:4853:acf2:b82e:a091:7b0b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f2a583sm9080203eaf.1.2026.06.24.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:29:38 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
Date: Wed, 24 Jun 2026 18:59:29 +0530
Subject: [PATCH] netfs: Fix kernel-doc parameter name for
 netfs_resize_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-netfs-doc-fix-v1-1-d826fc570a2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJJifQr0cHHWnvR0IhA/Pek4
 wzMVCiUmQqsQ4VMDxdOscM0DuBOEw9C9p1BCqmEkjNGukNBnxwGftEZEjZoLRfroDdXpq7/37a
 39gGR0DWEXwAAAA==
X-Change-ID: 20260624-netfs-doc-fix-cae0bf8825bc
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>
Cc: Shuah Khan <shuah@kernel.org>, netfs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Prashant Rahul <prashantrahul23@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=981;
 i=prashantrahul23@gmail.com; h=from:subject:message-id;
 bh=Rc4DIF8k/idcserzYjIMZTLyU7qERMe9TUYM+fovfvQ=;
 b=owEBbQKS/ZANAwAKAWw+kajX8DhtAcsmYgBqO9u/LSqHSwg46Zw58rxq9yDR8uDQsicnPLn6C
 TS+fKq+Vs+JAjMEAAEKAB0WIQRS5esR6MP3hQs0SsxsPpGo1/A4bQUCajvbvwAKCRBsPpGo1/A4
 bfOjEACVnCnKZvuhwmjBq2EYOs5lBYB+eCzJv4Pwhmt1YZVGi5YAhE3ML8QO9z+KGuFCxy1osoD
 l2TOc8uxvm7iyivSx0c+dIP7kmHwdagiZIKBqrAepyxv00Rs0h/ikLZ4ss8XNNcW4iIBUnPdfmQ
 /0EfVRYD45DwoxHYHXOXxrIyuQ3WwxyQ+4egadsDFONbFeQ0Wm7A6xbZFX1jGBHRNPMP187FDaR
 igeZHW2xqwX3SCd+J1VT4xIqAdW5Qe/uvgSUq+xPENOROuuwKh2OKtB1auM5zLnrivX9t/gWlPt
 W2809kOiE6KBylO0KZmdKtFNYQ0AgHzxnbhDr8H2GXgc/tMSHxooO04z9PTpfXv7z8JqW4UCrWS
 PFkPCMc38PWR1odyBIXsap+OuqmrKUbK24K4iQMGu4oIOEJ4vaCxA5JqDrhUcSYgrmcs4cXuLWY
 cIJXLDDN7+kUBgmDDr7/yDQ0VU80VKZRn3PBAuMNl7bu6ZalC1AxFflUmBJUV+x3bTTyWv6KQS7
 mW7Cgz8MbANtpbiwrujgrWIF3L2MBe24l5/FJJNfPO9ljQXLB8zqf8TAV2+++GmC91lcbS71GN3
 Vy8+P3+8DckL+qxxV3LnwL32WGpq5diPZzydR+X/4UDKJmn4LJcdFohekXrLlNEmyn3T5EOKfAO
 NWqs3RKcIi//z/g==
X-Developer-Key: i=prashantrahul23@gmail.com; a=openpgp;
 fpr=52E5EB11E8C3F7850B344ACC6C3E91A8D7F0386D

Update the kernel-doc comment for netfs_resize_file() to use
'ictx' instead of 'ctx', matching the actual function parameter
name and fixing a kernel-doc warning.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 include/linux/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 243c0f7379388..bdc270e84b307 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -753,7 +753,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 
 /**
  * netfs_resize_file - Note that a file got resized
- * @ctx: The netfs inode being resized
+ * @ictx: The netfs inode being resized
  * @new_i_size: The new file size
  * @changed_on_server: The change was applied to the server
  *

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260624-netfs-doc-fix-cae0bf8825bc

Best regards,
-- 
Prashant Rahul <prashantrahul23@gmail.com>

