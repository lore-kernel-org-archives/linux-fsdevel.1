Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B337BE78
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142570; cv=none; b=LjyFYVsFLPaCYa4Dk71aYgw01Q+4iaqQZ+mBkJZXEqSWbyFNyx9tE1TtDwGr+mGbR/wv9bc/75rgJgU5rkDh31wAkoCnmnSxyZ4q38AM6KpotDbI8zyVgqbW62fK0JOA/AuKFaZSBr1X1w98BNIdDEzg3e9ZqiUOaEpLP2gtsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142570; c=relaxed/simple;
	bh=L5Yq4MEDZxOBlhQy0Gc4VoqQ/4gNp9AOT5NCQkquueU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCNlnT9paf8mavyCMrEUQcJfe/YP7iCyTe/IcFSz/V+vFrPoKhUNyVwWWDN6c9jHXdnPqiJr1mciHTntro6+b75PNA7CX3NHqAwVglQRH6j0hfq0sgIxWvQ2rKAbFRNt/+xjiAmdfc2bg36WUk0A290irPzBjx0Vz4HVcqKo8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaRqLcIF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaRqLcIF"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35e4617924eso1335910a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777142568; x=1777747368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+B+zmNvoWMXQwBg1E6iwbD1n/mha5bKUYp5y/YGx78g=;
        b=jaRqLcIFsd5bIflZS2qok4S+ArfUtJOTju8f2dV5PUQZ2BYQCaGIQWH2HA0Aoi/Yq8
         82gJGZOm2o07Wmzi8rUwNveJby08el6uWKYg+ZC+SE0lFUwI7PREI+ZGdiJrZuTblIU9
         1543NiZO9hJaMdsx8yfFNzZKpQdNsZHX/vmSfDcvXzU/7U6kLUqU4+3pJlslTjbTvvz/
         1HOtzQVgAnfI8XUAfucoZdP1yf1CzAPOoh6x5UVq/x5LqogRklyqf0Wkuw00YQPovO2+
         IXiy5DDEXhFcVHs6s6Z21Jg+n4U3DnRku05xFh7Cr7PtRiktxtj3lWqs9SzdvIzIZOPD
         3HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777142568; x=1777747368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B+zmNvoWMXQwBg1E6iwbD1n/mha5bKUYp5y/YGx78g=;
        b=is6q7yrVnAlyyHuVvpvaN/UjZRRGe4pTkVrG8fdW7VI3QSsuRuAlGtgRNZqdMUfYWA
         G/uLKwHv+SCajUcLjgkgVBG7VgLBocAA3FmKvl/Rqn9Z1AuCaJlUkzDcfibWFJhgNp10
         HgkG17QGkN6YqiWx3SqAvqktCBFEM/eWDi/Cac+BJRS+oC9xWDTgOvd2czWouS05U6P0
         Ts2tcxZ2NxTnYRTuSEvD083/1/9tgo2rDF3uCnG7ct1vKBL589e5LpHTFNtlVLvIFqM4
         LeqI45lvrpAFnQwJdrTKzaQkDnJt9reBo/5MrO89rdxlbYk86GqwpVAlmTfp6IApKqzf
         UDxg==
X-Gm-Message-State: AOJu0YxulRaOOgqklcdAMEFWx7Kjk+kotIUca1LFL3nNKcaJ5tS8lDpM
	Uk6TdONxchj4pX4aU778QagSGjLwW/LIU5KCumJvi14+zUej5pYGbZoV
X-Gm-Gg: AeBDiesViro7WeEoIGWWrmcZP06GZw6GhEuHE0pOn5R53gnG2H3IZSXk2z3NlTS4CDZ
	EPJw1oKI8rUvycwUIvtjjvS723iH9vuNL3OWFqJLWx+q/Kyv1FgGUoaV9WMGKd9i9HkzQJYHw+l
	QxCO9VyGNoJc4wbD2maNY7KD+POeh56DiUemyT9RGiDQft7iR2Ieu2jqW1GUkAdab9FXh9w8ohl
	XkNw33wCRH89Vs5atCGJppUqTxEbYlwLk9K08wmrwgGi4jnHLrTfvuWlJg3OQ/j5DvLrTsRO+ZD
	ch44iVGFa2voqbAuSSNfia1YqN2wuDa04oQEhTnC5WrH1Xel/K1mUkdnDRED2lbCvaEjknnEH0T
	/1sSKZEZ/ciYDYNtzfXLiECVBd5z0V6wyTAlCIvr7rFEa4qxGFtefftkxf6HfaDYKs2NOyjAh/R
	dTqtld5hc8LJY2f79z9zaspcJVy6Q=
X-Received: by 2002:a05:6a21:1bc8:b0:3a3:2819:5d41 with SMTP id adf61e73a8af0-3a32819819bmr6555615637.5.1777142568286;
        Sat, 25 Apr 2026 11:42:48 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm33975874b3a.38.2026.04.25.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:42:47 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/2] ntfs: fix index walk NULL deref and WSL symlink leak
Date: Sun, 26 Apr 2026 03:42:41 +0900
Message-ID: <20260425184243.116396-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent fixes for the new fs/ntfs/ that landed in v7.1-rc1.

  1/2 fixes a NULL dereference in ntfs_index_walk_down(). When
      kvzalloc() for ictx->ib fails, or ntfs_ib_read() fails mid
      traversal, the function previously returned a state that
      ntfs_index_next() and ntfs_readdir() could not distinguish
      from end-of-directory, and ntfs_ib_read() itself could write
      through a NULL ictx->ib. Errors are now propagated as
      ERR_PTR() through ntfs_index_next() up to ntfs_readdir().
      Reproduced with failslab fault injection on getdents64; the
      reproducer is described in the commit log.

  2/2 fixes a target-string leak in ntfs_reparse_set_wsl_symlink()
      when ntfs_set_ntfs_reparse_data() fails. Also switches the
      kvfree() on the local failure path to kfree() to match the
      kmalloc() done by ntfs_ucstonls().

The two patches are independent and may be applied in any order.

DaeMyung Kang (2):
  ntfs: fix NULL dereference in ntfs_index_walk_down()
  ntfs: fix WSL symlink target leak on reparse failure

 fs/ntfs/dir.c     | 13 ++++++++++---
 fs/ntfs/index.c   | 17 +++++++++++++----
 fs/ntfs/reparse.c |  5 +++--
 3 files changed, 26 insertions(+), 9 deletions(-)

--
2.43.0

