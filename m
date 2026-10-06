Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628149E13F
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301220; cv=none; b=Diivf8kw3eLRJUBQu/Wh3pFHJUewg+5nKqi1NfLCJKYko3N8O0mxmnH3NsQU1Mb3CYq/pbY4xSxgQp4N10lXhdOWzMX4wKw1xR0rSb5Y7WgrS9h8XGePrralWjQ8+xwuNM4oHRoeOOuWihgxkUY53fFk97Iuvi+K+v7ICsybRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301220; c=relaxed/simple;
	bh=REHjVogXIa6GL1Vv2G0GiJeIjII4qa/ZkiuDbr4SalE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCIuU0rGBPQyROUcLIlC1nCkellsPO3FSlIlAgG/qfqF1fB9f/ydpzdZ+t42CvgbCnt5YS9/6PzDeYgN2diAGei+NiHAVzxpKAOUYHf7lrelAPCcKZ3y39ANoPwlqsu4xoNvI7Z9zpq8PtxTd4gdcGH/qWZiRphkcnP5LjQhxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIpgrC6N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIpgrC6N"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso2531576f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791301214; x=1791906014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m1zrwm7WEKGaGG+VaSydSHUeojXXWf2d+Tt9lDJlBnw=;
        b=sIpgrC6N/AHXodolYCeuBOSaYuVjg7/lsNrbiLq1K58Lu0cpcJNgDs6xdOLdJLrNiO
         IDNE6OI5M3aZ5EZQf788GYDWH7ixuRbaGtTwaapXdXHfQQaNpFGsWxiJMZfqv2edOx4s
         OUNvROQyN40Dj4k8brWPIQztbho6tUrG3GvXkmtQb+UHXevKPV10q1/GRUyVY8enfW+S
         785o6xRUFpMJ2sTRiN79uXKwcSQ707tBhwhPcYT/gVr7Z3pbClXTYTBzbgoG4ctSRYZU
         8ZvVGs5xuGrEVc8mRh4JhTQjZO9l+E4VxGCqbqL3o2zyzdXRRgKFzdUZTrO0/tDAPpWi
         MGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301214; x=1791906014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1zrwm7WEKGaGG+VaSydSHUeojXXWf2d+Tt9lDJlBnw=;
        b=eblh+17sSaC3qnx4to7W3Ld6U95wzMj+bPvD34JlfSs4nYI3mpkLEx5TDGz3kaWgLN
         LPa59Gkttl72AAitKa4doeS9fd/PoMvbs/3phgXsx8s/LZebOZPFaXB7Mofh6u7i3zXC
         8Y7+LYfb6dmy3A/fyLrs4OYLRuJYMhhAPqEShd7hijOwV7H0IPeG/6FK4s6FjLf64llH
         +6z4Mh96BgPvwoPddd3TwAXIKhSzwiaxD0vlBY9/9XWvF9iw46pEJN5GJUyLGX7mIFJ7
         t0QiCB9jNMLGRXNsjGZaHLHxJkWokHhHVFL843yecjb0H2U9byNybttB84w4+C+Zwei2
         EdHw==
X-Forwarded-Encrypted: i=1; AKwUvByDeyp82FyWeTx79jAQV6uQu0r61q3DBFo7TE0tcFiFsG8jRlhqczuyCbtLI0XePyynzR0COlgR7QdbPCQH@vger.kernel.org
X-Gm-Message-State: AFq9FYJy3lAlpoDJNCdHTvOGkSajhLqfTgn2OikgeVGik6qX4igYkwE8
	XNU88wLqoLmC86A2P3QmHeJcce+jCYzhsZ6DfaRRy9KGw/HcEHiO17cGKIQyXuwDfemOLfjm+mE
	=
X-Gm-Gg: AYBFou1WRmBidorfG95RbOg1Q8mtNWGTajfbq8uMs/39r9h9z5X+v4NNQDyiOlQV3nB
	PmcYVcD+L0Q3tW1Rg3hRSkn3Lrk8XRqJZD7rBaLTp44RdbFmJhENad39htB37e0SFrk51auR6Xd
	lh9T1ZMoa5hXeCX2WV3ifOPD9y/lGFoEFWYjB/+rUDrlzd+MENTe1nzm9i/d7WxhMVnzkVE4s2P
	1H1DqGCXAUGKz4gTFai9R4987mHp+YYCPjyc++w9qXAmFXBr1wgaeAp8j+lSwE9DvHTUQqLkbet
	3VHOPreWoQ8C27kqZgsa2uk0182rbyeq82zV5D/cjMQt0ZJbQRNWTLh9oDGrc/RIP00M3fPemz8
	d1xKH5GK5OGPVqONQUraCJlyPMnAvBBbkzkvQplIkA3pfvQSO9MqPxnuF/fYT0P/alYIht6wTyA
	y8XbssWWZcwCW/Gzs3DmhfzB7G30y77a/qmcMSNRs8jodiL3slp/Su9ch46d3GMSHpQCZPjABmN
	0jgbuNnnXQ0jQt2XSk=
X-Received: by 2002:a05:6000:4b1b:b0:488:8ab9:f73e with SMTP id ffacd0b85a97d-48c47ff6561mr18053798f8f.24.1791301214146;
        Tue, 06 Oct 2026 08:40:14 -0700 (PDT)
Received: from fedora.domain.name ([217.218.153.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1fec3sm293660f8f.37.2026.10.06.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:40:13 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH] fs/iomap: document ret parameter of iomap_iter_continue
Date: Tue,  6 Oct 2026 19:10:05 +0330
Message-ID: <20261006154005.232338-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the ret parameter of iomap_iter_continue to avoid a
kernel-doc warning.

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
 fs/iomap/iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index c445a38b6..fd8791c49 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -51,6 +51,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
  * @iter: iteration structure
  * @iomap: the mapping that was just processed
  * @srcmap: the source mapping that was just processed
+ * @ret: return value from the previous mapping's ->end() callback
  *
  * Helper normally called via iomap_iter_next(). Called after the previous
  * mapping has been finished to determine whether there is more of the file
-- 
2.55.0

