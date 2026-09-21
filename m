Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0B451990
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979535; cv=none; b=aG+diDPRp7p06lTsHj7bdmkh/n8dWr0RhmtGjpF3AI02O5ol0X/HdzFLe9X5UqIw/7J7VXjoOYEBq2RtgC800QsT7LCAPEHTB33PZLBHDsplbWpsLXN5ka4jLvmMKtjoU3M6cGSGTxn1Yg4Egc+HeEbp1YRWgwQoHeLiqDqWxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979535; c=relaxed/simple;
	bh=0SHT6MWm/msHNRUWUhzX/lBZli3Y1PYjPl5eyNXCOq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJUBamrk5DsiMGARdMzta03UuwAfTLSakr8ux+akB50NnIIELtUIwtkw+a4Tt9dJXz/pXWwDtSL0IMlMJGPwFuq46znZ1YEQUOffIgXXzMGv7pfXi5tCvs+kKGP+quOn3P2qj0VKog/SeqSOMVdcUqbEzUI7OKclvZ/Oisx+tcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAOiTtrh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAOiTtrh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so15910845e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979531; x=1790584331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NhkMJwTslxPvbqpSBeyGrXtH+1chdTQCyctTNvD998Y=;
        b=LAOiTtrhZU//FBIiuWwr5BAl44TRxQ0gJMfcZASGG0Q/JVdevfPn0Mv0dCxKLsP98V
         LtdNQQeI7AShs3JJ6U5k+rKfab3HpVZwPng6ERT/B0psKiskoek+GyZJ4r99IItACVNi
         NM2V/MScKjCkDTQKM4rQxYkJAefn62JTiXZ4susZgnYOe/O9MDINXg1jLBnF4fnOTg8v
         bDB/R7P5R+sXgQT5fumdZLQmy2xV2TM0+5bYpebPSPrFgiD24+h5SaZKTDjDycYIF3fL
         cgy0c5i8NPSPIJQpFRhp9bh1v6Os0em6B3rTWfrMpgWT5OfJ5z64Qo+nJo5ElDGD/a4c
         7Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979531; x=1790584331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NhkMJwTslxPvbqpSBeyGrXtH+1chdTQCyctTNvD998Y=;
        b=KB/jx0Yeon4Nd1GhiWlQ5zgZ0FREnzbjaTU5Di+7eDak79NKCAHD/FpdA1zvwjXYK0
         Xt3aOTN+g+laaDDiFxb8bjGhdavTNDErh3Rc1blIoeJ7Kw2XAwbv/HaYUcB4TKqGDCIR
         PSfeodCEVH76t0GP6OvsKedJM+UW3jL/PCTjgU7Zd7CaYw8R4/lg/EYCRmrBgvn8E5od
         2nMptX4iYA7Bh+Hsu8tG/7phh/RsGLVZbE1PWS4QaivvdL9nQM1X3lceStOTgnQ5TLNV
         sObtuh8/9S2aKvVzqKL9ZZY7Ko/8u5/biUNocStgNoYADjBR8hXu1NHvccrVyOITU8Wv
         iwHg==
X-Forwarded-Encrypted: i=1; AKwUvBxe92mBuo3f86KBHY5EiKOD0vUHa27kg/ymJs5uwUAm4kiYKLXetcvJqcHUTPoUElPw7KIV237XRNXv+ph2@vger.kernel.org
X-Gm-Message-State: AFuF++lgt3n+DEs9CEZ5sZJ0UWVPYd9QADlVbSpUSGrLEBbAI3zq3MD9
	0bQ/D/bI9E1rhYzGUnTHBU34R2et2qkFNGlLj4ZYVXcEFlqiSCLtFrZz
X-Gm-Gg: AYBFou3sczY3rtYHACqyiDJBPKATqa+b/mYmiqbEn+7Lvvv9zDOjM7nXIX/FXqZpXNS
	VTPFnCnqOYGRbOO1nogyIQryj+2uu1XErqM+9xAK7QBiUsf/Sj3INnoygOLzYuVBkLT7sjXp80r
	W576hATAXAW814fcMj18j0NtsyStDhkDbaGRO5kZHGsYInc9Qs6m9KHTWs0yAn6gUyDYFSJh04o
	fRppTkuF8uQ1oUX2jpUwXlFQUQ0Qyl4h/QbB/KXC8noapphr+Aa3jZ3TTlhTG1xtnzFMwASz4G0
	1CXDkPJvhoqmA3U2Sbvy3+j0VfHNqBIGOo40sXpMMj+sjJwYy9mcWNehqByJgIZyNwcbnFBNXEd
	68bWAFjmex3qbOhabxYALqH1rfKNwczl+7Gtkn+UbEnk8CqFX3dqA7eV02uAf3X09k73rQ7+B9m
	+biPBbEHJaJq6RNnc+2riKQhun89I+mvrbxyEcXurcmJPSIbrAXRAHJIGCRze06bR6TG6i/GIUU
	7RwWrIincGeDPwS+JaS4kPx8c0bbslvdt1WihK0XLJD
X-Received: by 2002:a05:600c:1c20:b0:49f:bd3c:bc1c with SMTP id 5b1f17b1804b1-49fc5739f3bmr151626975e9.23.1789979531135;
        Mon, 21 Sep 2026 01:32:11 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm222806105e9.11.2026.09.21.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:32:10 -0700 (PDT)
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
Subject: [PATCH 1/3] iomap: don't resubmit an ioend after ->writeback_submit() failed
Date: Mon, 21 Sep 2026 10:31:31 +0200
Message-ID: <20260921083133.2960-2-parri.andrea@gmail.com>
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

iomap_add_to_ioend() submits the pending ioend through
->writeback_submit() before allocating a new one for the current range.
When the submission fails the helper completes the ioend with an error,
but iomap_add_to_ioend() returns the error without clearing
wpc->wb_ctx.  iomap_writepages() then submits whatever wpc->wb_ctx
points to, so the already completed ioend is submitted a second time.

For XFS the second bio_endio() lands in xfs_end_bio(), which
list_add_tail()s the already linked ioend into ip->i_ioend_list.  This
corrupts the list and leaves a use-after-free/double-free window against
the ioend completion worker.

Clear wpc->wb_ctx when ->writeback_submit() fails.  The old
iomap_submit_ioend() cleared the context unconditionally; that clear was
lost when submission moved to iomap_ioend_writeback_submit().

Fixes: f4fa7981fa26c ("iomap: hide ioends from the generic writeback code")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/ioend.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 7bbbb417f9152..bb8575768d888 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -246,8 +246,16 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 new_ioend:
 		if (ioend) {
 			error = wpc->ops->writeback_submit(wpc, 0);
-			if (error)
+			if (error) {
+				/*
+				 * ->writeback_submit() completed the ioend with
+				 * an error, so drop the stale context.
+				 * iomap_writepages() would otherwise submit it a
+				 * second time.
+				 */
+				wpc->wb_ctx = NULL;
 				return error;
+			}
 		}
 		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
-- 
2.53.0

