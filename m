Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8038F953
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144371; cv=none; b=A3xBwvH2qJSiCMQWwMZGU6VaslGSlxeR/gr7TM+YVDTLphVjvB+kqO0rko9QjSLaGcjj4tKoU/dwZ4EuzjnOjeWAcZ7miAU21a0A3mrcSnMQuN+9BPluY6p9Sa168f1MeBAwq49ZWY/gOv7btrm3JXeh9n5jfhx2cLL2YBtQFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144371; c=relaxed/simple;
	bh=l5zO/XAUzDIt/BzOjb9E9+JdiVlDpN7L/iEhqOAcMjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fyf6WJDwm4Ga4RzavN/xtOp0HsGWGZMZxFhg+8fa5pbDFoH2rUnZ8WWzz2fku++8t8m6u/qiubDK1/1M3MTAlkhG781sl2L6OaMZ0sBsM0FLykRPK8RuwFBHfiJiT0p+iPuDrRjyLLrWiPHNT2l1OQk483D/He6i9PQB4v7/XEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7PZBXZN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7PZBXZN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso5495705e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778144362; x=1778749162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vymH9jvFkd+f4AV47aojtaQEQA7/cw8LLkGt+TrxI50=;
        b=H7PZBXZNi3zrko4pHwFHbUvSO+2lGGwpDbqu+u9dKebo4FRMnC85GAKnF2pFDW0Q5N
         uz/+/VkJMQHiXUPqAiI4kZJXS+kmBCby8yl645DFw8gOOLVH6WKVtkZwN4SWo7TRKxYC
         kfot0jh8C8VxbuDftOCY+lvJNnpLJxtEK6aUJ7zBpSR3KW12iHlHpSpbdpiicAaz+JTu
         EPfYWDLxQEh44YzKNoRMKsppVooXinzQvQp5PwVN835NGC/K4lKtbpgs87jt6tJn4+df
         109KuhnyUCSG1657m3y+8XSp5XOZlT7U8a++1gqSx59wIMeQqwm5KfHAnelGcjoj9FP3
         CVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144362; x=1778749162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vymH9jvFkd+f4AV47aojtaQEQA7/cw8LLkGt+TrxI50=;
        b=DTeAfqRHFeLG8rjA1LrxlUfzNEu7EtkohMEJd4g1Ml5OylPx5JU7TJy2scdikY8qGl
         WsU08s7rCpysk7OPSG9mRCjCX7vf0bTsZCOY+gnEd+sVblcHI2a9PvLYBLAnmqIrNUD1
         MNtm6Hi9POjirouOjQGx/lV8qLmNsfcMnuI2GM478tyJM9//OcGrFdfoERiqadJp/QMt
         qT8TM7Yuu9OZXtB0ldqFstRKnU5e/KBDvmlBbGUuKRV58JeXfHyR7C5ieDcf6nq18zMo
         519HEmtdVbhSKPL9mpcVN4pqKlJFEZjz6ZiL0m+yGmINE4F4PJTm6Bdq7uvJZf2WJczN
         hrtQ==
X-Gm-Message-State: AOJu0YzobnOQkI12yI6KNEv5y75LdA7o85HUunc4M5gA1t+0E9xCbdlq
	QYCRMgLzOmYmbUrnlB4xJiAaEvEz6iXmQJ8Arw7uywV9ahER060uzNE=
X-Gm-Gg: AeBDietHHbHcYdwd+8t67VFvWAL3jaaUnzOrbJKrCeFrwthI5u9jgei/HxFFYFXdx54
	oxOSHhRlB7Q1hWLEfxDormrLc2FTWAPWjPFEqkfGgijKR8rGvCXrYAeojzpRoSIHtJ++CLYxY0T
	O2Q0CnDmn+N8KFwcm+ivyUjZf3fAruYx/SiTrYy02wd1SlWQPsl+bQyt8nwgcWhyP33cPW3YCoj
	pbZM3FxkbVFJxQh0vDmnKRE3+kcqOeE+UB6SG3qWFCTRmvB71y/M0YnDT/tXu2rQ5sVR7xl2Grz
	T8fijBWHNQ7Zq/JhuxBIlRnPJTFHwwOSaN1qnItvcn6yVvbsEFpuw6paJ9WDs98K7gFhGKRiGrf
	HJm9XaJLpajUu0WE9zArefStZV3Za9sHquyTQcXrQ6uI6/E2QKsEDBNe2+wn7naa7imo5V+L5J7
	rJNwtFZNH1As0AFnoiqYdfFOTUWLdkAjLreE33ONXXyv1BSZpj+cyic7UbY+1WcH/VipegOOEZh
	+JwdA==
X-Received: by 2002:a05:600c:8b65:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48e51f4e5fdmr130208985e9.28.1778144361671;
        Thu, 07 May 2026 01:59:21 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-148.brest.telecom.by. [46.53.134.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm189647545e9.5.2026.05.07.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 01:59:21 -0700 (PDT)
Date: Thu, 7 May 2026 12:01:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] sysfs: upgrade OOB write by buggy .show hook into WARNing
Message-ID: <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>
References: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>

Buggy .show hook will get just 1 line of dmesg:

	fill_read_buffer: ext4_attr_show+0x0/0x600 returned bad count

It may or may not oops later in some unrelated process.

But buggy .show hook most likely is corrupting random memory past sysfs
buffer therefore deserving more. WARN, make it more visible and let
QA machines panic earlier.

Also, delete useless cast -- "count" is >=0 at this point.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/sysfs/file.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -70,9 +70,8 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	 * The code works fine with PAGE_SIZE return but it's likely to
 	 * indicate truncated result or overflow in normal use cases.
 	 */
-	if (count >= (ssize_t)PAGE_SIZE) {
-		printk("fill_read_buffer: %pS returned bad count\n",
-				ops->show);
+	if (count >= PAGE_SIZE) {
+		WARN(1, "OOB write or bad count %zd at %pS\n", count, ops->show);
 		/* Try to struggle along */
 		count = PAGE_SIZE - 1;
 	}
