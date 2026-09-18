Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC604052DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727870; cv=none; b=NsoyCPeyXRMyBa+JCqRu+kZlw0KJpN4wLR+5XXq6Q0mc0Do8AufcC93FiqptkeEpY1CEHciu/vTxfwsTIUpg7ibWAQWQICmWgssI/wtfM0xmE3nKOjC5bXbx7rDaGXHe8jzQViouOW9x8v3UDIo89y6HZ25AfEpQdw6rftI7XUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727870; c=relaxed/simple;
	bh=9WXolKQnl4nR09tJ2zTfxPUGVKX126nWlQoWsMsa6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfw8FZiYN11/GvMro2sbAlsga3FTJP/mXQcQrukNsOC7Xrm+Jfrx9zf/lRW7wgp0R/kXmQPTny+/IRTGWYfixPsijVUFDF7KCdzSS8/D6Zw5WoULCiTv0E1ASkT+ioBdDCH7Jc8xMfzrwBRuOciqcyRpcl2KFQmk87o0GzCv5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlFxI6IU; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlFxI6IU"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b43b20bso3979135ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789727867; x=1790332667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7lp6VfC/CWEJQth+JIZbySidJqOjfJTVvIQb76h45k=;
        b=BlFxI6IUFqjgbGbM5aTri0shdMdpOwEIzF/Xfuwq6kALxoUPCv0hqa7wrzUhMOStsU
         fG3EPchKkQyGr3JFSYbiQXpV+w9L++Z/+lX+waY1UYGsbY2MBDoIgvKXMICVjOPcaMKV
         grGp78+gQ/zh9yfpmAWO+GvEOS0NMIsSnuw5yyULEZnD2GkAFITWxtO3kTtmYoUEGqwv
         YNZgNEyBEWH8pLa++/J5VjUfC/G88msx+36OhPRpD9RkoRxYy8ETNqisrf36EgWf+4y5
         LRmFP2td+Ff2AdNI0F+e5BqnGmvB9PPPKt+oBYlXlvapkssxlwZ83QNN5vExsr/kvZkI
         d/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789727867; x=1790332667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h7lp6VfC/CWEJQth+JIZbySidJqOjfJTVvIQb76h45k=;
        b=oAQZpk5Mn5V3qtEren0l5O57VJ1zHJonGft+5Dmf+BSqTI1VRtH9kKqyHDwufmjK6D
         juzwl/ZgJK5DYtf2h3A88fkRsPWy4FzRhOH6lUbiD07qcOvk2EpQ1aLbJLLngqmHGnNm
         HZLwoAkZzdEP/u/OJL0Q3IYa5f+ts/ZCeRuoiq5lDHH+I3hLhEa1MfFk2l7VhKDwL/Wy
         +yd8zHw7NLzYObOUb9iDHQ5sNkFNz8Qe8JYy3PpPShLYFbjtg3+jMeCSaLGNf2haQq8P
         nzbf3yRvvO4rQnS2Q000qAqpzeS5Tm5qohrKP+PMFJqTM0/yRIn7oILU+TBXmJBRi9Xe
         l0Uw==
X-Gm-Message-State: AFuF++mNBxDGMSOfBUYBaZ+QCo/aZk4VQwFlEqpAcUbS1KVrrmxVdy9c
	ckAts1/MruswtZvjycyZ1YAE9o/zgC+zTHevwhQ252qadECucUojp14ZIsPvEtLdiXs=
X-Gm-Gg: AYBFou2sElHLw8GqV+yN+JqDt14vofoSoHR5BIjiT+Pw2pprOEo2jtTV21lBtKHDR6p
	TmlkRoy3kPAMXTNQed9t/Me9HHYhnITIXxcZyMdcP+XCgGAPkXJO7UigmbO7GgPZu7In0BUakzk
	8dJDuQNGy7tQne0f3ZSYJdzHSObHaqmJaAsSJqLzMXjSYrVuwpMRoR1vM5blCqqQpJwYM8YQXXv
	TkhGaPDSHgOjgqN2JlIjeIErhxtrcNtZDVvmbP+6JbnQMEQvt2Pcwk0MfQCk1a2s6ZB+jy/UEQp
	n/+LDXUTjJljllFR8MUoXEe3pTAXWLXPx9bcbh7+j1HwO8Dpu2bG8lsvdkPSuLMuF5k+3PSm6w5
	oyAvMyltH2GxfVZ1GVkx2vNvEkA07HTfdxbaQobW+Lvew2CqrD0ct3f7jUHNcjkbajZaVyTW54x
	qwa7nzBlFphjXjtryiUUXHYo5Hmx0Nb+JrtFpJvYiRAdwJotAjin1fmilvg0jiu/KxcZoz90glM
	cxaCT4O3DZqik0uGuM6OnINHj6e3L/UXnEVk+0USD2obB8EpsqqTcnPllhM7abTBgNyvsS48pEK
	iaNoHFlMNY5TLkRqZBjmVl79T6O6kryI15dNOCe418JWo7FbGgWRDR3XRFRkgzE=
X-Received: by 2002:a17:902:c40e:b0:2db:331b:e187 with SMTP id d9443c01a7336-2ddb1add604mr47844355ad.8.1789727866959;
        Fri, 18 Sep 2026 03:37:46 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb760dd35sm5749815ad.80.2026.09.18.03.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:37:46 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	ansgar.loesser@kom.tu-darmstadt.de,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH v4 1/2] dax: return the comparison error from dax_dedupe_file_range_compare()
Date: Fri, 18 Sep 2026 18:37:37 +0800
Message-ID: <37be2d6f07799df3da33971e172681c3f78ac0e3.1789653814.git.matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789653814.git.matthias.goergens@gmail.com>
References: <aoQcvGw4UmkMKmUz@infradead.org> <cover.1789653814.git.matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dax_dedupe_file_range_compare() returns ret, the positive result of the
last iomap_iter() call, when dax_range_compare_iter() fails. The caller
treats any non-zero return as the result of the range preparation, and
xfs_file_remap_range() returns it as the remap result, so a failed
comparison on a DAX file reports success with a small positive length
instead of the error.

Return the error itself.

Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1fbba0d21c13d..de11bbbb6a384 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2264,7 +2264,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
-			return ret;
+			return status;
 		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
-- 
2.55.0

