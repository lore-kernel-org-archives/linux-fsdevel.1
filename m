Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690600;
	b=nfkir+85ZfJpX1nJSO1+cvWnA3a8fXm9E9G7dvrgQWyLD57vMOwFl0a6j7TYjoYqrq0v
	 cNWb3HSa8lMhxkjs/aK6p9KKNWtD254LfQnqmWB9aF8o59cUxi7Ks/zwihx5YWAnOdiBC
	 qHPaW5GvIF/m7nmRv8pm+FS7d0U3cTwpdSbNOfx/9muHRIo3C8ntuNm9Tom0jocSOkIJv
	 /yHG1cY0kzsOjyPD+eTjDZXXB+IE7OrQdeRBDk5CDAdaZXctzQGv+Gp5t/Jalh9y6JA6X
	 2BimYgLN/fy/Fmnxw0kZL4z1XG595n8urtpYw3AV1D6xrEeykrpCuPzbA8FrrpuwbKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p9jXNwa699IkdxAM2a5EMXt5gcZr4wwka5kn1dl+WNc=;
	b=2YaCoZ010RGpm3iFbr9EjmZpL16+GAambCMDMzVppauseCqMoHcU7V4JYM/DGLHS6ZxF
	 JzY0kmYdMmreekpYNzaqJKPXSWUcw8m0PCvRQCH3kSTzL9g3HNGJUOWL2nY0Dhe58oaZ/
	 DynQWYynMTLpy4DSQ5WQTSLr5Bz0cqTT/4yNKvnqw3ZxRnFn9r/xBKOErBVeKfLPZBCZU
	 98I9SjJ9FWEe4JHsqYCxd0mNm1orrqeMeRibEClI/eVzEg4p3Dl5CVrhtyMxQtBPWsMo0
	 NS4onaGhxQA8BEdhCoL1SGLcgubbrVrGZ7LQs3EBa58EF5rAAWDAz7fRlFWD/iHZ+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7vmWaUo;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90CA606A324
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 07:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7vmWaUo
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3ae1dca6bc0so2159437a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 23:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793690599; x=1794295399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9jXNwa699IkdxAM2a5EMXt5gcZr4wwka5kn1dl+WNc=;
        b=S7vmWaUoyslEfTjkDmZaSctew6UQ4i5PRtOOuyCzM7AgFpelmq58vuA8N6zvfnNGe3
         5GKfoprGk8jrR/28uvvos3Kem8HmxNs352a1343rJLf38vwB9YML6h1+CrfPkpnRgYGT
         hhtLUnsu4fpqtKUvDypt6zAEKiuz6rmeFkoOUpn8eDlHx92KlXo8W4w/uSUcxqK9NH2b
         BEwDQTwyJFKwW+xRo8v4UER8narutqHKkjB1vXxSWZ5Srjq4iBaIOBvrb07j5A3j7w4G
         eWX64gV/H5Egx6cFoYKRGfyfmMqN1v5z9G5WBmV8+EMksIF5wPl5I08kLUN/KzVQ/aTR
         N9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690599; x=1794295399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9jXNwa699IkdxAM2a5EMXt5gcZr4wwka5kn1dl+WNc=;
        b=PH9qJTca24n7LS0DKq0B4T3EH059l66v10QT/opQ+lHGXZbf9ZuT+j8E/ti1TNub9F
         DiUFkUS6qu4QA+1jroAoA5zpRqr/FrP+dUpxtorYhS0IrKvFvRh0S5k4IVmFVX5EQ8wI
         3cgIABT8g7/6BXzn5kPkx+lpyHUVEKghDmEvKC/+gXSxyLdgDjmeg31GbYTdU1mctoBS
         SM4wJjGHvFN8KEYCFY2p/pWO/Fr5ziPHZa7lapBL5QjrtV8BnmHW6CWCHOtuR7sQ9ug7
         tGow+dH/t6rbQDCJOHHxUDu/3mwMdKsfeQpsZm80yV/z436eCcY+AOWI2CEbQ89wCLal
         1DqA==
