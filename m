Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792742;
	b=QQWlIIi0j148aCwkXvx8DdG1pDlF0qYdYtKPFifiR1Ieuo3EuAHSHDsRuMpBjYBDOMRH
	 GDvLlCS+6L5dDrdXzhwuvpkjXNlUl1WAiBgtUIvvfS2ffOwyHxD6CKprOvY4Azxb9RSsa
	 w0OW2GlqlJaCHQBFGG7/Xch4kP/YNVVc8rpNtq7keNZSmxWSAEvul1F2xM6LKBO3Q8mYr
	 P/jUj8bh9g9j3npwwqLKg7gdhfnIfG5VqajyRw3/eIKdP/yFicMJTuzyMvovTfMigsMlS
	 XgwB1SogBP1Wa70OsaquxmjahQMpmOiv3ubuIwJuwAm4/vipXeL5Y2uqOaSIyJywMdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PycSAvgSc9xONqJbh7SrA9DU1TbX+LtklIzj5asGTnI=;
	b=Nn8rqBNBeICBPE5JtfiDK4Mv1cT6HOUcwjh64ptAuUQ0AYeLg07UfMfQfUODR5HYx4VN
	 Bn6Jp1QtyewN7nKrQG9zCnMkmSNVbaIJUmaOB/qDQrq+qMWXFePytpHsgBkCMtn9fkzya
	 jDrK+XPKPmWjjKICiM+wnpl2ucCNZ9KFYn0EnyYuWhz2lLnUMV4Z91jsVDM9WR/YwXQ42
	 lXe8RzABPnImyO59G9eyGwOctYobkwOlFgSNbXyuMk5TlR1RfXO+qtdOJU4HzUkhcWfSz
	 M8VYs0+DaneDpgMJepejTTvYB9D1InAVMGxTIV9kFEsgMYDdlH4wfwtNMEazankJlAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tBpCPDuY;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD340606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD340606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tBpCPDuY
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d73027aedso112685eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793792741; x=1794397541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PycSAvgSc9xONqJbh7SrA9DU1TbX+LtklIzj5asGTnI=;
        b=tBpCPDuYI/hM4RRuv/X9ivjp8uwRT0bT1oHFC+ZhGKs/BVl+YqfWsv/kGE4+2ifIVK
         URPFAItPo0HPtC0jkatlNWamLzuDPrhdoq+Ient9NJI/oN1a9q+Htup90DzK7h6LLTNu
         /0fScZyZnGv1BXIWpbgyEyLjbwJMPdSpYf88Ryn550n+TOOhZjLjiFy9lAd7ZstHDT3z
         ckVpYYLM0iwMsh6VCLsUGP2sW6VtLt46PAixIR5zVP8pWGAdP/dmQ5/UTtiSk+FSMsFT
         LJOBjBl0SDy2AUzvAPl9N3eT+lFN172sgoZ3V/EEFh1we/OFrXiKi3Mn2SxINm1j/itC
         LNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793792741; x=1794397541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PycSAvgSc9xONqJbh7SrA9DU1TbX+LtklIzj5asGTnI=;
        b=Cqsa+jZ+4s42cs0dLwrOBqyUnBSnGGA3r8/+wNL8AP8YG+7eIHeo1EoMCgcE6iVm95
         luLIOpN7o9HGxyBf8IpuYYim/MpYbOf2vFFr+fqTuU7Bqwj8L7+8pxDuwH+ytYzMJp3s
         oVAQwnTxrbQLAO9/Xnmbo2Uo7G0Fn/6o8kiJWlH+Bs9ZB6IsvRGMUiUQReeGOj1ZzFjW
         gQH0z94LnrQANjd3spRG1qu/wafe/6mACjfHQpwKYGj8LEz3wfkPQBaZlXeAHDemcZjl
         1pmtXaTzBi99i/rPp2fP2H/PW1Z9/1gUA6GC1lCqWtiNHeV+eOi0oJO9Q0IKmleDGjEb
         6kag==
