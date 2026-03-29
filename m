Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA727FB1F
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804817; cv=none; b=KMCdvzNuCccdo0WGArw7/VLrsTBDZ1aIINGFYQ1LEafnaXZ+tuUGUoxKY4fNBH/sCmjDZNmNwVTNDYcVkLU3apeZ87d6wk31NaMVQ7XIz6MKiaH3MbGTQzhE3dZqsCRW5Xh6AtITbO1IaqDitXp9zJmaY6zOUhC+BgcFqfi6q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804817; c=relaxed/simple;
	bh=q6/M4OdZtc+alS1DwnvRyoUObRGRNii9NRUn255hTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF5zoVVNA0/2A7a2gCKuAWr14gpSt3H/nOdQioPPdC5XmwHfr58ASCKz7s8MDS+D+v2rZNyJhLqz73/E1TfN8eoBiNfCiapGeR3XgsocWU1Rvjwk2asEPAsWTEI9pS/zSR6W1IQd73NBkrEOyyNFeuXd8HisL45rRVevi0mQJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlsVpaM9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlsVpaM9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso31551505e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804815; x=1775409615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuBtMTHfXISMz1y0xRBvnd5xru82Lmp3xXwNF/dfxA=;
        b=KlsVpaM9Yhvb1+q2rQjP/m0pJ6Q9uu02dunJiXVzr9AHBLjmaRqRVJ7nqL/qxmyE2y
         aMRAaptKmRzCAXhY/9cz+hCL9Ks+2+4gonZJTJdthR9SX4cliUOHlk4ElT6FqY6de0vI
         o51E2RxyPYa9G+NG79EucxAe8Bb1O0hWvTd9/G3xbXNTVrtmGyuSuJb6NBhaSBEDfvoD
         2MLsHQCdWMdB6Lm56faQ/6E3jx6yNKgeTGNjc6R0Wd6jNxM1D9Aeu4Ojh3WSo+MPI9D1
         4MBAL4dJb6xvELuV0rDvDHdqvm+YFBZ+Pe4xetg6jKOAoCRs41PcTYzW3Jym0U8eVZsy
         dEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804815; x=1775409615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuBtMTHfXISMz1y0xRBvnd5xru82Lmp3xXwNF/dfxA=;
        b=jOEl354Uz7Svz6OZj51e4LD8R+WJxfydPapFtJSU+dEhMYaLwkxY5kD1dgMmU1mPKr
         o5RZgX58aRcHHiTnxpbuevpn3PNlEZfW45E2+0QugWUULo5Aw9eSVXlpCIG1ByT3LG19
         f+yoQFBsvbyFZAoEjgtwGnrxd5X/os0QvWmh0HH2z4DCcmZrtBxT9HwgH7jb7uGbaeJO
         pw6JBnMpo/VXhPaxZ8eUUvZLtSWvV8QgNrANgBHE6jmKK/s+fSqe+ShR3Td2x2QmJMVx
         tZPmk3ZPCkn/4c7hwVyk3qFdVCKVCbNm7OBqET2vEmiTh24VDe+YfBi9SUwGV/wEmaCt
         muvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcH7K6CHEGA67s1nlozOqOBXmI9tiW4wqGOb9oL5nQh6ZGB0bsK6gwlHrN2YRMelxnmCYOtpl6apWMbjZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrz7ro9dini1aU5dDjrfW+MZj5YYiiL0kN4cnG2DjlMBCrQx+S
	j62+rZEewmtTc+k2RnMm5B0oBhIzKGQ7DfKuEvsCg3CJVFheMpyfJ7Ly
X-Gm-Gg: ATEYQzwDAk1zkWipdgiIOmU5Wb3FCypyl218RxohGW4q2HvzSvf1i2ZzNwxmDGwu5rT
	JNyBAWi6CgJW1JmGJJGEBkMk9etVj2eEQ7qruzINOU+B1X/dhse+PRUd0cRb4ka4cQ/EubAGwvj
	5U0avsq4rSWacX0N1lrsdtFGtDh1TqTHy9Ps9xgR8UkYE7XgFrak46FOb3Bzhn8UvvGBt0+nD2U
	ES2oW35JlQXFPZfnbs3ysembivIY6bl9WH04bZ2OXfVxJtESDGvwgsZpwT5qezHNJXqY5kKn+Ho
	d5q2MVgLVSLfGX3jy9fXLfV0XK8aYNFlX6NjR0G65CZ/6RpXWB6Jq6vMSlccdQWQEpLZOvr5hSb
	rTZd9xEjlWILdgD19UqrNu9xNm+eIzcF1sHwc169dJku5ZuLEi7fVvMfJev5FuJl8tzVID3bxCU
	K6eym0WOFG53ybbY44gDKk8uLEEp6JELZ7rvjsGOJ7BsfIagqE4o7u5sprnqYyYeT+3KLqUokSY
	RE5zNpIBzXn
X-Received: by 2002:a05:600d:7:b0:485:439b:683f with SMTP id 5b1f17b1804b1-48727f5fe73mr129079015e9.20.1774804814537;
        Sun, 29 Mar 2026 10:20:14 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:13 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/7] fs: add icount_read_once()
Date: Sun, 29 Mar 2026 19:19:56 +0200
Message-ID: <20260329172002.3557801-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used to denote the caller acknowledges how the count can
change from under them.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8afbe2ef2686..0cf27085a579 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,6 +2225,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+static inline int icount_read_once(const struct inode *inode)
+{
+	return atomic_read(&inode->i_count);
+}
+
 static inline int icount_read(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
-- 
2.48.1

