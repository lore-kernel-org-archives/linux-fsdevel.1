Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434591;
	b=zC9aK+YCUX2eQVz/+4u4nZraQkPfWvtbU+pHw6YF1EkuQCWRLZ+7dxUaVnBU6F/pBFzk
	 q1tyXOmstpAVIAho7Sa3CzG20HaEpO8lo7v3HtnlUIC+fl4L8egNlo4+f8kEOH8B1upyP
	 oQaL359XPECjloIo9uWa6ACUlTb/6dgPbD6NlZb9VWFAntCE8m+q9V4thA8GsDBBsPhN+
	 FXTl6CKYUJOW6nFt9Cn0jSz/UZRduD9g4go0MPdBpFRt+ooAHgRKmn6CFX4qStsxynKzC
	 66t4p/yAQw9g5QmNBhlsuID5uIt03Z/WQyILIHrskL3+xxPiib1T+JGCoIgak/UcoPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3WB24rA8ZdBO+wgJnzmfsh+oAV8Yu7u/lMoaF1dD+/A=;
	b=WZTTH9H4kRRp++IhTG6T4MX22V2TrKr3U0Z6nzAiFWJl9UYI+QAk+7dofzh473wRo1gE
	 FTTq0yHAtX2aNjWJ2I8Z5JFWB7QYNO+Fedl91ohanQX4RHm1Ftxojp02qHjZMN23CL9gM
	 GEhX5G2vwfAHcaivmhMpBIRZcFZJjCyeNG7OXHNU8l3DTpORvaZ3Br5QBUWqTvZLen4Ou
	 uBBTkvAz9EDAI21ar7ZZVeSIryPjm4qjzjG4xoG6dxZPp9qWuWPFeQlBeN4g6KH9x19Lw
	 zGxvN4sd7+iJ5nptF3BTV7c4cRbfmnPXHK8k2S8zMepoJhFP9u/clKk4dGDX4iMV10w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W/4w8wek";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C05606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 18:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C05606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W/4w8wek
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so4057885eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792434590; x=1793039390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3WB24rA8ZdBO+wgJnzmfsh+oAV8Yu7u/lMoaF1dD+/A=;
        b=W/4w8wekQdvr1HJK1p/qx8Vj7tq7/FS7PiMMu/LEUQY8HU7559yv8Nh3ZrpToQbpcR
         UakII9Z1uV2JZeMoGDH9vIGXXFSTYvJejgOsAHA87mIgE9vlGNjENdJkxpTGMoiSsvp0
         lmSIvtTE78fcBk8dFMTv+1LpsCWAVr+V+e2yWQli7qV4Xtr27X/asupcdvg+hvCaEJhs
         +rA/nJYkfQGP9uHG9dQUkzeUray2s+w9sOaMGmJvL/+zb8xr5e81rcrcBcDc8DpEI6DP
         zOYizs+iUJstsDCn05GzMEYggqkRWMompUNGCX87oMjMvTobPBYfZ1Bh1nTHsq+kMncE
         ja5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792434590; x=1793039390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WB24rA8ZdBO+wgJnzmfsh+oAV8Yu7u/lMoaF1dD+/A=;
        b=rNjvmHjm+yMx8s6ccyf0oBM2vh0LUG4Bd7yRFp9nDIZQP8ud54IJURrznyPuECRVN+
         nz9W5ia449Xiwt8VHaFiCH/gHgrO2rXQZpNv7G+PM5ZcwePUMfMn2O3356xMcLCigQ1b
         JwaGzLIUhNgeYrz3TxS6L/JONGPienlLOcq0/eHHyGc/b1KpA+xIY3jS9kLzc0nQ3hUp
         DlW/Ad+cQ9XzDAviF3MGQxH4jiBNnWVateXuP+vJfM1uE4CUwlL63klTa9H/3SB+/FKE
         RNlW7xDPlhcEo4PiFc9XdtQUbnZfAG/JiniyYDW4ACy6IqmbPrlxDEFWZ0eKjmsCtdwe
         DohQ==
