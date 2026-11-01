Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512855;
	b=bQHInbYKYhQoI4tT3Lsbi32ihM0mFu5WZBaL6jujfUPjOXivGtkAhUyG98EKl63/t72w
	 bO9wPTL8IjM+U24fZNwY1nfmjArXGXURBqep9LDlqYVE3s3xuEUtI24q943BnquzZCU7N
	 xscTG4OhWTd0QlfKVFE/NNGgmfo1JqLfL1hQY4APmB7y8ZYR6gL8lK9uUgNMHY8fx7fOl
	 yXRGZnmi7r4GpVbMSulPRLxQf3tVBEr0eRjlvSfRXaJ6Rwyt1m5nanzAGPZl2AODo/Brr
	 BGrkjimNXQNDJS0Wi5ylYhDA20B+RZAPXfBY2ncGQRRB9Cri/lfMHwPP7pSF36D2f8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9XbbjCkjt+jTYF1M8tFy6Kzjeu9f69j9G0roS6qzDt0=;
	b=Tlsw/YUAf48JAX+HO45zbMvhnjHDl3VqvptxpcsiNcdrk+L9uUcVF5xT/A4iUzzsGLco
	 vKtJqcgFQkcIWtY8bsmf8uxNAJxC0seFA96MrMHZTG0IIVzBfhPv+jD1mn+c/SvFL87yG
	 0vBBfjSZU0aeQhaadUstA0oMK2KH91kwOjlheANTQQbFh8Vv8qRkK4xdTXiTXUBO23ffm
	 +uzXJrzqzhNTjESAN4bDgYiIhBjxFmAcpDuywuec7bCjk7M+leQeorsgdoBnivXtMduZ6
	 UgTjr/QBL2wvIxGa+9g1J1Def5wYi/c6NOnDooBP4bS8pZqYq6blzTYA0jxRMASszvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HOVcFYu9;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADC606A334
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 06:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28ADC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HOVcFYu9
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so998005a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512854; x=1794117654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XbbjCkjt+jTYF1M8tFy6Kzjeu9f69j9G0roS6qzDt0=;
        b=HOVcFYu9v9uQ0YlGCKM1UGTozAjfDMqMxgMIyLCeXQ/gug+Av53Jzjp9/+chnMcN4R
         tV4taWfSasLhA2kcoF55AbaInWKoH2bLpWN+G7vTfiTXt/esxzG+AFLLd5rRjf123Yu5
         yUZ53ZRAUp/3Ln819368ELxlnocxiXpX1wPgLaPk3pAP2uAupI9zaY1+QfePr9B62LUE
         0yNo3vxzaTBfYUfB+Puz/7wu+selqJN2vml7WO5iMMjJ64/S2HctjT6jUFIUbbnoxypV
         qDvvYgtowupBFVkQFqO/j5U00Y0286PBA+2sSeTmAr22MO513j/BHLkQgcEn77mtQId8
         ryOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512854; x=1794117654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XbbjCkjt+jTYF1M8tFy6Kzjeu9f69j9G0roS6qzDt0=;
        b=jFyRsb01FU/xQjLhXWCra0YvtHFs7FXdYfOkvBVx4leGqGfXYGEtssJ9J/QsnMmcYJ
         Arqb0Kz3h+xNOZrQsPFF5ce8U1OgKJhYlOyKuBjCzS/lfkfq1KS2AHUjLP63SCiTmTEE
         5jDomqcSZHi9Wwn1k9GoktsmxcPxnYBxu6QPFYzMjcIvyNv6/8gabGO9plad8WRs9JhX
         wgeYFl/iVNbKD0zW2ObNXT3jzphoSXeDb2aZLdCN+TOUNnJX5KCIwYCyJGBlsSdYb7vd
         0XSkbGrr2sNtf1GfQPy+S4YLym7XrQ2jrHzJ/u4XynMlv+yKD04bR9TwTWLPEzKfeML2
         N0oQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOSvORrJTtIpjNdUFLakLC5ISuc2/GT63XpRUatCUoq5/cng4YrxmiaKPS+JKuhTUaxOZTT6y+1cwWq2YL@vger.kernel.org
X-Gm-Message-State: AFq9FYJtWkQL1omydrd9PiAEkt0V+LYfuHMXPEFczr/4S68Uut5RjJkU
	C1kuMasx1GDPG65zRTVQA6ISbJoEnx7+Pb7vmwlOWDsWqJj4ldP6re2n
