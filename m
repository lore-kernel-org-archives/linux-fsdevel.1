Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEA4229D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980542; cv=none; b=ma//syOhtmpt+Vmwr8QKQhs53oITpiPTb3DVMgcogKhvQgsj0yIgL+PXdhxJ1jugNA8LY3/nRbbd4/un1tq3yXGEytkZNhoYESu/RSPH2mQa13t0Q/Q4NRRZWmEiB3pABbXfJ6TMHPkzkxCVBsD+M9B8THIyeDPyiAau/OTx+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980542; c=relaxed/simple;
	bh=jzBsSOX7rKuC0DU0ptJYn1MzJwYKOpNvi0gpu+65E4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwvYOiEToU01JRE1SrstEMrynrTbRHOa8cqSyj4xhzS4K97yKFyXBPT2L391lAyB6jY6wDqICnPJZHogCI3Xnb5jtekEtJCzaBc88/raJGAwBjCJtDPRUueaS5tIUwPTZ+5HcXeYsWHXOnAMsgYYRwi3pWNhfDfdd7TbZ88SWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXAplSE+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXAplSE+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ca1479dfe0so14067585ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782980538; x=1783585338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTMF8MnBAWlilx2ysNeClr43UroMX+LYSUyIvM/sTTI=;
        b=AXAplSE+krlWWMsBQ3K9zcX1VS1/gshpGblr2sB02iBkM+Xhis0DpujKEd1i80lz9n
         PFleXQwuFssBKhmW86Beph2sY/QK9z47FW+AMj5e7mDWVVm9SWLk4ieCfGJnPpOhAZtt
         KnqTkhnthi+B1HBOOrIcfKnna4W9SPf3jou+Cv+MjUxg4QXFtErEFvnk2llA1g1Xk5UE
         Vqkaprw+nWQ3s8DYhV4azEbZ8x1vPlDl5GmMDABsCt6TG3y/xbnlILRMbxzUsNCarlQo
         ER5D6L4G+FkG40fv9pe/7GrJ6bWstzO8gYuTUoqmb1M87l8ZuoT6jr6TEBK0GzLyJW63
         7Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782980538; x=1783585338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTMF8MnBAWlilx2ysNeClr43UroMX+LYSUyIvM/sTTI=;
        b=Fjs4zyMII0JjBq/w23MdDp93xmQ2l8j7DuE83RFxSMI0BabVUBA14zQYzKGvqpoPXM
         3zgr22YwrUvkgDwuOkgi4bEQvi+O6CGNaYLnFIj32uNKPPj5Xa62KdP1TY2OL+kY8j4X
         df+Od3Mov08osmvAt1AOzeaTJ9N13wPBZFC5ZVS9b5WdXVd0J8/ufsjHIy28x9iloKGC
         DFyEZiTS9pgDBXoMQzEjZAFR/8VGD/X1//l8XognDW6tTCD0hByguni8TYa889SaAuxs
         o8CuZOcXBsvsC8Bhcy+v8UvtphRKFdOR7ee74tqi0f0yPWlDRYtaj/Of3bMFbYk9zh4j
         GJdA==
X-Forwarded-Encrypted: i=1; AHgh+Rre7cOICufTvbW1kEWAt5kS5nVGfkq8xLwDqacOaM/IQjlMmxanIgBr29V6KPflOuun6ZseszY4XJ1QT8eN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIVJEojVqVMXhFQvYkg8g3T2EmF3o37f1ky2ScBxyMtwm5Nd3
	chWRmkIWUMnsUJRf9lp0Fq5D/FWE3/Zt03h9+y4n7Ar5Og7aK5LsG03o
X-Gm-Gg: AfdE7cmbV/EwHkKue70Q+MyYwNm2yYJc6eaeVeWVc0jF3kELyf4v2IxDheKKsLvfe8u
	MeduEupBM7TlAEC4XAaYhY8sPAlJvKgA/BI/qCf/RzoWrcY9hvPvN72M89tJGPEq7OYYwhty2kV
	C6e/nrXNd9cFcvxTVIo1ij3QTAyUXKOXZ4/ctFZDSOo/jvJWB4rvcqNMJZWG8JZPrmRHLyNs2Qc
	jta8uRX8qRDHZAkzQk/IncBozCiIYqFUt9KY+GuCCSw1xTtRgZrh7VyOzFx28xTPl7vngmLX+dE
	xNGuMTcSNBzvlFAGmLo2zwsr8gAewthwSy4Kln1h7jssW6DkSoAO6GClWTaK/C6/XuJXCfoE4La
	4m983tFLpbiwXPKgk5R2ZY7gkUW2zpc1FXG5a1Bd/53kcuq9ML96Phl9ERayxc+s06w0QVYyD+l
	eKyefvl3Lx+18NVJ+g5crb7k0=
X-Received: by 2002:a17:903:18e:b0:2c9:e86e:a9f5 with SMTP id d9443c01a7336-2ca7e73cbd7mr51924685ad.18.1782980537706;
        Thu, 02 Jul 2026 01:22:17 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8da8aasm9875805ad.8.2026.07.02.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:22:17 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com
Subject: [PATCH v2 0/1] hfsplus: validate B-tree record offset table
Date: Thu,  2 Jul 2026 16:22:00 +0800
Message-ID: <20260702082201.286288-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6074d91cefcc32cb54f48a1ee214530836e6c948.camel@dubeyko.com>
References: <6074d91cefcc32cb54f48a1ee214530836e6c948.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Viacheslav,

Thanks for the review.

This v2 addresses your comments on the first version.

hfs_bnode_num_recs_valid() takes only struct hfs_bnode and uses node->num_recs
directly. I also introduce local variables around the record offset table size, hope
this make the calculation easy to understand.

The repeated record index checks are now moved into hfs_brec_record_valid(), and the
record offset checks are moved into hfs_brec_range_valid(). The range helper checks
offset order, alignment, node bounds, and that record data does not overlap the
record offset table.

I also make fd->record and related fields invalid when __hfs_brec_find() failed, and
change hfs_brec_keylen() to use hfs_brec_lenoff() for the validated record start.

Note that I kept the key length check as "keylen == 0 || keylen >= len".  I think the
length returned by hfs_brec_lenoff() is one record in a B-tree node, and keylen is
the key portion, the remaining bytes are the record payload. If I am right,
"keylen == len" would mean an empty payload and should be rejected, right?

Changes since v1:
- Use explicit zero comparisons for integer fields.
- Only use node as parameter of hfs_bnode_num_recs_valid().
- Add hfs_brec_record_valid() for record index validation.
- Add hfs_brec_range_valid() for per-record offset validation.
- Reject record ranges that overlap the record offset table.
- Preserve invalid fd fields when __hfs_brec_find() fails.
- Change hfs_brec_keylen() to reuse hfs_brec_lenoff().

Jiaming Zhang (1):
  hfsplus: validate B-tree record offset table

 fs/hfsplus/bfind.c      | 27 ++++++++++++++++--
 fs/hfsplus/bnode.c      | 16 ++++++++---
 fs/hfsplus/brec.c       | 37 +++++++++++++++---------
 fs/hfsplus/hfsplus_fs.h | 62 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 20 deletions(-)

-- 
2.43.0

