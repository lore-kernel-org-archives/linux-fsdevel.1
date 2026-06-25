Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7B28506F
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356009; cv=none; b=gsdPjQrtg++iMJr8MXA8XXonwKDlOu7zupfnYFtrIqLZw42HWbx7KTmBrvfSOZeO+OtAs7Eym1NfMLhUbE4JQzbRvT1mO4Eq02mdQHIjdqlepXtHYh/wZe2/rEDikoNrwPbLL5iHVUPPbK8G6+4NPTJnurkAPoR/NR1QNbypOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356009; c=relaxed/simple;
	bh=82P2aAvdbErIb2u2uSt6N0Zq50CMXom0XaepfiVW/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pq2Edb2rEfsokJpoxyuooojtz/HFr9S/B+MY7oiHP3H4Wcxyp2p6KGX0RO1H9mjsq7ketHdsUWHSqKHOJibCj1rzxS5U2c5Nx4dEJTTbOQjcv/ivW57be125+8IQSGWZEf0jsid+2ELekiVSw+JevZEUWtSrtnRNmRyuXJ7Fy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMKygq89; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMKygq89"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-48bd982d04bso370316b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 19:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782356006; x=1782960806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4WjU3Axdd/jtiKx3LjuPiSqi4lBo7DMVzuiHhfDMkY=;
        b=SMKygq89bIJ12IVCC4G4cDGt7vngFGAtRDrEtuf65oMRfg7adlonKEMiA4lzrhvB1c
         FsTPeqQB7jznouB9qlB3D9X+xd80xlW+yL62Qrcg3towLAIWNVP1Zst1P7Pq4v6O85Nd
         QVjM6LlQdwVKBstigkPXTNdCieyi3YV0zEaoq2iOLFjgNeT7glZp/5E+SMia3GyH/hBX
         JisqNpSWqMt3XQ7OKFsrlJHhCduuPNqPPP6yWkWot7hep8GYxEqIfz2vYwd4kzqCiSZq
         bD5UXxY7oVhncxB1Ud3NUdxfa+mCNnUXQ1X7jViMufMUhvkNeK587DW6+0g9u1D6aBwP
         IQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782356006; x=1782960806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4WjU3Axdd/jtiKx3LjuPiSqi4lBo7DMVzuiHhfDMkY=;
        b=XzEZArjZqXFf+cHYsaPEfF5mKQ05yhp1ljDK86st3aGXVXQQRqjcSuuq2hwUvDg43K
         BtbfivZu5KcpfXl5IuhkiSsdTOjFcHQlQ8yk1WM2zJiLVSJF0wHnutYtmrZpkGRvTVQg
         l1bSod9MhktQZvQK9nhUUov27EcNQ6SwLoy+Yx5ufKwkXdTafPD0h+UvkigFOIo+tl6V
         2U21HLVLhs0SZ3GHugBKAfOBzNG6iekZG5hJhAwMvlYDPvGkBr+zH83Bz8l2PVwKYDsl
         UkYdTYO4Qz6WIqei/K1WOkXAv+prKvjZpms3cVBd+UiOOzy2lR9ul2KTkbZyBE9Ja/e6
         YNmA==
X-Gm-Message-State: AOJu0Yxg0+0H3Rjf8M8rZPF2e+GdPukDHQP9E4H4LsGq0qR0JJhC1Eji
	NSJBtOuj9Ub+6e9aAF+kiKyLl+dsdgmluddInXYmMeRqgfvLTCoWxbQB
X-Gm-Gg: AfdE7cn/oa8R62jMX0RIAqAAUkrSSpwEN0OWFBdbbPbvqIcnE0wNwDweCqykeOJeGqc
	0h6u3vYB8VHSx0fC7o3Sid8IEbyePgibg/ebZcxhWjtBspjRYaGUwqhhVLwSP4w8NfGeWFfwYai
	lki3VUmHXqpyqMt+zMkaAK6stE5RCSAMIq9v0SszqCiiGgrFbctqLXaX1NU9v/H8v61Q2rpUc+i
	Oa4c7hSzst78jYuuQNi0hUO8qko5Wc53RkJOp11Yammk/zliJwplYRPJjiOi2weyMqcP9el4D4l
	AkFd/IROuExMEl7NP9CNLJ9UcynZqKJpDHTySbbc9lEgibpm2lt9Fl62rYwzf92LChFphXvj0HQ
	S90P0wx/3Y6dEqRid9km0dOdn1AlIRQ6TJUB3DdmXW6Ad0Bpnv06p+bKT8fq++OWSWf+jK2VGBr
	UF4yafO8xWT1zGioEJf0QI2B6/CI0RIwe/5W3XfO+p+rBdod1z58f/pB4slz9uxr7x
X-Received: by 2002:a05:6808:5028:b0:491:ef05:2c0a with SMTP id 5614622812f47-491ef052db3mr1276968b6e.26.1782356006138;
        Wed, 24 Jun 2026 19:53:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aee43c088sm9997162b6e.14.2026.06.24.19.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:53:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: hch@lst.de,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [RFC PATCH v1 0/3] iomap: convert to in-iter ->iomap_next() model
Date: Wed, 24 Jun 2026 19:47:20 -0700
Message-ID: <20260625024723.1611000-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is submitted to get some feedback on what converting to an in-iter
->iomap_next() model would look like. It revives Matthew's previous RFC [1],
which had the same goal.

The series merges ->iomap_begin()/->iomap_end() into a single ->iomap_next()
callback (patches 1-2) and shows an example of devirtualizing the callbacks on
a hot path so the indirect call through struct iomap_ops is avoided (patch 3).
This series is on top of vfs.all (commit e7a6d06e3c3e8).

A few questions:
* is this roughly the in-iter direction you had in mind?
* is removing the indirect call still worth it? My understanding is that
  indirect calls are cheap on modern eIBRS hardware and the conversion adds
  some per-filesystem boilerplate, so I'm unsure if it carries its weight. If
  not, do you think the in-iter model is still worth having on its own?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20200728173216.7184-1-willy@infradead.org/T/#u

Joanne Koong (3):
  iomap: add ->iomap_next() and iomap_process() helper
  xfs: convert read and buffered write iomap ops to ->iomap_next()
  xfs: example of devirtualizing buffered write iomap callbacks

 fs/iomap/buffered-io.c |  3 +-
 fs/iomap/iter.c        | 99 ++++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_file.c      | 26 +++++++++--
 fs/xfs/xfs_iomap.c     | 29 ++++++++++---
 fs/xfs/xfs_iomap.h     |  7 +++
 include/linux/iomap.h  | 98 ++++++++++++++++++++++++++++++++++++++---
 6 files changed, 231 insertions(+), 31 deletions(-)

-- 
2.52.0

