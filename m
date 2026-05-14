Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2D401A3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767713; cv=none; b=RvxR2j//oI7b3WiM5Z+795BR7sCurUJikpKlnhlpLpn/+Pv/C5lm4ZULLWH8t1int0AiAUHWGGxuQROgVfvft90t/Yy5luoWmRl5GKp29ZotFC1wD37fdagsu0SbnOrOc/S7ErMZ7F1G+kKB/QkYWlwCrEht0xPosGxbaAmF7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767713; c=relaxed/simple;
	bh=XQJFVEGXb8GG1McHakPa6lexp/lhSqp5SHuspFmBCmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaL3s/6pwBaygDcjZlBV3zoKvxEqflopS21hlVuHigc/VBifZNDksNBsD8cI9/WTMxX9iS6WJkHUgYsvjb7Uzi7pLZ9+oe1lpt2CO/QILKezvTbvvGs/lX+0UcJqZW3YRAPuOhY4btDm9gl89/uTZlUO8zpNw9YOVozPcpzxW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=YQ7jTSZX; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="YQ7jTSZX"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479ef2b78f3so6852886b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767703; x=1779372503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTKy+6a8jb6C2QuCQKPqyXABjIOGBqK3hbY009ZwCN0=;
        b=YQ7jTSZXMVUTpnHo+HDO+3N/2KadDZN3qqgLRk3cZD0UR6/gBHzMObv0Ucitaak+Av
         +ixjdBF36SLh2ItKzjHMiwz5M0pHPn3N2fx9yRZKukp6KSRihIA2/3kuvgpPAxwuYloh
         sILTUDxrDGO5zreyqQqh7DgqJR4G8KoxGnod77mLWTq1gUL7p8b9no8LhTPWqJmaHg/a
         +yPUYucfIuF342wN4HoZb5g3Rt45kx+UD+I27Fl3tS0V2R3aBndV293TsBqfUytE5a+2
         XrpOBOQLzpGc9rUUJmM6Oh+Gx8VOmw9AnfE+kpc5yU8EIZen0Kzc30vBa2h87264MYpZ
         1KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767703; x=1779372503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTKy+6a8jb6C2QuCQKPqyXABjIOGBqK3hbY009ZwCN0=;
        b=dXlEVitPKZyNwrKdfJPwsK9KOHypu5pV55tU+PM61h7ohxlhfPHy55IoPCNDYMlKoK
         6LoLoDAKAT++WHOikx6xtt91NsBDJGuPd3cpWPZjq/HG9nMp63XwH2dtNbrs2FhE+vNn
         yOqcSluc8iQQcF1ZstUC2x1oZ6pIBGqByWkQsBG1Zfhe6z0Bbh+DMfpU2Fd3qfdS+VYA
         2NtYCkwwxpsN9Jg5lXk1qTHsfHjCnlF78LeIEQyE1zi525ln/h8JtueJCBkkvwuE9kB6
         8U5FpTqn0Poz3FnOu3Px98eZx7minqJwYxfL1tx9Ey1t+rj/JMoS2Yrp4EZTPgVKqtV4
         VoMQ==
X-Gm-Message-State: AOJu0Yyeso6fjbKJdygbJOCeGsmtJhda+zi+yy6C/bbgvvbGEwGC5UqR
	UHIYfdg0a+MNn46qF0h5aaCMn3BpzouE4oJTBdCHttI9zCVh6U5qV8mVm53FvJ2XEA8=
X-Gm-Gg: Acq92OHJxTiEQ6/LsQflZmfTZ6CNsbWtHN2Af7dkh+RygURDNS32wmncJxLdmeuL+eU
	djrsUApcobjKeem/Q6bTs0uciepK+rsvC3k+O/TXS0mxOPOrjCdJLvxjGwNAPLMGt1VFtI1p6UO
	Gz47/kxEi/53FUktnS4YO25v6qsJtwQ7LNlzz2kiYtIkQbYT14KNlkr7SLRMYLZ7C24+T4PodG/
	N6jc4QkX/vsjhrQmcyLfVQ54FY3+avF82RzLmqQ1h4MPqGYfMqyQXHc55cL9Uu/7/MH1WGIZ52R
	nuUF+dwo/ilzMeFPJ8H1BrUd9yVOIZ3VETRUZSKSddKEdyqHI7xoO9KIKT+oH64Z1UhG0TxGyL3
	sW5RO/Y8VQvFQY/qNBDiHhuo6n9u2Qzl581w8KnT0qxTrQyxBd5B6S1JxENLnWd4RZGKBvPdeim
	MIjmt+O/pT1YoW3BD/hpgyzbP1MOFuMu6rG7+bqpvMTKcbN6FTJoCGraBEYxpNARb2Qug=
X-Received: by 2002:a05:6808:4f08:b0:471:f036:7926 with SMTP id 5614622812f47-482b2c73cd1mr4937708b6e.28.1778767702773;
        Thu, 14 May 2026 07:08:22 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCHSET v2 0/6] io_uring related epoll cleanups
Date: Thu, 14 May 2026 08:07:16 -0600
Message-ID: <20260514140817.623026-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

One of the nastier things about epoll is how it allows nesting contexts
inside each other, leading to the necessity of loop detection and the
issues that have come with that.

I don't believe there's any reason to support nesting on the io_uring
side, in fact IORING_OP_EPOLL_CTL is a historical mistake, imho. But
let's at least try and contain the damage and disallow nested contexts
from our side.

Changes since v1:
- Add patch renaming struct epoll_filefd to struct epoll_key

 fs/eventpoll.c            | 91 ++++++++++++++++++---------------------
 include/linux/eventpoll.h |  8 ++++
 io_uring/epoll.c          | 18 +++++++-
 3 files changed, 67 insertions(+), 50 deletions(-)

-- 
Jens Axboe