X-Forwarded-Encrypted: i=1; AKwUvByKtBdMXk0i3gOVwXrxonsTjKLT0CseFgrihGxcbR1E0qmzZrZu1ONELCEfYzfVJO05tyGTnvppOwF6miHb@vger.kernel.org
X-Gm-Message-State: APuU4Z9u8QtCSim87eQo3eP6sVMlKh76PJ4P+dPLaeFpCMXB0JpXSvsc
	kwzNlUTo/0OY74qNxt2svDxRAUpq+VCfZat66otwTnuZnXqK7k4i3fqq
X-Gm-Gg: AYBFou27vbXgS9Kl0PsJMu/M5yGxL6Zi59f84BTU5TDv2z5g3QCG9ZtSnUxuGm7LjRX
	VJ+Xd0iUJLCnNEP7YJ9vW0gs5kGypseW/n5Ae3q9xLtF4GXzde6xOQW+pSc2T+4FQ4uZndkFGpo
	o+mxqEs6sRb6x7jOn8BQ0YBRYbVPnOwWt2Yrbbbnx1XqRKOiAASP23JahiIUYu0jfXkMaJ6Rj7p
	M0NQZEw4f8gGx8+NdVKiHMrtrOX3dcoFcO16KEaRwJaEYTiyziYUUI4+5CijuVgpud5FxCCENhJ
	x6AzAgAIjg/9YMSrdbLMZ+Mrrpu2omBFZcU3l+fmM8DMOMVNyO3rjuZo6XwNKbu4WCa65KeOmYb
	ihMaSnPF1whxHrt3HOBN6LoTjLT4qJ3w0VYbKJl15CrJ60mGkSY74M7sOvAxqRg7hhd+4adk+qI
	sggA/258TMcTXwbKCI04jXMIdPYdRRYyNWF4kA4jM985uep+DdoStv/07hBtya0dlUvqA8JCIEZ
	Lj3Su4fVG5Ub7LdGWRH57BU8m8k48Q7/OV5YxXzpzjjpNjfcscNv30pLVHTu2XHbYnJWChtNt08
	gs0Vcg4IR3soNSggWIx4THftJRzlF+oYPJhV2OWv7KjKvQ8zbPIr8ZVg6C0b4JbvflH190uB/CY
	m7jMxegrOpKgr2WsyfxO5RjMnXccZt8H2sqKOnLMzfSR6m+n9q2vJVaumteA=
X-Received: by 2002:a05:7022:1706:b0:1ac:7044:2bad with SMTP id a92af1059eb24-1ac70442d69mr20667069c88.36.1793792740829;
        Wed, 04 Nov 2026 03:45:40 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2f7sm7467199c88.9.2026.11.04.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:45:40 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: me@bobcopeland.com
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] omfs: reject unsupported nonzero size changes
Date: Wed,  4 Nov 2026 11:45:30 +0000
Message-ID: <20261104114530.30536-1-dennylin0707@gmail.com>
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

omfs_shrink_inode() only implements truncation to zero and returns -EIO
for a nonzero i_size. However, omfs_setattr() updates i_size and the page
cache before calling omfs_truncate(), which discards that error.

As a result, ftruncate() on an empty file to 16384 bytes succeeds, but
reading the extended file fails with EIO. Shrinking to a nonzero size
also leaves the old extents in place, so a later extension can expose
data that should have been discarded.

Reject size changes with a nonzero target before changing i_size or the
page cache. Keep truncation to zero and requests that leave the size
unchanged working.

Fixes: 8f09e98768c1 ("omfs: add file routines")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/omfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 79a413f1dc0..a4bf45d73bc 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -353,6 +353,9 @@ static int omfs_setattr(const struct mnt_idmap *idmap,
 		error = inode_newsize_ok(inode, attr->ia_size);
 		if (error)
 			return error;
+		/* Only truncation to zero is implemented. */
+		if (attr->ia_size)
+			return -EOPNOTSUPP;
 		truncate_setsize(inode, attr->ia_size);
 		omfs_truncate(inode);
 	}

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)