X-Forwarded-Encrypted: i=1; AKwUvBxmnsTzPfCDIherIQNLODILE45eABhtEBglxraFlygbH2h41yfn2gaqemFZDsfWkXQNbkQgy0cjP2EAB6vW@vger.kernel.org
X-Gm-Message-State: APuU4Z8qmYSiz7NhQCrrGlyUIyjGWIAONxZhgtWvooSQauTbTNBk1D1/
	wcvCpN29+Sv92ugeIgg8JkA1H2Xozsk8Qu8SzS7C+5LlH3e0Bf+q9/gY
X-Gm-Gg: AYBFou1x5lqbf7rqKLfn4O1gobccpkTPanl0Y2uW0B9tslEOBvPokNi0PM3Ay9NkRLa
	09h8eQoH4sibLJUVPF7eAo62pOUPD475McqkiHDVlOEwzaNB/9FEhdKuGqoRXGP4G2/f36Aqhn9
	dBWuHeqwfWqgvVqMc9ksXJM/u0GsnYCfeyUA/1ese4dBI/KFXkxqGB+b1JO88hPdivmyYHTgewi
	Xxf5MJAdqnD5f5QE9FH6Dn1o+CAgVAjZMlnjvvdb25ov7r5YjsbS4PLUtoUcmjd2quddUIxjJbg
	ShyOhW03bEmrD2jOHeJB239sqMFVIHUYCGXxZGA0f4aOsoa4ajPkloEQ89CrEpIeB7GvDq3nne2
	DhZEhwCUPHSwBPh1TlYl8ARZ1n2uISdxE6+RLdx3Y9NV9VS+pq86Ku7dd9nGDYu4xy/3Jj9eckX
	Ie+WOEuVkg7DX+CY1AlGRELJQiiSPF0WGcAkwL/3wP2cF6V03NzTZXNwUvsgxnUOvdbyU/gK/Mo
	7xp4s4ojCl2EZgYNC3m7H3TkVCBFZnpnCUM0JPJO7L/LEoFbrjwJdc0k46AUvNv5IXBW1IPmf1j
	36J30LlnlG49Rjo8qgHNBYtHiFD3A+J7q4VcsmTZk30n6iAVotEULJKtvKNSkEq01nQcIdEXMar
	m/Q==
X-Received: by 2002:a17:90b:5686:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3ae89724b1dmr10286440a91.21.1793690599284;
        Mon, 02 Nov 2026 23:23:19 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm8638824a91.1.2026.11.02.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:23:18 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	willy@infradead.org,
	kas@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] buffer: avoid extending i_size after failed writes
Date: Tue,  3 Nov 2026 07:22:34 +0000
Message-ID: <20261103072234.55611-1-dennylin0707@gmail.com>
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

generic_write_end() updates i_size to pos + copied even when a nonempty
write copied no data. Since prefaulting moved to the slow write path, a
pwrite() past EOF from an unreadable buffer can fail with EFAULT after
extending the file to the write offset.

For example, on ext2, a one-byte pwrite() at offset 4096 into an empty
file fails with EFAULT but leaves a 4096-byte file.

Require copied data before extending i_size for a nonempty write. Keep
zero-length write_end() calls working, since generic_cont_expand_simple()
uses them for expanding truncate operations.

Also call pagecache_isize_extended() only when i_size changed. Otherwise,
blocking the size update would leave its endpoint beyond EOF and trigger
its warning.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5d3852b726d6b113542e9761315cfdaf99f14587..f88ca7c079bee3462288fdebf57131da60b74798 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2203,7 +2203,7 @@ int generic_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	 * But it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
-	if (pos + copied > inode->i_size) {
+	if ((copied || !len) && pos + copied > inode->i_size) {
 		i_size_write(inode, pos + copied);
 		i_size_changed = true;
 	}
@@ -2211,7 +2211,7 @@ int generic_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos)
+	if (i_size_changed && old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
 	/*
 	 * Don't mark the inode dirty under folio lock. First, it unnecessarily

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0
