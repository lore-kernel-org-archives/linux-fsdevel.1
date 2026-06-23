Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECE39E9DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246591; cv=none; b=PIyK8YHAkIRmB6OTwMveA/aLd9A3O9x84Ydue6WtlQT1KP/DpWnERD9mdy6Jpl0TRJ28LUOKvubUAYQHoKyJSozoVIpmY7LcXHWa5fxKv1WhnaKbgHVkd/6Uf7WKv2i6fiZNszylBDO4nxl00wr8gbfRWD3OxCzcA0HTfBRqW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246591; c=relaxed/simple;
	bh=ae9tZLJ9VP0xrA7+kEz3m9adVBnH3W5m1UaMdylFOhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjWELsJ3exG4HpeNLb+suwxvtnEbbpD2wrZmvV36maDtmm1EejHieht3W7CLUeuilxeMv0zqheTOf3tN0ZcqnKGKG2Q+x8Jtx/BFdfAC+eYzz2T3vE9x8utNL+y5EKRPuaqAReNlv3W6Ahj+SvCnMqSGPz5hI4SArUvf7KbKKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC9qkNbv; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC9qkNbv"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4877b2c9e9fso310320b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246588; x=1782851388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuNi7da+RA4oD3knIL+KO9HKkOpiQqXbFGyr9zpIeq0=;
        b=mC9qkNbvvt5qH0rlsKn/PMZ4z0eK9ehZzKfJiAWwjY5RjGSGzyCIa8cagDBbPMyOAE
         dqqFxyqo4oV0XPQ7vyq+J8Nrb3RFdi3tBzam2xonSoYEJ5DSt7wZHpDoMwlVcJKrT/hR
         kyCZJRrYrln0dNW8z71QgX3/0BScVxNqYn5DGsU2qIKr9M30nz7f7bDhVyZr5liYAVIL
         rqFU1aCynatxsYwHVHWMZhdtHF8C/vRr7Zu6J89zBgyaM3VjKL89YkLBOqMenR8jOp6o
         pSF1KHcQ5Vx5wWPZuj5gMI9FlEJUVr9Zsy9z6PzrGBSEGNMxVfFEqfBD4IDZEWjv/2jg
         1BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246588; x=1782851388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuNi7da+RA4oD3knIL+KO9HKkOpiQqXbFGyr9zpIeq0=;
        b=mZk5sLVylyRENM295dt2gFuEco2ojzO82eZ6BYjJQTPEpaZGu2a4sjP8NcMweOlYTz
         cYNM+9k/XRATd1oVwgh2eIhE08WvjmKw8ZbwVMein1nkV+FZPjNi7ck6wnhvrz0BT9Al
         1B6DZRCMADjaAhKJ4jBRLlB3BoTKgom1JMomLXRriIZ5wR4E4GN93tbfwjvLFwT7egaW
         TZpQiukAGkr+NzmXj0rxYcjXLniz73H0+KvYBitn5C5QUkXPcTzqVBO/fAbxuQOEmHav
         aILzhbim4wYmanHb2Xf+LgxtITP7j5TsGsP2OzY6h9VqutrOJlmNxUpFmhlcL9qlXbGn
         VmaA==
X-Gm-Message-State: AOJu0Yw7jxJ6eHMbnx09pnRqFBUxdN2n0tWKUr1CKlcHmPIn8mfGCGlF
	pZtCofB0/QEbDUcINDO2kSxD+bIWn5pXIqt6Lvo0jqYWscQbXaiLO188
X-Gm-Gg: AfdE7cnfbJY0h4dGZHXHE5MxmOUt3G0MU/ZlXanV5AVajk0IahWpG3/sGihB2mtTUjK
	7BYv6/x61rpko2rwL8IgjPoJICwZ89cCrRcFLfOh+QwIVna3dvNUOgSDj+FmtR1y4om80Sus0zB
	4cJs2k/32NxwU6h5DZGo/yViuQbUX8bU3qRKuh4oZ9eKYjkRDIFABkXrM3EYHFQiqqNSzRyy31A
	kC6N1/OwF1DcOU2+tlRROeObp1pRsILy3U+iaPdy/BMkOmG53MuMnQADxE3Na53i+Cp4fNzCtI1
	F4M2FJIa0eW+YZ5mmmzAqYMcqZvlTIWD7dalpucFwHRO4VBGA63Bl4sgjeI4tSFtmV/d6wpWMGb
	Ix7wDLBNYxMWeWHYXoJZ7NCpaG8+8t41DvGZFBfIZnU4EbtT1huFUOMus2AqjFrwM5f618vYRSt
	7H5x9og/CPLwLIp1vTZuLZKseHmYKCUvocnYu5ea6CDrEiZPd6NBfudWurSIixvNjL
X-Received: by 2002:a05:6808:384c:b0:48a:3f80:ee54 with SMTP id 5614622812f47-4907a57a5e9mr275739b6e.23.1782246588618;
        Tue, 23 Jun 2026 13:29:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0ddd7bsm7130470b6e.7.2026.06.23.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:29:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de,
	djwong@kernel.org,
	miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v1 0/2] iomap: add helpers to keep uptodate bitmap in sync
Date: Tue, 23 Jun 2026 13:28:40 -0700
Message-ID: <20260623202843.2064992-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is on top of the main linux tree [1] because it depends on some
fuse changes in Miklos's tree that were merged into 7.2 but not yet pulled
into Christian's vfs tree.

The first patch in this series adds two helpers to iomap that update the
uptodate bitmap whenever a folio's uptodate status needs to be set or cleared.

This is so that external callers who need to update the uptodate folio state
from a non-iomap path can do so and keep the bitmap in sync.

The second patch adds the fuse caller side of it. fuse uses these two helpers
in the notify store path for storing server-pushed data into the page cache
pages and in the writethrough path. This series is needed before fuse can
start using large folios.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/

Joanne Koong (2):
  iomap: add helpers to mark and clear folio uptodate state
  fuse: use iomap helpers to update folio uptodate state

 fs/fuse/file.c         |  6 +++---
 fs/fuse/notify.c       |  4 +++-
 fs/iomap/buffered-io.c | 27 +++++++++++++++++++++++++++
 include/linux/iomap.h  |  2 ++
 4 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.52.0