X-Gm-Gg: AYBFou1+4Snb1HEmLdRAvdXVSe5uqAM2JwFZDynDAhnzj6DRKr5tT4PKOuhuu39CiqT
	cxp2yx1Y3OYMLlyjaE2ggomLkvXcYuYzFTjT8haIchRhtBuV16IlkUhYzgWVnUImHr0PZULE3Hm
	m4rfmG/lwB+HqYOzBylF+FWqJMn6o/IBdDiIFK9ffvwJpJknSNBdsz7grkkHBfGK4l+26TVBYvJ
	DgIMKZC7KFJf8xkLlfjcJl90kN2vj9vPB9IbN+4tSX62ca3u+g7xCoEsQcEgbdd9n6CpwE2XBkF
	1yudr9w33SCGVooIxWtZ8qjiMroddREdqY2ETZpRS8X8uoYdiKPp8GNWQoNeAQ51Z2DqtMk8UqD
	o7zoNwJKlE097jpgCHzk0lSKoHC5mjd723BW+Zs0U0Rw0jnTqc6p24Gp5YNKH6M+W6kcOIESW/l
	OL6KfbLyJhw0b7fTbgH653FNPet45GkwEk9aLzW9jXWKRjay2egKyrAZaP7pixVKvM5vgRNXJFe
	+8u6xZiwNhEKCN9TIGmG0Yad/wwf0QqQScgwO4NoHIXsHZw8gt8RqK/1pGpbELyjsM+MlUw2Iz2
	sJP8oWNqXV2wVgIFp6cJlbrJRShJ8riRdhaZJf9wMRizJVMvFNckrRCdYlGOLUUSNz3Deyzj8rx
	9gbvFe8zzGmrXB9pWWB8l+WJUcx7kWZahguOz9Q5kiqlMxw43smR8Hkn7M8wuwEWZ3GbTgEIw+k
	vV7GK0aXykjQ==
X-Received: by 2002:a05:6a20:88aa:b0:3eb:3b69:77b1 with SMTP id adf61e73a8af0-3eb3b699998mr1689140637.46.1793512854396;
        Sat, 31 Oct 2026 23:00:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:9201:5fb0:4dc4:c510:e576:213e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d067cesm1062706b3a.29.2026.10.31.23.00.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:00:53 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v1 1/2] fs: reject negative offsets for SEEK_DATA and SEEK_HOLE in default_llseek()
Date: Sat, 31 Oct 2026 23:00:48 -0700
Message-ID: <20261101060049.81441-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261101060049.81441-1-sidchintamaneni@gmail.com>
References: <20261101060049.81441-1-sidchintamaneni@gmail.com>
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

In default_llseek(), the range checks for SEEK_DATA and SEEK_HOLE compare
the signed loff_t offset directly against inode->i_size:

	if (offset >= inode->i_size) {
		retval = -ENXIO;
		goto out;
	}

When a negative offset is supplied to SEEK_HOLE (e.g. lseek(fd, -10,
SEEK_HOLE) on a sysctl file in /proc/sys), the signed comparison evaluates
to false and execution proceeds to:

	offset = inode->i_size;

This overwrites the negative offset with a non-negative value before the
final `if (offset >= 0 || unsigned_offsets(file))` check, causing
default_llseek() to update file->f_pos and return inode->i_size instead of
failing with -ENXIO. Similarly, for SEEK_DATA on a file with
FOP_UNSIGNED_OFFSET, a negative offset bypasses the range check and
succeeds via unsigned_offsets(file).

Read the inode size once via i_size_read(inode) after acquiring the inode
lock and compare (unsigned long long)offset >= eof for both SEEK_DATA and
SEEK_HOLE, matching must_set_pos().

Fixes: 982d816581ee ("fs: add SEEK_HOLE and SEEK_DATA flags")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 fs/read_write.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 676728310899..86ce8cea10d7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -333,13 +333,15 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
 	loff_t retval;
+	loff_t eof;
 
 	retval = inode_lock_killable(inode);
 	if (retval)
 		return retval;
+	eof = i_size_read(inode);
 	switch (whence) {
 		case SEEK_END:
-			offset += i_size_read(inode);
+			offset += eof;
 			break;
 		case SEEK_CUR:
 			if (offset == 0) {
@@ -354,7 +356,7 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 			 * long as offset isn't at the end of the file then the
 			 * offset is data.
 			 */
-			if (offset >= inode->i_size) {
+			if ((unsigned long long)offset >= eof) {
 				retval = -ENXIO;
 				goto out;
 			}
@@ -365,11 +367,11 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 			 * as long as offset isn't i_size or larger, return
 			 * i_size.
 			 */
-			if (offset >= inode->i_size) {
+			if ((unsigned long long)offset >= eof) {
 				retval = -ENXIO;
 				goto out;
 			}
-			offset = inode->i_size;
+			offset = eof;
 			break;
 	}
 	retval = -EINVAL;
-- 
2.50.1 (Apple Git-155)

