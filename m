Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894732FA2C
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965084; cv=none; b=rXOHul/1Am1c2I/pxh+Imxw1AUyVzc8n1kWfwJmSyvvtrvwrRwME925dAlF7p1nkt+fuK0zWhyAyUXXor5/CV4auodpJE3AY/x47cXlrHijysz9Zoz9b6zLqaH9cXSOo9ilOWm1H4nr9i+mCsj2hEOPpBg1zWzFL52V2jQfvSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965084; c=relaxed/simple;
	bh=lIuSLdLFUMYHYIkQND+5ezv/2Gm5SAaNrjxK7kuHO+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZGWpOYtOJU+Rr7qQ6xVqJPAHz/215hx7Q9u8w05CztTjPQzNN3nGhGuU1GgKX85VAQr0w+V7ilxBN3j/PSDgvhRVeiOKrpulhkeCZ2EjKMf60s9zosS5Wd2bhoSIlam1gRlQXJTLbvQ+RbuQlYHY/ThE/3KSJ+eZZ6phV/2p3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMqsSX/i; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMqsSX/i"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-388b404ea89so154716a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965083; x=1784569883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7b5s+xdKt531buNfoF0W/b2tSHU/H/fnzI1QXPkyZpQ=;
        b=MMqsSX/in9g+9lC5p+hPbfv1yt+3IABHCtE63KQwhVXtHcOovTpB6BcbDAmLsuu1Y+
         bm+Tnsm3/OouiRaMv2YH5CMgcktwZOmFCMfM7Zvxy/KY4tCEdvAZT+QVHVhXvJ+gP62P
         GIV8UZ4YdM1D1lJJOdlDZys1LU0sulcMKWxfcTyinoPIxncvBHfS3Cs2o9CcsUTOKKa0
         1AMxcw/S8TdI/nIQ+8yQV8Cwj3E4XXsDgBSZozlb9h6RQhS2ZLJJ5D2ZjD6zwjvhLWZC
         qVTSzp+k5lKVKobCIggQIztGIzWWPFlNfeQ+iPlA8gRRT4OzhOCdxYspLTwa31vL6Cmg
         C0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965083; x=1784569883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7b5s+xdKt531buNfoF0W/b2tSHU/H/fnzI1QXPkyZpQ=;
        b=ZHbjzK2kXWpZi5knFEpPXle6T1EirhhmOETyiDcYkZk4dhFMwLfB9Ny0Q+KCIMk3ZD
         QJjjS3xemcZV3z5Cy1R55hgeZtZBLLgsjxKJOaRlrmVN85Q2FfQcMJuEm2vBILcVswjd
         R8pWcMRF+932N0MZvbLoKLfXHlpv2rF8WnY7m6ItY041tgK8ct478LrI5q57Ld+PtHZ+
         Yh34+a4CDRWKLx42kdjtZKhu0Ykc0i7AAWs8W4HH3ta+T3HaXudlwl5Fj4q7aXSBF6zC
         ukwmkAOpOymsdkp9B+JGKmZUZfzPpIomeUN8oWLHgyXCSRwTPAW/ojgMMH0Zst0sHflo
         yfXA==
X-Forwarded-Encrypted: i=1; AHgh+RoQ2F1KOxzwGnqGYfU4afcnYbPWVK/f/eV4ZG9Jf2qx79ySs53kfVkxdJxVoO8GwDw5063iYYllqYXp8rf+@vger.kernel.org
X-Gm-Message-State: AOJu0YzPaRnM35HFUyMvGr324HiHZTykA7eE6jl5YcClLp9PKwjdmpGm
	Dl5/0D5nZYEa6Ecb2DVDl0aIZVRNzsoHMgqZFVbyo8doDRYGLOGLEa1Vq1yI3w==
X-Gm-Gg: AfdE7cmKjfH/Dl7eT2aFU6AaDceogjj0VhWMF0bId7oIklcrcnWvuaU6wIdpV80iNeh
	VQGF5/0aVxpFPGS+Qyoxy543ZwwNhtm3IdkOkp9IrfJyfS82B31mOHObZdCShfT24gByGcpjTYZ
	l+BRrBjWOTVGXQPqIpMYANsC0IK1B8LbQzC8CpZfS5VWQ6cGLKilj3TUsaHe7tJ8Dm2vWdeS757
	FDV/geAwpsFaWKur+dOLoCiHmoPswbf60w6kSVHIGm20Tn6zeJ3FrhUwSST2IjnhiPDYlXBMMEO
	/Izfza7GHpaK9V2e6ZiEbkGP3Ny/iFwPvUTKBtCB1ns/JQpTU1vsM/RgBtfKtqOu4t75OEVinos
	XxmuUB1HJo0LdxTmbjCl2UmFg45fJ+pjENbFDLQwRETKDUkWMsZ5Q0Z5KixEmzHfI0Dwdfx7XsR
	NUwDhCp1nY+WXmOLL4zSVz3bP3NNy7e7UEYj6IYnk=
X-Received: by 2002:a17:90b:2548:b0:36b:4d63:4a93 with SMTP id 98e67ed59e1d1-38d15364030mr14878803a91.13.1783965082598;
        Mon, 13 Jul 2026 10:51:22 -0700 (PDT)
Received: from primary ([223.181.22.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm72354027eec.2.2026.07.13.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:51:22 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>,
	syzbot+57f9327d593d301ce2a2@syzkaller.appspotmail.com
Subject: [RFC PATCH] fs/ntfs3: prevent positive E_NTFS_NONRESIDENT from reaching writeback error handling
Date: Mon, 13 Jul 2026 14:11:40 +0530
Message-ID: <20260713084140.249515-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

attr_data_write_resident() returns the internal positive status code
E_NTFS_NONRESIDENT when the DATA attribute becomes non-resident.
ntfs_writepages() propagates this value into generic writeback error
handling, which expects a standard negative errno and triggers
WARN_ON_ONCE(err > 0).

Translate positive E_NTFS_* status codes to -EIO before recording
the writeback error. This prevents positive internal status codes from
reaching generic writeback code while preserving the existing behaviour
of treating this path as a writeback error.

Reported-by: syzbot+57f9327d593d301ce2a2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=57f9327d593d301ce2a2
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
RFC:

I'd appreciate guidance on whether -EIO is the appropriate errno here.

E_NTFS_NONRESIDENT indicates that the DATA attribute became
non-resident during writeback. Translating it to -EIO prevents the
positive internal status code from reaching generic writeback code and
preserves the existing behaviour of treating this path as a writeback
error.

However, if the intended behaviour is to retry the write using the
non-resident path instead of failing it, then the correct solution would
be more than a simple errno translation. The proposed change assumes the
current terminal-error behaviour is intentional.
 fs/ntfs3/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0c9bd669117d..9458867c6b0b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1019,6 +1019,15 @@ static int ntfs_writepages(struct address_space *mapping,
 
 			folio_unlock(folio);
 			if (err2) {
+				/*
+				 * attr_data_write_resident() can return the
+				 * positive internal code E_NTFS_NONRESIDENT;
+				 * both mapping_set_error() and writeback_iter()
+				 * need a negative errno and warn on a positive
+				 * value.
+				 */
+				if (err2 > 0)
+					err2 = -EIO;
 				mapping_set_error(mapping, err2);
 				if (!err)
 					err = err2;

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.53.0

