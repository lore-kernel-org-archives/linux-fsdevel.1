Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8583281525
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858427; cv=none; b=J2G61F2cG7FNmmofbAw4LwThCNtJjCdHm7jdIMmsjAMS10Haw79HSL6uEsz3Jb2sDgTvdRWNWnzQkwR5PD9QaV2Wt1pCx/uG5r9YSbIujL6nzH4bODb7PkpClQU76C2Uk4B7Aq33Nq1vr6BEV7jT2Tfuc5J8b3Dpv0Ia8G1QTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858427; c=relaxed/simple;
	bh=8FF1P1uZsaS1CuePr84yL11mN3WEsBxENhokF9xYdkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbvwJAl0twPbSPvtWXtrBDDfB0ytzSjBpVte0jLrLM0ajc9k0Gt9zeXWx4DH8qVYQWh4ZMPPSCywWGxHgnSx6IXkGurny+vs2r9cAeGV/h3pXaOF2ql+ltK53E0nQ0pOtib3DDDTxKYDqFO1QE82Y1+AZeKM/hxe60Ec1IgALsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUUqeCbB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUUqeCbB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48539d21b76so1230205e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773858424; x=1774463224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AKOjXmg4ZTiKo+W/xuQx+XvAdaj0E/nqe9ECspGDl8=;
        b=XUUqeCbBkTIZSwczQ5izRzUbmdRptyLFHtbPxsxHqfc7aQDMU2928oQrKjywQicNMu
         xJMKXnGw8jqt7VhIrKx8tl20aDIWb1fUXfKiooV+BUjRbqBIKwtvUxh2l+wN4lBeKg/a
         I7wcFvnMNrxuyCy/EjQj4hBnDn5hawZGAFQNGL+hH1F2YR8X1xnchGNzgPq5ywpPbL+L
         uvU5ZCoJMxolBYPPWyK4vIh3/V0kLsBCXT+pdoe0Pf0T0uyh4ppP4+uDL1z4Y1Y75GkQ
         0A1KZoCSLMMVU71jn7a92ZACEcBQQTQQQFZ5UewbQT4RXyXmGuBvgYmDxNcjvnDMnl4A
         +eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773858424; x=1774463224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AKOjXmg4ZTiKo+W/xuQx+XvAdaj0E/nqe9ECspGDl8=;
        b=JTqs4eNpki1yjQxfjwJbJspNx2Ea6yaeM/rzuXRHT8gO0JchL3YcXYd8RwTOF8h4vO
         vqqAsTQ2cSP51rw19ATQ4+j01Ls1jrRkOGD+u4xJhJ7ETfNlGaayI46jwfXuHh308TRT
         +KnHH2x16bzW9icgQZ7z9PkyVxyPXY381bkeMB9OESC7AItBcZcc54a237w57XdXpxYg
         eoECCdMMAWeKfl7Z+MJnDusVms5+R32gf5Q9YjcF9ONSCuHslH4wza0og5wY58e9eDMD
         JhRrwc12lIhjM3Nl9dLWN+X7PwjP3oznWfucL8nLTUfBaQj5WYzOBrzqnrNwvsdTNPqz
         slCA==
X-Gm-Message-State: AOJu0Ywwl4AhxeP8yo/DEKga2YoHy4KU4SEoket3leILmmRs5YYomzX9
	/GU9zPD+YWduXwsArbsNJW9GxGKmgjBQSjXHXogfhYxtXEE1Duk0hEPuBxLW/KGY
X-Gm-Gg: ATEYQzxeyQ9ecCt7WKNdEjRGfguCenLwEfVBovIi4k546nzYDp1U4BI2uG9UacvB14y
	8z/I0KrzzTbyISZjOQxxxNNBRbuJgXEHS7ZAY9ZQgb72nldOUgCdqul+hsIqD1f39nTtpwTx6OQ
	RLrRE4jMq/94U9vGMgsgo9Insau8N8Kh8Q4f+FkbUUSIGcv4xF7UN+Uzk/0jnBMK5SRl3z/kPVX
	VSEdDJ4So/xKMoS7b6V4XQT3hj1clScYCLnYjvYChnFy2YYhLkldsZAHA4Wj6IsL4YqdVLdiqwW
	zQHhYdGVks43qSYneLt11A+Tsy1ecU3Q15XmpUGeF5zrphnRy8t7QmNQqw5a61ZLXaaoOurbSHc
	VV6ckk63oikOHJ3PuuclzYESxSR4k20x1JdzMykC9DqnBoZaGryVF3xtDq2YZu3Qr/LPRHXZRpo
	IrHMymlaxlD3ZrxMfjfl5xEn2UNNORvtNde6HnWOTRumwwplNL7Q9OhfN9Gwg67nqm4ooYwWgwp
	BMbCJ26CFzsWFZo5f4pLhk=
X-Received: by 2002:a05:600c:5392:b0:485:40c6:f526 with SMTP id 5b1f17b1804b1-486f4451109mr74951385e9.26.1773858423625;
        Wed, 18 Mar 2026 11:27:03 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4b74abdsm41889235e9.5.2026.03.18.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:27:03 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] fuse: add missing NULL check for fget() in fuse_parse_param()
Date: Wed, 18 Mar 2026 18:27:01 +0000
Message-ID: <20260318182701.21697-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the OPT_FD case of fuse_parse_param(), when using the old mount API,
fget() is called on the user-supplied file descriptor but its return
value is not checked for NULL before being passed to fuse_opt_fd().
fuse_opt_fd() unconditionally dereferences file->f_op, causing a kernel
NULL pointer dereference.

This is user-triggerable via: mount -t fuse -o fd=99999 dummy /mnt
where fd 99999 is not open.

The new mount API path (FSCONFIG_SET_FD) is not affected because
fsopen.c validates the fd with fget_raw() + NULL check before setting
param->file.

Add a NULL check after fget() and return an error via invalfc() when
the fd is invalid.

Fixes: 3f2496deff35 ("fuse: don't require /dev/fuse fd to be kept open during mount")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index af8ad96829fd..39b635651165 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -862,6 +862,8 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 			return fuse_opt_fd(fsc, param->file);
 		} else {
 			struct file *file __free(fput) = fget(result.uint_32);
+			if (!file)
+				return invalfc(fsc, "Invalid fuse fd");
 			return fuse_opt_fd(fsc, file);
 		}
 
-- 
2.53.0

