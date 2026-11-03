Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666624;
	b=eNiskFhycDQgH7ogieswOhzUpsG7YBxtfAfVaOG/gdnjKJE8dPfoH1rlxqmq5tLBVS3z
	 CxdHjxPlU8FTrXH2YLMBrG/C2fSuZGuh7RICmFwWW2VrnYOC9IUwTMAYBpOBogHg4rbOE
	 OoFUQiJMa9iJQmacmVrYTuxSbSvL6bJGaGcdEh3TkhAl5i/k3FVw3aiLbDayJVS9plg7F
	 jWttXnm2OQ0uT/2BaAYJ+g46MYyY2STRCXc0GWYhXzWSDIIX3+BbUO3GdveIA7WODlUMF
	 +riKX40FEDSdsJYkJMXjTr/SXAK5c050iPALj3a8yo3AkbYCdaaeUAKEyPuSNIpcYVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=7z1HE/KjWOtf8sdZhPk5sTCBtLjDDSjEVH4zmusVOl0=;
	b=X7D5ul8uWPpGu4hhpSTKebysDsqe22SIwakNhwBjhKWWQ8J1TWfk3OtwDDBSjqUluZm4
	 5wUPcxQ21ktKyxIpY//4S3N5Hj9VI3H5c58e97OzVM9GzNaRTh3Rt+lsRqLeNZIrKZASc
	 lM0eNJR3CPOIxiej+rpOL/wv0uwidgPK6VgQo4fVZZIb5C+Z4WghTQOT4DcRrPTr3B0fL
	 ArzQ7Pi/aAS+S6kM+iYef2DfJpW8Dd2FVvFmw8zThzhx4i+xR2azCarJ6zQAvvx6klkho
	 ZlEBex+nxFkHmCVSbSwvyOd8Nkoh09+ZmZPpLe8LofuOxtmEhEHeRLI4UNrH6Tq1zxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GjC1TcGN;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF26606A32D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 00:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF26606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GjC1TcGN
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so5415971eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 16:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793666623; x=1794271423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7z1HE/KjWOtf8sdZhPk5sTCBtLjDDSjEVH4zmusVOl0=;
        b=GjC1TcGNC9WINjV0Y0pUC86ugkq/6GBBmH0xesqh6Csl8qyNo9VnyfnlAp9FrWUrwn
         9ts4gCQ23ErzT6CkzVt9h6TKmSANQZbHs5msDRP3yzJcX97MGPf3IA61FBBpqrL+Xyoj
         fZDjUyEYx/wrGyjmPOEXUlvn8BBOfO0hpe85aNoPi/C+cNdPsYo/e6HUbhWt+GDxCqes
         4q3t1TRmATOewGz+S6RGA89GC1+UyYWSF0JJcK/GPTKotjnazoOBACM1CwO//4suffN9
         EXtQw+McGtnSl/kuagwfXgKQjiNwEpaIg/Q9iwXgUFW5ImO2B8ri5Enw3CyDsQ4TwzpZ
         +rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666623; x=1794271423;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7z1HE/KjWOtf8sdZhPk5sTCBtLjDDSjEVH4zmusVOl0=;
        b=jYIwpDGWmB76NTa+NHMUHKClea1ABKn9vKacE3UJ6SF77ZzZ95746yNHLlfXkOU6Zn
         chW3czBnnY2V4Ext1oOeY4OWjMoQK3b9GlBhA4GgsxuD+RTV/N2DAVkTIuBMm4SyZ3PH
         /Nb3lS8QEU1slKVxR6ECc1Gy5zCz+4nmUkOQ3vUzfmeb7SbUh3cVZxEWgX3lfqt7jvGX
         J384d+mPvheAGAg6LW7pIfs9XYdYt7PXjZuUfFXnzuT6Ny6/zjY2cvrk8SGcoarSUURY
         WwIFYJeb6nmdpg7/n3P6e2RI0DOL98rpXdF9dCtUcFYtzD+WZkhQh+NCdcoyoJakgsNU
         bHQw==
X-Gm-Message-State: AFq9FYIlOi8h7lo0jIC2lEMTxpIUNApv2gsce+FgY55LV/g6x3KXz4Il
	h8z3qv89EUsNpxeF97IjjY8FIPnFTGC8WZXN0r2NpkFs8CUxgpPftYJxwkdhdChvg3E=
