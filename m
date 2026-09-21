Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AF456297
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979538; cv=none; b=cGr0E1cB9UPX+2YmUxHQnChvNXX9ykWktACu9ht/UI7RtR4l47dLhXWl0I5SLuyqQUH8xWXzHDE5R9iJeeDnN/S0pW2Bj2ipxxI+RzFATJRnY4uSKw/I2eCzqjYVnWDA9ht5eikJRLlTYb0ijeQyhdqCFIId/snB8O/Kro1S7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979538; c=relaxed/simple;
	bh=6b27Y5R1I/dErxQ51DVfVbmyQ/c01ct05TSMdeHMzBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCkZ/rZjuOIpFZNS/kWx0MQp4UJBTKnaan+bFJCNEb0Okscy8HYO9om55ZuGtf/StiQ0tXWkWxSeAikWeybrEKUUKnNhqmzKaE8bUH5LnrU2sJI/lbVtFlhRq9sxb+dXh6TcByMvdY5O0RrKkrouiUJr4WiT7c8iKdNMlJvwDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr8bkAIJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr8bkAIJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso18399365e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979535; x=1790584335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bybxefWUQq7gjGvpEQCe+hIa+5aIsa8PecK6A3/B5/4=;
        b=Wr8bkAIJpxGgqX7bbXJuK19j7Edr9XwMNdoIknGkdxeJ6twZ6WUwpXGHb2Iyt6c9Md
         0UZVWXt2/TlgQJZxvRNoRn+WzpnOE5dk4NGs5tAoa5pQAeiVsbndQG8KqaKMfupEI22q
         Zgchk7acHJnevs3PtK9Y/aPW7Yb7BAGFdFSd1HN30+cNkntXFvu+Z5ZRYmbTEOq8cQ8Y
         qabB/fGmORWROPhm/u24K6bgSz1Sdhhk9W8zbkOF4hHyCdAcKJO0p3vRNmFCblcuqOZm
         rFYEH3k0704nL8nQ9e8ZUFM7LucKDKQ848VFFoA9Wuwobuxo/DWO1HpiSv1bk6S+ke7s
         021Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979535; x=1790584335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bybxefWUQq7gjGvpEQCe+hIa+5aIsa8PecK6A3/B5/4=;
        b=ESHDmx1EQsFC7s07d7Pk1adf8YDtUFT+5BPyQgyc3NuXz23dVrB6jdV6xdQGdf6ZMx
         au4IytQ+QUggZDEBpeDWtOcdyOuJgoBgxnBSJC3AQLVsguJCkMDycPrI8b1SL2xjSyV1
         enRos6UaCMEsG+O38oSB/lg8WkA3qbpPwzR2QKacm5Nol7RZR2kAlja/sxtgTKPuOSYk
         HCHFQBtcfyE+byoIUK166riuNuvsOlcFlNOQuhY8nbPvRC9UWF3AplzYrVlU+8pv/MyM
         NfRKdRtBCdHT5wIBaBkng51XhMQBRmKwT6s3Mqxst6BpKh7S7wkFbloPeDdJAU/2vuAv
         SFsA==
X-Forwarded-Encrypted: i=1; AKwUvBwzx6Rvf+7nXRK8NXSpt+lDKBGrL2/cSfxoYNVkm2m+kcwpRqHBIPKGtMJxQR7QaJHfnKXzLG+8Hur95pc+@vger.kernel.org
X-Gm-Message-State: AFuF++nukETU4zMNQWLFjh7l5JH7vVL6euz0pJdtfebKFOLy6AvEjXmN
	YaV6zKc2EHq3GsddXlWks1Wn4fhmK2MB8tdZI4q65q4npJ3DZ1X4LI4yXAUxzpjzgZs=
X-Gm-Gg: AYBFou3n/a8f/VIXMFD2qmZK60k1Fglqnyn2L/KSsNr2rz3bE0/y7Emh1LDTn8YNZsF
	pToCkjxVDQGemi5ROT3ZuOhYhkR4x7LM/7gpi9w5LYz+hlAXXme0XI7rxZdLoHOvf44A5I4cIkm
	L26oT90Ry5gGaHW0AnFrDjaakBpX80FvjYEQjllnB/xGNBoNcCdheBIHnx/zeSCJnSUOWVjd1nl
	la793ScakL37bB1cf4g4z4GEMhPvV696xXCcoKDdplwLGRbdPuUR7kraLhHRvDGgc2IYxRXFrWl
	vAKuYu78Z+wmeYzV+rvPyQg4enP/BoSfifsBGTAUfPodAbGo7uq13WSsBJH7BgVCj3BAYxUS4nh
	WA9RirTn507jK0Gi6Zf+CNHLWK/G/T0GhDxcjHj/XgdNqPr+TRH2dNuqLD+Dr2CPt42px9LteIU
	rXQU8O6zUh0wiwXS8Uf5XR9ghz75eyP7muIt4/9tYmnABbwsTtPDm2ZhTsqlyrsjzrr3zp8XCcW
	C9pNY7BuxZksz87DmXSqDdXQ4SjabHYYzPR5kmw3bIS
X-Received: by 2002:a05:600c:c8f:b0:49e:6c9b:4e94 with SMTP id 5b1f17b1804b1-49fc5743124mr136244555e9.28.1789979535490;
        Mon, 21 Sep 2026 01:32:15 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm222806105e9.11.2026.09.21.01.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:32:15 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] iomap: don't lose a failed direct I/O bio's error when zeroing the tail
Date: Mon, 21 Sep 2026 10:31:33 +0200
Message-ID: <20260921083133.2960-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921083133.2960-1-parri.andrea@gmail.com>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_dio_bio_iter() falls through to the sub-block tail zeroing when
the data bio submission fails, so that the rest of the block is still
zeroed and stale data is not exposed.  The zeroing result is assigned to
ret, which overwrites the submission error with the successful zeroing
result (zero) and the failed write is reported as success.

Store the zeroing result separately and only use it when the data path
did not already fail.

Fixes: 10553a91652d9 ("iomap: fix iomap_dio_zero() for fs bs > system page size")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/direct-io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8b4039d16ce89..8ae3fe64e475c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -581,9 +581,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
-		if (pad)
-			ret = iomap_dio_zero(iter, dio, pos,
-					     fs_block_size - pad);
+		if (pad) {
+			ssize_t zerror;
+
+			zerror = iomap_dio_zero(iter, dio, pos,
+						fs_block_size - pad);
+			if (!ret)
+				ret = zerror;
+		}
 	}
 out:
 	/* Undo iter limitation to current extent */
-- 
2.53.0