X-Forwarded-Encrypted: i=1; AKwUvByylGMuIvfUENwa5AtYC2HEF6+urXN81f0Mvt3qLjoIXZ6KV0Uw2ySfJgluerXHXXoI+PJRfL/IC4xpH/9L@vger.kernel.org
X-Gm-Message-State: AFq9FYKXa1iYJFHtfPoKfa6km8OnBtHV8gU9LGAhQP6EXGs6nN4EIgFT
	QzEQZVDNZy6CB6qxNN7VRzljInZdrbEB2DB4D9JSN5j0lw80sqnt+MFTxSkzkA==
X-Gm-Gg: AYBFou2nPgUkxmJfsp+dysurgDopzJ+dIHBsTU8zUaL6Gd2D0zZJ1oC6axe//rfYqNO
	i4ckhm0rpwwBWx9IGhK/AKYscn7ChfFGvY2baQX9aiqZKQAxUoSVWqL/oxb/LjwW4qr2MPx94Fw
	p1xctDiECpnDEXEzoT/23OltSP5Ry5Gd00EvNxzUk1wDeogr0TNhcYCD+23ml+XCfCFE6NlaLJG
	39OkdEFIHnaIWOkoEL+1/DBZUlsYhiWwuWuaquloPc0+KsNKXFnyfHCL/R7KfH671EZGce7TRrK
	k0+PsmRQXhZd076R0EYtw84+LMQHAW+1iEaacuBJFdEKlc8SX+0rqNJ+19Zqi6qz5UYVWNdkV5F
	EJkr/NYmjCkv38PKTo/am8lHunqftVlg8uFPvV+i3E+0nDv0ppwTr27HwxQ5w3D29o1DmY58HNk
	RZehEg7miFdO5GEeFTKtWRBTmJbmBjtOdZPtllVD8TCiAKA7nCljWUEs3O0UzW66ficdIESfTvU
	QpAYyPVGcspkdfbbpF26DaW2eqpAdKNct2sIVS0tngfz8DnrYB0Lhuc22yhSP16BGQAsAlpKWES
	KXZGl1KrnmszlOVH
X-Received: by 2002:a05:7301:1888:b0:339:7c91:21f4 with SMTP id 5a478bee46e88-361a312c22emr11721148eec.34.1792434589929;
        Mon, 19 Oct 2026 11:29:49 -0700 (PDT)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b792bsm35009576eec.5.2026.10.19.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:29:49 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: target-maintainer@vger.kernel.org
Cc: Pranith Kumar <bobby.prani@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] eventpoll: scale nested leaf additions
Date: Mon, 19 Oct 2026 11:29:31 -0700
Message-ID: <cover.1792432666.git.bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Adding an ordinary file to an epoll watched by another epoll takes
epnested_mutex. Workers adding different files to different epoll
instances therefore serialize on one global lock, even though their
reverse-path checks do not conflict.

The first patch freezes the epoll topology with a shared rwsem during
these leaf additions and uses a hashed per-file mutex to serialize
checks for the same target file. An epoll topology change takes the
rwsem for write and retains epnested_mutex for cycle and path checks.
The second patch separates the generation stamp and topology rwsem
onto cache lines of their own on SMP builds. In the tested ARM64
layout, this also separates them from epnested_mutex.

The series was built and tested on linux-next tag next-20261016
(7.3-rc7 based). Four workers each ran 2,000 epoll
add/delete pairs in nested and flat modes. Throughput:

  Kernel                 Nested pairs/s  Gain % Flat pairs/s Gain %
  Unpatched linux-next        1,558,641    0.0%    6,736,037  0.00%
  Parallel additions          5,325,959 +241.7%    6,771,375 +0.52%
  Parallel + alignment        5,487,081 +252.0%    6,780,276 +0.66%

This patch was developed with AI assistance.

Pranith Kumar (2):
  eventpoll: parallelize independent nested leaf additions
  eventpoll: separate nested-check objects by cache line

 fs/eventpoll.c | 116 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 26 deletions(-)

base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
-- 
2.47.3