X-Gm-Gg: AYBFou2IDMalcANI8bWKN+0pLNmc8GvPmu49ZYO+wOK4vifrmiBuQ6tiAOYMdKdmfY/
	nmSb8h+8UfUJT22cnr3GDGBpbTPGu+qxeSFkBirkfkWkmp8pQ5r2ZUrPJ/E0hswLAdUU43as+4D
	meXtTK9SFPNrciMRjlEZ4PZNnK8WVWBHxIxIyzJubqMVk/mVMAlZgVx5VLVyuwPH8eN+Jg8udiD
	MiDrrNl7mU8zMTYAj/jpge5hnHG5S2G88TM0dEHvLrStQXArFbkS8X8EiFo+ICAl8odiIlS3T1H
	oe1E2C5yOf+lT6FHiO+v/z7oQtQ/XsAusxO6R56Odk0W2L6Y0jYNh0KreepU4DRae5w+BV6dOR4
	G9xzGmp3evp76vbMssg+GCD4vjN2AL6dHHXXlEwwzGigwOc1QI/ma7VcGHn2R7lOzWjhoRgr98+
	6YGOkidpaRpkUAuisja3FHxOUJhoKfn43lH67ovAgEADKXQ7Twbex0V63hbZnevUe9kO/D7XJ5A
	lVPlAZ8C/Kb3KYngTad7SKsvxdZx6GyNYDJI7Y8Pdvl9o2y1mFxk95HEnkRqaINpwuWlOSNZz61
	dyuehKyVXJ7YNeADiX5wPeKV
X-Received: by 2002:a05:7300:fb02:b0:358:5bc0:4f08 with SMTP id 5a478bee46e88-36a425f611cmr15512454eec.37.1793666622592;
        Mon, 02 Nov 2026 16:43:42 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm36846013eec.10.2026.11.02.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:43:42 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 19:43:37 -0500
Subject: [PATCH v2] mm/filemap: clear page cache marks once when removing a
 folio
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bug-mm-filemap-init-marks-once-v2-1-985753b11173@gmail.com>
X-B4-Tracking: v=1; b=H4sIADgu6WoC/42NQQ6CMBAAv0L27JoWYgVP/MNwaOsCG2lLWiQaw
 t+tvMDjzGFmg0SRKcGt2CDSyomDz1CeCrCj9gMhPzJDKUolRSXQvAZ0DnueyOkZ2fOCTsdnwuA
 toakrq7RWV6MN5Mgcqef3Mbh3mUdOS4if47fKn/07vUqUqJqmri69VaoR7eA0T2cbHHT7vn8Bw
 qJ4xcwAAAA=
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

xas_store() clears the marks of an entry before it replaces the entry
with NULL.

page_cache_delete() calls xas_init_marks() after xas_store() whether it
stored a shadow entry or NULL, so a folio removed without a shadow, as
POSIX_FADV_DONTNEED and drop_caches do, has its marks cleared twice.
With 4K folios that is about 6% of the time it takes to drop clean page
cache.

Call xas_init_marks() only after storing a shadow entry, whose marks
xas_store() leaves alone. Dropping 8 GiB of 4K folios, median of five
runs, averaged over two boots of each kernel, in a 32 vCPU VM:

                          before    after
  POSIX_FADV_DONTNEED    1517 ms  1423 ms
  drop_caches            1515 ms  1422 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
V1 -> V2:
- Explain the condition in a comment (Jan Kara)
- Add Reviewed-by from Jan
- Rebase on v7.4-rc1

v1: https://lore.kernel.org/r/20261030-bug-mm-filemap-init-marks-once-v1-1-699835fc6690@gmail.com
---
 mm/filemap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6..c2effedf975a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -140,7 +140,9 @@ static void page_cache_delete(struct address_space *mapping,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	xas_store(&xas, shadow);
-	xas_init_marks(&xas);
+	/* If xas_store() didn't clear marks, do it now */
+	if (shadow)
+		xas_init_marks(&xas);
 
 	folio->mapping = NULL;
 	/* Leave folio->index set: truncation lookup relies upon it */

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261030-bug-mm-filemap-init-marks-once-b83c6aa67bab

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

